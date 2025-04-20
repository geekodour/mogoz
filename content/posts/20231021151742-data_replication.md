+++
title = "Data Replication"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Scaling Databases]({{< relref "20230608143206-scaling_databases.md" >}}), [Data Engineering]({{< relref "20230405003455-data_engineering.md" >}}), [Database]({{< relref "20221102123145-database.md" >}}), [Distributed Systems]({{< relref "20221102130004-distributed_systems.md" >}}), [Concurrency Consistency Models]({{< relref "20231113121413-concurrency_consistency_models.md" >}}), [Raft]({{< relref "20240912140206-raft.md" >}}), [crdt]({{< relref "20230607045339-crdt.md" >}})

OG Blogpost:

-   [Data Replication Design Spectrum](https://transactional.blog/blog/2024-data-replication-design-spectrum#Hermes) 🌟
-   [Constraining writers in distributed systems](https://shachaf.net/w/constraining-writers-in-distributed-systems)


## FAQ {#faq}


### What does replication give? {#what-does-replication-give}

The methodologies to attain this via data replication are different.

-   Availability
-   Fault tolerance (Durability)
    -   Eg. We store progress state and make sure to replicate it so that in times of crash, we can easily restart from the last checkpoint.


### How does [Consensus Protocols]({{< relref "20231118205116-consensus_protocols.md" >}}) relate to [Data Replication]({{< relref "20231021151742-data_replication.md" >}})? {#how-does-consensus-protocols--20231118205116-consensus-protocols-dot-md--relate-to-data-replication--20231021151742-data-replication-dot-md}

-   There are replication architecture which use the concept of leader or there's need of consensus, we need it then.
-   [When Does Consistency Require Coordination? | Peter Bailis](http://www.bailis.org/blog/when-does-consistency-require-coordination/)


### Retries and Idempotency {#retries-and-idempotency}

See [Data Delivery]({{< relref "20240722202632-data_delivery.md" >}})

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


## Handling writes in Replicated Systems {#handling-writes-in-replicated-systems}

{{< figure src="/ox-hugo/20231021151742-data_replication-2052247902.png" >}}


### LWW (Last Writer Wins) {#lww--last-writer-wins}

-   We just keep the last value and discard others
-   Uses Lamport [Clocks]({{< relref "20231119003900-clocks.md" >}}) (total order)


### MVR (Multi Value Register) {#mvr--multi-value-register}

-   We want to keep all the values from all clients here
-   This will keep multiple values and cause a conflict, the application code then can decide how to deal with the conflict.
-   Uses Vector [Clocks]({{< relref "20231119003900-clocks.md" >}}) (partial order)


## Types &amp; Protocols {#types-and-protocols}

> Context(as how I understand and try to fit in my mind):
>
> -   Types/methods: Uses cases and variants of replications, "types of replication" becomes what that replication allows
> -   Protocol: Underlying idea that can be used to implement the different "types of replication"


### Replication types/methods {#replication-types-methods}

> -   These are mostly in context of database and transactional replication but can be applied to any distributed system
> -   NOTE: Also see [PostgreSQL]({{< relref "20221102123302-postgresql.md" >}}) on the replication section.
> -   NOTE: There are other terminologies such as active-active etc.
>     I am avoiding them as I don't really want to get all that in my head rn.
>     I am born to strike stones and create fire.

| Context          | Name                                                                                                | Other names                                     | What?                                                                                                                                       |
|------------------|-----------------------------------------------------------------------------------------------------|-------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------|
| Database related | Logical                                                                                             |                                                 | PG specific, but logically replicate parts of the data                                                                                      |
|                  | Streaming                                                                                           | Physical                                        | When we want to stream the changes to replica/standby (In PG, its based on WAL streaming)                                                   |
|                  | Snapshot                                                                                            |                                                 |                                                                                                                                             |
|                  | Log based                                                                                           |                                                 | Eg. In case of [PostgreSQL]({{< relref "20221102123302-postgresql.md" >}}), WAL based replication, (Streaming replication/WAL archival etc) |
|                  |                                                                                                     |                                                 |                                                                                                                                             |
| Transactions     | Synchronous                                                                                         |                                                 | Slow, there should be no lag in data                                                                                                        |
|                  | Asynchronous                                                                                        |                                                 | Fast, there will be some lag in data                                                                                                        |
|                  | Semi-Synchronous                                                                                    |                                                 | In case of too many replicas, we selectively do sync for some to ensure some consistency and speed                                          |
|                  |                                                                                                     |                                                 |                                                                                                                                             |
| Architecture     | [Leader-Follower](https://arpitbhayani.me/blogs/master-replica-replication/) (single writer/leader) | primary-backup, primary-replica, master-replica | Eg. [PostgreSQL]({{< relref "20221102123302-postgresql.md" >}}) streaming replication                                                       |
|                  | Leader-Follower (multi writer/leader)                                                               |                                                 | Eg. CockroachDB(fake multi-writer, write is propagated to the leader)                                                                       |
|                  | [Multi Master](https://arpitbhayani.me/blogs/replication-formats) (true multi writer)               | multi-primary                                   | Every node is able to `accept and DO` the write. (There are some arch where we have RO replicas etc)                                        |
|                  | [Leaderless](https://arpitbhayani.me/blogs/leaderless-replication)                                  |                                                 |                                                                                                                                             |

Following are some notes on types that I am little familiar with.


#### Leader-Follower {#leader-follower}

> -   These can be used to lower load on primary/leader and also can be used as a failover mechanism
> -   It's much easier to achieve consistency with Leader-Follower setup than to use a "true multi master setup"
> -   If you want there to be one single leader you cannot elect a leader without either `consensus` or `operator intervention`

<!--list-separator-->

-  Single writer

<!--list-separator-->

-  Multi writer (multiple writers accept, but only leader writes)

    Not all servers accept writes, they proxy them to the leader.
    <https://www.reddit.com/r/PostgreSQL/comments/14g0vls/framework_for_achieving_postgresql_multimaster/>


#### Multi Master {#multi-master}

> -   More often than not, when people think they "need" multi-master they actually don't.
> -   Additionally: the application needs to be written for such a setup.
> -   People don't seem to understand that almost no platform is automatically compatible with MM out of the box. You have to account for sequence allocation, conflict management, cumulative data types, read/write race conditions (PACELC), session / server affinity, and far more besides. I

Any replica can process a request and distribute a new state.

<!--list-separator-->

-  Main challenges

    -   `conflict prevention` and `conflict resolution`
    -   Synchronous(eager): Conflict prevention
    -   Async(lazy): Conflict resolution

<!--list-separator-->

-  Ways to implement

    There are diff protocols to solve this

    -   Usually needs some form of distributed concurrency control must be used, such as a distributed lock manager.
    -   virtual synchrony model can be used aswell, chain replication etc. (See "Replication Protocols" in this page)


### Replication protocols {#replication-protocols}

> -   Now databases are also distributed systems but I wanted to separate out systems which need to replication beyond "database" needs, hence this distinction in types.
> -   [Types of Replication - SQL Server | Microsoft Learn](https://learn.microsoft.com/en-us/sql/relational-databases/replication/types-of-replication?view=sql-server-ver16) (Reading this I realized the names are very loosly held, don't go by names, this is similar to [Design Patterns]({{< relref "20221125204047-design_patterns.md" >}}))
> -   [Data Replication Design Spectrum](https://transactional.blog/blog/2024-data-replication-design-spectrum) 🌟

| Name                           | What? | Incremental | Example |
|--------------------------------|-------|-------------|---------|
| Streaming/Physical             |       |             |         |
| Broadcast based                |       |             |         |
| Chain based                    |       |             |         |
| Re-configuration based         |       |             |         |
| State Machine Replication(SMR) |       |             |         |
| Virtual Synchrony              |       |             |         |
| Hermes                         |       |             |         |


#### What are we taking about when we're talking about replication protocol? {#what-are-we-taking-about-when-we-re-talking-about-replication-protocol}

-   `“whatever the simplest replication topology is”` + `“whatever the simplest membership maintenance algorithm is“`


#### Notes on some replication protocols {#notes-on-some-replication-protocols}

<!--list-separator-->

-  Viewstamped Replication Protocol

    -   Q: This is consensus protocol or replication protocol?
    -   <https://github.com/tigerbeetle/tigerbeetle/blob/main/src/vsr/replica.zig>
    -   See [Consensus Protocols]({{< relref "20231118205116-consensus_protocols.md" >}})

<!--list-separator-->

-  Chain based

    -   Chain replication is simple but it does also assume you have a consensus implementation so I sort of disqualify it from being the simplest

<!--list-separator-->

-  Human based

    -   Old-school primary backup replication is probably the simplest, as your replication topology is dictated by a human operator


## TO Read {#to-read}

-   Chain replication: <https://www.cs.princeton.edu/courses/archive/fall16/cos418/docs/L13-strong-cap.pdf>
-   I believe MongoDB has moved to a RAFT based algorithm in their new replication protocol, CockroachDB uses a variation on it. It and PAXOS are the two of the most common distributed consensus approaches I believe.
-   DDIA : Chapter 5 &amp; 7
-   <https://developer.confluent.io/courses/architecture/data-replication/?s=35>
