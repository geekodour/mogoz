+++
title = "Database Transactions"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Database]({{< relref "20221102123145-database.md" >}}), [Concurrency]({{< relref "20221126204257-concurrency.md" >}}), [Concurrency Consistency Models]({{< relref "20231113121413-concurrency_consistency_models.md" >}}), [Distributed Systems]({{< relref "20221102130004-distributed_systems.md" >}})

> A transaction may contain arbitrary code, but it is fundamentally single-threaded.


## FAQ {#faq}


### Are `SELECT` statements also transactions? {#are-select-statements-also-transactions}

-   Yes. Since "Read" is subject to Isolation level, it needs to be a transaction. Eg. What is there that it can see depends on isolation level.


### Commits and Rollbacks {#commits-and-rollbacks}

-   Commit
    -   When: If a transaction completes
    -   Change is made permanent in the DB
-   Rollback
    -   When: If a transaction aborts/fails
    -   Undo all changes by the transaction


### Distributed transaction vs normal DB transaction {#distributed-transaction-vs-normal-db-transaction}

-   `Transaction Protocol = Concurrency Control(CC) + Atomic Commit Protocol`
-   `Distributed Transaction Protocol = Transaction Protocol + Replication Protocol`


#### Normal DB transaction {#normal-db-transaction}

-   Single DB system
-   Set of operations that we want to perform on our data
-   Typically, a transaction is an all-or-nothing affair
-   ACID properties can be implemented directly


#### Distributed transaction {#distributed-transaction}

-   Multiple systems/DB systems interacting. i.e Commit happens to more than one piece of hardware.
-   ACID properties over the network(handle network partitions)
-   Involves more coordination, messaging, logging etc. than normal transactions
-   Needs mechanisms like [Two Phase Commit (2PC)]({{< relref "20231116010456-two_phase_locking_2pl.md" >}})


## Normal Database Transactions {#normal-database-transactions}

This is done differently for different DBs, following is [PostgreSQL]({{< relref "20221102123302-postgresql.md" >}})'s approach


### How to do transaction? {#how-to-do-transaction}

-   Start: `BEGIN` or `START TRANSACTION`
-   End: `COMMIT` or `ROLLBACK`
-   i.e You can't have multiple `COMMIT` in a transaction, `COMMIT` / `ROLLBACK` marks the end of the transaction. (Nested transactions behave little differently)
-   You can have multiple `ROLLBACK` if you use `SAVEPOINT`
-   Sometimes they can `ABORT`
-   SQL statements outside of explicit transactions(BEGIN/COMMIT) automatically use single-statement transactions.


### Lifecycle &amp; Ordering {#lifecycle-and-ordering}

-   `T1` (started first) and `T2` (started later) both are RW transaction
-   `T1` does a lot of reads and then writes
-   `T2` writes and then does some reads
-   In this case, even if `T1` started before, it does not guarantee that writes from `T1` would go in first.


## Distributed Transactions {#distributed-transactions}

-   See [Distributed Systems]({{< relref "20221102130004-distributed_systems.md" >}}), [Data Replication]({{< relref "20231021151742-data_replication.md" >}})
-   See [Using Atomic Transactions to Power an Idempotent API](https://brandur.org/http-transactions#create-user)
-   See [An illustrated proof of the CAP theorem (2018) | Hacker News](https://news.ycombinator.com/item?id=41772624)
-   See [CAP]({{< relref "20221102130004-distributed_systems.md#cap" >}})
-   This is `Atomicity v/s Partial Failures`
-   `Transaction Protocol = Concurrency Control(CC) + Atomic Commit Protocol`
-   `Distributed Transaction Protocol = Transaction Protocol + Replication Protocol`


### Approaches {#approaches}


#### Two Phase Commit {#two-phase-commit}

{{< figure src="/ox-hugo/20231113145513-database_transactions-191620255.png" >}}

-   [Two Phase Commit (2PC)]({{< relref "20231116010456-two_phase_locking_2pl.md" >}})
-   We need to use this when we have physically [Sharded Databases]({{< relref "20230608143206-scaling_databases.md" >}})


#### Active-passive replicas {#active-passive-replicas}

{{< figure src="/ox-hugo/20231113145513-database_transactions-1750443389.png" >}}


#### Multi-active distributed transactions {#multi-active-distributed-transactions}

{{< figure src="/ox-hugo/20231113145513-database_transactions-577918071.png" >}}

-   This is the case where [Sharding]({{< relref "20230608143206-scaling_databases.md" >}}) is handled for us by the database (Eg. CockroachDB)
-   This is similar to [Two Phase Commit (2PC)]({{< relref "20231116010456-two_phase_locking_2pl.md" >}}) + Some Replication protocol


#### Doing it in [PostgreSQL]({{< relref "20221102123302-postgresql.md" >}}) directly {#doing-it-in-postgresql--20221102123302-postgresql-dot-md--directly}

-   [How to process distributed transaction within postgresql? - Stack Overflow](https://stackoverflow.com/questions/21109362/how-to-process-distributed-transaction-within-postgresql)
-   [Distributed transaction on PostgreSQL - Stack Overflow](https://stackoverflow.com/questions/65830457/distributed-transaction-on-postgresql)
-   [Atomic Commit of Distributed Transactions - PostgreSQL wiki](https://wiki.postgresql.org/wiki/Atomic_Commit_of_Distributed_Transactions)


### Long running transactions (Saga) {#long-running-transactions--saga}

-   See [Microservices]({{< relref "20230210012034-microservices.md" >}})
-   It operates differently comparerd to ACID but achieves similar things at business levels applied correctly
-   [Long-running transaction - Wikipedia](https://en.wikipedia.org/wiki/Long-running_transaction)
-   [Pattern: Saga](https://microservices.io/patterns/data/saga.html)


## Resources {#resources}

-   [Postgres sequences can commit out-of-order](https://blog.sequinstream.com/postgres-sequences-can-commit-out-of-order/)
-   [Rediscovering Transaction Processing From History and First Principles](https://tigerbeetle.com/blog/2024-07-23-rediscovering-transaction-processing-from-history-and-first-principles)
