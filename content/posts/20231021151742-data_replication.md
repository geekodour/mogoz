+++
title = "Data Replication"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Scaling Databases]({{< relref "20230608143206-scaling_databases.md" >}}), [Data Engineering]({{< relref "20230405003455-data_engineering.md" >}}), [Database]({{< relref "20221102123145-database.md" >}}), [Distributed Systems]({{< relref "20221102130004-distributed_systems.md" >}})


## <span class="org-todo todo TODO">TODO</span> Types {#types}

NOTE: Many of these could be different names for same thing


### WAL file archiving {#wal-file-archiving}


### Full table replication {#full-table-replication}

Full table replication copies all existing, new, and updated data from the primary database to the target, or even to every site in your distributed system.


### Key based (incremental) replication {#key-based--incremental--replication}

Key-based incremental replication identifies updated and new data using a replication key column in the primary database and only updates data in the replica databases which has changed since the last update. This key is typically a timestamp, datestamp, or an integer.


### Log based (incremental) replication {#log-based--incremental--replication}

Log-based incremental replication copies data based on the database binary log file, which provides information on changes to the primary database such as inserts, updates, and deletes.


### Logical replication {#logical-replication}


### Trigger based replication {#trigger-based-replication}


### Real time replication {#real-time-replication}


### Streaming replication {#streaming-replication}


### Multi master replication {#multi-master-replication}

-   More often than not, when people think they "need" multi-master they actually don't.
-   the application needs to be written for such a setup


### active-active replication {#active-active-replication}


## TO Read {#to-read}

-   DDIA : Chapter 5 &amp; 7
-   <https://en.wikipedia.org/wiki/Replication_(computing)>
-   <https://arpitbhayani.me/blogs/multi-master-replication/>
-   <https://arpitbhayani.me/blogs/master-replica-replication/>
-   <https://www.reddit.com/r/SQLServer/comments/brqhfc/is_transactional_replication_the_right_approach/>
-   <https://www.reddit.com/r/dataengineering/comments/130ls2m/how_does_your_company_handle_replication_and_cdc/>
-   <https://debezium.io/>
-   <https://docs.google.com/spreadsheets/d/1DwobnPHZCCAYCcgR3u62-XFRwWQbbTXeurYo2-2rR0A/edit#gid=0>
-   <https://www.reddit.com/r/PostgreSQL/comments/9fjeoe/postgresql_tutorial_getting_started_with/>
-   <https://redis.com/blog/what-is-data-replication/>
-   <https://www.keboola.com/blog/database-replication-techniques>
-   <https://learn.microsoft.com/en-us/sql/relational-databases/replication/types-of-replication?view=sql-server-ver16>
-   <https://github.com/neuroforgede/pg_auto_failover_ansible>
-   <https://github.com/hapostgres/pg_auto_failover>
-   <https://www.2ndquadrant.com/en/blog/logical-replication-postgresql-10/>
-   <https://www.citusdata.com/blog/2018/02/21/three-approaches-to-postgresql-replication/>
-   <https://www.reddit.com/r/PostgreSQL/comments/10qn58p/logical_replication_in_postgresql/>
-   <https://medium.com/@piyushbhangale1995/logical-replication-in-postgresql-c448e4b3eb95>
-   <https://www.reddit.com/r/PostgreSQL/comments/14g0vls/framework_for_achieving_postgresql_multimaster/>
-   <https://www.enterprisedb.com/>
