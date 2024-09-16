+++
title = "Programming Languages"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Parsers]({{< relref "20230511160225-parsers.md" >}})

> Thus a language definition implies a model of the machine on which programs in the language will run. If a real machine conforms well to the model, then an implementation on that machine is likely to be efficient and easily written; if not, the implementation will be painful to provide and costly to use.
>
> Via "Portability of C Programs and the Unix System", S.C. Johnson and D.M. Ritchie


## How they are made? {#how-they-are-made}

-   C, FORTRAN, Java, Pascal, Lisp, Forth, Ada, Python, Ruby, Go, etc.: none of these languages are context-sensitive. None are context-free either. Programming languages are complicated
-   Modern languages typically are defined in multiple levels
    -   L1: Defining the lexical structure, using something like [Regular Expressions]({{< relref "20230413090911-regular_expressions.md" >}})
    -   L2: Defining [Context Free Grammar (CFG)]({{< relref "20230422102551-context_free_grammar_cfg.md" >}}) or close to it
    -   L3: Uses arbitrary code to finish the parse.
-   This has proven to be a robust way to design languages which both humans and compilers understand.


### Lex/Flex vs Yacc/Bison {#lex-flex-vs-yacc-bison}

-   These are old tools, but basically `Lex` and `Yacc` "were" not free. While their alternatives `Flex` and `Bison` are.


#### Lexing {#lexing}

-   `Flex` is a lexer generator
-   `Lexing` : Turning a stream of characters into a stream of abstract `tokens`
-   It lets you provide a [Regex]({{< relref "20230413090911-regular_expressions.md" >}}) for each type of token in your language, and it will write a lexer for you


#### Parsing {#parsing}

-   `Bison` is a parser generator. It takes a list of `productions` and writes a parser for you.
-   `Parsing`: Collecting `tokens` into their `productions`
-   Lets you specify a `grammar` that groups `tokens` together into various logical pieces. Eg. Order of operations, groups statements properly as intended by the programmer.
-   Usually that grammar is given in something like [BNF]({{< relref "20230422075825-bnf.md" >}})


### LLVM {#llvm}

See [LLVM]({{< relref "20231101205118-llvm.md" >}})


### Grammar? {#grammar}

-   See [Chomsky Hierarchy]({{< relref "20230421154510-chomsky_hierarchy.md" >}})
-   For reading in the `user input` we need to write a `grammar` which `describes` the `language`.
    -   Use the `grammar` to validate `user input`.
    -   Use the `grammar` to build a structured internal representation(understand, evaluate, compute etc)


## Paradigms {#paradigms}

{{< figure src="/ox-hugo/20221101220306-programming_languages-651648906.png" >}}

> Difference between [function and a procedure](http://amzotti.github.io/programming%20paradigms/2015/02/13/what-is-the-difference-between-procedural-function-imperative-and-declarative-programming-paradigms/)
>
> Both functions and procedures are subroutines used to re-executing a predefined block of code.
>
> -   Functions
>     -   Functions return a value
>     -   Designed to have minimal side effects
>     -   Usually concerned with higher level ideas and concepts.'
> -   Procedure
>     -   Do not return a value
>     -   Primary purpose is to accomplish a given task and cause a desired side effect.


### Declarative {#declarative}

-   A Function
-   Expressions. Usually no statements or commands.
-   "what to do, not how to do it."
-   [Functional Programming]({{< relref "20221125204135-functional_programming.md" >}}) is a subset of declarative programming
-   Declarative programming is to program on a higher level of abstraction than imperative programming. Neither is better or worse, but both have their places.


### Imperative {#imperative}

-   Statements and Commands
-   A procedure. Causes side effects, mutates state.
-   How to do it, not what to do
-   Procedural programming is a subset of imperative programming.


## Terms {#terms}

-   Statically Typed: Detects type errors at compile time; if a type error is detected, the language won’t allow execution of the program.
-   Type Safety: A type-safe language limits which kinds of operations can be performed on which kinds of data.
    -   Some languages, like Python and Racket, are type-safe but dynamically typed. That is, type errors are caught only at run time. Other languages, like C and C++, are statically typed but not type safe: they check for some type errors, but don’t guarantee the absence of all type errors. That is, there’s no guarantee that a type error won’t occur at run time. And still other languages, like Java, use a combination of static and dynamic typing to achieve type safety.


## Links {#links}

-   [One Div Zero: A Brief, Incomplete, and Mostly Wrong History of Programming Languages](https://james-iry.blogspot.com/2009/05/brief-incomplete-and-mostly-wrong.html)
-   [Where does software innovation happen? A zoomable map](https://pldb.io/blog/whereInnovation.html)
