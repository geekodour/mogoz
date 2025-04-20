+++
title = "Stream Processing/Ingestion Patterns"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Data Engineering]({{< relref "20230405003455-data_engineering.md" >}}), [Batch Processing Patterns]({{< relref "20240606113829-batch_processing_patterns.md" >}}), [Kafka]({{< relref "20230210012126-kafka.md" >}})


## FAQ {#faq}


### How does differential dataflow relate to stream processing? {#how-does-differential-dataflow-relate-to-stream-processing}


### A problem statement for restaurant orders :) {#a-problem-statement-for-restaurant-orders}

> Let's assume we are building a data pipeline for Uber Eats where we keep getting orders. We want a dashboard which shows each restaurant owner
>
> -   How many orders?
> -   What are the Top 3 ordered dishes (with order count)?
> -   What’s the total sale amount?
>
> There are 3 buttons on the UI which allow the users (restaurant owners) to see these numbers for different time periods:
>
> -   Last 1 hour
> -   Last 24 hours (= 1 day)
> -   Last 168 hours (= 24h \* 7 = 1 week)
>
> The dashboard should get new data every 5 minutes. How do you collect, store and serve data?

See <https://www.reddit.com/r/dataengineering/comments/18ciwxo/how_do_streaming_aggregation_pipelines_work/>


#### Solution {#solution}

```nil
There are techniques most data systems offer to handle periodic (5m, 1h, etc) computation on incoming data (from Kafka, etc).

- Dynamic table on Flink
- Dynamic table on Snowflake (as \fhoffa mentioned)
- Materialized views on Clickhouse
- Delta Live table on Databricks

The underlying concept is that these systems store metrics state (either in memory or on disk or another db) and update them as new data comes in. In our case they will update per hour and then dump it into a place to be read from later.

If you partition your data by hour, One thing to note is that the metrics you specified are additive (can be added across hours), if they are non additive (such as unique customer id count) that will require more memory (or other techniques such as Hyperloglog).

While most systems can handle these for you, its good to know the underlying concept, since that will impact memory usage/cost. Hope this helps. LMK if you have any questions.

```


## What is it really? {#what-is-it-really}

![](/ox-hugo/20240901014444-stream_processing_ingestion_patterns-1907756710.png)
[Rethinking Stream Processing and Streaming Databases - RisingWave: Open-Source Streaming SQL Platform](https://risingwave.com/blog/rethinking-stream-processing-and-streaming-databases/)

> `stream processing` and `streaming ingestion` are different things. There are systems which do one, there are also systems which do both, partially, fully, all tradeoffs.

{{< figure src="/ox-hugo/20240901014444-stream_processing_ingestion_patterns-1209853002.png" >}}


### Streaming ingestion {#streaming-ingestion}

-   This simply means ingesting to something in a streaming fashion (could be a OLAP database)
-   This has to deal with things like de-duplications as OLAP systems don't have a primary key etc. Schema and Datatype changes in source table etc.
-   Along with streaming ingestion lot of OLAP databases allow for `continuous processing` (different from stream processing)
    -   Underlying concept is that these systems store metrics state and update them as new data comes in.
    -   Some examples are: Dynamic table on Flink, Dynamic table on Snowflake, Materialized views on [Clickhouse]({{< relref "20240901192322-clickhouse.md" >}}), Delta Live table on Databricks etc.


### Stream processing {#stream-processing}

> Stream processing systems are designed to give quick updates over a pre-defined query. To achieve that, incremental computation lies at the core of the design principle of stream processing. Instead of rescanning the whole data repository, stream processing systems maintain some intermediate results to compute updates based only on the new data. Such intermediate results are also referred to as states in the system. In most cases, the states are stored in memory to guarantee the low latency of stateful computation. Such a design makes stream processing systems vulnerable to failures. The whole stream processing pipeline will collapse if the state on any node is lost. Hence, stream processing systems use checkpoint mechanisms to periodically back up a consistent snapshot of global states on an external durable storage system. If the system fails, it can roll back to the last checkpoint and recover its state from the durable storage system.

-   In most cases, they're more flexible and capable than OLAP db's `continious processing` features. So they sit in-front of the streaming ingestion into OLAP making sure OLAP gets cleaned and processed data.
    -   But in most cases, you might not even not need stream processing, whatever `continious processing` feature OLAP DBs have might be enough, they're great imo in 2024.


## Architectures {#architectures}

-   [Lambda](https://en.wikipedia.org/wiki/Lambda_architecture): Here we merge real-time and historical data together
    -   [How to create near real-time models with just dbt + SQL - Archive - dbt Community Forum](https://discourse.getdbt.com/t/how-to-create-near-real-time-models-with-just-dbt-sql/1457)
-   [Kappa](https://pradeepl.com/blog/kappa-architecture/): If you don’t need a lot of historical data, and only need streaming data.
    -   [ATProto for distributed systems engineers - AT Protocol](https://atproto.com/articles/atproto-for-distsys-engineers)


## Tech Comparison {#tech-comparison}


### Comparison table {#comparison-table}

| RT Stream Processor | DBMS                                                                    | Tech Name                                                              | RT Stream Ingestion                                                                                                             | What?                                                                                                                                                                                                                                                                                                                                               |
|---------------------|-------------------------------------------------------------------------|------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Yes                 | No                                                                      | Apache Flink                                                           | Yes, but not meant to be a DB                                                                                                   | Can be used in-front of a OLAP store                                                                                                                                                                                                                                                                                                                |
| Yes                 | No                                                                      | Benthos/Redpanda Connect                                               | No                                                                                                                              | Apache Flink, Rising Wave alternative                                                                                                                                                                                                                                                                                                               |
| Yes                 | No                                                                      | [Proton](https://github.com/timeplus-io/proton)                        | No                                                                                                                              | Stream Processing for [Clickhouse]({{< relref "20240901192322-clickhouse.md" >}}) ?                                                                                                                                                                                                                                                                 |
| Yes                 | Yes ([PostgreSQL]({{< relref "20221102123302-postgresql.md" >}}) based) | RisingWave                                                             | Yes, but not meant to be a DB                                                                                                   | [Apache Flink alternative](https://docs.risingwave.com/docs/current/risingwave-flink-comparison/), it's pretty unique in what it does. See [comparision w MateralizeDB](https://github.com/orgs/risingwavelabs/discussions/1736)                                                                                                                    |
| Yes                 | Yes(OLAP)                                                               | [Materialize DB](https://materialize.com/)                             | Yes                                                                                                                             | Sort of combines `stream processing` + OLAP ([More powerful](https://www.reddit.com/r/dataengineering/comments/10ffdvx/optimize_joins_in_materialize_with_delta_queries/) than [Clickhouse]({{< relref "20240901192322-clickhouse.md" >}}) in that case), supports [PostgreSQL]({{< relref "20221102123302-postgresql.md" >}}) logical replication! |
| ?                   | Yes(OLAP)                                                               | BigQuery                                                               | Yes                                                                                                                             | It's BigQuery :)                                                                                                                                                                                                                                                                                                                                    |
| Not really          | Yes(OLAP)                                                               | Apache Druid                                                           | `True` realtime ingestion                                                                                                       | Alternative to [Clickhouse]({{< relref "20240901192322-clickhouse.md" >}})                                                                                                                                                                                                                                                                          |
| No                  | Yes(OLAP)                                                               | Apache [Pinot](https://www.uber.com/en-IN/blog/pinot-for-low-latency/) | Yes                                                                                                                             | Alternative to [Clickhouse]({{< relref "20240901192322-clickhouse.md" >}})                                                                                                                                                                                                                                                                          |
| No                  | Yes(OLAP)                                                               | [StarTree](https://startree.ai/)                                       | Yes                                                                                                                             | Managed Apache Pinot                                                                                                                                                                                                                                                                                                                                |
| No                  | Yes(OLAP)                                                               | [Clickhouse]({{< relref "20240901192322-clickhouse.md" >}})            | Yes, Batched realtime ingestion                                                                                                 | See [Clickhouse]({{< relref "20240901192322-clickhouse.md" >}})                                                                                                                                                                                                                                                                                     |
| No                  | Quack like it!(OLAP)                                                    | [DuckDB]({{< relref "20231123234702-duckdb.md" >}})                    | No                                                                                                                              | See [DuckDB]({{< relref "20231123234702-duckdb.md" >}})                                                                                                                                                                                                                                                                                             |
| No                  | Yes(OLAP)                                                               | Rockset                                                                | Yes                                                                                                                             | Easy to use alternative to Druid/Clickhouse. Handles [updates :)](https://rockset.com/blog/comparing-rockset-apache-druid-clickhouse-real-time-analytics/)                                                                                                                                                                                          |
| No                  | Yes(OLAP)                                                               | Snowflake                                                              | Yes but [not very good](https://clickhouse.com/blog/clickhouse-vs-snowflake-for-real-time-analytics-comparison-migration-guide) | -                                                                                                                                                                                                                                                                                                                                                   |
| No                  | No                                                                      | NATS                                                                   |                                                                                                                                 | [Message Broker]({{< relref "20240501121916-message_queue.md" >}})                                                                                                                                                                                                                                                                                  |
| No                  | No                                                                      | NATS Jetstream                                                         |                                                                                                                                 | [Kafka]({{< relref "20230210012126-kafka.md" >}}) alternative                                                                                                                                                                                                                                                                                       |
| No                  | No                                                                      | [Kafka]({{< relref "20230210012126-kafka.md" >}})                      |                                                                                                                                 | kafka is kafka                                                                                                                                                                                                                                                                                                                                      |


### Druid vs Clickhouse {#druid-vs-clickhouse}

> ClickHouse doesn’t guarantee newly ingested data is included in the next query result. Druid, meanwhile, does – efficiently, too, by storing the newly streamed data temporarily in the data nodes whilst simultaneously packing and shipping it off to deep storage.

-   Druid is more "true" realtime than clickhouse in this sense but that much of realtime is not usually needed in most of my cases.
-   [What Is Apache Druid And Why Do Companies Like Netflix And Reddit Use It? - YouTube](https://www.youtube.com/watch?v=rZTzl6iUKs4)

{{< figure src="/ox-hugo/20240901192322-clickhouse-461602811.png" >}}


### Risingwave vs Clickhouse {#risingwave-vs-clickhouse}

-   They can be used together


### Benthos(Redpanda Connect) vs Risingwave {#benthos--redpanda-connect--vs-risingwave}

-   Both are stream processors
-   Risingwave is a stateful streaming processor
-   Benthos is sitting somewhere between stateless and stateful systems


### NATS jetstream vs Benthos {#nats-jetstream-vs-benthos}

-   NATS jetstream seems like a persistent queue (Eg. [Kafka]({{< relref "20230210012126-kafka.md" >}}))
-   Benthos is something that would consume from that stream and do the stream processing and put the output elsewhere.


### More on Redpanda {#more-on-redpanda}

-   See [Kafka]({{< relref "20230210012126-kafka.md" >}})


### More on Redpanda Connect / Benthos {#more-on-redpanda-connect-benthos}

-   <https://github.com/weimeilin79/masterclass-connect>
-   <https://graphql-faas.github.io/benthos/concepts.html>

{{< figure src="/ox-hugo/20240901014444-stream_processing_ingestion_patterns-2120966530.png" >}}


#### Delivery Guarantee {#delivery-guarantee}

{{< figure src="/ox-hugo/20240901014444-stream_processing_ingestion_patterns-1482186460.png" >}}

See [Data Delivery]({{< relref "20240722202632-data_delivery.md" >}})

-   In benthos/rp connect, `input <> process <> output` , entire pipeline needs to run e2e(i.e `output` needs to finish), then it sends an `ACK` back to the input in which case it'll move on to the next item in the list.
-   dropping a message also sends an `ACK`, i.e we'll move to the next message etc.


#### Lifecycle {#lifecycle}

-   With `run`, eg. after using `input:file` the process will automatically kill itself
-   But if using `streams`, they process will keep living
-   After "success" ACK is sent back to the input from the output, but synchronous response is also possible with `sync_response` output component.
    -   `sync_response` only work with few input components such as `http_server`
    -   `sync_response` can be used with `input:http_server` and `output:http_client` turning redpanda connect into sort of a proxy webserver.


#### Message semantics {#message-semantics}

{{< figure src="/ox-hugo/20240901014444-stream_processing_ingestion_patterns-935743546.png" >}}

-   messages have `metadata` + `context`


#### `Configuration`, `Components` and `Resource` (Hierarchy) {#configuration-components-and-resource--hierarchy}

-   Configuration is passed via config file/api, `resources` are passed in via the `-r` flag.
-   `-r` is usually used to switch resources in different environments (used as feature toggle)

<!--list-separator-->

-  `components`

    -   `rpk connect list`, we sort of have components for these:
        -   Inputs
        -   Processors
        -   Outputs
        -   Caches
        -   Rate Limits
        -   Buffers
        -   Metrics
        -   Tracers
        -   Scanners
    -   In some/most cases, the same `component` will be available for `input` and `output` but the parameters will differ etc.
    -   `configuration` contains `components`
        -   `components` are hierarchical.
            -   Eg. `input` can have a list of child `processor` attached to it, which in turn can have their own `processor` children.

<!--list-separator-->

-  `resources`

    -   `resources` are `components` , identified by `label`.
        -   Some `components` such as `caches` and `rate limits` can only be created as a `resource`.
    -   Main usecase is "reuse", another similar concept is `templates`
    -   Can be specified in the same configuration, can also be specified separately and passed via `-r`
    -   Types
        -   `input_resources: []`
        -   `cache_resources: []`
        -   `processor_resources: []`
        -   `rate_limit_resources: []`
        -   `output_resources: []`
        -   It's defined using the above config and used in `input/pipeline/output` via the `resource` component

<!--list-separator-->

-  Other

    -   Eg. crazy number of levels

    <!--listend-->

    ```nil
     processors:
        - resource: foo # Processor that might fail
        - switch:
          - check: errored()
            processors:
              - resource: bar # Recover here
    ```


#### Batching {#batching}

<!--list-separator-->

-  Batching at `input` vs `output`

    -   It's little confusing, some components apparently perform better when batched at input, and some at input. If you want to do "batch processing" then you'd want to batch in the `input`.
        -   If `input` itself doesn't support batching, we can use `broker` and make the `input` or multiple input support batching at input stage.
        -   `broker` also works similarly for `output`

<!--list-separator-->

-  Creating and breaking batches

    -   A batch policy(input/output having `batching` attribute) has the capability to create batches, but not to break them down.
        -   This also takes in `processor` incase, you want to pre-process before sending out the batch.
    -   `split` breaks batches


#### Processor (array of processors in `input/pipeline/output` section) {#processor--array-of-processors-in-input-pipeline-output-section}

-   `proccessor` are not just limited to `pipeline` section.
-   Native way of doing processing/manipulating shit is via `bloblang` (via `mapping` or `mutation`)
    -   NOTE: The `mapping` processor previously was called the `bloblang` processor(now deprecated)

<!--list-separator-->

-  Data Enrichment

    <!--list-separator-->

    -  Branching

        {{< figure src="/ox-hugo/20240901014444-stream_processing_ingestion_patterns-471875811.png" >}}

    <!--list-separator-->

    -  Workflow

        {{< figure src="/ox-hugo/20240901014444-stream_processing_ingestion_patterns-1131335009.png" >}}

    <!--list-separator-->

    -  Caching

        > There's `cache` and then there's `cached`

        <!--list-separator-->

        -  `cache`

            ![](/ox-hugo/20240901014444-stream_processing_ingestion_patterns-221179985.png)
            ![](/ox-hugo/20240901014444-stream_processing_ingestion_patterns-1687139583.png)
            ![](/ox-hugo/20240901014444-stream_processing_ingestion_patterns-1585399265.png)

        <!--list-separator-->

        -  `cached`

            {{< figure src="/ox-hugo/20240901014444-stream_processing_ingestion_patterns-1876612491.png" >}}

<!--list-separator-->

-  Batching &amp; buffer

    <!--list-separator-->

    -  Basics

        -   `buffer` is how we handle `batching`
        -   `buffer` can be: window buffer, `batch` buffer
        -   Using `buffer` might alter the delivery guarantees etc. might drop things. be cautious.

    <!--list-separator-->

    -  Transactions and Buffering

        See [Database Transactions]({{< relref "20231113145513-database_transactions.md" >}})

        -   `input -> processing -> output` is a transaction (an ACK is sent to the input after output finishes)
        -   But when we use buffering, the semantics of this "transaction" is changed.

    <!--list-separator-->

    -  Pure Batching

        {{< figure src="/ox-hugo/20240901014444-stream_processing_ingestion_patterns-568650701.png" >}}

        -   config needed: `count, size, period`

    <!--list-separator-->

    -  Windowing / Window Processing

        {{< figure src="/ox-hugo/20240901014444-stream_processing_ingestion_patterns-582094035.png" >}}

        -   `Tumbling window`: No overlap
        -   `Sliding window`: Overlap
        -   config needed: `system_window` &amp; `group_by_value` in the processor
        -   This seems like but is NOT `stateful stream processing`, benthos is stateless. (debatable)
            -   [Stateful Stream Processing | Apache Flink](https://nightlies.apache.org/flink/flink-docs-master/docs/concepts/stateful-stream-processing/)

    <!--list-separator-->

    -  Rate limiting

        See [Rate Limiting]({{< relref "20231230211156-rate_limiting.md" >}})
        ![](/ox-hugo/20240901014444-stream_processing_ingestion_patterns-486169216.png)


#### Exception handling {#exception-handling}

{{< figure src="/ox-hugo/20240901014444-stream_processing_ingestion_patterns-1455545020.png" >}}

-   Works w `processor` and `output`, not w `input`??? (DOUBT)
    -   `retry` and `drop` work for both `processor` and `output`
    -   `reject` and `dlq` work only for `output`

<!--list-separator-->

-  Exception/Error creation

    -   an exception can be triggered by whatever happens when processing
    -   we can however have some control over how to create custom errors using blobl, otherwise if the processor itself errors out that works too.

<!--list-separator-->

-  Catching / Try / Drop

    -   `try` (abandon) : If any of the processor in sequence fails, "skip" rest of it.
    -   `retry` (unlimited attempts)
        -   This is similar to `try` as in like a blanket processor. But `try` simply just takes in a `list of processor`, but `retry` takes in some more params along with `list of processors`
    -   `catch` (handle): catch the message/event w error and handle it somehow.
        -   `catch` can be emulated with `switch:check:errored()` (this is desirable if you want to maintain the error flag after success)
        -   This is the `catch` processor, which is different from the `catch` function used in `bloblang`.
        -   `catch` can then send off the `error()` to `log` or remap the `new document` with the error message etc.

<!--list-separator-->

-  Dropping message

    -   `mapping` + `errored()` + `deleted()` : Dropping at processing stage. I personally would suggest dropping at output stage.
    -   `reject_errored`: (Dropping at `output` stage)
        -   rejects messages that have failed their "processing" steps
            -   If `input` supports `NACK/NAK`, it'll be sent a NAK at protocol level, and that message will NOT be re-processed.
            -   Successful messages/events are sent to the child output
            -   Otherwise they'll simply be reprocessed unless we use `fallback` and setup a DLQ mechanism.
    -   `switch` + `errored()` + `error()`: Maximum flexibility while handling how to route failed/errored messages.
    -   `broker` can also be used to route messages accordingly.

<!--list-separator-->

-  Fallback(eg.DLQ) and Batching

    -   Redpanda Connect makes a best attempt at inferring which specific messages of the batch failed, and only propagates those individual messages to the next fallback tier.
    -   However, depending on the output and the error returned it is sometimes not possible to determine the individual messages that failed, in which case the whole batch is passed to the next tier in order to preserve at-least-once delivery guarantees.


#### Development Tips 🌟 {#development-tips}

<!--list-separator-->

-  Test script

    ```yaml
    input:
      stdin:
        scanner:
           lines: {}
    output:
      stdout: {}
    ```

    **\*\***


#### Bloblang {#bloblang}

-   3 ways to use bloblang in `pipeline`: ![](/ox-hugo/20240901014444-stream_processing_ingestion_patterns-979595624.png)
-   Most common usecase is via `mapping`. Some of the usecases of `mapping` overlaps with use of `jq` processor and so on.

> -   Works in `processors` (proper) and in `output` (via interpolation only)
>     -   Processor
>         -   `processor:bloblang`
>         -   `processorr:mapping`
>         -   `processor:branch:request_map/result_map`
>         -   `processor:<other processors>` , eg. `switch` processor has a `check` attribute which takes in a blobl query.
>     -   Output (via interpolation)
> -   additionally, can evaluate using: `rpk connect blobl` / `server`

![](/ox-hugo/20240901014444-stream_processing_ingestion_patterns-1415772818.png)
![](/ox-hugo/20240901014444-stream_processing_ingestion_patterns-2055065224.png)

<!--list-separator-->

-  Interpolation &amp; Coalecing

    -   Env var:  `{ENV_VAR_NAME}`
    -   Interpolation of blobl: `${!<bloblang expression>}`
    -   Coalecing: root.contents = this.thing.(article | comment | share).contents | "nothing"

<!--list-separator-->

-  Variables

    -   Using `let` &amp; referenced using `$`
    -   Metadta access via interpolation or via `@` inside `mapping`
    -   Log all metadata
        ```yaml
        ​    - log:
                level: INFO
                fields_mapping: |-
                  root.metadata = meta()
        ```

<!--list-separator-->

-  Conditionals

    -   all conditionals are expressions
    -   `if` : Can be a `statement` and can also be an `assignemnt`
        ```nil
        // this works
        root.pet.treats = if this.pet.is_cute {
          this.pet.treats + 10
        } else {
          deleted()
        }

        // this also works
        if this.pet.is_cute {
          root.pet.treats = this.pet.treats + 10
          root.pet.toys = this.pet.toys + 10
        }
        ```
    -   `match`: Only `assignment`
        -   Also accepts a parameter which alters the `this` context.

<!--list-separator-->

-  Error handling &amp; creation

    -   It seems like error handling is only supported in `pipeline` block and not in `input` block processors. (have to confirm)
    -   Use of `catch`
    -   Error handling of `redpanda connect/benthos` is different from blobl error handling. These consepts exists at different levels of the stack.
    -   We create error either via `throw` or via using helper functions which help in validating and coercing fields(eg. `number, not_null, not_empty` etc.)

<!--list-separator-->

- <span class="org-todo todo TODO">TODO</span>  Functions vs Methods

    -   Methods: Specific to datatypes/structured inputs etc. Eg. string.split etc
    -   Functions: Independent functions

<!--list-separator-->

-  Custom Methods

    -   We create `custom methods` by using `map` keyword.
        -   `this` inside `map` refers to the parameter of `apply`
        -   `root` inside `map` refers to new value being created for each invocation of the map
    -   Can be applied to single values or to the entire object recursively.
        ```nil
        // use map for a specific case
        map parse_talking_head {
          let split_string = this.split(":")

          root.id = $split_string.index(0)
          root.opinions = $split_string.index(1).split(",")
        }

        root = this.talking_heads.map_each(raw -> raw.apply("parse_talking_head"))

        // apply for the whole document recursively
        map remove_naughty_man {
          root = match {
            this.type() == "object" => this.map_each(item -> item.value.apply("remove_naughty_man")),
            this.type() == "array" => this.map_each(ele -> ele.apply("remove_naughty_man")),
            this.type() == "string" => if this.lowercase().contains("voldemort") { deleted() },
            this.type() == "bytes" => if this.lowercase().contains("voldemort") { deleted() },
            _ => this,
          }
        }

        root = this.apply("remove_naughty_man")
        ```

<!--list-separator-->

-  `this` &amp; named context

    -   `this` points to the "context"
    -   Usually it points to the `input document`, but based on usage it can point to other things, eg. inside a `match` block, `match this.pet` now inside the `match` block, `this` will point to the document inside the outer `this.pet`, i.e reducing boilerplate inside the `match` block.
    -   Instead of `this`, we can also use named context with `<context name> -> <blobl query>`

<!--list-separator-->

-  `this` and `root` &amp; `mapping`

    -   `mapping` "most of the time" refers to mapping `JSON(structured) documents` (Both `new` and `input` documents)
    -   `mapping` purpose: construct a brand `new document` by using an `input document as a reference`
        -   Uses `assignments`, everything is an assignment, even deletion!
    -   components
        -   `root`: referring to the root of the `new document`
        -   `this`: referring to the root of the `input document`
    -   In a `mapping`, on the LHS, if you omit `root`, it'll still be root of the new document. i.e `root.foo` is same as `foo` on lhs.

    <!--list-separator-->

    -  Non JSON documents

        -   `this` ("this" is JSON specific)
            -   `this` keyword mandates that the current in-flight message is in JSON format
            -   You should first ensure that your message is valid JSON by using `log` processor (if it's not, you can use the `content()` function in a `mapping` processor to extract the message data and parse it somehow)
        -   `content()`
            -   Can be used in mapping the input as a binary string. `Eg. root = content().uppercase() vs root = this`, result is similar but `this` is json specific but with `content` we're reading with raw data.


#### Other notes {#other-notes}

-   @ vs meta
    -   root.poop = meta("presigned_url") # string
    -   root.doop = @presigned_url # binary

<!--list-separator-->

-  WASM

    [WebAssembly]({{< relref "20230510200213-webassembly.md" >}})

    -   I recommend using the redpanda_data_transform processor in connect. It’s based on WebAssembly and rpk can generate the boilerplate for you
    -   follow this tutorial: <https://docs.redpanda.com/current/develop/data-transforms/run-transforms/>
    -   But instead of using rpk transform deploy,
    -   point the built wasm module using <https://docs.redpanda.com/redpanda-connect/components/processors/redpanda_data_transform/> that module_path property is a path to the wasm file from rpk transform build
    -   docs.redpanda.com
    -   Data Transforms in Linux Quickstart | Redpanda Self-Managed
    -   Learn how to build and deploy your first transform function in Linux deployments.


## things ppl say {#things-ppl-say}

-   We use debezium to stream CDC from our DB replica to Kafka.
    -   We have various services reading the CDC data from Kafka for processing


## Resources {#resources}

-   [GitHub - turbolytics/sql-flow: DuckDB for streaming data](https://github.com/turbolytics/sql-flow)
-   <https://web.archive.org/web/20230509174541/https://docs.google.com/spreadsheets/d/1DwobnPHZCCAYCcgR3u62-XFRwWQbbTXeurYo2-2rR0A/edit#gid=0>
