+++
title = "CDC ( Change Data Capture )"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Data Replication]({{< relref "20231021151742-data_replication.md" >}}), [Data Engineering]({{< relref "20230405003455-data_engineering.md" >}}), [Stream Processing/Ingestion Patterns]({{< relref "20240901014444-stream_processing_ingestion_patterns.md" >}}), [Batch Processing Patterns]({{< relref "20240606113829-batch_processing_patterns.md" >}}), [Event Sourcing]({{< relref "20230406185222-event_sourcing.md" >}})


## What? {#what}

-   If you need to maintain constraints before events are written (e.g. not selling more items than you have in stock). It's easier to use a DB and CDC.
-   CDC enables real-time or near-real-time data synchronization and helps ensure that downstream systems are kept up to date with the latest changes in the data sources.
-   See ["Change Data Capture Breaks Encapsulation". Does it, though?](https://lobste.rs/s/yepcsr/change_data_capture_breaks)
-   See [DBLog: A Generic Change-Data-Capture Framework | by Netflix Technology Blog | Netflix TechBlog](https://netflixtechblog.com/dblog-a-generic-change-data-capture-framework-69351fb9099b)


### Outbox Pattern {#outbox-pattern}

{{< figure src="/ox-hugo/20230406185222-event_sourcing-978549675.png" >}}


### CDC vs CQRS {#cdc-vs-cqrs}

-   These are different things and can compliment each other
-   CQRS
    -   Gives us a better and optimized system for r/w if the scenario is right
    -   A pattern that separates the read and write responsibilities of a system into distinct components. CQRS allows for a more optimized and scalable system by tailoring the data models and operations to the specific needs of reading and writing.
-   CDC
    -   Because w Event driven systems, we get eventual consistency, read data might not be upto-date. If we really need it, we can use CDC.
    -   A technique used to capture and propagate data changes from a source system to other systems or components.
    -   It focuses on capturing the changes made to a data source and making those changes available to other parts of the system in a real-time or near-real-time manner.
    -   Can also be used to add constratints before write.


### Replication for CDC {#replication-for-cdc}

See [Data Replication]({{< relref "20231021151742-data_replication.md" >}})
![](/ox-hugo/20230406185222-event_sourcing-1535234753.png)


## Resources to come back later {#resources-to-come-back-later}

-   [Change Data Capture (CDC) Tools should be database specialized not generalized | Hacker News](https://news.ycombinator.com/item?id=41304830)
-   <https://en.wikipedia.org/wiki/Change_data_capture>
-   <https://github.com/tikal-fuseday/delta-architecture>
-   <https://www.decodable.co/connectors/postgres-cdc>
-   <https://medium.com/@howdyservices9/real-time-replication-from-postgres-to-delta-lake-using-debezium-kafka-connect-spark-structured-626dc7f1e3e1>
-   <https://medium.com/@dinesh.reddy_80040/building-a-robust-cdc-pipeline-mysql-to-delta-lake-via-debezium-kafka-pyspark-streaming-and-ba9264591d86>
-   <https://medium.com/israeli-tech-radar/streaming-data-changes-to-a-data-lake-with-debezium-and-delta-lake-pipeline-299821053dc3>
-   <https://debezium.io/>
-   <https://clickhouse.com/blog/clickhouse-postgresql-change-data-capture-cdc-part-2>
-   [Show HN: Light implementation of Event Sourcing using PostgreSQL as event store | Hacker News](https://news.ycombinator.com/item?id=38084098)
    -   <https://github.com/supabase/pg_replicate> (nice)
-   <https://news.ycombinator.com/item?id=37610899>
-   <https://blog.peerdb.io/real-time-change-data-capture-from-postgres-16-read-replicas>
