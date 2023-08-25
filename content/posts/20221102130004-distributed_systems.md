+++
title = "Distributed Systems"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [System Design]({{< relref "20230113141133-system_design.md" >}}), [Systems]({{< relref "20221101150250-systems.md" >}}), [Inter Process Communication]({{< relref "20221101173527-ipc.md" >}}), [Database]({{< relref "20221102123145-database.md" >}}), [Concurrency]({{< relref "20221126204257-concurrency.md" >}})


## Important links {#important-links}

-   [Foundational distributed systems papers](https://muratbuffalo.blogspot.com/2021/02/foundational-distributed-systems-papers.html?m=1) : O' double G


## Meta {#meta}


### Eventual Consistency {#eventual-consistency}

-   Dynamo paper discusses why eventual consistency is OK
    -   Also: [Eventually consistent | Communications of the ACM](https://dl.acm.org/doi/10.1145/1435417.1435432)
    -   Also: [Rethinking Eventual Consistency - Microsoft Research](https://www.microsoft.com/en-us/research/publication/rethinking-eventual-consistency/)


## Thinking frameworks {#thinking-frameworks}


### Meta {#meta}

-   CAP and PACELC help us know what things we need to be aware of when designing a system, but they’re less helpful in actually designing that system.


### CAP {#cap}

![](/ox-hugo/20221102130004-distributed_systems-21358776.png)
Systems can do 2 of the 3, Eg. Abandon C(onsistency) but maintain (A)vailability and (P)artition tolerance.


#### The pillars {#the-pillars}

-   Consistency
    -   Requires that there’s a total ordering of events where each operation looks as if it were completed instantaneously.
-   Availability
    -   All requests eventually return a successful response eventually.
    -   There’s no bound on how long a process can wait.
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

    -   You can't really be `CA`, Even though CAP says we can only choose 2, in real world though we can't really ignore partition tolerance because network [can always fail.](https://codahale.com/you-cant-sacrifice-partition-tolerance/)
    -   So since `P` is not optional in reality, systems make tradeoff between `C` and `A`. i.e Improve Consistency but weaken Availability and vice-versa.

<!--list-separator-->

-  AP &amp; CP

    -   C and A are treated as more of a sliding scale. So systems can be `AP` or `CP` but this is [not the right way to think](https://martin.kleppmann.com/2015/05/11/please-stop-calling-databases-cp-or-ap.html) about [Distributed Systems]({{< relref "20221102130004-distributed_systems.md" >}}).


### PACELC {#pacelc}

-   Partitioned, Availability, Consistency Else Latency, Consistency
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

-   `Consistency As Logical Monotonicity`
-   Provide a way to reason through the behavior of systems under eventual consistency
-   Provide a path to data structures with behavior that's easier to reason about than last-writer-wins


## Synchronization {#synchronization}


### 2PC {#2pc}

-   Leader writes a durable transaction record indicating a cross-shard transaction.
-   Participants write a permanent record of their willingness to commit and notify the leader.
-   The leader commits the transaction by updating the durable transaction record after receiving all responses.
    -   It can abort the transaction if no one responds.
-   Participants can show the new state after the leader announces the commit decision.
    -   They delete the staged state if the leader aborts the transaction.
