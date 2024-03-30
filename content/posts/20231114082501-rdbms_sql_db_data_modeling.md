+++
title = "RDBMS / SQL / DB Data Modeling"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Database]({{< relref "20221102123145-database.md" >}}), [SQL]({{< relref "20230217190123-sql.md" >}}), [Database Indexing]({{< relref "20231113185310-database_indexing.md" >}})

A data model is a collection of concepts for describing the data in a database.


## Normalization {#normalization}


### Which one? {#which-one}

-   This really depends on access pattern and usecase
-   But generally go with normalized cuz less space and updates in one place, we can always de-normalize it if required


### Normalized {#normalized}

-   Why normalize? to reduce data redundancy and better `data integrity` through `constraints`.
-   Less storage space, More lookups, Updates in one place
-   We need to JOIN


### De-normalized {#de-normalized}

-   More storage, Less lookups, Updates in many places!


## Keys/Constraints {#keys-constraints}

> Keys define constraints


### Primary {#primary}

-   Primary key uniquely identifies a single tuple.
-   Must be `UNIQUE` and `NOT NULL`. Can be added via
-   Adding a primary key will automatically create a unique B-tree index on the column or group of columns
-   In [Distributed Systems]({{< relref "20221102130004-distributed_systems.md" >}}), primary keys via `auto-incrementing id` may not be not ideal. Because now we need a global lock. [uuid]({{< relref "20230801145421-uuid.md" >}}) solves this.


#### Best practices {#best-practices}

-   Pick a globally unique natural primary key (e.g. a username) where possible.
-   Whether to have composite primary key or have one primary key with the things concatenated is choice. If you have one single column primary key, [SQL JOINs]({{< relref "20231019134157-sql_joins.md" >}}) might look simpler.


#### Postgres Examples {#postgres-examples}

```sql
CREATE TABLE products (
    product_no integer UNIQUE NOT NULL,
    name text,
    price numeric
);
CREATE TABLE products (
    product_no integer PRIMARY KEY,
    name text,
    price numeric
);
CREATE TABLE example (
    a integer,
    b integer,
    c integer,
    PRIMARY KEY (a, c)
);
```


### Foreign {#foreign}

-   Often recommended as a must-have for enforcing referential integrity checks in your database.
-   Optional constraint: `UNIQUE`
-   Optional constraint: `NOT NULL`
-   A foreign key must reference(parent) columns that either are a primary key or form a unique constraint.
    -   reference c(i.e column in `parent table` must have an index)
-   A table can have multiple foreign keys with different tables
-   See [Database Indexing]({{< relref "20231113185310-database_indexing.md" >}})


#### Terms {#terms}

-   `FK`: A column or a group of columns in a table that reference the primary key of another table.
-   `child table / referencing table`: Table containing the FK
    -   Good idea to add index the referencing column too because, `ON DELETE` and `ON UPDATE` will need to scan this back.
-   `parent table / referenced table`: Table being referred to by the FK
    -   Always an indexed column(s) by design
-   `CONSTRAINT` : Command used to specify name for FK. (optional)
-   `FOREIGN KEY` : Specify column(s) from `child table`
-   `REFERENCES` : Specify column(s) from `parent table`


#### Postgres Examples {#postgres-examples}

```sql
CREATE TABLE orders (
    order_id integer PRIMARY KEY,
    product_no integer REFERENCES products (product_no),
    quantity integer
);
-- same as
-- NOTE: in absence of a column list the primary key of the parent table is used
-- as the referenced column
CREATE TABLE orders (
    order_id integer PRIMARY KEY,
    product_no integer REFERENCES products,
    quantity integer
);
-- multiple column FK
-- child cols ~ parent col (number&type)
CREATE TABLE t1 (
  a integer PRIMARY KEY,
  b integer,
  c integer,
  FOREIGN KEY (b, c) REFERENCES other_table (c1, c2)
);
-- self referencing is allowed
CREATE TABLE tree (
    node_id integer PRIMARY KEY,
    parent_id integer REFERENCES tree,
    name text,
    ...
);
```


#### Deleting/Updating records with foreign keys? {#deleting-updating-records-with-foreign-keys}

-   If we have FK constraints, it'll prevent deletion if we try deleting from `parent table`. We'll need to update the `referencing/child row` before deleting
-   `ON DELETE`, `ON UPDATE` : determine the behaviors when the primary key in the parent table is deleted and updated. (TODOTODO)
-   We have `ON DELETE` and `ON UPDATE`, `ON UPDATE` is not used much as `REFERENCES` column is usually primary key and primary keys are not updated often.
-   `ON DELETE`
    -   NO ACTION (default behavior, raise error)
    -   RESTRICT (most common, does not defer the check)
    -   CASCADE (most common) : When a parent row is deleted, child row(s) should be automatically deleted as well.
        -   SET NULL: Set the cild row in the child column to NULL
        -   SET DEFAULT: Set the cild row in the child column to column's default value
    -   NOTE: `ON DELETE` will not delete the child row. It'll just deal with the FK. An application that actually wants to delete both objects would then have to be explicit about this and run two delete commands.
-   `ON UPDATE`
    -   CASCADE: Updated value of the referenced column should be reflected in the child table.


#### More than one column foreign key? (Composite FK) {#more-than-one-column-foreign-key--composite-fk}

-   `number&type` of columns in `child table` need to match the `number&type` of columns in `parent table`
-   `FOREIGN KEY` : Specify column(s) from `child table`
-   `REFERENCES` : Specify column(s) from `parent table`


#### Junction tables {#junction-tables}

-   [Why exactly area many-to-many relationships bad database design?](https://www.reddit.com/r/Database/comments/al8rop/why_exactly_area_manytomany_relationships_bad/)
-   [Should I store additional data in SQL join/junction table?](https://stackoverflow.com/questions/38403191/should-i-store-additional-data-in-sql-join-junction-table)
-   [Where should linking tables be stored?](https://softwareengineering.stackexchange.com/questions/437742/where-should-linking-tables-be-stored)
-   [What benefit does a junction table provide](https://softwareengineering.stackexchange.com/questions/426533/what-benefit-does-a-junction-table-provide-over-adding-an-additional-field-with)


### Others keys {#others-keys}

-   Surrogate key: Primary keys that are not columns
-   Candidate keys
    -   All the keys that could have been the primary key
-   Alternate keys
    -   Basically unique keys
    -   In [PostgreSQL]({{< relref "20221102123302-postgresql.md" >}}), there's no notion of alternate keys. As an alternative, you can simply use `UNIQUE` constraint or `UNIQUE` index.
    -   Basically has the potential to be primary key but not. (`Alternate keys = Candidate Keys - Primary Key`)


### Other constraints {#other-constraints}

-   `CHECK`: For each column, you can put a check constraint at DB level. (Beware of operand being `NULL`)
    ```sql
      price numeric CHECK (price > 0)
      -- same as
      price numeric CONSTRAINT positive_price CHECK (price > 0)
      -- multi column (eg. check that discounted price always less)
      price numeric CHECK (price > 0), -- column constraint
      discounted_price numeric CHECK (discounted_price > 0), -- column constraint
      CHECK (price > discounted_price) -- table constraint
      -- same as (matter of taste)
      CHECK (discounted_price > 0 AND price > discounted_price)
    ```
-   `NOT NULL` is same as `CHECK (column_name IS NOT NULL)`


## Relationships {#relationships}

See [SQL X-to-Y – Damir Systems Inc.](https://archive.is/20201101183428/https://www.damirsystems.com/sql-x-to-y/#selection-843.35-846.0)

| Possibility | Existence     | Multiplicity of entity |
|-------------|---------------|------------------------|
| is in       | exactly-one   | [1]                    |
| is in       | at-most-one   | [0,1]                  |
| is in       | at-least-one  | [1,\*]                 |
| may be in   | more-than-one | [0,\*]                 |

Here, in this example we have two entities `T` (thing) and `C` (category), both can be in one of these 4 states.(4x4=16 cases). Some of these cases can be
![](/ox-hugo/20221102123145-database-1445371018.png)


### Possibilities {#possibilities}


#### T[1] - C[1] {#t-1-c-1}

-   exactly-one `thing` in `each category`
-   exactly-one `category` in `each thing`


#### T[0,1] - C[1] {#t-0-1-c-1}

-   at-most-one `thing` in `each category`
-   exactly-one `category` in `each thing`


#### T[0,\*] - C[1] {#t-0-c-1}

-   more-than-one `thing` maybe in `each category`
-   exactly-one `category` in `each thing`


#### T[1] - C[0,1] {#t-1-c-0-1}


#### T[0,1] - C[0,1] {#t-0-1-c-0-1}


#### T[0,\*] - C[0,1] {#t-0-c-0-1}


#### T[0,\*] - C[1,\*] {#t-0-c-1}


#### T[1] - C[0,\*] {#t-1-c-0}


#### T[0,1] - C[0,\*] {#t-0-1-c-0}


#### T[1,\*] - C[0,\*] {#t-1-c-0}


#### T[0,\*] - C[0,\*] {#t-0-c-0}


#### T[1] - C[1,\*] / Hard {#t-1-c-1-hard}

-   exactly-one `thing` in `each category`
-   at-least-one `category` in `each thing`


#### T[1,\*] - C[0,1] / Hard {#t-1-c-0-1-hard}

-   at-least-one `thing` in `each category`
-   at-most-one `category` in `each thing`


#### T[1,\*] - C[1] / Hard {#t-1-c-1-hard}

-   at-least-one `thing` in `each category`
-   exactly-one `category` in `each thing`


#### T[1,\*] - C[1,\*] / Hard {#t-1-c-1-hard}


#### T[0,1] - C[1,\*] / Hard {#t-0-1-c-1-hard}


### <span class="org-todo todo TODO">TODO</span> Why do some of these need triggers etc. need to dig {#why-do-some-of-these-need-triggers-etc-dot-need-to-dig}


## Schema {#schema}


### Logical schema/Interface {#logical-schema-interface}

-   [Codd’s](https://en.wikipedia.org/wiki/Edgar_F._Codd) belief that queries should only be written to the interface, and never to the implementation.
-   The logical schema is the set of tables and logical constraints (foreign keys, CHECK constraints, etc) on those tables.


### Physical schema/Implementation {#physical-schema-implementation}

-   Physical schema is the set of indexes provided for those tables.


## Other best practices {#other-best-practices}

-   Maybe don't name tables with keywords like `users` etc.
-   When adding dates, if timestamp not needed. use time(0), will save timezone woes.
