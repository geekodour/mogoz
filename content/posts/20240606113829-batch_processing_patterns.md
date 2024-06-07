+++
title = "Batch Processing Patterns"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Data Engineering]({{< relref "20230405003455-data_engineering.md" >}})


## Incremental batch Jobs {#incremental-batch-jobs}


### Mets {#mets}

-   It's given that for the inserts themselves we'll be using upsert or handling de-duplication in some-way
-   Secondly its given that all of these jobs by nature will be idempotent
-   There's also CDC and SCD Type2


### Patterns {#patterns}


#### Process Indicator/ High Watermark pattern {#process-indicator-high-watermark-pattern}

-   What: Fetch some data, keep a mark of last(highest) fetched record, on next run pick from there.
-   It assumes all chunks are processed sequentially
-   The last chunk processed has the largest set of ids
-   This will not work at all when doing trying to run the job in parallel
    -   For when running in parallel, there will be no sequence and "order" will not matter and `last != largest` in the source dataset.
    -   So this can only be useful if we fetching sequentially
-   Examples of this pattern
    -   [data ingestion - How can I do an incremental load based on record ID in Dagster - Stack Overflow](https://stackoverflow.com/questions/73983827/how-can-i-do-an-incremental-load-based-on-record-id-in-dagster)
    -   [How to incrementally update an asset without using partitions · dagster-io/dagster · Discussion #14733 · GitHub](https://github.com/dagster-io/dagster/discussions/14733)
    -   [process indicator pattern](https://stackoverflow.com/questions/66690749/starting-a-new-job-instance-with-last-processed-record-as-jobparameter-in-spring)
