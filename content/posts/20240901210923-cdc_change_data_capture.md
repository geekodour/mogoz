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
-   <https://clickhouse.com/blog/clickhouse-postgresql-change-data-capture-cdc-part-2>
-   <https://en.wikipedia.org/wiki/Change_data_capture>
-   <https://github.com/tikal-fuseday/delta-architecture>
-   <https://www.decodable.co/connectors/postgres-cdc>
-   [Show HN: Light implementation of Event Sourcing using PostgreSQL as event store | Hacker News](https://news.ycombinator.com/item?id=38084098)
    -   <https://github.com/supabase/pg_replicate> (nice)


## [PostgreSQL]({{< relref "20221102123302-postgresql.md" >}}) CDC Tools {#postgresql--20221102123302-postgresql-dot-md--cdc-tools}

-   [Ways to capture changes in Postgres | Hacker News](https://news.ycombinator.com/item?id=37610899)
-   [Real-time Change Data Capture from Postgres 16 Read Replicas](https://blog.peerdb.io/real-time-change-data-capture-from-postgres-16-read-replicas)
-   [Reliably replicating data between Postgres and ClickHouse | Hacker News](https://news.ycombinator.com/item?id=43111294) and [Clickhouse]({{< relref "20240901192322-clickhouse.md" >}})
-   <https://github.com/xataio/pgstream>
-   <https://github.com/pgflo/pg_flo>
-   <https://github.com/redpanda-data/connect/pull/2917>
-   <https://github.com/sequinstream/sequin>
-   [Kuvasz-streamer: open-source CDC for Postgres for low latency replication | Hacker News](https://news.ycombinator.com/item?id=42582203)
