+++
title = "Programming Languages"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Parsers]({{< relref "20230511160225-parsers.md" >}})


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

-   How it helps?
    -   Writing two backends for two different architectures would be a lot of work and then lots of platform specific optimizations therefore llvm is the present and seems to be the future for the foreseeable future as well.
    -   See MLIR


## Paradigms {#paradigms}

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
