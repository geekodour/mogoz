+++
title = "Programming Languages"
author = ["Hrishikesh Barman"]
draft = false
+++

## How they are made? {#how-they-are-made}

-   C, FORTRAN, Java, Pascal, Lisp, Forth, Ada, Python, Ruby, Go, etc.: none of these languages are context-sensitive. None are context-free either. Programming languages are compilcated
-   Modern languages typically are defined in multiple levels
    -   L1: Defining the lexical structure, using something like regular expressions
    -   L2: Defining context-free grammar or close to it
    -   L3: Uses arbitrary code to finish the parse.
-   This has proven to be a robust way to design languages which both humans and compilers understand.


### Lex/Flex vs Yacc/Bison {#lex-flex-vs-yacc-bison}

-   These are old tools, but basically `Lex` and `Yacc` "were" not free. While their alternatives `Flex` and `Bison` are.


#### Lexing {#lexing}

-   `Flex` is a lexer generator
-   `Lexing` : Turning a stream of characters into a stream of abstract `tokens`
-   It lets you provide a regex for each type of token in your language, and it will write a lexer for you


#### Parsing {#parsing}

-   `Bison` is a parser generator. It takes a list of `productions` and writes a parser for you.
-   `Parsing`: Collecting `tokens` into their `productions`
-   Lets you specify a `grammar` that groups `tokens` together into various logical pieces. Eg. Order of operations, groups statements properly as intended by the programmer.
-   Usually that grammar is given in something like [BNF]({{< relref "20230422075825-bnf.md" >}})


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
-   "what to do, not how to do it."
-   Functional programming is a subset of declarative programming
-   Declarative programming is to program on a higher level of abstraction than imperative programming. Neither is better or worse, but both have their places.


### Imperative {#imperative}

-   A procedure
-   "How to do it, not what to do
-   Procedural programming is a subset of imperative programming.
