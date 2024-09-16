+++
title = "Consensus Protocols"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Two Phase Locking (2PL) &amp; Two Phase Commit (2PC)]({{< relref "20231116010456-two_phase_locking_2pl.md" >}}), [Distributed Systems]({{< relref "20221102130004-distributed_systems.md" >}}), [Concurrency Consistency Models]({{< relref "20231113121413-concurrency_consistency_models.md" >}}), [Data Replication]({{< relref "20231021151742-data_replication.md" >}}), [Eventual Consistency]({{< relref "20231117135755-eventual_consistency.md" >}}), [Zookeeper]({{< relref "20221102125923-zookeeper.md" >}})

    {{< figure src="/ox-hugo/20231118205116-consensus_protocols-1001622362.png" >}}

> "making sure participants come to the same conclusion about something and nobody has the wrong answer"


## FAQ {#faq}


### Partial Quorum {#partial-quorum}


## Approaches {#approaches}


### Paxos {#paxos}

{{< figure src="/ox-hugo/20221102130004-distributed_systems-866307772.png" >}}


#### Variants {#variants}

<!--list-separator-->

-  Replicated State Machine (RSM)

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
