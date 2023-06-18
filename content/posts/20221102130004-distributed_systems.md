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

-   Dynamo paper discusses why eventual consistecy is OK
    -   Also this : [Eventually consistent | Communications of the ACM](https://dl.acm.org/doi/10.1145/1435417.1435432)
    -   Also: [Rethinking Eventual Consistency - Microsoft Research](https://www.microsoft.com/en-us/research/publication/rethinking-eventual-consistency/)


## Thinking frameworks {#thinking-frameworks}


### CAP {#cap}

-   Systems can do something like abandon C(onsistency) of but maintains (A)vailability and (P)artition tolerance.
-   CAP's unhelpful use of "total availability"
    -   which isn't a system property that most datacenter applications care about.
    -   Mobile, IoT, and other frequently-disconnected applications do care about it.


### PARCEL {#parcel}

-   PACELC is a better tool than CAP for thinking about this stuff


### CALM {#calm}

-   provide a way to reason through the behavior of systems under eventual consistency
-   provide a path to data structures with behavior that's easier to reason about than last-writer-wins


## Synchronization {#synchronization}


### 2PC {#2pc}

-   Leader writes a durable transaction record indicating a cross-shard transaction.
-   Participants write a permanent record of their willingness to commit and notify the leader.
-   The leader commits the transaction by updating the durable transaction record after receiving all responses.
    -   It can abort the transaction if no one responds.
-   Participants can show the new state after the leader announces the commit decision.
    -   They delete the staged state if the leader aborts the transaction.
