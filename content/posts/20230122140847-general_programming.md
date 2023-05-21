+++
title = "General Programming"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Design Patterns]({{< relref "20221125204047-design_patterns.md" >}})


## Pragmatic {#pragmatic}


### Invariants {#invariants}

<div class="warning small-text">

> An invariant is any logical rule that must be obeyed throughout the execution of your program that can be communicated to a human, but not to your compiler.
</div>

-   Invariants are bad. Every invariant of this kind that you remove from your code is an improvement, because it lowers the cognitive load of working with it.
-   See [What are invariants](https://softwareengineering.stackexchange.com/questions/32727/what-are-invariants-how-can-they-be-used-and-have-you-ever-used-it-in-your-pro)


## Opinions {#opinions}


### What a well rounded engineer should know {#what-a-well-rounded-engineer-should-know}

Source: [The Well Rounded Engineer - Speaker Deck](https://speakerdeck.com/swanandp/the-well-rounded-engineer?slide=126)

-   Get rid of the trial and error method, instead take the analytical approach
-   Learn to read research papers
-   In general, proficiency is about understanding trade-offs
-   Language
    -   Be proficient in two paradigms. (Eg. FP and OOP)
-   DB
    -   Basic skills: Model your data, Be performance aware, Write raw SQL
    -   Advanced skills: Idiomatic design, Be operations aware, Grok SQL
-   Protocol
    -   Be proficient in using two protocols (Eg. TCP/IP, HTTP, TLS)
    -   Understand: How it works, How to debug it, Design considerations
-   SW Arch
    -   Understand how to design commonly used systems (Eg. Workers, Queues, Async Systems, Data pipeline, Load balancers)
-   Compilers
    -   Ability to write toy compilers, interpreters, parsers is helpful
    -   Start with parsers, then interpreters and then compilers
    -   Recursive Descent parsers open you up to a whole new coding style
-   Write simple games
    -   Changing requirements and specific set of rules
    -   Make small games
    -   Try from first principles, Avoid frameworks
    -   Once you write the game, write a bot that plays the game
-   Algo&amp;DS
    -   Understand fundamental approach of solving problems recursively
    -   Understand master method to analyse recursive solutions


### Systems Engineering {#systems-engineering}

-   Be explicit about what you are building
-   Be explicit about how you are building it
