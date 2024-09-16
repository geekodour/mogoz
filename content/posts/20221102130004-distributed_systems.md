+++
title = "Distributed Systems"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [System Design]({{< relref "20230113141133-system_design.md" >}}), [Systems]({{< relref "20221101150250-systems.md" >}}), [Inter Process Communication]({{< relref "20221101173527-ipc.md" >}}), [Database]({{< relref "20221102123145-database.md" >}}), [Concurrency]({{< relref "20221126204257-concurrency.md" >}}), [CALM]({{< relref "20230909165220-calm.md" >}}), [Clocks]({{< relref "20231119003900-clocks.md" >}})


## Important links {#important-links}

-   [Foundational distributed systems papers](https://muratbuffalo.blogspot.com/2021/02/foundational-distributed-systems-papers.html?m=1) : O' double G


## Theory {#theory}


### Predicate Logic {#predicate-logic}

See [Logic]({{< relref "20230925154135-logic.md" >}})

-   safety properties (next, stable, invariant)
-   liveness properties (transient, ensures, leads-to, variant functions).


### Formal tooling {#formal-tooling}

See [Formal Methods]({{< relref "20230403235716-formal_methods.md" >}})


## What/Intro {#what-intro}

A "distributed system" is simply a system that splits a problem over multiple machines, solving it in a way that is better, more efficient, possible etc than a single machine.


### Use of the distribution {#use-of-the-distribution}

Use of the distribution provided by distributed system

-   Can be used to [provide fault tolerance and high-availability](https://news.ycombinator.com/item?id=32540234)


## FAQ {#faq}


### What Eventual Consistency? {#what-eventual-consistency}

See [Eventual Consistency]({{< relref "20231117135755-eventual_consistency.md" >}})


### How to Design Distributed Systems? {#how-to-design-distributed-systems}

-   A correct distributed program achieves (nontrivial) distributed property `X`
-   Some tricky questions before we start coding:
    -   Is `X` even attainable?
        -   Cheapest protocol that gets me X?
    -   Can I use something existing, or do I invent a new one
    -   How should i implement it?
-   We depend on the different entities participating in the distributed system on having some local **knowledge**


## Thinking frameworks {#thinking-frameworks}


### Meta {#meta}

-   CAP and PACELC help us know what things we need to be aware of when designing a system, but they’re less helpful in actually designing that system.
-   [CALM]({{< relref "20230909165220-calm.md" >}}) provide a way to reason through the behavior of systems under [Eventual Consistency]({{< relref "20231117135755-eventual_consistency.md" >}})


### CAP {#cap}

{{< figure src="/ox-hugo/20221102130004-distributed_systems-21358776.png" >}}

-   Systems can do 2 of the 3, Eg. Abandon C(onsistency) but maintain (A)vailability and (P)artition tolerance.
-   When talking about CAP we have to make a difference between
    -   The original CAP Conjecture
    -   The subsequent [CAP Theorem](https://www.cl.cam.ac.uk/research/dtg/archived/files/publications/public/mk428/cap-critique.pdf)


#### The pillars {#the-pillars}

-   Consistency
    -   Requires that there’s a total ordering of events where each operation looks as if it were completed instantaneously.
    -   Linearizability is what the CAP Theorem calls Consistency. (See [Concurrency Consistency Models]({{< relref "20231113121413-concurrency_consistency_models.md" >}}))
-   Availability
    -   All requests eventually return a successful response eventually.
    -   There’s no bound on how long a process can wait.
    -   Brewer: If a given consumer of the data can always reach **some** replica
    -   Gilbert &amp; Lynch: If a given consumer of the data can always reach **any** replica
-   Partition Tolerance
    -   Some subset of nodes in the system is incapable of communicating with another subset of nodes.
    -   All messages are lost.
    -   Partition Tolerance is the ability to handle this situation.


#### Case of "total availability" {#case-of-total-availability}

-   Total availability is not something that most datacenter applications care about.
-   Mobile, IoT, and other frequently-disconnected applications do care about it.


#### Real World {#real-world}

<!--list-separator-->

-  CA

    -   Partition, `P` WILL ALWAYAS BE THERE
    -   You can't really be `CA`, Even though CAP says we can only choose 2, in real world though we can't really ignore partition tolerance because network [can always fail.](https://codahale.com/you-cant-sacrifice-partition-tolerance/)
    -   So since `P` is not optional in reality, systems make tradeoff between `C` and `A`. i.e Improve Consistency but weaken Availability and vice-versa.

<!--list-separator-->

-  AP &amp; CP

    -   C and A are treated as more of a sliding scale. So systems can be `AP` or `CP` but this is [not the right way to think](https://martin.kleppmann.com/2015/05/11/please-stop-calling-databases-cp-or-ap.html) about [Distributed Systems]({{< relref "20221102130004-distributed_systems.md" >}}).


### PACELC {#pacelc}

-   Partitioned(Availability, Consistency) Else (Latency, Consistency)
-   PACELC is a more nuanced than CAP for thinking about this stuff
-   Definition
    -   If there is a partition (P)
        -   How does the system trade off availability and consistency (A and C);
    -   else (E), when the system is running normally in the absence of partitions
        -   How does the system trade off latency (L) and consistency (C)
-   [CAP](#cap) does not really choose between `C` and `A` but only makes certain tradeoff
-   PACELC tells, we choose between `Consistency` and `Latency`
-   Eg. Cassandra is `PA/EL` system.


### CALM {#calm}

-   See [CALM]({{< relref "20230909165220-calm.md" >}})


### Hellerstein's inequality {#hellerstein-s-inequality}

![](/ox-hugo/20221102130004-distributed_systems-264773258.png)
![](/ox-hugo/20221102130004-distributed_systems-172090201.png)
![](/ox-hugo/20221102130004-distributed_systems-1420368844.png)
![](/ox-hugo/20221102130004-distributed_systems-1839879694.png)

-   Useful in cases when sql queries remain the same but in the backend you can keep on fine tuning stuff like add indexes and what not. But this way of developing applications is much more useful in cloud applications where the environment changes all the time.
-   Distributed language requirements
    -   Something unthinkable: Need to represent time-varying state
    -   Something unpredictable: Need to represent uncertainty (i.e. nondeterminism in ordering and failure)


## Impossibility Results {#impossibility-results}

> We can check the `Impossibility Results` for each of the different dist sys problems. Eg. CAP theorem considers the coordinating attack model for the atomic storage problem and shows that with arbitrarily unreliable channels, you cannot solve the atomic storage problem either.

-   Example via 2PC: [Two-phase commit and beyond](https://muratbuffalo.blogspot.com/2018/12/2-phase-commit-and-beyond.html)


### Results {#results}


#### coordinated attack {#coordinated-attack}

-   [Two Generals' Problem - Wikipedia](https://en.wikipedia.org/wiki/Two_Generals'_Problem)
-   The coordinating attack result says that if the communication channels can drop messages you cannot solve distributed consensus using a deterministic protocol in finite rounds.


#### FLP impossibility results {#flp-impossibility-results}

-   [Paper summary: Perspectives on the CAP theorem](https://muratbuffalo.blogspot.com/2015/02/paper-summary-perspectives-on-cap.html)
-   Assume reliable channel, or eventually for a sufficient period reliable channels.
-   Under an asynchronous model, you cannot solve distributed consensus using a deterministic protocol in finite rounds, in the presence of a single crash failure.


### Solutions to impossibility results {#solutions-to-impossibility-results}

> These allow us to circumvent (not to beat) these impossibility results


#### consensus {#consensus}

-   See [Consensus Protocols]({{< relref "20231118205116-consensus_protocols.md" >}})


#### fault-tolerance {#fault-tolerance}


## Time and Clocks {#time-and-clocks}

See [Clocks]({{< relref "20231119003900-clocks.md" >}})


## Problems in Distributed Systems {#problems-in-distributed-systems}


### Synchronization {#synchronization}

See [Database Transactions]({{< relref "20231113145513-database_transactions.md" >}}), see [Synchronization]({{< relref "20240816134029-synchronization.md" >}})


#### 2PC {#2pc}

-   See [Two Phase Locking (2PL) &amp; Two Phase Commit (2PC)]({{< relref "20231116010456-two_phase_locking_2pl.md" >}})
-   Leader writes a durable transaction record indicating a cross-shard transaction.
-   Participants write a permanent record of their willingness to commit and notify the leader.
-   The leader commits the transaction by updating the durable transaction record after receiving all responses.
    -   It can abort the transaction if no one responds.
-   Participants can show the new state after the leader announces the commit decision.
    -   They delete the staged state if the leader aborts the transaction.


#### Real time sync {#real-time-sync}

-   See [Local First Software (LoFi)]({{< relref "20230915141853-local_first_software.md" >}})


### atomic storage problem {#atomic-storage-problem}

-   CAP tries to solve this


### Replication {#replication}

-   See [Data Replication]({{< relref "20231021151742-data_replication.md" >}})


### Consensus {#consensus}

See [Consensus Protocols]({{< relref "20231118205116-consensus_protocols.md" >}})


### Distributed Snapshots {#distributed-snapshots}

> Distributed snapshots are trying to do as little work as possible to get a consistent view of the distributed computation, without forcing the heavy cost of consensus on it. For example, node A is sending a message to node B, we don't care if we capture in:
>
> -   1: A before it sends the message, B before it receives the message
> -   2: A after it has sent the message, the message, and B before it receives the message
> -   3: A after it has sent the message, B after it has received the message
>
> No matter which of those states we restore, the computation will continue correctly.

-   [Distributed Snapshots: Chandy-Lamport protocol](https://blog.fponzi.me/2024-05-30-distributed-snapshots.html)
-   [Distributed Snapshots: Determining Global States of Distributed Systems | the morning paper](https://blog.acolyer.org/2015/04/22/distributed-snapshots-determining-global-states-of-distributed-systems/)


### Distributed Locks {#distributed-locks}

-   See [Database Locks]({{< relref "20231114211916-database_locks.md" >}})
-   [How to do distributed locking — Martin Kleppmann’s blog](https://martin.kleppmann.com/2016/02/08/how-to-do-distributed-locking.html)
-   Purpose: Ensure that among several nodes that might try to do the same piece of work, only one actually does it (at least only one at a time).


#### Resources {#resources}

-   [A robust distributed locking algorithm based on Google Cloud Storage – Joyful Bikeshedding](https://www.joyfulbikeshedding.com/blog/2021-05-19-robust-distributed-locking-algorithm-based-on-google-cloud-storage.html)
-   [Leader Election with S3 Conditional Writes | Hacker News](https://news.ycombinator.com/item?id=41357123)
-   [distributed-lock-google-cloud-storage-ruby/README.md at main · FooBarWidget/distributed-lock-google-cloud-storage-ruby · GitHub](https://github.com/FooBarWidget/distributed-lock-google-cloud-storage-ruby/blob/main/README.md)
-   [Reddit - Dive into anything](https://www.reddit.com/r/golang/comments/t52d4f/gmutex_a_global_mutex_using_google_cloud_storage/)
-   [Distributed Locks with Redis (2014) | Hacker News](https://news.ycombinator.com/item?id=41292477)


### Service Discovery and Peer to Peer communication {#service-discovery-and-peer-to-peer-communication}

-   See [peer-to-peer]({{< relref "20221101184751-peer_to_peer.md" >}})


## Notes from LK class {#notes-from-lk-class}


### Class 1 {#class-1}

-   Dist sys
    -   Running on several nodes, connected y network
    -   Characterized by partial failures
    -   System w partial failure + Unbounded latency
-   Partial Failures
    -   Eg. Cloud computing vs HPC
        -   Cloud: Work around partial failures
        -   HPC: Treat partial failures as total failure. Uses check-pointing.
-   Byzantine Faults
    -   If you send a request to another node and don't receive a response, it's **impossible** to know why. (without a global knowledge system)
    -   Byzantine faults can be seen as a subset of partial failures
    -   Eg.
        -   There could be issues in M1 -&gt; M2
            -   Network issues
            -   Queue congestion
            -   M1 breaking
        -   There could be issues in M2 -&gt; M1
            -   M2 Lying
            -   Cosmic rays
    -   Solution
        -   These do not address all kinds of uncertainties
        -   Timeouts and Retries
            -   Issue with timeouts is that it will not work well when the message causes a side effect. Eg. increment some counter
        -   Predict Max delay
            -   Eg. from M1-&gt;M2 =2d+r (if d is time for M1-M2 and r is processing time)
