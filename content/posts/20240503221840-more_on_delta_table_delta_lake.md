+++
title = "More on Delta Table / Delta Lake"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Data Engineering]({{< relref "20230405003455-data_engineering.md" >}})


## FAQ {#faq}


### Delta Lake and Streaming {#delta-lake-and-streaming}

-   Some people are using it as a <https://github.com/delta-io/delta-rs/issues/413>
-   Delta lake supports streaming but delta-rs package has some limitations I think
    -   [Table streaming reads and writes — Delta Lake Documentation](https://docs.delta.io/latest/delta-streaming.html)
    -   <https://github.com/pola-rs/polars/issues/2858#issuecomment-1722202162>


### How delta-rs and pyarrow and polars are related? {#how-delta-rs-and-pyarrow-and-polars-are-related}

Delta-rs can read a delta table and create a pyarrow table in memory, which you can then use to create a polars dataframe.


### Benifits of delta table over plain parquet {#benifits-of-delta-table-over-plain-parquet}

-   Schema evolution
-   Versioning
-   Delta tables always return the most up-to-date information, so there is no need to call REFRESH TABLE [manually after changes](https://docs.databricks.com/en/delta/best-practices.html#differences-between-delta-lake-and-parquet-on-apache-spark).
    -   See if we have this gurantee with `delta-rs`


## Delta Table/Lake usage {#delta-table-lake-usage}

{{< figure src="/ox-hugo/20230405003455-data_engineering-1276164824.png" >}}

-   Earlier this was only available to be used via Spark based APIs. But with `delta-rs`, this changes and we can access delta lake with other APIs.
-   [DuckDB]({{< relref "20231123234702-duckdb.md" >}}) with pyarrow
    -   Uses `delta-rs`, an of the Delta Lake protocol in Rust, featuring Python bindings.
-   Polars
    -   Polars Delta Lake connector depends on `delta-rs`
-   [Kafka]({{< relref "20230210012126-kafka.md" >}})
    -   [delta-io/kafka-delta-ingest](https://github.com/delta-io/kafka-delta-ingest)


## Operations in Delta Lake / Table {#operations-in-delta-lake-table}

> -   These are differently named in `delta-rs` lib and original delta lake terminologies
> -   Thing is not worry about how things are looking in the delta table repository, there can be multiple versions etc. appends can keep older files, etc. compaction will compact files etc. Just thinking in terms of operations is good enough. Ideally, you never want to touch the delta table directory manually.

-   Some [delta.io documentations](https://docs.delta.io/2.0.2/delta-update.html#language-python) use `delta-spark` python package. We are using the [deltalake](https://pypi.org/project/deltalake/) python package which is part of the [delta-rs](https://github.com/delta-io/delta-rs?tab=readme-ov-file) project.
-   `delta-rs` is a delta lake implementation in rust on top of pyarrow, which does not need spark. Great for small scale pipelines!
-   Finally we might want to use `polars` because it builds on top of `delta-rs` and gives us nice wrappers in which we don't need to deal with pyarrow direrctly and has helper methods and optimizations.
-   Some delta documentations have mentions of `INSERT`, `UPDATE`, `DELETE` and `MERGE`. which can be applied to a table.
-   **All operations on delta table are logical.**, i.e if you delete, it's not really deleted etc. `vaccumm` is later used to actually remove files from disk.
    -   TODO: What about merge??


### Writer methods {#writer-methods}

-   We're following what `delta-rs` write gives us: `‘error’, ‘append’, ‘overwrite’, ‘ignore’`
-   Additionally if we use polars, we can use `merge` along with this. But using `merge` needs us to do additional things. If we're not using polars, we need to do merge by getting the pyarrow thing manually.


#### error {#error}


#### append {#append}

-   [There is no way to enforce delta table column to have unique values](https://community.databricks.com/t5/data-engineering/how-to-enforce-delta-table-column-to-have-unique-values/td-p/7098). So we want to use append only if we can ensure that there are no duplicates.
-   If you don't have Delta table yet, then it will be created when you're using the append mode.
-   Mode "append" atomically adds new data to an existing Delta table and "overwrite" atomically replaces all of the data in a table.

<!--list-separator-->

-  Merging vs Append

    -   Append: When you know there are no duplicates


#### overwrite {#overwrite}

-   Instead of writing data in the append mode, you can overwrite the existing data. But this still will duplicate files in storage


#### ignore {#ignore}


#### merge {#merge}

-   You have some JOIN between one or more columns between two Delta tables. If there is a match then UPDATE, otherwise if there is NO match then INSERT.
-   There can be multiple `whenMatched` and `whenNotMatched` clauses

<!--list-separator-->

-  Concerns

    -   A merge operation can fail if `multiple rows of the source match the target` and then we try to update target table.
    -   Merge in delta table requires 2 pass over the source dataset, so `merge` can produce incorrect results if the source dataset is non-deterministic(eg. current time).
        -   Eg. Reading from non-Delta tables. For example, reading from a CSV table where the underlying files can change between the multiple scans.
    -   MERGE INTO is slow on big datasets. Think about compaction and access patterns if this happens. Having partitioning and using it in the query can help.


### Handling schema updates {#handling-schema-updates}

> Attempting to add data to a Delta file that has different schema ( different column names, differnt data types, etc) will cause Delta to deny the transaction and it will raise an exception (A schema mismatch detected when writing to the delta table) and will show you the current data schema and the schema of the data that you are trying to append. It becomes up to you to fix the schema before appending the data or if you want the new columns to be added to the existing schema you can choose to do Schema Evoloution by approving the new schema.

-   In `merge`, schema is handled the following ways:
    -   For `update` / `insert` , the specified target columns must exist in target
    -   For `updateAll` / `insertAll`
        -   `source` must have all of `target` columns
        -   `source` can have extra columns. i.e source columns can be superset
            -   extra column are ignored by default
            -   If schema evolution is enabled, new columns will be added to target table


### <span class="org-todo todo TODO">TODO</span> Table methods {#table-methods}

-   TODO Read the delta-rs docs


#### Table operations {#table-operations}

See <https://docs.delta.io/2.0.2/delta-update.html#language-python>

-   delete
-   update
-   merge
