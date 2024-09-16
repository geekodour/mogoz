+++
title = "Concurrency Consistency Models"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Distributed Systems]({{< relref "20221102130004-distributed_systems.md" >}}), [Database]({{< relref "20221102123145-database.md" >}}), [Correctness criteria]({{< relref "20221126204257-concurrency.md#correctness-criteria" >}}), [Eventual Consistency]({{< relref "20231117135755-eventual_consistency.md" >}})


## FAQ {#faq}


### Strong Consistency(Linearizable) vs Sequential Consistency {#strong-consistency--linearizable--vs-sequential-consistency}

-   Both care about giving an illusion of a single copy.
-   Sequential Consistency
    -   Cares about `program order`
    -   `P(A)` executes `T1` and `T2`
    -   then `P(B)` executes `T3`
    -   Order could be: `(T1-T2)-T3`, `T3-(T1-T2)`, `T1-T3-T2` but not `T3-T2-T1`. Because this will violate order of `P(A)`
    -   There's **no** global `real time order`
-   Strong consistency (Linearzability)
    -   Cares about `real time order`
    -   `P(A)` executes `T1` and `T2`
    -   then `P(B)` executes `T3`
    -   Order would be: `(T1-T2)-T3`


### Strong and Weak? {#strong-and-weak}

Not all consistency models are directly comparable. Often, two models allow different behavior, but neither contains the other. Different consistency models fall in the spectrum of strong and weak.

-   Stronger
    -   More restrictive consistency models
    -   Slower
    -   More time spent in doing coordination (See [Consensus Protocols]({{< relref "20231118205116-consensus_protocols.md" >}}))
    -   Easier to reason about
-   Weaker
    -   More permissive consistency models
    -   Faster
    -   Harder to reason about


### Different meanings of consistency {#different-meanings-of-consistency}

-   ACID
    -   Related to [Database]({{< relref "20221102123145-database.md" >}})
    -   Satisfying application specific constraints.
    -   E.g. “every course with students enrolled must have at least one lecturer”
-   Replication
    -   See [Data Replication]({{< relref "20231021151742-data_replication.md" >}})
    -   Replicas should be "consistent" with other replicas
    -   This is similar to what consistency means in [CAP]({{< relref "20221102130004-distributed_systems.md#cap" >}})
    -   [Brewer](https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.24.3690) originally defined consistency as single copy `serializability`. (As if we're interacting with only one copy of the object, even though multiple things might be modifying it)
    -   [Gilbert &amp; Lynch](https://users.ece.cmu.edu/~adrian/731-sp04/readings/GL-cap.pdf) defined consistency as `linearizability` of a read write register
-   Different consistency models have their own meaning of consistency


### Which consistency model to pick for my application? {#which-consistency-model-to-pick-for-my-application}

-   General rule: Pick the weakest consistency model that satisfies your needs


### What's total ordering? {#what-s-total-ordering}

-   To the user it seems like they're interacting with one single system
-   In the total ordering, a read operation sees the latest write operation.
-   We can always compare the logical timestamps. (i.e figure out who was last)


### How are [Database Locks]({{< relref "20231114211916-database_locks.md" >}}) and [Database Transactions]({{< relref "20231113145513-database_transactions.md" >}}) related? {#how-are-database-locks--20231114211916-database-locks-dot-md--and-database-transactions--20231113145513-database-transactions-dot-md--related}

-   `Transactions` and `locks` can be used together to provide `serializability` (isolation)
-   `Transactions` provide atomicity
-   `Transactions` + `locks` provide `serializability`


## Consistency models {#consistency-models}

![](/ox-hugo/20231113121413-concurrency_consistency_models-1053246930.png)
![](/ox-hugo/20231113121413-concurrency_consistency_models-968724547.png)


### How to read this image? {#how-to-read-this-image}

-   Think of the parent node as the combination of the nodes under it.
    -   Eg. Strict Serializable = Serializable + Linearizable
-   We say that consistency model A implies model B if A is a subset of B. For example, linearizability implies sequential consistency because every history which is linearizable is also sequentially consistent.


### Models {#models}

These consistency models are enabled by `concurrency control` (CC). You can come up with your own too. Infact many have, S3 consistency, Consistent Prefix etc.


#### Jespen {#jespen}

<!--list-separator-->

-  Strict Serializable

    -   Eg. Strict Serializable = Serializable + Linearizable

<!--list-separator-->

-  Linearizable

    ![](/ox-hugo/20231113121413-concurrency_consistency_models-309381389.png)
    ![](/ox-hugo/20231113121413-concurrency_consistency_models-322372086.png)

    -   **Strong Consistency** = **Linearizable**
    -   Cares about `real time order`
    -   Serializability does not take the flow of time into consideration. Linearizability implies time-based ordering.
    -   Modifications happen instantaneously, any read operation will see the `latest and same` value.
        -   Read should return the most `recent` write
        -   Subsequent reads should return same value, until next write
    -   So if the [replication]({{< relref "20231021151742-data_replication.md" >}}) happened asynchronously, there will be lag and ultimately reads will not see the latest value or if replicated un-uniformly, different reads will see different values.
    -   So we can't do async replication, we can't do sync replication(too slow), so the answer is [Consensus Protocols]({{< relref "20231118205116-consensus_protocols.md" >}}) like Raft and Paxos which provide strong consistency.

<!--list-separator-->

-  Serializable

    -   AKA `one-copy serializable`
    -   Allows truly parallel execution of instructions
    -   Could bring in performance improvements but this also means stricter controls so that can slow things down as-well. (Tradeoff)
    -   Even with parallel executing transactions, the end result is same as if the transactions where executed serially.

    <!--list-separator-->

    -  Implementations

        -   [Two Phase Locking (2PL)]({{< relref "20231116010456-two_phase_locking_2pl.md" >}}) enables this
            -   Deadlock possibilities
            -   Serialization failures
        -   [SSI-based](https://drkp.net/papers/ssi-vldb12.pdf) (Serializable Snapshot Isolation)
            -   Provides performance similar to snapshot isolation and considerably outperforms strict two-phase locking on read-intensive workloads
            -   [Transactions: Serializable Snapshot Isolation – Distributed Computing Musings](https://distributed-computing-musings.com/2022/02/transactions-serializable-snapshot-isolation/)
            -   [PostgreSQL]({{< relref "20221102123302-postgresql.md" >}}) uses this

<!--list-separator-->

-  Sequential Consistency

    {{< figure src="/ox-hugo/20231113121413-concurrency_consistency_models-1136044853.png" >}}

    -   This is weaker than Strong consistency(Linearizable)
    -   Cares about `program order/thread order` and `legal sequencing`

<!--list-separator-->

-  Read your writes / Read-after-writes

    -   If a process writes, if it reads again it should see what it wrote

<!--list-separator-->

-  Monotonic Reads (Readonly)

    -   Time-order(fwd only), same process
    -   Either get the same read, else a newer read, never an older read than the first read in the process


#### Others {#others}

<!--list-separator-->

-  Consistent prefix

<!--list-separator-->

-  S3 Consistency

    See [Object Store (eg. S3)]({{< relref "20240630172513-object_store_eg_s3.md" >}})

<!--list-separator-->

-  Bounded Staleness


## Resources {#resources}

-   [Consistency Models Explained](https://www.bodunhu.com/blog/posts/consistency-models-explained/)
-   [Testing Distributed Systems for Linearizability](https://anishathalye.com/testing-distributed-systems-for-linearizability/#user-content-fn-1)
