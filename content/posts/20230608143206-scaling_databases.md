+++
title = "Scaling Databases"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Database]({{< relref "20221102123145-database.md" >}}), [Distributed Systems]({{< relref "20221102130004-distributed_systems.md" >}}), [System Design]({{< relref "20230113141133-system_design.md" >}})

<div class="warning small-text">

> -   Scaling vertically means something totally diff. compared to sharding vertically. Something to keep in mind.
</div>

|            | Sharding                                                        | Partitioning                                  | Scaling           |
|------------|-----------------------------------------------------------------|-----------------------------------------------|-------------------|
| Horizontal | One that uses row-partitioning(more talked about)               | row-partitioning                              | Scale out(shard)  |
| Vertical   | One that uses column-partitioning(usually application specific) | column-partitioning, similar to normalization | Scale up(beef up) |


## Scaling {#scaling}


### Things to consider before you scale {#things-to-consider-before-you-scale}

<div class="warning small-text">

> Notes
>
> -   Indexes and replications make lookup/reads easier but can cause difficulties with writes
</div>

-   [ ] Query logs, slow queries, optimize?
-   [ ] Schema change? Poor design?
-   [ ] What kind of load are we dealing w, read or write?
-   [ ] Indexes? Indexes speed up reads, but slow down writes
-   [ ] Do we need additional caching before DB layer?
-   [ ] Batch writing?
-   [ ] If data is not immediately needed, can we queue it?
-   [ ] If load is read heavy, will replication help? (be aware of complicated writes)
    ![](/ox-hugo/20230608143206-scaling_databases-1527913602.png)
-   [ ] Basically try all the performance optimizations you can do


### You are sure that you need to scale things. {#you-are-sure-that-you-need-to-scale-things-dot}

You've tried all performance optimizations, nothing seems to meet your needs. It's time to scale up/out.


#### Scale up (Vertical) {#scale-up--vertical}

-   Increasing capacity of server
-   It's easier to scale up than scale out.


#### Scale out (Horizontal) {#scale-out--horizontal}

-   This is basically sharding ( **sharding is the last resort** )
-   Sharding is an example of horizontal scaling
-   Because RDBMS are designed to run on a single machine, sharding takes some effort and it's not something to do casually.
-   It changes the kind of queries you can run. In an existing project, sharding would very likely break things.


## Sharding {#sharding}

-   Read
    -   [How does database sharding work?](https://planetscale.com/blog/how-does-database-sharding-work)
    -   [Database Sharding Explained](https://architecturenotes.co/database-sharding-explained/)
-   It's a concept related to distributed systems(different machines) and uses the ideas of database partitioning in dist sys setting.
-   Because this results in smaller tables it'll most likely improve performance etc(at the db layer atleast).
-   Vitess(MySQL) and [Citus](https://www.citusdata.com/)([PostgreSQL]({{< relref "20221102123302-postgresql.md" >}})) can help you shard v/s sharding manually.
-   You also have databases and services that [do sharding](https://research.google/pubs/pub39966/) for you (Eg.[cockroachDB](https://www.cockroachlabs.com/), planetscale, dynamo, cassandra, yugabytedb etc.)


### What it involves? {#what-it-involves}


#### Decide on a sharding scheme {#decide-on-a-sharding-scheme}

-   What data gets split up, and how? How is it organized?
-   Considering which tables are stored together because JOINs across systems is costly.


#### Organize your target infrastructure {#organize-your-target-infrastructure}

-   How many servers are you sharding to? How much data will be on each one?
-   You would want to optimize for flexibility


#### Create a routing layer {#create-a-routing-layer}

-   How does your application know where to store new data, and query existing data?
-   This usually is implemented in the application layer, can be relatively simple and stored in a JSON blob, config file, kv store etc.


#### Planning and executing the migration {#planning-and-executing-the-migration}

-   How do you migrate from a single database to many with minimal downtime?
-   Migration strategy can be business specific but a rough idea can be something like
    -   Double-write: Incoming writes get applied to both the old and new databases.
    -   Backfill: Once double-writing has begun, migrate the old data to the new database.
    -   Verification: Ensure the integrity of data in the new database.
    -   Switch-over: Actually switch to the new database. This can be done incrementally, e.g. double-reads, then migrate all reads.


### Partition strategies {#partition-strategies}

{{< figure src="/ox-hugo/20230608143206-scaling_databases-1096083832.png" >}}


#### Horizontal/Row partitioning {#horizontal-row-partitioning}

-   Split things at the row level based on certain attributes of the content of the row(See schemes).


#### Vertical/Column partitioning {#vertical-column-partitioning}

-   Split things at the schema/table/column level.


### Shard key and shards {#shard-key-and-shards}

{{< figure src="/ox-hugo/20230608143206-scaling_databases-2034465638.png" >}}

-   Shard Key is a piece of the primary key that tells how the data should be distributed.
-   The same node houses entries that have the same shard key.


#### Physical shard {#physical-shard}

-   The database node is also called the physical shard
-   Multiple logical shards are included in a database node, also known as a physical shard.


#### Logical shard {#logical-shard}

-   Each small table is called a logical shard.
-   A logical shard can only span one node because it is an atomic unit of storage.


### Sharding Scheme {#sharding-scheme}

-   The outcome of a scheme is that it gives you a `shard key` which you can use to do database operations on.
-   The strategy can be very specific to the organization/business
-   There are some popular thinking frameworks like hash, range, directory based etc. (These are mostly `vertically-partitioned-sharding-schemes`)


#### Hash based/Key based {#hash-based-key-based}

{{< figure src="/ox-hugo/20230608143206-scaling_databases-326042762.png" >}}

-   Eg. Normal hash-table like strategy to distribute the load


#### Range based {#range-based}

{{< figure src="/ox-hugo/20230608143206-scaling_databases-1126928374.png" >}}

-   Divides the data into rows based on a determined key or range of values.
-   Eg. How notion sharded [based on teamID](https://www.notion.so/blog/sharding-postgres-at-notion)


#### Directory based {#directory-based}

-   Eg. Sharding based on organization, like how Clarisights would do it.


### Cross-shard/Global transactions {#cross-shard-global-transactions}

-   Usually you want to avoid cross shard stuff by keeping related tables in the same node.
-   But you can't always avoid global transactions. i.e multiple sub-transactions(across shards) need to coordinate and succeed.
-   The secret to performant manual sharding is to figure out a way to minimize JOINs across shards
-   One solution is 2PC (2 Phase commit)
