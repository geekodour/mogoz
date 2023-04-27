+++
title = "Pushdown Automata (PDA)"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Automata Theory]({{< relref "20230421132238-automata_theory.md" >}})


## What? {#what}

-   The PDA is an automaton equivalent to the [Context Free Grammar (CFG)]({{< relref "20230422102551-context_free_grammar_cfg.md" >}}) in language-defining power.
-   Generalization of [Finite Automata]({{< relref "20230421165125-finite_automata.md" >}})
-   Think of an &epsilon;-NFA with the additional power that it can manipulate a stack. It can use the stack to help choose the next move.
    ![](/ox-hugo/20230422123752-pushdown_automata-1649683298.png)
