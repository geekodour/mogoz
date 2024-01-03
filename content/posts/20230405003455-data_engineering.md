+++
title = "Data Engineering"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Distributed Systems]({{< relref "20221102130004-distributed_systems.md" >}}), [Database]({{< relref "20221102123145-database.md" >}}), [Caches]({{< relref "20221101214226-caches.md" >}})

{{< figure src="/ox-hugo/data_eng_landscape.jpg" >}}


## FAQ {#faq}


### <span class="org-todo todo TODO">TODO</span> Data Layers? {#data-layers}

NOTE: This is just for my understanding

-   Storage Layer: S3, Parquet, Other file types
-   Transaction Layer: Open table formats, eg. Delta Lake
-   Semantic Layer


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


## Data Warehouse and Data Lake {#data-warehouse-and-data-lake}

{{< figure src="/ox-hugo/20230405003455-data_engineering-1415605235.png" >}}


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
    -   Uses the [record shredding and assembly algorithm](https://github.com/julienledem/redelm/wiki/The-striping-and-assembly-algorithms-from-the-Dremel-paper) described in the Dremel paper.
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

    {{< figure src="/ox-hugo/20230405003455-data_engineering-1276164824.png" >}}

    -   Earlier this was only available to be used via Spark based APIs. But with `delta-rs`, this changes and we can access delta lake with other APIs.
    -   [DuckDB]({{< relref "20231123234702-duckdb.md" >}}) with pyarrow
        -   [milicevica23/dbt-duckdb-delta-plugin-demo](https://github.com/milicevica23/dbt-duckdb-delta-plugin-demo)
        -   [Native Support for Deltalake · duckdb/duckdb · Discussion #4463 · GitHub](https://github.com/duckdb/duckdb/discussions/4463)
        -   [Build a poor man’s data lake from scratch with DuckDB | Dagster Blog](https://dagster.io/blog/duckdb-data-lake)
        -   Uses `delta-rs`, an of the Delta Lake protocol in Rust, featuring Python bindings.
    -   Polars
        -   Polars Delta Lake connector depends on `delta-rs`
        -   [Goodbye Spark. Hello Polars + Delta Lake. - by Daniel Beach](https://dataengineeringcentral.substack.com/p/goodbye-spark-hello-polars-delta)
        -   [Reading Delta Lake Tables into Polars DataFrames | Delta Lake](https://delta.io/blog/2022-12-22-reading-delta-lake-tables-polars-dataframe/)
        -   [Building a poor man's data lake: Exploring Polars and Delta Lake](https://www.edgarbahilo.com/poor-mans-data-lake-with-polars-deltalake/)
        -   [pola-rs/polars#11039 Add \`sink_delta\` to write delta table](https://github.com/pola-rs/polars/issues/11039) (Streaming Write Support not Yet)
    -   [Kafka]({{< relref "20230210012126-kafka.md" >}})
        -   [delta-io/kafka-delta-ingest](https://github.com/delta-io/kafka-delta-ingest)

<!--list-separator-->

- <span class="org-todo todo TODO">TODO</span>  Merging in Delta

    -   [New features in the Python deltalake 0.12.0 release | Delta Lake](https://delta.io/blog/2023-10-22-delta-rs-python-v0.12.0/)
    -   [Delta Lake Merge | Delta Lake](https://delta.io/blog/2023-02-14-delta-lake-merge/)
    -   [pola-rs/polars#11983 Support merge operation for Delta tables](https://github.com/pola-rs/polars/issues/11983)
    -   [pola-rs/polars#12392 feat(python): \`merge\` w/o pyarrow ](https://github.com/pola-rs/polars/pull/12392)
    -   [Implement merge command · Issue #850 · delta-io/delta-rs · GitHub](https://github.com/delta-io/delta-rs/issues/850)
    -   [Support merge (upsert) in Python · Issue #1357 · delta-io/delta-rs · GitHub](https://github.com/delta-io/delta-rs/issues/1357)

    <!--list-separator-->

    -  MERGE INTO

        -   You have some JOIN between one or more columns between two Delta tables. If there is a match then UPDATE, otherwise if there is NO match then INSERT.
        -   MERGE INTO is slow on big datasets. Think about compaction and access patterns if this happens.
        -   Having partitioning and using it in the query can help.

    <!--list-separator-->

    -  Merging vs Append

        -   Append: When you know there are no duplicates


### Dataframe libraries {#dataframe-libraries}


#### Polars {#polars}

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


### DBT (T, Transform) {#dbt--t-transform}

{{< figure src="/ox-hugo/20230405003455-data_engineering-1796721536.png" >}}

-   Working isolated on a database server was complicated. A solution was introduced with dbt.
-   Writing, versioning, testing, deploying, monitoring all that complicated SQL is very challenging. This is what DBT is good for. DBT doesn't replace SQL, it simply augments it by allowing you templatize, modularize, figure out all the inter-dependencies, etc.
-   Why DBT? You would generally use dbt as a transform framework for the same reason you'd use Ruby on Rails or Django etc as a web framework
-   [The unreasonable effectiveness of dbt](https://dbt.picturatechnica.com)
-   Analogy (with MVC, See [Design Patterns]({{< relref "20221125204047-design_patterns.md" >}}))
    -   Model : source
    -   Controller : ephemeral model
    -   View : materialized (view, table, incremental) model


## Processing Types {#processing-types}


### Batch processing {#batch-processing}

-   Ingesting data that's run daily and dumping into a bucket can be a batch operation


### Stream processing {#stream-processing}

-   This can mean different things for different people, eg. for some ingestion pipeline, streaming might just means anything ingesting more often than every ten minutes.


#### Streaming Databases {#streaming-databases}

-   [Apache Flink and RisingWave](https://risingwave.com/blog/the-preview-of-stream-processing-performance-report-apache-flink-and-risingwave-comparison/)
-   [RisingWave, the Rust-Written Open-Source Streaming Database Released Version 1.1](https://www.reddit.com/r/rust/comments/15xd03y/risingwave_the_rustwritten_opensource_streaming/)
-   [Rethinking Stream Processing and Streaming Databases](https://www.reddit.com/r/apachekafka/comments/10x684l/rethinking_stream_processing_and_streaming/) (Good background)


## Related Topics {#related-topics}


### Information retrieval {#information-retrieval}

See [Information Retrieval]({{< relref "20231123014416-information_retrieval.md" >}})


### Caching related problems {#caching-related-problems}


#### Hotspots {#hotspots}

-   Horizontally scaled but shit going to the same node. UUID instead of incremental primary key would be a saver.


#### Cold start {#cold-start}

-   If cache crashes, all high traffic goes to db and db can crash again, so we need some way to warm up the cache beforehand


## Links {#links}

-   [Ask HN: Upskilling as a Data Engineer | Hacker News](https://news.ycombinator.com/item?id=34147090)
-   [Wide Column Store NoSQL vs SQL Data Modeling - YouTube](https://www.youtube.com/watch?v=bTEfRmdBq7I&t=457s)
-   [Scalable Efficient Big Data Pipeline Architecture – Machine Learning for Developers](https://www.ml4devs.com/articles/scalable-efficient-big-data-analytics-machine-learning-pipeline-architecture-on-cloud/)
