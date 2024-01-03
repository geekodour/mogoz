+++
title = "Queues, Scheduling and orchestrator"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [System Design]({{< relref "20230113141133-system_design.md" >}}), [Systems]({{< relref "20221101150250-systems.md" >}}), [Distributed Systems]({{< relref "20221102130004-distributed_systems.md" >}}), [Message Queue (MQ)]({{< relref "20230404153903-message_passing.md#message-queue--mq" >}}), [Operating Systems]({{< relref "20221101172456-operating_systems.md" >}})


## Types {#types}

-   Some comment

    > <https://alexis.bernard.io/blog/2023-10-15-background-job-queues-and-priorities-may-be-the-wrong-path.html>
    >
    > The article is a bit unclear because it's lacking the proper vocabulary. Priorities and deadlines (what the article calls "SLOs") are both valid ways to approach scheduling problems with different tradeoffs.
    >
    > The fixed priority systems the article talks about trade off optimal "capacity" utilization for understandable failure dynamics in the overcapacity case. When you're over capacity, the messages that don't go through are the messages with the lowest priority. It's a nice property and simple to implement.
    >
    > What the article proposes is better known as deadline scheduling. That's also fine and widely used, but it has more complicated failure dynamics in the overcapacity case. If your problem domain doesn't have an inherent "priority" linked to the deadlines, that may be acceptable, but in other cases it may not be.
    >
    > Neither is inherently better and there's other approaches with yet different tradeoffs.


## Tools {#tools}

-   Dagster
-   [windmill](https://www.windmill.dev/)
-   airflow
-   [GitHub - cschleiden/go-workflows: Embedded durable workflows for Golang similar to DTFx/Cadence/Temporal](https://github.com/cschleiden/go-workflows)
-   <https://brandur.org/river>
-   <https://temporal.io/>
