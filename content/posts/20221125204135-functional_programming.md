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


## Principles/Concepts {#principles-concepts}


### Abstraction Principle {#abstraction-principle}

The Abstraction Principle says to avoid requiring something to be stated more than once; instead, factor out the recurring pattern. Higher-order functions enable such refactoring, because they allow us to factor out functions and parameterize functions on other functions.


## Links {#links}

-   <https://www.reddit.com/r/programming/comments/17obifa/monads_for_the_rest_of_us/?context=3>


## Internet comments {#internet-comments}

-   Unlike imperative programming, functional programming is not a series of “steps” where you just exit when you are done, returning some value. It is instead a mathematical expression.
