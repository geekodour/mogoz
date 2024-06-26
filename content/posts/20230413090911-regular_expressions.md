+++
title = "Regular Expressions"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Programming Languages]({{< relref "20221101220306-programming_languages.md" >}}), [Computation and Computer Theory]({{< relref "20221101221439-computation_and_computer_theory.md" >}}), [Automata Theory]({{< relref "20230421132238-automata_theory.md" >}})


## History {#history}

We get 2 definitions of `regular languages` from these 2 events.

-   1951, Kleene: Regular language is a language which is recognized by a finite automata.
-   1956, Chomsky: Regular languages defined by languages generated by `Type 3` / `regular grammars`


## Theory {#theory}

-   RE describes language by an algebra
-   They describe "exactly" the regular language
-   `L(E)` is the `language`, `E` is the regex.


### Operations {#operations}


#### Union {#union}

-   Eg. `{01,111,10} \cup {00, 01}` = `{01,111,10,00}`


#### Concatenation {#concatenation}

-   Eg. `{01,111,10}{00, 01}` = `{0100, 0101, 11100, 11101, 1000, 1001}`


#### Kleene Star {#kleene-star}

-   `A*` : Kleene closure / Kleene star
-   L\* = `{\epsilon} \cup L \cup LL \cup LLL \cup ...`
-   Eg. {0,10}\* = {&epsilon;, 0, 10, 00, 010, 100, 1010,...}


## Lexical Analysis {#lexical-analysis}

> -   `tokens`: substrings that together represent a unit.


### Basics {#basics}

-   The first thing a compiler does is break a program into `tokens`
-   We can write `regex` for each different kind of `token`
-   Each `regex` has a specific action associated
    -   Eg. Just print out, put it into a symbol table etc.


### Issues {#issues}

{{< figure src="/ox-hugo/20230413090911-regular_expressions-1559352848.png" >}}

1.  Convert `RE` for each `token` to &epsilon;-NFA
    -   Eg. identifier &epsilon;-NFA
    -   Eg. Reserved word &epsilon;-NFA
2.  Combine all `RE` by w new start state w &epsilon; moves to start state of each &epsilon;-NFA
3.  Convert to DFA
4.  Set priority in DFA. Eg. DFA accepting `if` reserved word should have higher priority than DFA accepting identifier `if`


## Implementations {#implementations}


### Modern Implementations {#modern-implementations}

-   Modern regex engines are augmented with features that allow the recognition of non-regular languages
-   Characters like, `[` and `-` have special meanings, so you need to escape them with `\`
-   Some operators
    -   Concatenation: [a<sub>1</sub>,a<sub>2</sub>,...a<sub>n</sub>] is shorthand for a<sub>1</sub>+a<sub>2</sub>+...+a<sub>n</sub>
    -   Union: | operator.
    -   One or more: `+` , `E+` = `EE*` (E concatenated w E\*)
    -   Zero or one of: `?`, E? = E + &epsilon;, `[ab]?` = a + b + &epsilon;


### Flavors {#flavors}

-   PCRE
-   [Javascript]({{< relref "20221126085225-javascript.md" >}})'s regex in certain cases the engine is stateful
    -   See [javascript - Why does a RegExp with global flag give wrong results?](https://stackoverflow.com/questions/1520800/why-does-a-regexp-with-global-flag-give-wrong-results)


## Learning Resources {#learning-resources}


### Tutorials {#tutorials}

-   [Why you really can parse HTML (and anything else) with regular expressions – Neil Madden](https://neilmadden.blog/2019/02/24/why-you-really-can-parse-html-and-anything-else-with-regular-expressions/) 🌟
-   [Regular expression Denial of Service - ReDoS](https://owasp.org/www-community/attacks/Regular_expression_Denial_of_Service_-_ReDoS)
-   [A Visual Guide to Regular Expression](https://amitness.com/regex/)
-   [Python Tutorial: re Module - How to Write and Match Regular Expressions (Regex) - YouTube](https://www.youtube.com/watch?v=K8L6KVGG-7o)
-   [Emacs: basics of regular expressions (regexp) - YouTube](https://www.youtube.com/watch?v=TxYGHjKBMUg)
-   <https://github.com/ziishaned/learn-regex>
-   [My most useful RegExp trick — surma.dev](https://dassur.ma/things/regexp-quote/)
-   [Python 3.11: possessive quantifiers and atomic grouping added to re module](https://learnbyexample.github.io/python-regex-possessive-quantifier/)
-   [Building regex.help](https://maciej.gryka.net/building-regex-help)
-   <https://javascript.info/regular-expressions>


### Tools {#tools}

-   <https://github.com/aloisdg/awesome-regex>
-   <https://regex101.com/>
-   <https://regexr.com/>
-   <https://regexone.com/>
-   <https://projects.lukehaas.me/regexhub/>
-   <https://remram44.github.io/regex-cheatsheet/regex.html>


## Practical Concepts {#practical-concepts}


### Greedy and Lazy {#greedy-and-lazy}


#### Greedy {#greedy}

```js
let regexp = /".+"/g;

let str = 'a "witch" and her "broom" is one';

alert( str.match(regexp) ); // "witch" and her "broom"
```

<!--list-separator-->

-  What happens?

    -   For every position in the string
        -   Try to match the pattern at that position.
        -   If there’s no match, go to the next position.
        -   If we found the match for the `current part of the pattern` then we try to find a match for the `next part of the pattern`
            -   Eg. in `".*"` , `"` will be first part, `.*` will be second and so on
        -   If we reach the end of the string(no more characters!) and we find no match, we `backtrack`.
        -   We keep backtracking till we find a match for the entire regex pattern.
            -   Eg. In `'a "witch" and her "broom" is one'` , the engine first goes till end of the string because of `.+` but then `backtrack` till it finds the ending `"` in end of `broom"`


#### Lazy {#lazy}

-   `?`
    -   Usually `?` is a quantifier by itself (zero or one)
    -   If added after another quantifier (or even itself): It switches the matching mode from `greedy` to `lazy`
    -   Eg. `.*?`, `.+?` lazy search for `.*` and `.+`

<!--list-separator-->

-  What happens?

    -   For every position in the string
        -   Try to match the pattern at that position.
        -   If there’s no match go to the next position.
        -   If we found the match for the `current part of the pattern` then we try to find a match for the `next part of the pattern`
            -   Eg. in `".*?"` , `"` will be first part, `.*?` will be second and so on
        -   **DIFFERENCE:** Now, because `.*?` is lazy, engine try to match the part after `.*?` which is `"` . If it doesn't find, it'll just match with `.*`
            -   This is the nature of the lazy, it'll try to end the match as soon as possible.
        -   If we reach the end of the string(no more characters!) and we find no match, we `backtrack`.
        -   We keep backtracking till we find a match for the entire regex pattern.
            -   Eg. In `'a "witch" and her "broom" is one'` , the engine first goes till end of the string because of `.+` but then `backtrack` till it finds the ending `"` in end of `broom"`


### Lookaround {#lookaround}

-   Lookaround = Lookahead + Lookbehind
-   This allow you to match some something but also tell the engine to make sure that this and that should be before and after what I want to match, if they are there then only it'll be a match


#### Look ahead {#look-ahead}

-   (?=) : Postitive
-   (?!) : Negative


#### Look behind {#look-behind}

When you want to negate certain characters in a string, you can use character class but when you want to negate more than one character in a particular sequence, you need to use negative look ahead

-   (?&lt;=) : Postitive
-   (?&lt;!) : Negative
