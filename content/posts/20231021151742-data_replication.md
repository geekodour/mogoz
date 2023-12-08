+++
title = "Data Replication"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Scaling Databases]({{< relref "20230608143206-scaling_databases.md" >}}), [Data Engineering]({{< relref "20230405003455-data_engineering.md" >}}), [Database]({{< relref "20221102123145-database.md" >}}), [Distributed Systems]({{< relref "20221102130004-distributed_systems.md" >}}), [Concurrency Consistency Models]({{< relref "20231113121413-concurrency_consistency_models.md" >}})


## FAQ {#faq}


### What does replication give? {#what-does-replication-give}

-   Availability
-   Fault tolerance


### Retries and Idempotency {#retries-and-idempotency}

-   `At-most-once`: Send request, don't retry, update may not happen
-   `At-least-once`: Retry request until `acknowledged`, may repeat update
-   `Exactly-once`: (retry + idempotence) or deduplication


### Issues with idempotency {#issues-with-idempotency}

{{< figure src="/ox-hugo/20231021151742-data_replication-1430351446.png" >}}

-   If the functions are different eg. add &amp; subtract on the same data, we don't have the same gurantees
-   \\(f(f(x)) = f(x) \quad \text{but} \quad f(g(f(x))) \neq g(f(x))\\)


### What's a tombstone? {#what-s-a-tombstone}

-   When we actually don't delete something
-   But instead just mark it as deleted
-   Can be GC'ed later


## Replication Types {#replication-types}


### Based on "How" {#based-on-how}

-   Sync
-   Async
-   [Consensus Protocols]({{< relref "20231118205116-consensus_protocols.md" >}})


## Failure Modes {#failure-modes}


### Node failures {#node-failures}

-   Followers/Secondary: catchup recovery from log
-   Leader
    -   Detecting leader failure: timeout based detection/Heartbeat message
    -   Leader Election: Node learns it's a leader, communicated w followers
    -   Failover


### Adding and removing data {#adding-and-removing-data}

{{< figure src="/ox-hugo/20231021151742-data_replication-1611841254.png" >}}

-   We can solve this by using logical [Clocks]({{< relref "20231119003900-clocks.md" >}}) and timestamps!
-   Every record has a logical timestamp of last write. This tells which values are newer/older.
-   Without timestamp even if replicas talked among themselves, they'll not know which one was the last write. With timestamp that's solved with a `reconcile state` / `anti-entropy` mechanism.
    ![](/ox-hugo/20231021151742-data_replication-2048671749.png)


## Architecture Types {#architecture-types}


### Leader-Follower {#leader-follower}


#### Single Leader {#single-leader}

-   Distinct Leader: Master or Primary
-   Followers: Read replicas, slaves, secondaries, participants
-   Flow
    -   Read through followers
    -   Write through leaders
-   Replication
    -   Sync: Blocking
    -   Async: Non-blocing
    -   Semi-Sync : Sometime sync/sometimes async
-   Issues
    -   With async, the new leader might not have the latest writes


### Leaderless {#leaderless}

-   See [Consensus Protocols]({{< relref "20231118205116-consensus_protocols.md" >}})


## Handling writes in Replicated Systems {#handling-writes-in-replicated-systems}

{{< figure src="/ox-hugo/20231021151742-data_replication-2052247902.png" >}}


### LWW (Last Writer Wins) {#lww--last-writer-wins}

-   We just keep the last value and discard others
-   Uses Lamport [Clocks]({{< relref "20231119003900-clocks.md" >}}) (total order)


### MVR (Multi Value Register) {#mvr--multi-value-register}

-   We want to keep all the values from all clients here
-   This will keep multiple values and cause a conflict, the application code then can decide how to deal with the conflict.
-   Uses Vector [Clocks]({{< relref "20231119003900-clocks.md" >}}) (partial order)


## <span class="org-todo todo TODO">TODO</span> Types {#types}

NOTE: Many of these could be different names for same thing


### WAL file archiving {#wal-file-archiving}


### Full table replication {#full-table-replication}

Full table replication copies all existing, new, and updated data from the primary database to the target, or even to every site in your distributed system.


### Key based (incremental) replication {#key-based--incremental--replication}

Key-based incremental replication identifies updated and new data using a replication key column in the primary database and only updates data in the replica databases which has changed since the last update. This key is typically a timestamp, datestamp, or an integer.


### Log based (incremental) replication {#log-based--incremental--replication}

Log-based incremental replication copies data based on the database binary log file, which provides information on changes to the primary database such as inserts, updates, and deletes.


### Logical replication {#logical-replication}


### Trigger based replication {#trigger-based-replication}


### Real time replication {#real-time-replication}


### Streaming replication {#streaming-replication}


### Multi master replication {#multi-master-replication}

-   More often than not, when people think they "need" multi-master they actually don't.
-   the application needs to be written for such a setup


### Master-Master replication {#master-master-replication}


### active-active replication {#active-active-replication}


## TO Read {#to-read}

-   Chain replication: <https://www.cs.princeton.edu/courses/archive/fall16/cos418/docs/L13-strong-cap.pdf>
-   I believe MongoDB has moved to a RAFT based algorithm in their new replication protocol, CockroachDB uses a variation on it. It and PAXOS are the two of the most common distributed consensus approaches I believe.
-   DDIA : Chapter 5 &amp; 7
-   [Replication, Clustering, and Connection Pooling - PostgreSQL wiki](https://wiki.postgresql.org/wiki/Replication,_Clustering,_and_Connection_Pooling)
-   [PostgreSQL: Documentation: 16: Chapter 27. High Availability, Load Balancing,...](https://www.postgresql.org/docs/current/high-availability.html)
-   <https://en.wikipedia.org/wiki/Replication_(computing)>
-   <https://arpitbhayani.me/blogs/multi-master-replication/>
-   <https://arpitbhayani.me/blogs/master-replica-replication/>
-   <https://www.reddit.com/r/SQLServer/comments/brqhfc/is_transactional_replication_the_right_approach/>
-   <https://www.reddit.com/r/dataengineering/comments/130ls2m/how_does_your_company_handle_replication_and_cdc/>
-   <https://debezium.io/>
-   <https://docs.google.com/spreadsheets/d/1DwobnPHZCCAYCcgR3u62-XFRwWQbbTXeurYo2-2rR0A/edit#gid=0>
-   <https://www.reddit.com/r/PostgreSQL/comments/9fjeoe/postgresql_tutorial_getting_started_with/>
-   <https://redis.com/blog/what-is-data-replication/>
-   <https://www.keboola.com/blog/database-replication-techniques>
-   <https://learn.microsoft.com/en-us/sql/relational-databases/replication/types-of-replication?view=sql-server-ver16>
-   <https://github.com/neuroforgede/pg_auto_failover_ansible>
-   <https://github.com/hapostgres/pg_auto_failover>
-   <https://www.2ndquadrant.com/en/blog/logical-replication-postgresql-10/>
-   <https://www.citusdata.com/blog/2018/02/21/three-approaches-to-postgresql-replication/>
-   <https://www.reddit.com/r/PostgreSQL/comments/10qn58p/logical_replication_in_postgresql/>
-   <https://medium.com/@piyushbhangale1995/logical-replication-in-postgresql-c448e4b3eb95>
-   <https://www.reddit.com/r/PostgreSQL/comments/14g0vls/framework_for_achieving_postgresql_multimaster/>
-   <https://www.enterprisedb.com/>
-   [Follower Reads](https://martinfowler.com/articles/patterns-of-distributed-systems/follower-reads.html)
