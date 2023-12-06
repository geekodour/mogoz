+++
title = "Distributed Systems"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [System Design]({{< relref "20230113141133-system_design.md" >}}), [Systems]({{< relref "20221101150250-systems.md" >}}), [Inter Process Communication]({{< relref "20221101173527-ipc.md" >}}), [Database]({{< relref "20221102123145-database.md" >}}), [Concurrency]({{< relref "20221126204257-concurrency.md" >}}), [CALM]({{< relref "20230909165220-calm.md" >}})


## Important links {#important-links}

-   [Foundational distributed systems papers](https://muratbuffalo.blogspot.com/2021/02/foundational-distributed-systems-papers.html?m=1) : O' double G


## What/Intro {#what-intro}

A "distributed system" is simply a system that splits a problem over multiple machines, solving it in a way that is better, more efficient, possible etc than a single machine.


### Use of the distribution {#use-of-the-distribution}

Use of the distribution provided by distributed system

-   Can be used to [provide fault tolerance and high-availability](https://news.ycombinator.com/item?id=32540234)


## Meta {#meta}


### Eventual Consistency {#eventual-consistency}

See [Eventual Consistency]({{< relref "20231117135755-eventual_consistency.md" >}})


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


## Synchronization {#synchronization}


### 2PC {#2pc}

-   Leader writes a durable transaction record indicating a cross-shard transaction.
-   Participants write a permanent record of their willingness to commit and notify the leader.
-   The leader commits the transaction by updating the durable transaction record after receiving all responses.
    -   It can abort the transaction if no one responds.
-   Participants can show the new state after the leader announces the commit decision.
    -   They delete the staged state if the leader aborts the transaction.


## Replication {#replication}

-   See [Data Replication]({{< relref "20231021151742-data_replication.md" >}})


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


## Designing Distributed Systems {#designing-distributed-systems}

-   A correct distributed program achieves (nontrivial) distributed property `X`
-   Some tricky questions before we start coding:
    -   Is X even attainable?
        -   Cheapest protocol that gets me X?
    -   Can I use something existing, or do I invent a new one
    -   How should | implement it?
-   We depend on the different entities participating in the distributed system on having some local **knowledge**
