+++
title = "Functional Programming"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Programming Languages]({{< relref "20221101220306-programming_languages.md" >}})


## Meta {#meta}

-   Mutability breaks "referential transparency": ability to replace expression with ts value without affecting result of computation
-   Variables never change value
-   [Functions]({{< relref "20221101164202-functions.md" >}}) never have side effects


### Mutation {#mutation}

-   Mutation is more than just a way to of getting a computation done, it becomes shared state/communication channel and we want to avoid doing that whenever possible.
-   Side-effects is another term for mutations and similar things


### Composition {#composition}

Two things to make composition easier

-   Abstractions
-   Immutability


## Internet comments {#internet-comments}

-   Unlike imperative programming, functional programming is not a series of “steps” where you just exit when you are done, returning some value. It is instead a mathematical expression.
