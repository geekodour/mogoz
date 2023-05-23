+++
title = "Context Free Grammar (CFG)"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Chomsky Hierarchy]({{< relref "20230421154510-chomsky_hierarchy.md" >}}), [Regular Expressions]({{< relref "20230413090911-regular_expressions.md" >}}), [Automata Theory]({{< relref "20230421132238-automata_theory.md" >}})


## What? {#what}

-   Introduced in the [Chomsky Hierarchy]({{< relref "20230421154510-chomsky_hierarchy.md" >}})
-   Recursive system for generating strings
-   Almost every programming language defines its language using CFG using the [BNF]({{< relref "20230422075825-bnf.md" >}}) notation


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


## Parse Tree {#parse-tree}

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

-   If a grammar is Ambiguous we can find un-ambiguous grammar for not always, some grammars are inherently ambiguous.


#### LL(1) Grammars (Un-ambiguous) {#ll--1--grammars--un-ambiguous}

-   (L)eftmost derivation, (L)eft-to-right scan, (1) symbol of lookahead
-   Most [Programming Languages]({{< relref "20221101220306-programming_languages.md" >}}) have `LL(1)` grammars, they are never `ambiguous`. (They need to be unambiguous for what they do)
-   Such CFG can be converted into [Pushdown Automata (PDA)]({{< relref "20230422123752-pushdown_automata.md" >}})
-   [Resilient LL Parsing Tutorial](https://matklad.github.io/2023/05/21/resilient-ll-parsing-tutorial.html)
