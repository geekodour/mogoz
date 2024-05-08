+++
title = "Orchestrators and Scheduling"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [System Design]({{< relref "20230113141133-system_design.md" >}}), [Systems]({{< relref "20221101150250-systems.md" >}}), [Distributed Systems]({{< relref "20221102130004-distributed_systems.md" >}}), [Message Queue (MQ)]({{< relref "20240501121916-message_queue.md" >}}), [Operating Systems]({{< relref "20221101172456-operating_systems.md" >}}), [Task Queue]({{< relref "20230404163634-task_queue.md" >}})


## Theory {#theory}


### Properties/Terms {#properties-terms}

-   Important property for orchestrators is: "determinism and idempotency"
-   Priority
-   Deadlines
-   SLO / TTLs


### Scheduling senarios {#scheduling-senarios}


#### Overcapacity {#overcapacity}

The fixed priority systems the article talks about trade off optimal "capacity" utilization for understandable failure dynamics in the overcapacity case. When you're over capacity, the messages that don't go through are the messages with the lowest priority. It's a nice property and simple to implement.


#### Deadline scheduling {#deadline-scheduling}

What the article proposes is better known as deadline scheduling. That's also fine and widely used, but it has more complicated failure dynamics in the overcapacity case. If your problem domain doesn't have an inherent "priority" linked to the deadlines, that may be acceptable, but in other cases it may not be.


## FAQ {#faq}


### Job/Task Queue vs Workflow orchestration {#job-task-queue-vs-workflow-orchestration}

See [Task Queue]({{< relref "20230404163634-task_queue.md" >}})


## Pipeline orchestration tooling landscape {#pipeline-orchestration-tooling-landscape}

-   See [Data Engineering]({{< relref "20230405003455-data_engineering.md" >}})
-   Some of these pipelines are gearerd towards some workflow and some are related to data. Based on what's our goal, we need to see what fits.
-   Workflow/Orchstrators and Job Queues are different tools for different things, they can be mixed and matched but not mutually exclusive.


### More on Job/Task Queue {#more-on-job-task-queue}

See [Task Queue]({{< relref "20230404163634-task_queue.md" >}}) and [Message Queue]({{< relref "20240501121916-message_queue.md" >}})


#### Comparison of Celery vs Temporal {#comparison-of-celery-vs-temporal}

-   This comparison doesn't make much sense unless you're trying to use celery as an orchestrator(which I think we should not use it as).


### More on Workflow and Orchestrators {#more-on-workflow-and-orchestrators}

| Tool        | Made for who?                 | What kind of workload?                                                 |
|-------------|-------------------------------|------------------------------------------------------------------------|
| Dagster     | Data Teams                    | Running operations outside of the main application specific to data    |
| Airflow     |                               |                                                                        |
| Temporal    | Data Teams + Application devs | Running a flow centered around a specific user, and maintaining state. |
| Windmill    | Hybrid Teams                  | Mix of Internal tooling and application workflow                       |
| n8n         | Internal Tooling              | More on the IFTT but for technical folks kind of things                |
| node-red    | Similar to n8n                | More focused on embedded and homelab type stuff                        |
| Retool      | Internal Tooling              | Internal tooling interface etc                                         |
| go-workflow | Embedded workflow             | Lightweight temporal(?)                                                |


#### Windmill {#windmill}

-   Mixed usecase (Inspired by Airflow and Temporal but more opinionated)
    -   The goal of Windmill is to bring the benefits of those workflow engines in a more accessible package
-   Rely on the ACID properties of [PostgreSQL]({{< relref "20221102123302-postgresql.md" >}}) to achieve persistence and transactionality of the workflow's state.
-   Idempotence: Assumption to be an at-least-once workflow engine
    -   In exceptionally rare events of an infrastructure crash (shutdown, network split, etc): recover automatically but it is up to the application developer to implement idempotency in parts where it is critical


#### Airflow {#airflow}

-   Task based orchestration
    -   Gives you visibilty into what tasks are run, not around what data assets are generated
-   Somewhat data oriented

    > Maybe the most data-oriented thing about Airflow is its concept of a data interval, where each DAG run is associated with some "logical date" and an interval of time that starts from the logical date (inclusive) and ends at the next logical date in the schedule (exclusive). The idea is that if you have a daily task that runs at 1 AM, then the task is expected to operate on data starting from "yesterday at 1 AM" until "today at 1 AM". But it's entirely up to the user/developer what you actually do with those logical date ranges, and you're free to ignore them entirely if you don't need them.


#### Dagster (data pipeline orchestrator) {#dagster--data-pipeline-orchestrator}

-   Its mean for batch data processing (not stream)
-   Asset based orchestration instead of task-based orchestration that airflow uses
    -   It might be complicated than airflow's approach but useful
-   Separates business logic from infra: Allows you to run the same workflow in your laptop and in some production setup where the execution engine is totally different.
-   More focused on `workflow orchestration + data`
    -   Eg. with dagster you have a concept of asset which is data specific
    -   Features like data lineage tracking and asset cataloging which are not there in temporal because its more general
    -   More useful when we're doing data work external to the main application

<!--list-separator-->

- <span class="org-todo todo TODO">TODO</span>  Dagster and Celery combination

    -   <https://discuss.dagster.io/t/16322908/i-m-pretty-novice-in-terms-of-the-python-system-for-what-use> 🌟
    -   <https://dagster.io/integrations/dagster-celery>


#### Temporal (workflow+business state) {#temporal--workflow-plus-business-state}

<!--list-separator-->

-  What is temporal in tangible terms?

    -   It's for timespanning workflows. It's a step up from something of a distributed [Task Queue]({{< relref "20230404163634-task_queue.md" >}})
    -   The idea is "Enterprises, come use temporal", not "soloist ditch your cronjobs" (from some HN user)
    -   "Platform that guarantees the Durable Execution of your `application code`."
        -   Moves of a lot of complexity associated with building reliable distributed applications to the platform level.
    -   Temporal is an sdk for workflows, meaning you have to code around their sdk and learn their abstractions.

<!--list-separator-->

-  How temporal relates to Distributed transactions

    -   **Temporal is not a solution for distributed transactions. It is an orchestrator that solves the problem of a lack of distributed transactions.** (See [Database Transactions]({{< relref "20231113145513-database_transactions.md" >}}))
        -   [Building event-driven, reactive applications with Temporal: Workflows vs Sagas - YouTube](https://www.youtube.com/watch?v=EaBVzjtSK6A)

<!--list-separator-->

-  Usecase example

    -   In a way Temporal is a superset of the other tools but, it's a more general orchestrator than other tools in the ecosystem
    -   But it has a specific usecase around workflows being triggered by `business logic and state management`

        > For example think about a flow called “order a meal”.
        >
        > -   The flow has multiple steps, and between the steps it sits (and maintains state) and listens to outside events, in order to advance to the next step in the flow.
        > -   The “order a meal” flow might have steps like payment started, payment finished, food picked, food delivered, user sent review…
        > -   And you have millions of flows like this, a flow for each user, with robust state management, that knows exactly what is the current state.
    -   Another one

        > -   user enters their personal details / create an account on the user service
        > -   it then also have to enter CC information and this information needs to be verified by the payment service
        > -   your workflow also allows a 1-month trial, and recurring billing after that
        > -   at intervals of 1 month, use the payment service with the stored CC information to bill the user, and send them a "thank you for your payment" email
        > -   if there's a problem charging the card, send them an email to instead "fix" their payment details, hold the workflow off for a few days in the hope that the user fixes their payment details
        > -   when the user fixes their payment details, send an even to the workflow telling it it's ok to resume billing
        > -   if the user cancels their subscription mid-way, send an event to the workflow asking it to sleep until the billing cycle is over, then wake up and delete the user from the list of subscribed users, and shutdown the workflow

<!--list-separator-->

-  Pipelines and Temporal

    -   Temporal is distinct in that it's neither limited to DAGs nor to data pipelines.
    -   Tasks can run as long as needed (even months). They support heartbeating to detect failures promptly. Each heartbeat can include application data. So if the task fails, then when retried, it can read that data to continue from the last processed point.

<!--list-separator-->

-  Complaints for Temporal

    -   Temporal has never gone far enough for me in terms of developer experience and observability. It fits into a neat slice in an enterprise stack with their execution model, but it's difficult to adopt without a dedicated engineer integrating logging and observability w/ opentelemetry with your workflows


#### FAQ {#faq}

<!--list-separator-->

-  Dagster vs Temporal vs Others

    > I recently evaluated Dagster, Prefect, and Flyte for a data pipeliney workflow and ended up going with Temporal.
    >
    > The shared feature between Temporal and those three is the workflow orchestration piece. All 3 can manage a dependency graph of jobs, handle retries, start from checkpoints, etc.
    >
    > At a high level the big reason they’re different is Temporal is entirely focused on the orchestration piece, and the others are much more focused on the data piece, which comes out in a lot of the different features. Temporal has SDKs in most languages, and has a queuing system that allows you to run different workflows or even activities (tasks within a workflow) in different workers, manage concurrency, etc. You can write a parent workflow that orchestrates sub-workflows that could live in 5 other services. It’s just really composable and fits much more nicely into the critical path of your app.
    >
    > Prefect is probably the closest of your list to temporal, in that it’s less opinionated than others about the workflows being “data oriented”, but it’s still only in python, and it deosn't have queueing. In short this means that your workflows are kinda supposed to run in one box running python somewhere. Temporal will let you define a 10 part workflow where two parts run on a python service running with a GPU, and the remaining parts are running in the same node.js process as your main server.
    >
    > Dagster’s feature set is even more focused on data-workflows, as your workflows are meant to produce data “assets” which can be materialized/cached, etc.
    >
    > They’re pretty much all designed for a data engineering team to manage many individual pipelines that are external from your application code, whereas temporal is designed to be a system that manages workflow complexity for code that (more often) runs in your application.
    >
    > -   jtmarmon
