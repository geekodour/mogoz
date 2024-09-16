+++
title = "Data Engineering"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Distributed Systems]({{< relref "20221102130004-distributed_systems.md" >}}), [Database]({{< relref "20221102123145-database.md" >}}), [Caches]({{< relref "20221101214226-caches.md" >}}), [Database Transactions]({{< relref "20231113145513-database_transactions.md" >}})

{{< figure src="/ox-hugo/data_eng_landscape.jpg" >}}


## FAQ {#faq}


### <span class="org-todo todo TODO">TODO</span> Data Layers? {#data-layers}

NOTE: This is just for my understanding

-   Storage Layer: S3, Parquet, Other file types
-   Transaction Layer: Open table formats, eg. Delta Lake
-   Semantic Layer : Cube (This is new kid, an enhancement)


### File listing problem in Data lakes {#file-listing-problem-in-data-lakes}

{{< figure src="/ox-hugo/20230405003455-data_engineering-2068107708.png" >}}

-   When you want to read a Parquet lake, you must perform a file listing operation and then read all the data. You can’t read the data till you’ve listed all the files.
-   With delta lake, because of the transaction log, we can avoid file listing and get the path directly.


### Access patterns and Performance {#access-patterns-and-performance}


#### File skipping {#file-skipping}

<!--list-separator-->

-  Column Pruning

    -   Unlike CSV, with parquet we can do column pruning.

<!--list-separator-->

-  Parquet row-group Filtering

    -   Parquet file is split by `row-group` by format.
    -   Each `row-group` has min/max statistics for each column.
    -   We can filter by `row-group` for some `column` before we load the data, after which we apply our actual application filtering logic.

<!--list-separator-->

-  File filtering

    {{< figure src="/ox-hugo/20230405003455-data_engineering-1358079267.png" >}}

    -   Parquet doesn’t support file-level skipping
    -   This can be done with Delta Tables, we still add the `row-group` filter but additionally do file based filtering.
    -   Because of the transaction log, we get even better results than simple row-group filtering in plain parquet file with file level skipping.

<!--list-separator-->

-  Partition pruning/filtering

    -   This assumes you've partitioned your data correctly
    -   The more partitions you can “prune” or hone in on the less files and data must be scanned for matches.

<!--list-separator-->

-  Partial reading / Predicate pushdown

    -   See [Optimizations - Polars](https://pola-rs.github.io/polars/user-guide/lazy/optimizations/)
    -   You want to push down your filters and selections to the file reader.
    -   You can imagine that arrow is file reader in that situation and what you want is to give to that reader as much information what you need in order to skip loading into memory.
    -   This is possible because of the parquet file specific metadata representation which allows the reader to skip data.
    -   This is possible in object store using [HTTP]({{< relref "20230222161545-http.md" >}}) range requests, and the [query engine]({{< relref "20231113151855-query_engines.md" >}}) being able to calculate offsets based on metadata etc.
        -   [Range HTTP Header Archives - Jayendra's Cloud Certification Blog](https://jayendrapatil.com/tag/range-http-header/)
        -   [filesystems - S3 based file system capable of requesting only part of file - Server Fault](https://serverfault.com/questions/320642/s3-based-file-system-capable-of-requesting-only-part-of-file)


#### Compaction and Defrag {#compaction-and-defrag}

-   Compaction
    -   Will compact small files into bigger one. Will increment a version.
    -   See [Small file compaction](https://delta-io.github.io/delta-rs/usage/optimize/small-file-compaction-with-optimize/)
-   Defrag
    -   `z-ordering`, will co-locate similar data in similar files.
    -   Z-order clustering can only occur within a partition. Because of this, you cannot Z-order on fields used for partitioning.
    -   Z-order works for all fields, including high cardinality fields and fields that may grow infinitely (for example, timestamps or the customer ID in a transactions or orders table).


#### Partitioning {#partitioning}

-   Partitioning is the way to break big data up into chunks, logically and physically. Commonly things are partitioned over dates.
-   Partitioning works well only for low or known cardinality fields (for example, date fields or physical locations) but not for fields with high cardinality such as timestamps. (See z-ordering)
-   To check cardinality, you can try listing the number of distinct values per column.

<!--list-separator-->

-  When do we need Partitioning?

    -   Databricks: When [data &gt; 1TB](https://docs.databricks.com/en/tables/partitions.html), but depends on the data.
    -   Delta Lake: You can partition by a column if you [expect data in that partition](https://docs.delta.io/latest/best-practices.html) to be at least 1 GB.

<!--list-separator-->

-  Partitioning in Delta Lake v/s Hive Style Partitioning

    -   [When to partition tables on Databricks | Databricks on AWS](https://docs.databricks.com/en/tables/partitions.html)
    -   Apache Hive-style partitioning is not part of the Delta Lake protocol, and workloads should not rely on this partitioning strategy


### What about Databricks? {#what-about-databricks}

-   Databricks has some optimizations such as ingestion time clustering which won't be there if you're using open source version of delta lake. We can get creative and find ways to optimize this based on our data, maybe with partitions or by other needs, whatever necessary.


### General recommendations {#general-recommendations}

-   Data processing engines don’t perform well when reading datasets with many small files. You typically want files that are between 64 MB and 1 GB. You don’t want tiny 1 KB files that require excessive I/O overhead.


### What's the evolution like? {#what-s-the-evolution-like}

-   <https://blog.twingdata.com/p/the-evolution-of-a-data-stack>


### Data cleaning tools {#data-cleaning-tools}

-   This is a slight enhancement
-   You can always do data cleaning using the standard library methods of the language you're using. (Eg. using optional chaining / coalesing etc)
-   But there are certain libraries/processes which can maybe make the data cleaning processes simpler/easier to write and maintain/extend etc.
-   These tools can be especially useful when the response object is not guaranteed to be the exact same and you need some verification around that X,Y,Z field exists etc etc.
-   In `R`, you have tools such as: [A Grammar of Data Manipulation • dplyr](https://dplyr.tidyverse.org/)
-   In [Javascript]({{< relref "20221126085225-javascript.md" >}}), you have [tidyjs](https://github.com/pbeshai/tidy?) but it suffers [issues](https://github.com/pbeshai/tidy/issues/73), even loadsh can help a bit i guess but at that point just use optional chaining maybe
    -   Now for this I thought we can use [effect/schema](https://github.com/Effect-TS/effect/tree/main/packages/schema) or zod for that matter and split it into 2 steps as [mentioned here](https://stackoverflow.com/questions/74809136/parsing-and-flattening-complex-json-with-pydantic):
        -   The first model should capture the "raw" data more or less in the schema you expect from the API.
        -   The second model should then reflect your own desired data schema.
        -   This 2 step process helps debug the pipeline if ever needed. Applies to other validator in other languages like pydantic(python) aswell.
-   But for this job, I'd personally prefer python+pydantic. Goes good together.
    -   Some resources
        -   [Pydantic is all you need: Jason Liu - YouTube](https://www.youtube.com/watch?v=yj-wSRJwrrc) ([Missing - Instructor](https://python.useinstructor.com/concepts/maybe/), Maybe Pattern)
        -   [Better Data Extraction Using Pydantic and OpenAI Function Calls](https://wandb.ai/jxnlco/function-calls/reports/Better-Data-Extraction-Using-Pydantic-and-OpenAI-Function-Calls--Vmlldzo0ODU4OTA3)
    -   Some other tools
        -   <https://glom.readthedocs.io/en/latest/index.html>
        -   <https://github.com/pytoolz/toolz/>
-   Another thing handle data cleaning at the application level if possible and [not at the db level](https://stackoverflow.com/questions/72397616/how-to-enforce-the-shape-of-a-json-jsonb-in-postgres). You should always enforce proper constraints if its structured data but most of the data might be unstrutured and we might want to store it in JSONB columns etc.


## Data pipeline {#data-pipeline}

Point of data pipeline is to generate/maintain data assets (Tables/Files/ML models etc)
![](/ox-hugo/20230405003455-data_engineering-1854298562.png)


## Data Warehouse and Data Lake {#data-warehouse-and-data-lake}

See [Data systems built on Object Store]({{< relref "20240816033216-data_systems_built_on_object_store.md" >}})
![](/ox-hugo/20230405003455-data_engineering-1415605235.png)


### Data warehouse (Analytics, Structured Data) {#data-warehouse--analytics-structured-data}

-   Exists because we have different sources
    -   OLTP source of truth database, but you also have SaaS products, events, logging exhaust, and honestly probably some other OLTP databases
-   Warehouse provides value because it brings together data that otherwise could not be jointly queried.
-   Traditionally used for analytical, but usecases for operational queries are also there
-   Must take care of workload contention so what analytical workload on the warehouse doesn't affect operational data which needs freshness.
-   Must separate the storage from the compute to scale.
-   Tools like DBT help interact with/build DW


#### Analytical {#analytical}

{{< figure src="/ox-hugo/20230405003455-data_engineering-147848926.png" >}}

-   Designed to grind through reams of historical data and efficiently produce periodic reports.
-   Eg. snowflake, can be duckdb, can even be a bash script for that matter


#### Operational {#operational}

{{< figure src="/ox-hugo/20230405003455-data_engineering-1333840662.png" >}}

-   Designed to ingested data continually and make it immediately available to query
-   This is not a popular thing yet but [Materialize is trying to do something around it.](https://materialize.com/blog/operational-data-warehouse/) It uses some Streaming technology.


### Data Lake (Storage, raw/unstructed/structured data) {#data-lake--storage-raw-unstructed-structured-data}

{{< figure src="/ox-hugo/20230405003455-data_engineering-1899874048.png" >}}

-   Throw data into files like json, csv, parquet into a storage system like s3
-   This is also supposed to handle un-structured data like text, images, videos etc.
-   Eg. Parquet data lake: likely has a partitioning strategy that has been optimized for your existing workloads and systems.


### Data Lakehouse {#data-lakehouse}

-   Combining
    -   Analytics strengths of the Data warehouse
    -   Scalability and inexpensive storage of the Data lake
-   Data warehousing principles applied over data in a data lake.
-   Open Table formats / Lakehouse storage systems
    -   Delta lake: Uses [delta](https://docs.databricks.com/en/migration/parquet-to-delta-lake.html) (open table formats), a parquet data lake can be converted into a delta lake. Additionally delta can [store unstructured data as-well.](https://docs.databricks.com/en/machine-learning/reference-solutions/images-etl-inference.html)
    -   Apache Hudi
    -   Iceberg


## Technologies {#technologies}


### Apache Spark {#apache-spark}

{{< figure src="/ox-hugo/20230405003455-data_engineering-993265666.png" >}}

-   An alternative to MapReduce but better


### Data formats {#data-formats}

-   Arrow and Parquet are used together to leverage their respective strengths: Arrow's efficiency in in-memory processing and Parquet's effectiveness in on-disk data storage and retrieval.


#### Parquet (on disk) {#parquet--on-disk}

-   Parquet was created to provide a compressed, efficient columnar data storage format
-   Data format [that allows querying](https://github.com/duckdb/duckdb/blob/6c7c9805fdf1604039ebed47d233ea55cabb4b2c/test/sql/copy/parquet/test_parquet_remote.test#L28) + metadata along w actual data
-   Metadata: Schema info, File level metadata, Column level, custom user level, stats for data skipping etc.
-   Grafana Tempo switched from [Protocol Buffers]({{< relref "20230522131118-protocol_buffers.md" >}}) storage format to Apache Parquet last year.
-   Supports schema and compression, because columnar easier to do compression (processing speed + storage reduction)
-   See [Delta Lake vs. Parquet Comparison | Delta Lake](https://delta.io/blog/delta-lake-vs-parquet-comparison/)

<!--list-separator-->

-  Format

    {{< figure src="/ox-hugo/20230405003455-data_engineering-1722946962.png" >}}

    -   Hierarchically: `File > row group(s) > Column(s) > 1 column chunk > page(s)`
    -   Uses the [record shredding and assembly algorithm](https://github.com/julienledem/redelm/wiki/The-striping-and-assembly-algorithms-from-the-Dremel-paper) described in the Dremel paper to convert nested schema to columns.
    -   Data is stored in batches("row groups")
    -   Row Group = Batch = column(s)
    -   Each column can contain compressed data and metadata
    -   By itself does not support `append`, i.e **parquet files are immutable**. See Delta Lake for append.

<!--list-separator-->

-  Hive Style Partitions

    ```python
    # writing
    applications.to_parquet('somedir', schema = my_schema, partition_cols=['INCOME_TYPE'])

    # reading
    pd.read_parquet('somedir/NAME_INCOME_TYPE=Working/')
    # OR ( this does a seq scan for the partition unlike the direct path^)
    pd.read_parquet('somedir', filters=[('INCOME_TYPE', '=', 'Working')])
    # OR
    pd.read_parquet('somedir') # read the whole thing
    ```


#### Apache Arrow (in memory) {#apache-arrow--in-memory}

-   Arrow is an in-memory data format designed for efficient data processing and interchange.
-   Arrow provides the efficient data structures and some `compute kernels`, like a SUM, a FILTER, a MAX etc.
-   Arrow is **not** a [Query Engine]({{< relref "20231113151855-query_engines.md" >}})
-   Its primary focus is to enable fast analytics on big data by providing a standardized, language-agnostic memory format that supports zero-copy reads.
-   Makes it possible to exchange a pointer to some memory and other process would be able to read this memory without copy and use further.
-   Example of [DuckDB]({{< relref "20231123234702-duckdb.md" >}}) and Delta-rs
    -   Duckdb and deltars(data fusion) “speaks” arrow
    -   So you can read something in delta-rs and hand it over to duckdb engine in a format that both understand.


### Open Table formats {#open-table-formats}

![](/ox-hugo/20230405003455-data_engineering-482781745.png)
![](/ox-hugo/20230405003455-data_engineering-540870506.png)
Open table formats such as delta or iceberg were developed to serve the big data engines, such as spark or flink. But this is slowly changing as Delta Lake is slowly becoming agnostic and now can be accessed from polars and [DuckDB]({{< relref "20231123234702-duckdb.md" >}}) aswell.


#### Delta Table/Lake {#delta-table-lake}

-   Delta "Table/Lake" are interchangeable
-   `Delta Lake` is used to implement the Databricks lakehouse.
-   It is the "transactional layer" applied on top of the data lake "storage layer" via the transaction log.
    -   Allows for ACID capabilities (see [Database]({{< relref "20221102123145-database.md" >}}))
-   Delta Lake features break assumptions about data layout that might have been transferred from Parquet, Hive, or even earlier Delta Lake protocol versions.

<!--list-separator-->

-  What?

    {{< figure src="/ox-hugo/20230405003455-data_engineering-2138965607.png" >}}

    -   It is a folder with
        -   Many parquet files, which are normally just added
        -   A transaction log folder with metadata. (Storing metadata in transaction log more efficient than storing it in the parquet file itself?)
    -   These parquet files build up our last version of the tables.
    -   You can imagine that readers and writers add and delete parquet files and are synchronized over the transaction log folder.

<!--list-separator-->

-  Why?

    -   If we just have simple parquet files in our data lake, we'd have to write additional logic for upsert/merge etc. But with using something like Delta Lake, [this becomes simpler.](https://delta.io/blog/2023-10-22-delta-rs-python-v0.12.0/)

<!--list-separator-->

-  How

    See [More on Delta Table / Delta Lake]({{< relref "20240503221840-more_on_delta_table_delta_lake.md" >}})


### Dataframe libraries {#dataframe-libraries}


#### Polars {#polars}

More on [Polars]({{< relref "20240510084554-polars.md" >}})

-   Polars can inter-operate with other data processing libraries, including PyArrow. (Note pyarrow and arrow itself are different and polars plays well with both)
-   Polars [merely uses arrow2 as its in-memory representation](https://news.ycombinator.com/item?id=26454585) of data. Similar to how pandas uses `numpy`. But on top of arrow2, polars implements efficient algorithms for JOINS, GROUPBY, PIVOTs, MELTs, QUERY OPTIMIZATION, etc.
-   You can convert data between Polars dataframes and other formats, such as Pandas dataframes or Arrow tables
-   [I wrote one of the fastest DataFrame libraries | Ritchie Vink](https://www.ritchievink.com/blog/2021/02/28/i-wrote-one-of-the-fastest-dataframe-libraries/)
-   It works [nicely](https://duckdb.org/docs/guides/python/polars.html) with [DuckDB]({{< relref "20231123234702-duckdb.md" >}})


#### Pandas {#pandas}

-   Uses numpy as its data representation


## ETL {#etl}


### Meta Ideas about ETL {#meta-ideas-about-etl}


#### ETL or ELT? {#etl-or-elt}

-   Combination of cheap storage + easy to run compute = switch from ETL to ELT
-   In ELT, everyone just dumps the raw data and then does all the cleaning/transforming there with SQL.


#### Singer Spec (EL protocol) {#singer-spec--el-protocol}

-   Singer is an open-source project/protocol that provides a set of best practices for writing scripts that move data.
-   Singer uses a JSON-based specification for defining how data is extracted and load(`EL`), and it has a growing ecosystem of pre-built `taps` and `targets`
    -   `taps`: For extracting data from various sources
    -   `targets`: For loading data into different destinations
-   Issue with Singer is tap/target quality. The spec itself is fine, but the tap/targets written by the community need to be more standardized.
-   Singer is also a CLI tool??


#### Reverse ETL? (confirm?) {#reverse-etl--confirm}

-   This is basically creating operational/transactional database records from analytical db


### Data Pipeline Frameworks (for EL, Extract and Load) {#data-pipeline-frameworks--for-el-extract-and-load}

| Name         | Singer? | OSS/Selfhost? | Cloud/Paid? |
|--------------|---------|---------------|-------------|
| Stitch       | YES     | NO            | YES(less)   |
| Meltano      | YES     | YES           | Not Yet     |
| PipelineWise | YES     | YES           | NO          |
| Fivetran     | NO      | NO            | YES(very)   |
| Airbyte      | NO      | YES           | YES         |
| Hevodata     | NO      | NO            | YES         |

-   Cloud offerings usually have [orchestration]({{< relref "20231025103420-queues_and_scheduling.md" >}}) built in, so need not worry about that.
-   Lot of Meltano extractors/loaders are airbyte wrappers


#### Singer spec based {#singer-spec-based}

<!--list-separator-->

-  Stitch

    -   Stitch obviously gets a lot of use out of Singer,
    -   Stitch, of course, inherits all of Singer's problems, since it uses Singer.

<!--list-separator-->

-  Meltano

    -   Implementation of the `Singer spec`
    -   Singer SDK: Allows you to create a `tap` and `targets` for some sources, without groking the Singer spec. This tries to overcome issues about quality of taps/targets.
    -   Meltano also inherits all Singer issues.

<!--list-separator-->

-  PipelineWise

    -   Not very popular but is in the same bucket


#### Airbyte {#airbyte}

-   Airbyte data protocol (still compatible with Singer's one so you can easily migrate any tap to Airbyte)
-   Trying to build a better standard and connector ecosystem than Singer.
-   Doesn't have an official CLI, everything happens over API calls. For automation, [suggests a terraform provider.](https://reference.airbyte.com/reference/using-the-terraform-provider)


#### Fivetran {#fivetran}

-   Fivetran is an ELT tool and a direct competitor to Stitch


#### DltHub {#dlthub}

-   `dlt` is new kid in town
-   When using with dagster, a \`dlt\` pipeline would be a dagster asset
-   You can use singer taps with dlt, but it makes for a bad experience.
-   dlt is upstream of dbt, dlt loads data, dbt transforms it.
-   But they're sort of leaning of gpt for some reason, I don't understand why


### Data Transformation Frameworks {#data-transformation-frameworks}


#### Examples {#examples}

<!--list-separator-->

-  DBT (T, Transform)

    {{< figure src="/ox-hugo/20230405003455-data_engineering-1796721536.png" >}}

    -   Working isolated on a database server was complicated. A solution was introduced with dbt.
    -   Writing, versioning, testing, deploying, monitoring all that complicated SQL is very challenging. This is what DBT is good for. DBT doesn't replace SQL, it simply augments it by allowing you templatize, modularize, figure out all the inter-dependencies, etc.
    -   Why DBT? You would generally use dbt as a transform framework for the same reason you'd use Ruby on Rails or Django etc as a web framework
    -   [The unreasonable effectiveness of dbt](https://dbt.picturatechnica.com)
    -   Analogy (with MVC, See [Design Patterns]({{< relref "20221125204047-design_patterns.md" >}}))
        -   Model : source
        -   Controller : ephemeral model
        -   View : materialized (view, table, incremental) model
    -   DBT Gotchas
        -   The filename in the `models/` directory is the `table name` that the select statement will write to
        -   Currently only works with `.yml` files, not `.yaml`
        -   DBT [is not](https://stackoverflow.com/questions/63002171/can-dbt-connect-to-different-databases-in-the-same-project) a EL/Ingestion tool, the `source` and `target` need to be in the same `database`. i.e, You can't transform data from [PostgreSQL]({{< relref "20221102123302-postgresql.md" >}}) to [DuckDB]({{< relref "20231123234702-duckdb.md" >}}), you'd have to do the loading/ingestion step separately and then in whichever DB preferable, you do the transformation. After the transformation is done, we can decide where to store the transformed data, i.e the `target`

<!--list-separator-->

-  SQLMesh

    -   [GitHub - TobikoData/sqlmesh](https://github.com/TobikoData/sqlmesh) : Better alternative to DBT??


### Anomaly detection {#anomaly-detection}

-   <https://github.com/Desbordante/desbordante-core>
-   Great expectation etc


## Processing/Ingestion Types {#processing-ingestion-types}

> While batch/stream processing and batch/stream ingestion are two completely different things, this section talks all of it in general.


### Batch processing {#batch-processing}

-   See [Batch Processing Patterns]({{< relref "20240606113829-batch_processing_patterns.md" >}})
-   Ingesting data that's run daily and dumping into a bucket can be a batch operation


### Stream processing {#stream-processing}

See [Stream Processing/Ingestion Patterns]({{< relref "20240901014444-stream_processing_ingestion_patterns.md" >}})

-   **Streaming use cases are defined by the consumption SLA of the data, not the production.** 🌟
-   This can mean different things for different people, eg. for some ingestion pipeline, streaming might just means anything ingesting more often than every ten minutes.


### Update patterns {#update-patterns}

See <https://docs.delta.io/2.0.2/delta-update.html#-write-change-data-into-a-delta-table>


#### CDC {#cdc}

-   See [CDC ( Change Data Capture )]({{< relref "20240901210923-cdc_change_data_capture.md" >}})
-   See [Event Sourcing]({{< relref "20230406185222-event_sourcing.md" >}})


#### SCD Type2 {#scd-type2}


### Problems / Challenges {#problems-challenges}

-   De-duplication
-   Schema drift, column type change in source


## Related Topics {#related-topics}


### Information retrieval {#information-retrieval}

See [Information Retrieval]({{< relref "20231123014416-information_retrieval.md" >}})


### Caching related problems {#caching-related-problems}


#### Hotspots {#hotspots}

-   Horizontally scaled but shit going to the same node. UUID instead of incremental primary key would be a saver.


#### Cold start {#cold-start}

-   If cache crashes, all high traffic goes to db and db can crash again, so we need some way to warm up the cache beforehand


## <span class="org-todo todo TODO">TODO</span> Layered architecture {#layered-architecture}

> There is no one fits all architecture that makes sense for all situations. In fact it is mostly the opposite. The role of an architect is to know how to pick and choose patterns/technologies/methodologies to best solve a problem. The worst architects know one way of doing things and force it into every situation.
>
> The medallion architecture is one way to architect a data flow. Sometimes 3 stages is good. Sometimes you just need one. Maybe some complicated ones need 5. Also the stages don't necessarily need to be physically separate. A silver layer consisting only of views is perfectly valid.
>
> And for the love of money don’t call the layers bronze, silver and gold. I’ve moaned before about it, it is meaningless to users/engineers… like calling 1, 2 and 3. Give the layers meaning to what you intend to use them for. Raw, validated, conformed, enriched, curated, aggregated … people will know exactly what that layer means just by the name.
>
> -   Reddit users


### Medallion architecture {#medallion-architecture}

-   `bronze/raw/staging/landing`
    -   for data you have little to no control over, like data imported from external sources
    -   We may or may not retain these
-   `silver/intermediate/transform`
    -   your main work area, the bulk of tables go to this layer, little to no guarantee about forward/backward compatibility with external systems
    -   Minimal conversion to [Delta Table]({{< relref "20240503221840-more_on_delta_table_delta_lake.md" >}}). Minimal or no typing. Append only, may add columns for source file metadata or date or batch job id to rows. Will grnerally be 1/5th size of raw
-   `gold/final`
    -   data that you expose to external system: optimized for queries, strict schema compatibility, etc


### How many layers to have? {#how-many-layers-to-have}

-   Sometimes you might just need `bronze` -&gt; `gold`, sometimes the problem might demand something more than these 3 layers etc.


### What format should data be in each layer? {#what-format-should-data-be-in-each-layer}

-   The format could be anything, typical convention is raw will have parquet/json etc. Silver will have something like delta table etc, and gold will be some fast query db etc.
-   But all of these 3 could be the same too. Eg. all of the 3 could be different postgres tables, all 3 could be delta lake tables.


## Links {#links}

-   [Wide Column Store NoSQL vs SQL Data Modeling - YouTube](https://www.youtube.com/watch?v=bTEfRmdBq7I&t=457s)
-   [Scalable Efficient Big Data Pipeline Architecture – Machine Learning for Developers](https://www.ml4devs.com/articles/scalable-efficient-big-data-analytics-machine-learning-pipeline-architecture-on-cloud/)
-   <https://pandera.readthedocs.io/en/stable/> (similar to great expectations)
-   [Postgres Materialized Views from Parquet in S3 with Zero ETL | Lobsters](https://lobste.rs/s/xmgy3x/postgres_materialized_views_from)
