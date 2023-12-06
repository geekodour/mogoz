+++
title = "Data Engineering"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Distributed Systems]({{< relref "20221102130004-distributed_systems.md" >}}), [Database]({{< relref "20221102123145-database.md" >}}), [Caches]({{< relref "20221101214226-caches.md" >}})

{{< figure src="/ox-hugo/data_eng_landscape.jpg" >}}


## Jargons {#jargons}


### Data Lake {#data-lake}

-   Throw data into files like json, csv, parquet into a storage system like s3
-   Used for unstructured data/big data


### Data warehouse {#data-warehouse}

-   Exists because we have different sources
    -   OLTP source of truth database, but you also have SaaS products, events, logging exhaust, and honestly probably some other OLTP databases
-   Warehouse provides value because it brings together data that otherwise could not be jointly queried.
-   Traditionally used for analytical, but usecases for operational queries are also there


#### Analytical {#analytical}

-   Designed to grind through reams of historical data and efficiently produce periodic reports.


#### Operational {#operational}

{{< figure src="/ox-hugo/20230405003455-data_engineering-1333840662.png" >}}

-   Designed to ingested data continually and make it immediately available to query
-   This is not a popular thing yet but [Materialize is trying to do something around it.](https://materialize.com/blog/operational-data-warehouse/) It uses some Streaming technology.


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

<!--list-separator-->

-  Format

    {{< figure src="/ox-hugo/20230405003455-data_engineering-1722946962.png" >}}

    -   Hierarchically: `File > row group(s) > Column(s) > 1 column chunk > page(s)`
    -   Uses the [record shredding and assembly algorithm](https://github.com/julienledem/redelm/wiki/The-striping-and-assembly-algorithms-from-the-Dremel-paper) described in the Dremel paper.
    -   Data is stored in batches("row groups")
    -   Row Group = Batch = column(s)
    -   Each column can contain compressed data and metadata

<!--list-separator-->

-  Partitions

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


### Dataframe libraries {#dataframe-libraries}


#### Polars {#polars}

-   Polars can inter-operate with other data processing libraries, including PyArrow. (Note pyarrow and arrow itself are different and polars plays well with both)
-   Polars [merely uses arrow2 as its in-memory representation](https://news.ycombinator.com/item?id=26454585) of data. Similar to how pandas uses `numpy`. But on top of arrow2, polars implements efficient algorithms for JOINS, GROUPBY, PIVOTs, MELTs, QUERY OPTIMIZATION, etc.
-   You can convert data between Polars dataframes and other formats, such as Pandas dataframes or Arrow tables
-   [I wrote one of the fastest DataFrame libraries | Ritchie Vink](https://www.ritchievink.com/blog/2021/02/28/i-wrote-one-of-the-fastest-dataframe-libraries/)


#### Pandas {#pandas}

-   Uses numpy as its data representation


## Information retrieval {#information-retrieval}

See [Information Retrieval]({{< relref "20231123014416-information_retrieval.md" >}})


## Caching related problems {#caching-related-problems}


### Hotspots {#hotspots}

-   Horizontally scaled but shit going to the same node. UUID instead of incremental primary key would be a saver.


### Cold start {#cold-start}

-   If cache crashes, all high traffic goes to db and db can crash again, so we need some way to warm up the cache beforehand


## Processing Types {#processing-types}


### Batch processing {#batch-processing}


### Stream processing {#stream-processing}

-   This can mean different things for different people, eg. for some ingestion pipeline, streaming might just means anything ingesting more often than every ten minutes.


## Links {#links}

-   [Ask HN: Upskilling as a Data Engineer | Hacker News](https://news.ycombinator.com/item?id=34147090)
-   [Wide Column Store NoSQL vs SQL Data Modeling - YouTube](https://www.youtube.com/watch?v=bTEfRmdBq7I&t=457s)
-   [Scalable Efficient Big Data Pipeline Architecture – Machine Learning for Developers](https://www.ml4devs.com/articles/scalable-efficient-big-data-analytics-machine-learning-pipeline-architecture-on-cloud/)
