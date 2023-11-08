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


### Parquet {#parquet}

-   TODO need to read more
-   Data format [that allows querying](https://github.com/duckdb/duckdb/blob/6c7c9805fdf1604039ebed47d233ea55cabb4b2c/test/sql/copy/parquet/test_parquet_remote.test#L28)
-   Grafana Tempo switched from [Protocol Buffers]({{< relref "20230522131118-protocol_buffers.md" >}}) storage format to Apache Parquet last year.


## Information retrieval {#information-retrieval}

-   See [GitHub - kuutsav/information-retrieval: Neural information retrieval / semantic-search / Bi-Encoders](https://github.com/kuutsav/information-retrieval)


### Forward Index {#forward-index}

-   Eg. Doc123 =&gt; "the","apple","in","tree"
-   Keywords can be marked more or less relevant etc
-   Problems: capitalization, phases, alternate spellings, other stuff.
-   Inverted index can be generated out of it


### Ranking {#ranking}


#### TF-IDF (Term Freq. and Inverse Doc. Freq) {#tf-idf--term-freq-dot-and-inverse-doc-dot-freq}

-   Not used too much these days but old OG

<!--list-separator-->

-  Formula

    -   Term Freq: How often word appears in doc
    -   Doc Freq: How often word occurs in ALL set of documents. (Tells us that "is" is pretty common)
    -   Relevancy =  \\(\frac{Term Freq}{Document Freq}\\)
        -   i.e Term Freq \* 1/Doc Freq
        -   i.e Term Freq \* Inverse Doc Freq
        -   i.e TF-IDF


#### Page Rank {#page-rank}

-   Again not used a lot anymore but the algorithm was similar to TF-IDF but includes backlinks and a damping factor into the eqn.


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

-   [Wide Column Store NoSQL vs SQL Data Modeling - YouTube](https://www.youtube.com/watch?v=bTEfRmdBq7I&t=457s)
-   [Scalable Efficient Big Data Pipeline Architecture – Machine Learning for Developers](https://www.ml4devs.com/articles/scalable-efficient-big-data-analytics-machine-learning-pipeline-architecture-on-cloud/)
