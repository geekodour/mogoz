+++
title = "Chomsky Hierarchy"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Regular Expressions]({{< relref "20230413090911-regular_expressions.md" >}}), [Automata Theory]({{< relref "20230421132238-automata_theory.md" >}})


## The Hierarchy {#the-hierarchy}

![](/ox-hugo/20230413090911-regular_expressions-2035335085.png)
![](/ox-hugo/20230421154510-chomsky_hierarchy-1981082395.png)


### Type 0 (Recursively Enumerable) {#type-0--recursively-enumerable}


### Type 1 (Context Sensitive) {#type-1--context-sensitive}

-   all context-free languages are also context-sensitive languages, but some languages are neither context-sensitive nor context-free.
-   context-sensitivity is often not resolved in the parsing phase but in later phases


### Type 2 (Context Free) {#type-2--context-free}

-   Used to parse programming languages
-   The classic example people is x \* y; in C, which is either multiplication or a variable declaration, depending on whether x is a type or a value. This proves that C cannot be a context-free language.


### Type 3 (Regular Languages) {#type-3--regular-languages}

-   It's not idea to parse programming languages(Type 2) with regular expression hence.


## Grammars to Alphabet {#grammars-to-alphabet}

-   `Grammars` are defined by `Languages`
-   `Languages` are defined by set of `Strings`
-   `Strings` are defined by sequence of `Symbols`
-   Set of `Symbols` is defined by the `Alphabet`


### Grammar {#grammar}

-   Whenever we put restriction on a language, we create a grammar
    ![](/ox-hugo/20230421154510-chomsky_hierarchy-4440614.png)


### Language {#language}

-   A set of strings accepted by an automaton `A` is the language for `A`
-   Eg. If `A` accepts `s-o` and `s-o-o`, then set of these 2 strings represent the language for `A`
-   Denoted by `L(A)`
-   Different types of Automatons accept different languages
-   They can be finite or infinite sets
-   Personal Note: `L(Alphabet)` , `L(Automaton)` seem like the same thing.


### String {#string}

-   Eg. In C, `"O"` is `string`, while `'0'` is a character/symbol.


### Alphabet {#alphabet}

-   Finite set of symbols
-   Eg. ASCII, Unicode, `{0,1}`, `{a,b,c}`, set of signals used by some communication protocol


## Languages classes {#languages-classes}

-   Set of languages. Eg. The regular languages


### Properties {#properties}


#### Decision Properties {#decision-properties}

-   Eg. Empty, Finite, Infinite?, Does the protocol terminate, Does the protocol fail?
-   Harder to answer for larger classes of languages


#### Closure Properties {#closure-properties}

-   Given languages in the class, an operation (e.g., union) produces another language in the same class.


### Regular Languages {#regular-languages}

-   A `language` that is accepted by a [Finite Automata]({{< relref "20230421165125-finite_automata.md" >}})
-   Proofs for decision properties for regular languages require RE or DFA.

![](/ox-hugo/20230421154510-chomsky_hierarchy-2069183308.png)
![](/ox-hugo/20230421154510-chomsky_hierarchy-1178592700.png)


#### Descriptors {#descriptors}

-   [Regular Expressions]({{< relref "20230413090911-regular_expressions.md" >}})
-   FA/FSM/DFA/NDFA/NFA (See [Finite Automata]({{< relref "20230421165125-finite_automata.md" >}}))


### Context Free Languages {#context-free-languages}

-   Let us do things that regular languages can't do. Eg. Lets us process natural and programming languages, Match parenthesis or XML tags etc.
-   Powerful than [Regular Expressions]({{< relref "20230413090911-regular_expressions.md" >}}) and [Finite Automata]({{< relref "20230421165125-finite_automata.md" >}}) but still cannot define all possible languages.


#### Descriptors {#descriptors}

<!--list-separator-->

-  Context-free grammars

    See [Context Free Grammar (CFG)]({{< relref "20230422102551-context_free_grammar_cfg.md" >}})

    -   Recursive system for generating strings

<!--list-separator-->

-  Pushdown Automata

    See [Pushdown Automata]({{< relref "20230422123752-pushdown_automata.md" >}})

    -   Generalization of Finite Automata(FA)


### Recursively Enumerable Languages {#recursively-enumerable-languages}

-   Turning machines : It can tell us what can be computed by computation and what cannot be.