+++
title = "Consensus Protocols"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Two Phase Locking (2PL) &amp; Two Phase Commit (2PC)]({{< relref "20231116010456-two_phase_locking_2pl.md" >}}), [Distributed Systems]({{< relref "20221102130004-distributed_systems.md" >}}), [Concurrency Consistency Models]({{< relref "20231113121413-concurrency_consistency_models.md" >}}), [Data Replication]({{< relref "20231021151742-data_replication.md" >}}), [Eventual Consistency]({{< relref "20231117135755-eventual_consistency.md" >}}), [Zookeeper]({{< relref "20221102125923-zookeeper.md" >}}), [Data Replication]({{< relref "20231021151742-data_replication.md" >}})


OG Blogposts
    -   <https://medium.com/@adamprout/categorizing-how-distributed-databases-utilize-consensus-algorithms-492c8ff9e916>  🌟
    -   [Consensus Resources](https://eatonphil.com/consensus.html?s=35)
    -   [Durability and the Art of Consensus by Joran Dirk Greef - YouTube](https://www.youtube.com/watch?v=tRgvaqpQPwE)

{{< figure src="/ox-hugo/20231118205116-consensus_protocols-1001622362.png" >}}

> "making sure participants come to the same conclusion about something and nobody has the wrong answer"


## FAQ {#faq}


### Partial Quorum {#partial-quorum}


### Consensus is NOT for [Scaling]({{< relref "20230608143206-scaling_databases.md" >}}) {#consensus-is-not-for-scaling--20230608143206-scaling-databases-dot-md}

> -   consensus is not for scaling
> -   consensus impedes scaling
> -   [An intuition for distributed consensus in OLTP systems | notes.eatonphil.com](https://notes.eatonphil.com/2024-02-08-an-intuition-for-distributed-consensus-in-oltp-systems.html)

-   Consensus protocols like RAFT primarily solve high availability with strong consistency guarantees (linearizability), not horizontal scaling. Their main purpose is to ensure that a system remains available and consistent even when some nodes fail.
-   Consensus actually impedes scaling due to several factors:
    -   The requirement for majority agreement creates coordination overhead
    -   Adding more nodes to a consensus group increases the likelihood of slow network responses
    -   The centralized leadership model (in protocols like RAFT) creates a bottleneck for writes
-   True horizontal scaling requires sharding, where:
    -   Data is partitioned across multiple independent consensus groups
    -   Each shard has its own consensus cluster for that subset of data
    -   This allows the system to distribute load while maintaining consistency within each shard

Systems make different trade-offs:

-   Systems like etcd, Consul focus on strong consistency via a single consensus group but don't scale horizontally for writes
-   Some systems support "horizontal scaling" for reads by allowing stale (non-linearizable) reads
-   Truly horizontally scalable systems like Cockroach, Spanner use consensus within shards but distribute data across many shards

> The fundamental tension is clear: consensus `provides the critical property of linearizable consistency` with `high availability`, but this comes at the cost of scalability. System designers must carefully consider their requirements when choosing between strong consistency and horizontal scalability.


## Approaches {#approaches}


### Paxos {#paxos}

{{< figure src="/ox-hugo/20221102130004-distributed_systems-866307772.png" >}}


#### Variants {#variants}

<!--list-separator-->

-  Replicated State Machine (RSM)

    See [Local First Software (LoFi)]({{< relref "20230915141853-local_first_software.md" >}})

<!--list-separator-->

-  chain replication type advanced atomic storage protocols


### Raft {#raft}

See [Raft]({{< relref "20240912140206-raft.md" >}})


### Viewstamped Replication Protocol {#viewstamped-replication-protocol}


#### VR vs Raft {#vr-vs-raft}

-   Viewstamped Replication relies on [Message Passing]({{< relref "20230404153903-message_passing.md" >}}), while RAFT relies on RPC
-   "VSR is also described in terms of message passing, whereas Raft took VSR’s original message passing and coupled it to RPC—shutting out things like multipath routing and leaving the logical networking protocol misaligned to the underlying physical network fault model." - Joran
-   Comparing the 2012 VSR and 2014 Raft papers, they are remarkably similar.
-   VSR better in prod than raft (opinion)
    -   It’s all the little things. All the quality, clear thinking and crisp terminology coming from Liskov, Oki and Cowling.
    -   Oki’s VSR was literally the first to pioneer consensus in ‘88, so it’s well aged, and the ‘12 revision again by Liskov and Cowling is a great vintage!


#### Resources {#resources}

-   [Paper: VR Revisited - An analysis with TLA+ — Jack Vanlightly](https://jack-vanlightly.com/analyses/2022/12/20/vr-revisited-an-analysis-with-tlaplus)
-   [Viewstamped Replication explained](https://blog.brunobonacci.com/2018/07/15/viewstamped-replication-explained/)
-   <https://github.com/tigerbeetle/viewstamped-replication-made-famous>
-   [Implementing Viewstamped Replication protocol – Distributed Computing Musings](https://distributed-computing-musings.com/2023/10/implementing-viewstamped-replication-protocol/)
-   [Paper #74. Viewstamped Replication Revisited - YouTube](https://www.youtube.com/watch?v=Wii1LX_ltIs)


## Election {#election}


### Links {#links}

-   <https://github.com/kellabyte/holocron>
