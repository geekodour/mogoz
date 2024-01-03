+++
title = "Context Free Grammar (CFG)"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Chomsky Hierarchy]({{< relref "20230421154510-chomsky_hierarchy.md" >}}), [Regular Expressions]({{< relref "20230413090911-regular_expressions.md" >}}), [Automata Theory]({{< relref "20230421132238-automata_theory.md" >}}), [Parsers]({{< relref "20230511160225-parsers.md" >}})

> A context-free grammar is a grammar in which the left-hand side of each production rule consists of only a single nonterminal symbol.
>
> 2 non terminals, CFG sad :)
> \\[
> L(G) = {a^nb^nC^n|n \ge 1}
> \\]
>
> 1 non terminals, CFG go brrr :)
> \\[
> L(G) = {a^nb^n|n \ge 1}
> \\]


## What? {#what}

-   Introduced in the [Chomsky Hierarchy]({{< relref "20230421154510-chomsky_hierarchy.md" >}}), one of the few types of grammar. Type 2 to be specific.
-   Recursive system for generating strings
-   Almost every programming language defines its language using CFG using the [BNF]({{< relref "20230422075825-bnf.md" >}}) notation, but most languages [are actually context sensitive](http://trevorjim.com/python-is-not-context-free/)


## Grammar {#grammar}

![](/ox-hugo/20230422102551-context_free_grammar_cfg-147790085.png)
![](/ox-hugo/20230422102551-context_free_grammar_cfg-462622954.png)

-   `terminals`
    -   symbols of the alphabet of the language being defined.
-   `variables`
    -   `nonterminals`: A finite set of other symbols(strings), each of which represents a language.
    -   Recursive sets of `strings` (`languages`)
    -   Start symbol
        -   The `variable` whose `language` is the one being defined.
-   `rule`: Referred to as a `production`
    -   head -&gt; body
    -   `variable` (head) -&gt; string of `variables` and `terminals` (body)


### Derivations {#derivations}

{{< figure src="/ox-hugo/20230422102551-context_free_grammar_cfg-1955617418.png" >}}

-   `Derivations` allow us to replace **any** of the `variables` in the `string`.
    -   **any** is key here, it's what makes things context free
-   We `derive` strings in the language of a CFG. So we can have many different derivations of the same `string`
    -   Starting with the `start symbol`
    -   Repeatedly replacing some variable `A` by the body of one of its productions.
    -   i.e, the `productions for A` are those that have `head A`.


## Parsing CFG {#parsing-cfg}


### Parse Tree {#parse-tree}

{{< figure src="/ox-hugo/20230422102551-context_free_grammar_cfg-1964708787.png" >}}

-   Trees labeled by symbols of a particular CFG.
-   `Leaves`: labeled by a `terminal` or &epsilon;
-   `Interior nodes`: labeled by a variable or &epsilon;.
    -   Children are labeled by the body of a production for the parent.
-   `Root`: must be labeled by the `start symbol`.
    -   If `root` is not a `start symbol`, we call it "Parse Tree w root A" (`A` being some arbitrary `variable`)


### Ambiguity and Un-Ambiguity {#ambiguity-and-un-ambiguity}


#### Ambiguous Grammar {#ambiguous-grammar}

![](/ox-hugo/20230422102551-context_free_grammar_cfg-1433651669.png)
![](/ox-hugo/20230422102551-context_free_grammar_cfg-1408441215.png)

-   A CFG is ambiguous if there is a string in the language that is the yield of two or more parse trees.
-   There is a string in the language that has 2 different `leftmost` derivations.
-   There is a string in the language that has 2 different `rightmost` derivations.


#### Un-ambiguous {#un-ambiguous}

-   Some ambiguous grammar can be made un-ambiguous grammar but some grammars are inherently ambiguous.


### Parsing techniques {#parsing-techniques}

See [Parsers]({{< relref "20230511160225-parsers.md" >}})


## Grammar Specification Types {#grammar-specification-types}

-   See [BNF]({{< relref "20230422075825-bnf.md" >}})
-   Extended Backus–Naur form (EBNF)
-   Augmented Backus–Naur form (ABNF).


## Derivation {#derivation}


### Expression types / Expression notation {#expression-types-expression-notation}

> -   Polish and Reverse Polish notation, as they are usually described, do require that all operators have a known arity.
> -   `Arity` is just the number of operands that the operator takes.
> -   This means, for example, that unary minus needs to be a different operator than subtraction. Otherwise we don’t know how many operands to pop from the stack when we see an operator.

```nil
1 + 2 * 3  // Infix
+ 1 * 2 3  // Polish (prefix)
1 2 3 * +  // Reverse Polish (postfix)
```


#### Prefix {#prefix}

-   AKA Polish Notation


#### Infix {#infix}

> "writing grammars for infix arithmetic expressions isn’t as simple or elegant as you might expect. Encoding the precedence and associativity rules into a grammar that is unambiguous (and can be handled by LL and LR parsers) is pretty ugly and nonintuitive. This is one reason why LL and LR parsers are often extended with capabilities that let you specify operator precedence; for example, see the precedence features of Bison."

-   Human Calculator syntax
-   Depends on order of operations


#### Postfix {#postfix}

-   AKA Reverse Polish Notation (RPN)


### Conversions {#conversions}


#### prefix to postfix {#prefix-to-postfix}

-   Can be done only w a stack

<!--listend-->

```nil
// PN to RPN
1. Split in to 3 iterator ranges: tokens 1, 2 and (3 to N)
    ( + )( 1 )(*  2  3)
2. Output token 2
3. If length of range(3 to N) > 1 recurse, else output token 3
4. Output token 1.
```


#### postfix to prefix {#postfix-to-prefix}

-   Can be done only w a stack

<!--listend-->

```nil
// RPN to PN
1. Split in to 3 iterator ranges: tokens 1, (2 to N-1) and N
   ( 1 ) ( 2 3 * ) ( + )
2. Output token N
3. Output token 1
4. If length of range(2 to N-1) > 1 recurse, else output token 2.
```


#### infix to postfix {#infix-to-postfix}

-   [Shunting Yard](https://www.reedbeta.com/blog/the-shunting-yard-algorithm/) Algo by God


## Subsets {#subsets}


### Deterministic Contest free languages {#deterministic-contest-free-languages}

-   Un-ambiguous, can be processed in linear time


### Left Recursion {#left-recursion}

-   Some rules (indirectly) reference themselves before any other (they are on the left of the rule). See [left-recursive](https://en.wikipedia.org/wiki/Left_recursion)
    -   Gets complicated if rule matches empty string


#### Examples {#examples}

See [Left Recursion · PhilippeSigaud/Pegged Wiki · GitHub](https://github.com/PhilippeSigaud/Pegged/wiki/Left-Recursion)

-   Direct: Caused by a rule referencing itself in the left-most position.
    ```nil
    A = A
    A = A | B | C | D | E | F ...
    ```
-   Indirect
    ```nil
    A = B
    B = A
    =>
    A = A
    A = A
    =>
    A = A
    ```


#### Issues {#issues}

-   A formal grammar that contains left recursion cannot be parsed by a LL(k)-parser or other naive recursive descent parser.
-   In the example above, a top down parser would try parsing A and then again A and then again..., never gets to B
-   The basic problem is that with a recursive descent parser, left-recursion causes instant death by stack overflow.
-   Only a few things are naturally left-recursive, most left-recursion is a hack to get iteration, which LL parser generators have built-in.


#### Remove left recursion {#remove-left-recursion}

source: [eli5 left recursion](https://www.reddit.com/r/ProgrammingLanguages/comments/w27u4w/can_someone_eli5_how_to_factor_out_left_recursion/)

```nil
A =
  | A x y z
  | B
  | C

# 1) Removing self-reference in leftmost position
A =
  |   x y z
    ^-- Yoink!
  | B
  | C

# 2) Find alternatives
A =
  | ... <- We're transforming this rule so we ignore it
  | B <- There's an alternative!
  | C <- There's an alternative!

# 3) Fill the leftover hole with all possible alternatives
A =
  | (B | C) x y z
    ^^^^^^^-- Plop!
  | B
  | C

# 4) Secret step: simplify (this is actually called left-factoring,
# not to be confused with factoring out left-recursion)
A =
  | (B | C) x y z
    ^^^^^^^-- Same pattern!
  | (B | C) <- Same pattern!

# So we get

A = (B | C) (x y z)?
```


## To read {#to-read}
