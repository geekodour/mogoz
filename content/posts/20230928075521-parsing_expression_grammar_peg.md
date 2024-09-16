+++
title = "Parsing Expression Grammar (PEG)"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Context Free Grammar (CFG)]({{< relref "20230422102551-context_free_grammar_cfg.md" >}}), [Programming Languages]({{< relref "20221101220306-programming_languages.md" >}}), [Parsers]({{< relref "20230511160225-parsers.md" >}}), [Production Systems]({{< relref "20230928170934-production_systems.md" >}})


## What {#what}

-   Syntactically, PEGs also look similar to context-free grammars (CFGs), but they have a different interpretation: the choice operator selects the first match in PEG, while it is ambiguous in CFG.
-   Unlike CFGs, **PEGs cannot be ambiguous**; a string has exactly one valid parse tree or none
-   Provides unlimited lookahead capability
-   An Alternative to [Context Free Grammar (CFG)]({{< relref "20230422102551-context_free_grammar_cfg.md" >}})


## About PEG Parsers {#about-peg-parsers}

-   See [Parsers]({{< relref "20230511160225-parsers.md" >}})
-   It's possible to build LL and LR parsers for some PEGs but all PEGs can't be built using LL/LR because of unlimited lookahead. (NOTE: I don't understand this properly)
-   PEG can be parsed in linear time by using a packrat parser


## Links {#links}

-   [PEG Parsing Series Overview](https://medium.com/@gvanrossum_83706/peg-parsing-series-de5d41b2ed60)
-   [PEP 617 – New PEG parser for CPython | peps.python.org](https://peps.python.org/pep-0617/)
-   [This is why you should never use parser combinators and PEG | Lobsters](https://lobste.rs/s/nybhsl/this_is_why_you_should_never_use_parser)
    -   [Use context-free grammars instead of parser combinators and PEG | Hacker News](https://news.ycombinator.com/item?id=40566784)
