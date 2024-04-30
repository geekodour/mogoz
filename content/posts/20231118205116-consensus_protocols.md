+++
title = "Consensus Protocols"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Two Phase Locking (2PL) &amp; Two Phase Commit (2PC)]({{< relref "20231116010456-two_phase_locking_2pl.md" >}}), [Distributed Systems]({{< relref "20221102130004-distributed_systems.md" >}}), [Concurrency Consistency Models]({{< relref "20231113121413-concurrency_consistency_models.md" >}}), [Data Replication]({{< relref "20231021151742-data_replication.md" >}}), [Eventual Consistency]({{< relref "20231117135755-eventual_consistency.md" >}}), [Zookeeper]({{< relref "20221102125923-zookeeper.md" >}})

    {{< figure src="/ox-hugo/20231118205116-consensus_protocols-1001622362.png" >}}


## FAQ {#faq}


### Partial Quorum {#partial-quorum}


## Paxos {#paxos}

{{< figure src="/ox-hugo/20221102130004-distributed_systems-866307772.png" >}}


## Raft {#raft}


### Leader selection {#leader-selection}

-   The protocol doesn't require a quorum (majority) for a leader election vote to pass, it can function on 2 servers.
-   When the 3rd one returns, it will see it's raft log is out of date and will synchronise back up and start working again. During that phase it will not make itself a candidate for leader election


## Resources {#resources}

-   [When Does Consistency Require Coordination? | Peter Bailis](http://www.bailis.org/blog/when-does-consistency-require-coordination/)
