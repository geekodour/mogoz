+++
title = "Window Functions in SQL"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [SQL]({{< relref "20230217190123-sql.md" >}})


## Basics {#basics}

![](/ox-hugo/20230217190123-sql-808720929.png)
![](/ox-hugo/20230217190123-sql-677262254.png)
![](/ox-hugo/20230217190123-sql-1563821933.png)

-   Like an aggregation but tuples are not grouped into a single output tuples.
-   You can probably do what window function does by clever use of subqueries and `GROUP BY` but window functions make it easier
-   Will add a new column in `SELECT` (Which will be the window aggregated value)
-   Let's you
    -   Reference values in other rows!
    -   Do a sort of "extended group by"
    -   Compute aggregation in incremental fashion
    -   Performs a "sliding" calculation across a set of tuples that are related.


## Use {#use}

-   Running totals
-   Moving averages


## Components {#components}

-   Window: A set of rows
    -   Can be a whole table
    -   Can be one single row
-   Aggr Func: Normal aggregation functions + `ROW_NUMBER()`, `RANK()`, `LAG`, `LEAD`, `NTH_VALUE` etc.
-   `OVER` : How to group tuples while computing the `window func`


## Aggregation functions {#aggregation-functions}

From some reddit comment

-   If you need to join a row to it's logical "next" row (e.g. a query which joins today's sales with yesterdays sales), you can simplify subqueries using LEAD/LAG
-   If you need to know the relative position of rows in the dataset, then use ROW_NUMBER/RANK/NTILE.
-   If you want to aggregate rows based on unique values of a certain column (e.g. return a table of sales with columns for each month), it's much easier to use PIVOT/UNPIVOT than CASE statements.
-   If you need to filter rows based on the output of an aggregate function, for example finding all rows that where Count(\*) &gt; 2, use a HAVING clause than a nested query.


## On OVER {#on-over}

{{< figure src="/ox-hugo/20231019212748-window_functions_in_sql-778519145.png" >}}

-   `ORDER BY` and `PARTITION BY` can be used together
    -   `PARTITION_BY` segregates is like `GROUP_BY` but per partition
    -   `ORDER_BY` segregates using range/row/group with custom frame start and end using `BETWEEN`
-   `OVER` is not specific to Window functions but mostly used
-   Alternative to `GROUP BY`


### OVER() {#over}

-   `OVER()` : makes all rows visible at every row

{{< figure src="/ox-hugo/20230217190123-sql-1049070408.png" >}}


### PARTITION BY {#partition-by}

-   When you want to `aggregate` but `not merge`
-   This partition has nothing to do with database partitioning (See [Scaling Databases]({{< relref "20230608143206-scaling_databases.md" >}}))

![](/ox-hugo/20230217190123-sql-1398448603.png)
![](/ox-hugo/20230217190123-sql-108054879.png)
![](/ox-hugo/20230217190123-sql-438292000.png)
![](/ox-hugo/20230217190123-sql-2014090892.png)


### ORDER BY {#order-by}

{{< figure src="/ox-hugo/20230217190123-sql-1711695673.png" >}}

-   `ORDER BY` inside a window function only affects the window and not the query output


#### FRAMING {#framing}

![](/ox-hugo/20230217190123-sql-1619572283.png)
![](/ox-hugo/20230217190123-sql-1906471995.png)


#### RANKING {#ranking}


## Learn more on Window Functions {#learn-more-on-window-functions}

-   [SQL Window Functions Explained [book]​](https://antonz.org/sql-window-functions-book/)
-   [Window Functions in SQL - Simple Talk](https://www.red-gate.com/simple-talk/databases/sql-server/t-sql-programming-sql-server/window-functions-in-sql/)
-   [6 Key Concepts, to Master Window Functions · Start Data Engineering](https://www.startdataengineering.com/post/6-concepts-to-clearly-understand-window-functions/)
-   [Introduction to Window Functions in SQL](https://khashtamov.com/en/sql-window-functions/)
-   [Advanced SQL window functions quiz](http://www.windowfunctions.com/questions/intro/)
-   <https://momjian.us/main/writings/pgsql/window.pdf>
-   [Pagination Using window-functions (OVER)](https://use-the-index-luke.com/sql/partial-results/window-functions)
