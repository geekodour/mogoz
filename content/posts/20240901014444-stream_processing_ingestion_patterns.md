+++
title = "Stream Processing/Ingestion Patterns"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Data Engineering]({{< relref "20230405003455-data_engineering.md" >}}), [Batch Processing Patterns]({{< relref "20240606113829-batch_processing_patterns.md" >}})


## FAQ {#faq}


### How does differential dataflow relate to stream processing? {#how-does-differential-dataflow-relate-to-stream-processing}


### A problem statement for restaurant orders :) {#a-problem-statement-for-restaurant-orders}

> Let's assume we are building a data pipeline for Uber Eats where we keep getting orders. We want a dashboard which shows each restaurant owner
>
> -   How many orders?
> -   What are the Top 3 ordered dishes (with order count)?
> -   What’s the total sale amount?
>
> There are 3 buttons on the UI which allow the users (restaurant owners) to see these numbers for different time periods:
>
> -   Last 1 hour
> -   Last 24 hours (= 1 day)
> -   Last 168 hours (= 24h \* 7 = 1 week)
>
> The dashboard should get new data every 5 minutes. How do you collect, store and serve data?

See <https://www.reddit.com/r/dataengineering/comments/18ciwxo/how_do_streaming_aggregation_pipelines_work/>


## What is it really? {#what-is-it-really}

![](/ox-hugo/20240901014444-stream_processing_ingestion_patterns-1907756710.png)
[Rethinking Stream Processing and Streaming Databases - RisingWave: Open-Source Streaming SQL Platform](https://risingwave.com/blog/rethinking-stream-processing-and-streaming-databases/)

> `stream processing` and `streaming ingestion` are different things. There are systems which do one, there are also systems which do both, partially, fully, all tradeoffs.

{{< figure src="/ox-hugo/20240901014444-stream_processing_ingestion_patterns-1209853002.png" >}}


### Streaming ingestion {#streaming-ingestion}

-   This simply means ingesting to something in a streaming fashion (could be a OLAP database)
-   This has to deal with things like de-duplications as OLAP systems don't have a primary key etc. Schema and Datatype changes in source table etc.
-   Along with streaming ingestion lot of OLAP databases allow for `continuous processing` (different from stream processing)
    -   Underlying concept is that these systems store metrics state and update them as new data comes in.
    -   Some examples are: Dynamic table on Flink, Dynamic table on Snowflake, Materialized views on [Clickhouse]({{< relref "20240901192322-clickhouse.md" >}}), Delta Live table on Databricks etc.


### Stream processing {#stream-processing}

> Stream processing systems are designed to give quick updates over a pre-defined query. To achieve that, incremental computation lies at the core of the design principle of stream processing. Instead of rescanning the whole data repository, stream processing systems maintain some intermediate results to compute updates based only on the new data. Such intermediate results are also referred to as states in the system. In most cases, the states are stored in memory to guarantee the low latency of stateful computation. Such a design makes stream processing systems vulnerable to failures. The whole stream processing pipeline will collapse if the state on any node is lost. Hence, stream processing systems use checkpoint mechanisms to periodically back up a consistent snapshot of global states on an external durable storage system. If the system fails, it can roll back to the last checkpoint and recover its state from the durable storage system.

-   In most cases, they're more flexible and capable than OLAP db's `continious processing` features. So they sit in-front of the streaming ingestion into OLAP making sure OLAP gets cleaned and processed data.
    -   But in most cases, you might not even not need stream processing, whatever `continious processing` feature OLAP DBs have might be enough, they're great imo in 2024.


## Architectures {#architectures}

-   [Lambda](https://en.wikipedia.org/wiki/Lambda_architecture): Here we merge real-time and historical data together
    -   [How to create near real-time models with just dbt + SQL - Archive - dbt Community Forum](https://discourse.getdbt.com/t/how-to-create-near-real-time-models-with-just-dbt-sql/1457)
-   [Kappa](https://pradeepl.com/blog/kappa-architecture/): If you don’t need a lot of historical data, and only need streaming data.
    -   [ATProto for distributed systems engineers - AT Protocol](https://atproto.com/articles/atproto-for-distsys-engineers)


## Tech Comparison {#tech-comparison}

| RT Stream Processor | DBMS                                                                    | Tech Name                                                              | RT Stream Ingestion                                                                                                             | What?                                                                                                                                                                                                                                                                                                                                               |
|---------------------|-------------------------------------------------------------------------|------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Yes                 | No                                                                      | Apache Flink                                                           | Yes, but not meant to be a DB                                                                                                   | Can be used in-front of a OLAP store                                                                                                                                                                                                                                                                                                                |
| Yes                 | No                                                                      | Benthos/Redpanda Connect                                               | No                                                                                                                              | Apache Flink, Rising Wave alternative                                                                                                                                                                                                                                                                                                               |
| Yes                 | No                                                                      | [Proton](https://github.com/timeplus-io/proton)                        | No                                                                                                                              | Stream Processing for [Clickhouse]({{< relref "20240901192322-clickhouse.md" >}}) ?                                                                                                                                                                                                                                                                 |
| Yes                 | Yes ([PostgreSQL]({{< relref "20221102123302-postgresql.md" >}}) based) | RisingWave                                                             | Yes, but not meant to be a DB                                                                                                   | [Apache Flink alternative](https://docs.risingwave.com/docs/current/risingwave-flink-comparison/), it's pretty unique in what it does. See [comparision w MateralizeDB](https://github.com/orgs/risingwavelabs/discussions/1736)                                                                                                                    |
| Yes                 | Yes(OLAP)                                                               | [Materialize DB](https://materialize.com/)                             | Yes                                                                                                                             | Sort of combines `stream processing` + OLAP ([More powerful](https://www.reddit.com/r/dataengineering/comments/10ffdvx/optimize_joins_in_materialize_with_delta_queries/) than [Clickhouse]({{< relref "20240901192322-clickhouse.md" >}}) in that case), supports [PostgreSQL]({{< relref "20221102123302-postgresql.md" >}}) logical replication! |
| ?                   | Yes(OLAP)                                                               | BigQuery                                                               | Yes                                                                                                                             | It's BigQuery :)                                                                                                                                                                                                                                                                                                                                    |
| Not really          | Yes(OLAP)                                                               | Apache Druid                                                           | `True` realtime ingestion                                                                                                       | Alternative to [Clickhouse]({{< relref "20240901192322-clickhouse.md" >}})                                                                                                                                                                                                                                                                          |
| No                  | Yes(OLAP)                                                               | Apache [Pinot](https://www.uber.com/en-IN/blog/pinot-for-low-latency/) | Yes                                                                                                                             | Alternative to [Clickhouse]({{< relref "20240901192322-clickhouse.md" >}})                                                                                                                                                                                                                                                                          |
| No                  | Yes(OLAP)                                                               | [StarTree](https://startree.ai/)                                       | Yes                                                                                                                             | Managed Apache Pinot                                                                                                                                                                                                                                                                                                                                |
| No                  | Yes(OLAP)                                                               | [Clickhouse]({{< relref "20240901192322-clickhouse.md" >}})            | Yes, Batched realtime ingestion                                                                                                 | See [Clickhouse]({{< relref "20240901192322-clickhouse.md" >}})                                                                                                                                                                                                                                                                                     |
| No                  | Quack like it!(OLAP)                                                    | [DuckDB]({{< relref "20231123234702-duckdb.md" >}})                    | No                                                                                                                              | See [DuckDB]({{< relref "20231123234702-duckdb.md" >}})                                                                                                                                                                                                                                                                                             |
| No                  | Yes(OLAP)                                                               | Rockset                                                                | Yes                                                                                                                             | Easy to use alternative to Druid/Clickhouse. Handles [updates :)](https://rockset.com/blog/comparing-rockset-apache-druid-clickhouse-real-time-analytics/)                                                                                                                                                                                          |
| No                  | Yes(OLAP)                                                               | Snowflake                                                              | Yes but [not very good](https://clickhouse.com/blog/clickhouse-vs-snowflake-for-real-time-analytics-comparison-migration-guide) | -                                                                                                                                                                                                                                                                                                                                                   |
| No                  | No                                                                      | NATS                                                                   |                                                                                                                                 | [Message Broker]({{< relref "20240501121916-message_queue.md" >}})                                                                                                                                                                                                                                                                                  |
| No                  | No                                                                      | NATS Jetstream                                                         |                                                                                                                                 | [Kafka]({{< relref "20230210012126-kafka.md" >}}) alternative                                                                                                                                                                                                                                                                                       |
| No                  | No                                                                      | [Kafka]({{< relref "20230210012126-kafka.md" >}})                      |                                                                                                                                 | kafka is kafka                                                                                                                                                                                                                                                                                                                                      |


### Druid vs Clickhouse {#druid-vs-clickhouse}

> ClickHouse doesn’t guarantee newly ingested data is included in the next query result. Druid, meanwhile, does – efficiently, too, by storing the newly streamed data temporarily in the data nodes whilst simultaneously packing and shipping it off to deep storage.

-   Druid is more "true" realtime than clickhouse in this sense but that much of realtime is not usually needed in most of my cases.
-   [What Is Apache Druid And Why Do Companies Like Netflix And Reddit Use It? - YouTube](https://www.youtube.com/watch?v=rZTzl6iUKs4)

{{< figure src="/ox-hugo/20240901192322-clickhouse-461602811.png" >}}


### Risingwave vs Clickhouse {#risingwave-vs-clickhouse}

-   They can be used together


### Benthos(Redpanda Connect) vs Risingwave {#benthos--redpanda-connect--vs-risingwave}

-   Both are stream processors
-   Risingwave is a stateful streaming processor
-   Benthos is sitting somewhere between stateless and stateful systems


### NATS jetstream vs Benthos {#nats-jetstream-vs-benthos}

-   NATS jetstream seems like a persistent queue (Eg. [Kafka]({{< relref "20230210012126-kafka.md" >}}))
-   Benthos is something that would consume from that stream and do the stream processing and put the output elsewhere.


## things ppl say {#things-ppl-say}

-   We use debezium to stream CDC from our DB replica to Kafka.
    -   We have various services reading the CDC data from Kafka for processing


## Resources {#resources}

-   <https://web.archive.org/web/20230509174541/https://docs.google.com/spreadsheets/d/1DwobnPHZCCAYCcgR3u62-XFRwWQbbTXeurYo2-2rR0A/edit#gid=0>
