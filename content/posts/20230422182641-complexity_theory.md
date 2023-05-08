+++
title = "Complexity Theory"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Automata Theory]({{< relref "20230421132238-automata_theory.md" >}}), [Algorithms]({{< relref "20230205172402-algorithms.md" >}}), [Computation and Computer Theory]({{< relref "20221101221439-computation_and_computer_theory.md" >}})

> I don't think I've been more confused in my entire fucking life.
>
> -   me, 24th April'23
> -   me, 25th April'23
> -   Things that I am seeing
>     ![](/ox-hugo/20230422182641-complexity_theory-419452339.png)
> -   "because people define whatever they please, then the field grows organically, and some things are used more than others"

This page covers what [this wikipedia](https://en.wikipedia.org/wiki/Computational_complexity_theory) page covers. (Also see, [TCS](https://en.wikipedia.org/wiki/Theoretical_computer_science)). This is mostly copy paste material, I tried linking back to source when possible, did not want to overload with links as personal note. I am pretty sure info here is incorrect in many places but this is what I understand of it right now.

-   1965 : P was introduced
-   Cook &amp; Levin &amp; Karp


## Some History {#some-history}

-   See
    -   </ox-hugo/history_of_complexity_theory.pdf>
    -   [if-then-else/if-then-else.md at master · e-n-f/if-then-else · GitHub](https://github.com/e-n-f/if-then-else/blob/master/if-then-else.md)
    -   [A repo that keeps track of the history of logic. It chronicles the eminent personalities, schools of thought, ideas of each epoch.](https://github.com/prathyvsh/history-of-logic)


### 1837 {#1837}

See [The Analytical Engine]({{< relref "20221101221734-the_analytical_engine.md" >}})


### 1933 {#1933}

Kurt Godel, Hilbert did something something


### 1936 {#1936}

Alonzo Church came up with Lambda calculus


### 1936 {#1936}

-   Alan turing came up w Turing machine
-   Introduced the idea of decidability


### 1943 {#1943}

-   McCulloch and Walter Pitts presented idea of FSM
-   See [Automata Theory]({{< relref "20230421132238-automata_theory.md" >}})


### 1951 {#1951}

-   The equivalence of the `regular expressions` and `Finite Automata` is known as the **Kleene's theorem**.
-   Stephen Kleene described regular languages and regular expressions using mathematical notation called regular sets
-   [Kleene's Theorem (CS 2800, Spring 2017)](https://www.cs.cornell.edu/courses/cs2800/2017sp/lectures/lec27-kleene.html)
-   [ECE374-B SP23: Lecture 5 - DFA/NFA/RegEx equivalence and grammars](https://ecealgo.com/lectures/Lec5.html)
-   From RE To Automaton : [Kleene's Theorem (a): from regex to automaton](https://www.youtube.com/watch?v=s-ha9I4EUmI)
-   From Automaton To RE : [Kleene's Theorem (b): from automaton to regex](https://www.youtube.com/watch?v=NwspiW2hzVI)


### 1956 {#1956}

See [Chomsky Hierarchy]({{< relref "20230421154510-chomsky_hierarchy.md" >}})


### 1959 {#1959}

-   Nondeterministic finite automaton was introduced (NFA/NDFA)
-   Showed the equivalence to DFA


### 1965 {#1965}

-   Introduced the idea of `P`
-   Introduced the idea of tractable vs intractable problems.
-   Set the stage for `P = NP?`
-   [Cobham's thesis - Wikipedia](https://en.wikipedia.org/wiki/Cobham%27s_thesis)


### 1968 {#1968}

-   Ken Thompson made Regular Expressions popular by using them in
    -   Pattern Matching (String Search)
    -   Lexical Analysis (Scanners, Tokenizer Modules in parsing programming languages)
-   For implementing, he used NFA.
    -   **Thompson's construction** (the algorithm) compiled a regular expression into an NFA
    -   NFA can be converted into RE using Kleene's algorithm


### 1970 {#1970}

-   \\(O\\) was popularized in computer science by Donald Kunuth


### 1971-1973 {#1971-1973}

-   Cook &amp; Levin came up with the proof of existence of NP-complete problems with SAT
-   Karp came w more stuff, presented a general framework for proving NP-completeness
-   `P=NP?` was set in discussions.
-   Meyer and Stock meyer introduced [Polynomial hierarchy](https://en.wikipedia.org/wiki/Polynomial_hierarchy), introduced `PSPACE`


## FAQ {#faq}

You can read the FAQ before reading anything or after reading everything or anytime in between. Basically information in the FAQ is not ordered.


### Meta {#meta}


#### Computational complexity vs Complexity class {#computational-complexity-vs-complexity-class}

-   An `algorithm` has a `time/space complexity` (computational complexity)
-   A `problem` belongs to a `complexity class`. `problems` don't have run-times.
    -   If you ever come across a discussion discussing time complexity of a problem, it's probably shorthand referring to the time complexity of the best known algorithm that solves the problem.
    -   `P,NP,PSPACE,EXPTIME` etc. are all complexity classes. This means they contain problems, not algorithms.


#### Can turing machine only solve decision problems? {#can-turing-machine-only-solve-decision-problems}

[No.](https://cs.stackexchange.com/questions/9574/can-turing-machines-solve-non-decision-problems)


#### In practice, are all intractable problems in-feasible and all tractable solutions feasible? {#in-practice-are-all-intractable-problems-in-feasible-and-all-tractable-solutions-feasible}

-   Here theory and practice differ
-   By definition, problems in `P` class are tractable, but in practice, even n<sup>3</sup> or n<sup>2</sup> algorithms are often impractical on realistic sizes of problems. (i.e We'd call a problem with a n<sup>3</sup> solution to belong in `P`)
-   A polynomial-time solution with large degree or large leading coefficient grows quickly, and may be impractical for practical size problems
-   Conversely, an exponential-time solution that grows slowly may be practical on realistic input
-   A solution that takes a long time in the worst case may take a short time in most cases or the average case, and thus still be practical.
-   Saying that a problem is not in P does not imply that all large cases of the problem are hard or even that most of them are.
-   Similarly, a polynomial time algorithm is not always practical. If its running time is, say, n<sup>15</sup>, it is unreasonable to consider it efficient and it is still useless except on small instances.


#### Is halting problem the end all be all? {#is-halting-problem-the-end-all-be-all}

-   [No.](https://cs.stackexchange.com/questions/27728/are-all-undecidable-uncomputable-problems-reducible-to-the-halting-problem)
-   [Proof that the halting problem is NP-hard?](https://stackoverflow.com/questions/6990683/proof-that-the-halting-problem-is-np-hard/6990715#6990715)


### NPH &amp; NPC {#nph-and-npc}


#### NP-hard has anything to do with decidability? {#np-hard-has-anything-to-do-with-decidability}

-   No. Whether a problem is decidable is orthogonal to the hardness.
-   NPH + decidable + NP: NPC problems basically
-   NPH + undecidable : HALT (Halting problem)
-   NPH + decidable + (not) NP : [TQBF](https://cs.stackexchange.com/questions/9063/np-hard-problems-that-are-not-in-np-but-decidable)


#### Are any NP-complete problems solved in P time? {#are-any-np-complete-problems-solved-in-p-time}

-   No. This would mean P=NP
-   But some problems like, 2SAT, XORSAT, Maximum Matching, and Linear Programming, these "seem like they should be NP-complete" at first glance, but then turn out to have clever polynomial-time algorithms.


#### Are all NP-Hard problems equally hard? {#are-all-np-hard-problems-equally-hard}

-   No. Not all, some are.
-   "Equally hard" here means can be reduced to one another.
-   Some NP-hard problems may have efficient approximation algorithms that can find solutions that are close to optimal, while others may have no known efficient algorithms or even be proven to be unsolvable in polynomial time.
-   Why?
    -   Every `NP` and `P` problem is reducible to `NP-complete` and `NP-hard` by definition
    -   Any `NP-hard` problem is [NOT reducible](https://cs.stackexchange.com/questions/53981/can-all-np-hard-problems-be-reduced-to-one-another) to any other `NP-hard` problem.
    -   Any `NP-complete` problem [can be reduced](https://math.stackexchange.com/questions/1542179/can-any-np-complete-problem-can-be-reduced-to-any-other-np-complete-problem-in-p) to any other `NP-complete` problem.
    -   All `NP-complete` problems can be reduced to `NP-hard` problems.
    -   So some `NP-hard` problems (which are `NP-complete`) can be reduced to one another.


#### Are all NP-Complete problems equally hard? {#are-all-np-complete-problems-equally-hard}

-   Yes, in a fundamental sense.
-   Any `NP-complete` problem [can be reduced](https://math.stackexchange.com/questions/1542179/can-any-np-complete-problem-can-be-reduced-to-any-other-np-complete-problem-in-p) to any other `NP-complete` problem.


### Decision problems {#decision-problems}


#### Why are decision problems so popular? {#why-are-decision-problems-so-popular}

-   We focus on studying the decision problems in undergrad complexity theory courses because they are simpler and also questions about many other kinds of computations problems can be reduced to questions about decision problems.
-   Most discussions online on complexity classes will be referring to decision problems because `P` and `NP` are classes which contain only decision problems and most discussions online are about `P` and `NP`. See FAQ for more details on this.
-   NP-Hardness ["officially" is a category](https://cs.stackexchange.com/questions/137136/does-np-hard-problems-have-to-be-decision-problems-what-the-fact-please-cont) of decision problems but people use it for other types of problems too.
-   [Why are decision problems commonly used in complexity theory?](https://cs.stackexchange.com/questions/4874/why-are-decision-problems-commonly-used-in-complexity-theory)
-   [complexity of decision problems vs computing functions](https://cs.stackexchange.com/questions/4667/complexity-of-decision-problems-vs-computing-functions)


#### What about decision version/counter parts of problems? {#what-about-decision-version-counter-parts-of-problems}

-   Things can be converted into decision problem easily, which is a good thing.
-   [Does every computational problem have a decision version?](https://cs.stackexchange.com/questions/79707/does-every-computational-problem-have-a-decision-version)


#### Why does NP only deal with decision problems? {#why-does-np-only-deal-with-decision-problems}

-   First of all, it's a class of decision problems. So sort of by definition. There are other NP equivalent classes for other types of problems, such as [FNP](https://cstheory.stackexchange.com/questions/37812/what-exactly-are-the-classes-fp-fnp-and-tfnp).
-   Secondly, verification in polynomial time only makes sense for decision problems.
-   You cannot verify an optimization problem in polynomial time because to verify that solution is infact the most optimal, you'll have to check all solutions and number of solutions can grow exponentially.


### Misc {#misc}


#### What kind of computational problem is sorting? {#what-kind-of-computational-problem-is-sorting}

-   We cannot say it is in `P` because sorting is not a decision problem. It can have a decision version of it though.
-   It seems like a [function problem](https://en.wikipedia.org/wiki/Function_problem) and should belong to `FP` complexity class but [different](https://cstheory.stackexchange.com/questions/6055/complexity-class-corresponding-to-sorting) people have different answers.


#### <span class="org-todo todo TODO">TODO</span> What are Lower &amp; Upper bounds for problems &amp; solutions? {#what-are-lower-and-upper-bounds-for-problems-and-solutions}

-   when talking about problems, we are talking about the best known solution, and for the problem it is the worst case. so a problem if stated has a non-poly solution, the algo itself is talking of worst case, so algo might perform 👍 good in better cases
-   When we say “NP-complete is hard”
    -   We’re talking about worst-case complexity
    -   The average-case complexity is often much more tractable.


## Computing model {#computing-model}


### Turing machines(TM) for describing complexity classes {#turing-machines--tm--for-describing-complexity-classes}

-   If you look into definitions of any of the complexity classes(eg. `P`, `NP`) in [this page](https://en.wikipedia.org/wiki/Complexity_class), you'll notice that the definitions are based on TM.
-   There's nothing problematic about using TM to talk about complexity classes, but its usually implied and I just wanted to be explicit about it.
-   Why specifically, TM? My wild guess is because it's the closest model to real world computing that we do and the foundational work was done relating back to TM.


### Computing models other than TM {#computing-models-other-than-tm}

-   There are [other models](https://en.wikipedia.org/wiki/Model_of_computation) of computations like [Lambda calculus](https://stackoverflow.com/questions/43830085/what-it-means-lambda-calculus-is-equivalent-to-turing-machine), but in general, when we are talking complexity classes, discussions usually are in terms of the TM and related terms.
-   There are complexity classes for other models of computing, like for Quantum Computer ([BQP](https://en.wikipedia.org/wiki/BQP)) and attempts with [lambda](https://cstheory.stackexchange.com/questions/23798/p-and-np-classes-explanation-through-lambda-calculus) [calculus](https://cstheory.stackexchange.com/questions/376/using-lambda-calculus-to-derive-time-complexity).
-   To be aware of: When we see lower bounds for problems, it's often given for a model of computation that is more restricted than the set of operations that you could use in practice and therefore there are algorithms that are faster than what would naively be thought possible.


### Time Bounded TM {#time-bounded-tm}

-   See [Automata Theory]({{< relref "20230421132238-automata_theory.md" >}})

{{< figure src="/ox-hugo/20230421132238-automata_theory-1252882163.png" >}}


### NMT (Nondeterministic Turing Machine) {#nmt--nondeterministic-turing-machine}

-   This is a thought experiment, this machine does not exist fr.
-   NTM that can create parallel timelines and try a different choice in each timeline.
-   It can solve NP problems in polynomial time
-   If you can `check/verify` a solution of length N in polynomial time, just branch on every single possible input of length N.
-   If you can solve a problem with branching, have the NTM also track the history of every step. Then a valid solution will also have a linear set of steps.


## Problem {#problem}


### Formalism of a problem {#formalism-of-a-problem}


#### Language {#language}

> \\(L={w∣w\\) is the encoding of an input \\(y\\) to problem \\(X\\), and the answer to input \\(y\\) for problem \\(X\\) is "Yes" }

-   A `language` is the formal realization of a `problem`.
-   `languages` are defined by set of `strings`
-   Each `string` in the `language` encodes some `instance` of the `problem`
-   `strings` are defined by sequence of `symbols`
-   Set of `symbols` is defined by the `alphabet`
-   Eg. \\(\\{0,1\\}\*\\) is the set of all binary sequences of any length.
-   Determining if the answer for an input to a decision problem is "yes" is equivalent to determining whether an encoding of that input over an alphabet is in the corresponding language.
-   A `string` is in a `language` iff the answer to the `instance` is "yes"
-   each `string` is the input


### Categorization {#categorization}

These categorizations can overlaps as required.

-   Decidability
-   Intractability
-   Computational work
-   Complexity Classes
-   Hardness/Completeness (optional)


### Decidability {#decidability}

![](/ox-hugo/20230421132238-automata_theory-544564772.png)
![](/ox-hugo/20230422182641-complexity_theory-566556351.png)
![](/ox-hugo/20230422182641-complexity_theory-962329215.png)

-   A problem \\(L\\) is said to be decidable if there exists an algorithm with accepts all the elements of \\(L\\) and rejects those which do not belong to \\(L\\).
-   Time not a constraint when it comes to decidability. If one is able to write any algorithm that does the job, the problem will be decidable.
-   Related readings
    -   [Rice's theorem - Wikipedia](https://en.wikipedia.org/wiki/Rice%27s_theorem)


### Intractability {#intractability}

{{< figure src="/ox-hugo/20230422182641-complexity_theory-572165861.png" >}}

-   Again, must remind that it's a property [of a problem](https://en.wikipedia.org/wiki/Computational_complexity_theory#Intractability) and not the solution. But the property itself depends on what solution we have for the problem.
-   While decidability was about whether an algorithm for the problem exists or not, intractability is about if the problem has an efficient solution.
-   For a more formal definition, see [Cobham's thesis](https://en.wikipedia.org/wiki/Cobham%27s_thesis)


### Computational work {#computational-work}

-   These are technically called [computational problems](https://en.wikipedia.org/wiki/Computational_problem)
-   We have categorized problems based on what kind of computational work it requires to get to a solution.


#### Example computational problem types {#example-computational-problem-types}

-   Common ones: decision, search, counting, optimization, function, promise etc.
-   More complicated ones: [NPO](https://en.wikipedia.org/wiki/Combinatorial_optimization#NP_optimization_problem), optimization problems with decision counterparts in `NP`. When we say some optimization problem is NP-hard, what we actually mean is that the corresponding decision problem is NP-hard(i.e NP-complete).


#### Computational problem and their complexity classes {#computational-problem-and-their-complexity-classes}

Different computational problems have different complexity classes.

-   Decision problems have their own class [P](https://en.wikipedia.org/wiki/P_(complexity)), [NP](https://en.wikipedia.org/wiki/NP_(complexity)) etc.
-   Function problems have their own class [FP](https://en.wikipedia.org/wiki/FP_(complexity)), [FNP](https://cstheory.stackexchange.com/questions/37812/what-exactly-are-the-classes-fp-fnp-and-tfnp) etc. (Natural generalization of `NP`)
-   And so on.


### Complexity classes {#complexity-classes}

{{< figure src="/ox-hugo/20230422182641-complexity_theory-877504635.png" >}}

-   Our motive with complexity classes is that we want to put problems of a similar complexity into the same class
-   Every complexity class is a `set` of formal `languages` (`problems`)
-   Now because we know that, "Okay, problem X belongs to the same class as problem Y", we can probably try similar approaches to problem solving that worked for Y.


#### P {#p}

-   Contains decision problems
-   Problems in this class can be solved in polynomial time or less by a DTM.
-   Other names: [PTIME/DTIME](https://en.wikipedia.org/wiki/P_(complexity)), Deterministic polynomial class


#### NP {#np}

-   Contains decision problems
-   **Definition 1**: Problems that can be `verified` in polynomial time but **may** take super-polynomial time to `solve` using a DTM.
-   **Definition 2**: If you had a NTM, this problem are also `solvable` in polynomial time. `solvable` here means getting an `YES`
-   Other names: NPTIME, Non-deterministic polynomial class


#### co-NP {#co-np}

-   Contains decision problems
-   Opposite of NP
-   It looks for and `NO`, if we find a `NO` that means it is solvable in polynomial time.
-   Whether the complexity classes `NP` and `co-NP` are different is also an open question. General consensus is that, `NP != co-NP`, but there's no proof.


#### Relationship between complexity classes {#relationship-between-complexity-classes}

![](/ox-hugo/20230422182641-complexity_theory-1107245466.png)
![](/ox-hugo/20230422182641-complexity_theory-712362423.png)

-   [Is there any relationship between time complexity and space complexity](https://cs.stackexchange.com/questions/110934/is-there-any-relationship-between-time-complexity-and-space-complexity-of-an-alg)
-   [Why does space(n) &lt;= time(n) imply that TIME(f(n)) is a subset of SPACE(f(n))?](https://cs.stackexchange.com/questions/92102/why-does-spacen-timen-imply-that-timefn-is-a-subset-of-spacefn)


#### More info {#more-info}

-   [Petting Zoo - Complexity Zoo](https://complexityzoo.net/Petting_Zoo)
-   [List of complexity classes](https://en.wikipedia.org/wiki/List_of_complexity_classes)
-   [Complexity class](https://en.wikipedia.org/wiki/Complexity_class)


### Hardness and completeness {#hardness-and-completeness}

-   Hardness/Completeness are properties of a problem that we can "prove" if there is a need to.
-   This is just another further categorization of problems which tries to specify a relative hardness to problem.
-   Here we're talking in general sense, we're not talking about NP-hard or NP-complete, just the general idea of hardness and completeness.


#### What does being "hard" even mean? {#what-does-being-hard-even-mean}

-   Again, I'll re-specify that hardness is a property of a problem and not a property of a solution(algorithm).
    -   `efficient/inefficient` : Terms used with `algorithms`
    -   `easy/hard` : Terms used with `problems`
-   Well, "hard" does not really mean "hard". WTF?
-   What I mean is, what's hard for a computer may not be hard for a human. And what's hard for a human may not be hard for a computer. In-fact, there are lot of "efficient" solutions to "hard" problems.
-   So we're talking in terms of hardness for computational problem that a computer will compute. With some loss of generality, we can say "easy problems" are the ones that are solved in polynomial time and "hard problems" are the ones that take superpolynomial(more than polynomial) time.
-   It's similar to how time-complexity(in the world of algorithms) has nothing to with how complex it is to understand an algorithm. An algorithm might be really simple to understand for you but might have a time complexity of \\(O(n!)\\).
-   These 2 blog-posts do a better job at explain the idea of why NP-Hard [problems are](https://www.hillelwayne.com/post/np-hard/#fnref:NP-hard-example) [not really hard](https://jeremykun.com/2017/12/29/np-hard-does-not-mean-hard/).


#### General idea {#general-idea}

-   I have this problem `X` that I am not able to solve.
-   I know there's problem `Y` that is not solved by humanity yet.
-   If I can somehow prove, `X` is as hard as `Y`, I can now not worry about solving `X` efficiently and look for other approaches that were taken to solve `Y`, and maybe it'll work for my problem.
-   This "proving" is what it takes to make something to be `hard` / `complete`, a problem by itself does not become `hard` / `complete`


#### Hardness vs Completeness {#hardness-vs-completeness}

![](/ox-hugo/20230422182641-complexity_theory-1412134848.png)
Both of these property are always relative to some existing complexity class. Eg. `X-hard`, `X-complete` (Where `X` is some complexity class), `NP-hard`, `NP-complete`, [P-complete](https://en.wikipedia.org/wiki/P-complete) and so on.

-   Hardness
    -   If something is `X-hard` it is at least as hard as the hardest problems in class.
    -   So if we call something `X-hard`, that means it **may** even belong outside the class `X`.
    -   If something is NP-hard, it could be even harder than the hardest problems in NP
-   Completeness
    -   If something is `X-complete` it is among the hardest problems in that class.
    -   All `X-complete` problem will belong to the class `X`
    -   { `X-complete` problems } is a proper subset of { `X-hard` problems }


## NP-hardness &amp; NP-completeness {#np-hardness-and-np-completeness}

Before understanding NP-hardness and NP-completeness, you should understand what `NP` is(a complexity class, what it means to be a complexity class), and you should understand the terms "hardness" and "completeness" in general sense.


### A bit of history (1970s) {#a-bit-of-history--1970s}


#### Cook, Levin and Karp cooked something {#cook-levin-and-karp-cooked-something}

{{< figure src="/ox-hugo/20230422182641-complexity_theory-527343648.png" >}}

-   [Cook and Levin](https://en.wikipedia.org/wiki/Cook%E2%80%93Levin_theorem) said that SAT problem is `NP-complete`.
    -   SAT was the [first problem](https://cstheory.stackexchange.com/questions/31717/did-stephen-cook-see-the-significance-of-showing-that-sat-is-np-hard-before-actu) to be proven `NP-complete`.
    -   i.e Any problem in `NP` can be reduced in polynomial time to SAT.
    -   i.e If SAT is solved, all `NP` problems will be solved in polynomial-time. If this happens, `P=NP`.
-   Around the same time, Karp showed that [21 diverse combinatorial and graph theoretical problems](https://en.wikipedia.org/wiki/Karp%27s_21_NP-complete_problems), each infamous for its intractability, are NP-complete


#### How does their help? {#how-does-their-help}

I mean it should not be a question at this point but it helps in 2 ways that I can think of.

1.  It helps to show that your problem is infact hard
    -   Before proving SAT is `NP-complete`, there was no reference to a truly hard problem, so this allowed us to define hardness.
    -   If prove your problem to be NP-complete, then you have tied its hardness to the hardness of hundreds of other problems.
    -   Your problem is now at-least as hard as the hardest NP-complete problem.
    -   So now you can stop looking for an efficient solution because there exists none.
2.  If ever `P=NP`, we have a way to solve every problem in `NP` in polynomial time with a DTM.
    -   For any NP-problem \\(A\\), there is a polytime algorithm &alpha; reducing SAT to \\(A\\). (by def.)
    -   Take an instance of \\(A\\), turn it into an instance of SAT via &alpha;
    -   Now this is where our current world is at. ⏲
    -   If we ever find a polynomial-time solution for SAT, say &beta;
    -   Now we can use &beta; to solve \\(A\\) because we reduced SAT to \\(A\\)
    -   Since reduction algorithm(&alpha;) was polynomial time, final solution is polynomial time.


### Reductions {#reductions}

-   There is a [general idea of reduction](https://en.wikipedia.org/wiki/Reduction_(complexity)), but we'll focus on reduction wrt `problems`
-   Reductions are "algorithms" that converting one problem to another.
-   Reduction is a [systematic way](https://github.com/j2kun/essays/blob/master/reductions-mathematical-hacks.md) to transform instances of one problem into instances of another, so that solutions to the latter translate back to solutions to the former.


#### Cook's reduction {#cook-s-reduction}

-   AKA Turning reduction
-   AKA [Polynomial-time reduction](https://en.wikipedia.org/wiki/Polynomial-time_reduction)
-   Allows you to call the black-box more than once.
-   `L` is NP-hard if
    -   For any decision problem `B` in `NP`
    -   `B` can be `solved` in `P` time by a TM with oracle access to `L`.


#### Karp's reduction {#karp-s-reduction}

-   AKA [Many-one reduction](https://en.wikipedia.org/wiki/Many-one_reduction)
-   Allows you to call the black-box problem exactly once. (I [don't really understand](https://cs.stackexchange.com/questions/93508/turing-reduction-vs-karp-reduction) this part)
-   `L` is NP-hard if
    -   For any decision problem `B` in `NP`
    -   `B` can be `transformed` into an instance of `L` in `P` time using a TM.


#### <span class="org-todo todo TODO">TODO</span> Direction of reduction {#direction-of-reduction}

{{< figure src="/ox-hugo/20230422182641-complexity_theory-1176835919.png" >}}

-   To prove a `X` is hard: Reduce to `X`
-   [Clarification on the reductions](https://www.reddit.com/r/AskComputerScience/comments/12ibd88/often_confusing_terminology_in_the_concept_of/)
-   When we [reduce](https://en.wikipedia.org/wiki/Many-one_reduction) \\(A\\) to \\(B\\), we are saying that \\(B\\) is at least as hard as \\(A\\). But \\(A\\) could be easier.
-   When we try to prove hardness, we reduce `from` the known problem `to` the problem we're trying to prove
    -   i.e Reduce from SAT to `X`. Now we know `X` is atleast as hard as SAT.
    -   i.e Reduce Halting to `X`. Now you can try reducing this but you most probably won't be able to because halting is probably harder than your problem.


### NP-hard &amp; NP-complete {#np-hard-and-np-complete}

{{< figure src="/ox-hugo/20230422182641-complexity_theory-570628832.png" >}}


#### NP-hard (NPH) {#np-hard--nph}

-   Hardness itself is not specific to decision problems. But `NP-hardness` is specific to decision problems but [sometimes](https://cstheory.stackexchange.com/questions/14787/np-hardness-of-an-optimization-problem) used for other computational problems as-well depending on context.
-   Based [on the](https://cs.stackexchange.com/questions/16386/teaching-np-completeness-turing-reductions-vs-karp-reductions) [reduction](https://cs.stackexchange.com/questions/84076/if-a-problem-is-cook-np-hard-and-this-problem-is-in-np-does-it-prove-that-the) used(Cook v/s Karp), `NP-hard` will [have](https://cs.stackexchange.com/questions/125328/karp-reduction-from-optimization-problems-to-decision-problems) a [slightly](https://cs.stackexchange.com/questions/35971/is-a-karp-levin-reduction-a-levin-reduction) [different meaning](https://cs.stackexchange.com/questions/11120/can-one-show-np-hardness-by-turing-reductions). Most discussions will be referring to Karp's reduction though.
-   Problems in this class **do not** have to be a decision problem
-   The definition following will be based on Karp's reduction.
-   If each `NP` problem can be reduced(in poly-time) to a problem `L`. Then `L` can be considered `NP-hard`


#### NP-complete (NPC) {#np-complete--npc}

-   Decision problems which contains the hardest problems in `NP`
-   `NP-complete` problems is a proper subset of `NP-hard` problems.
-   As a general rule, if it is in `NP` and it is **not** known to be in `P`, then it's `NP-complete`. Assuming `P != NP`, [exceptions](https://cs.stackexchange.com/questions/1810/are-there-np-problems-not-in-p-and-not-np-complete) go in [NP-intermediate](https://en.wikipedia.org/wiki/NP-intermediate)
-   There [are a lot of](https://en.wikipedia.org/wiki/List_of_NP-complete_problems) lists on [the internet](https://cgi.csc.liv.ac.uk/~ped/teachadmin/COMP202/annotated_np.html) [with NP-complete](https://adriann.github.io/npc/npc.html) problems.


#### Difference between NP-hard and NP-complete {#difference-between-np-hard-and-np-complete}


## Solution {#solution}


### Formalism {#formalism}

-   `Algorithm` : A Turing Machine is the [formal analogue](https://cs.stackexchange.com/questions/13669/what-is-the-difference-between-an-algorithm-a-language-and-a-problem) of an algorithm. Algorithm is the TM.


#### How is it represented? {#how-is-it-represented}

-   We want to represent the asymptotic behavior of the algorithm, the function. For this, we use [Big Oh Notation]({{< relref "20230423114200-big_oh_notation.md" >}}) (See [big-o growth](https://www.desmos.com/calculator/kgwiv5zizm))
-   A language to talk about **functions**
-   We're just talking about properties of functions, we're not talking about meanings.


### Computational complexity {#computational-complexity}

-   Complexity is the number of operations.
-   It is a relative measure of how many steps it will need to take to achieve something wrt to the input length.
-   It has nothing to do with how long it is to write down the solution or how complicated it is to follow.


#### Time complexity {#time-complexity}

-   [What is pseudopolynomial time?](https://stackoverflow.com/questions/19647658/what-is-pseudopolynomial-time-how-does-it-differ-from-polynomial-time)


#### Space complexity {#space-complexity}


### Analysis {#analysis}


#### Relationship of Complexity Analysis and Big Oh {#relationship-of-complexity-analysis-and-big-oh}

-   In algorithm complexity analysis we're more interested in \\(O, \Omega, \Theta\\) bounds of [Big Oh Notation]({{< relref "20230423114200-big_oh_notation.md" >}})
-   The statement "X case is \\(Y(f(n))\\)", for any values of `X`, `Y`, , `f`, `n` is valid. Eg. Nothing is stopping you from saying "The best case is \\(O(1)\\)" or "The worst case is \\(\Omega(n^{2})\\)". That is, the bounds do not relate to the case, it's only after the analysis we can say something about it.
-   In practice, we mostly talk about worst case in terms of upper bound however.


#### Types of Analysis {#types-of-analysis}

Lot of analysis we can run by using [Big Oh Notation]({{< relref "20230423114200-big_oh_notation.md" >}})

-   worst-case running time (most common)
-   average-case analysis
-   best-case analysis
-   expected time analysis for randomized algorithms
-   amortized time analysis, and many others.


#### Asymptotic Analysis {#asymptotic-analysis}

-   Asymptotic complexity simply talks of individual (worst) cases. The measure is against the size of input only—not against the data and/or operations (probability) distribution over many executions


#### Amortized Analysis {#amortized-analysis}

-   Amortised complexity of an algorithm is expressed as the average complexity over many (formally infinite number of) cases.
-   The idea is that if you run certain operations very many times, and in the great majority, the operations run very fast (e.g. in constant time), it’s OK that in some rather rare cases, they run for quite a long time; these cases are made up for (i.e. amortised) by all the other fast cases. It makes sense to compare algorithms using amortised complexity analysis if you expect them to run very many times and the you’re only seeking the whole to be efficient, not the particular runs.


### Cases {#cases}

-   A `case` for an algorithm is associated with an instance of a problem. More precisely the "inputs".
-   We have: Best, Worst and Average case (WCRT, ACRT, BCRT)


#### Graph for a function/algorithm {#graph-for-a-function-algorithm}

For any function(algorithm)
![](/ox-hugo/20230205172402-algorithms-735131562.png)

-   We have a `Time v/s Size` graph of WCRT,ACRT and BCRT
-   Each dot represent different variation of the same input size(eg. sorting [1234] vs [4321])


#### Average case (ACRT) {#average-case--acrt}

-   BCRT and WCRT are apparent.
-   ACRT is picking cases at random
-   Randomized algorithms are getting popular, those algorithms usually require ACRT analysis to show merits


#### WCRT is \\(O(n^{2})\\) vs WCRT is \\(\Theta(n^{2})\\) {#wcrt-is-o--n-2--vs-wcrt-is-theta--n-2}

-   Sometimes we can make exact statements about the rate of growth of that function, sometimes we want to express upper or lower bounds on it.
-   Not all algorithms can have \\(\Theta\\) complexity. There are algorithms that vary in complexity. Those can only be described with Big-O complexity
-   When we say \\(O(n^{2})\\), the function may also be \\(O(n)\\)   , we do not know.
    -   When we say \\(\Theta(n^{2})\\), we know for a fact the function is \\(O(n^{2})\\) and \\(\Omega(n^{2})\\), because it is bounded by \\(c\_{1}n^{2} \le f(n) \le c\_{2}n^{2}\\)
    -   When we say \\(f(n)\\) will be lower-bounded by \\(log(n)\\)and upper-bounded by \\(n\\), we know \\(f(n) \in \Omega(log(n)) \\) and \\(f(n) \in O(n)\\)
    -   Therefore we can say that \\(\Theta(n^{2})\\) gives us a more accurate (or at least equal) sense of worst-case run time than \\(O(n)\\)


### Upper and lower bounds {#upper-and-lower-bounds}

-   [Upper bound vs lower bound for worst case running time](https://stackoverflow.com/questions/7628991/upper-bound-vs-lower-bound-for-worst-case-running-time-of-an-algorithm)


## Proving hardness and reducing {#proving-hardness-and-reducing}


### For NP {#for-np}

-   You don't really prove hardness for NP because NP itself says nothing about hardness. But you can prove membership.
-   It's just a class of decision problems that gets verified in polynomial time.
-   But to prove NP membership, you can just use the solution as the certificate to state that it's in NP. But the certificate needs to be polynomial time, i.e you should be able to verify it in polynomial time.
-   Two ways
    -   Actually describe a non-deterministic polynomial algorithm that solves the problem.
    -   Use a certificate and verifier approach
-   [Proof that this problem is in NP](https://cs.stackexchange.com/questions/52130/proof-that-this-problem-is-in-np)


### For NP-hard {#for-np-hard}

> I have lost my patience dealing w this topic. This section might contain incorrect info.

-   It's generally not apparent if a problem is NP-hard or no. So we need to prove it.
-   When we say "we need to prove hardness", this is what we mean.
-   While trying to prove that `L` is `NP-hard` we need to reduce an existing `NP-hard` to `L`.
-   It's a prerequisite to proving `NP-complete`, as `NP-complete` is a proper subset of `NP-hard`.
-   We can probably prove something is `NP-hard` directly, but commonly we use `reduction`.
-   There's a library of NP-hard problems that you can pick from, some of them are cleverly designed to be easy to be reduced to. Try to get a feel over time for which problems more easily lend themselves to different schemes, like packing, or covering, or traversing graphs.
-   Do a reduction on the problem. If the reduction is same as the reduction of some other known NP-Hard problem, we're done. The reduction itself should take polynomial time
    ![](/ox-hugo/20230422182641-complexity_theory-315370952.png)


### For NP-complete {#for-np-complete}

-   You have to prove membership to `NP`
    -   that it is a decison problem
    -   that it is verifiable in poly-time
-   You have to prove membership to `NP-hard`
-   Examples
    -   [Splitting utility costs between roommates is NP-Complete](https://luckytoilet.wordpress.com/2014/04/05/splitting-utility-costs-between-roommates-is-np-complete/)
    -   [Misleadingly Simple NP-Hard Problem](https://hackernoon.com/adventures-in-programming-interviews-misleadingly-difficult-np-hard-problem-43092597018c)
    -   [How to prove that a problem is NP complete?](https://stackoverflow.com/questions/4294270/how-to-prove-that-a-problem-is-np-complete)


### For NP-hard but not NP-complete {#for-np-hard-but-not-np-complete}

-   Proving that a problem is in `NP-hard` but not in `NP-complete` is tricky
-   This demands we prove the problem
    1.  Does not exist in `NP`
    2.  Is harder than any `NP-complete` problem, because `NP-complete` is a subset of `NP-hard`
-   There's no known way to directly compare the hardness of problems that are not in NP with those that are. We can use approximation.
-   Example
    -   Halting problem
    -   The optimization-version of traveling salesman where we need to find an actual schedule is harder than the decision-version of traveling salesman where we just need to determine whether a schedule with length &lt;= k exists or not.


### For NP-hard but not known to be NP-complete {#for-np-hard-but-not-known-to-be-np-complete}

-   Mario was proved to be `NP-hard` but not `NP-complete`. Here is [some explanation](https://cs.stackexchange.com/questions/110345/why-isnt-the-generalized-super-mario-bros-obviously-in-np) that I don't yet understand.


## Dealing with hard problems {#dealing-with-hard-problems}

-   Dealing with `NP-complete` problems and `NP-hard` problems is more or less the same as `NP-complete` problems are `NP-hard` as-well.
-   But not all `NP-hard` problems are `NP-complete`, but most of these problems have decision problem counter parts that fall in `NP-complete`.
-   Once you know a problem is hard(`NP-complete` or `NP-hard`), you can ask, "can I find good approximate solutions?". Eg. See how [Bin packing problem](https://en.wikipedia.org/wiki/Bin_packing_problem) is handled with. It's both `NP-hard` and `NP-complete`. NPO is the class of optimization problems whose decision versions are in NP
-   [Dealing with intractability: NP-complete problems](https://cs.stackexchange.com/questions/1477/dealing-with-intractability-np-complete-problems)
-   [I need to solve an NP-hard problem. Is there hope?](https://stackoverflow.com/questions/27455585/i-need-to-solve-an-np-hard-problem-is-there-hope)
-   [What is inapproximability of NP-hard problems?](https://cs.stackexchange.com/questions/62915/what-is-inapproximability-of-np-hard-problems)
-   [Is there any NP-hard problem which was proven to be solved in polynomial time?](https://cs.stackexchange.com/questions/139829/is-there-any-np-hard-problem-which-was-proven-to-be-solved-in-polynomial-time-or)
-   [How to determine the solution of a problem by looking at its constraints?](https://codeforces.com/blog/entry/21344)


## P vs NP {#p-vs-np}

{{< figure src="/ox-hugo/20230422182641-complexity_theory-2126297177.png" >}}


### The Question {#the-question}

-   Q: is `P = NP`?
-   Q: Are `P` and `NP` the same class?
-   Q: Can problems which are verified in p-time also be solved in p-time?
-   Q: If it's easy to check the solution, is it also easy to find the solution?


### What we know about the question {#what-we-know-about-the-question}

-   What `P`, `NP`, `NP-hard` and `NP-complete` mean.
-   `NP` problems here refers to `NP-complete` problems. (VERIFY)
-   `P` is a subset of `NP`, but not sure if it's a proper subset.
-   `P != NP` is currently the general consensus by Computer Scientists
    -   It's easy to understand for mere mortals too. It's almost is natural.
    -   That _solving is harder than just checking a solution_.
    -   **BUT**, No one knows how to prove `P != NP`, hence we have this question.


### What happens if P = NP? {#what-happens-if-p-np}

-   Problems which are easy to check will become easy to solve
-   It'll be possible to reduce every `NP` problem to `P`
-   It'll be possible to reduce every `NP-complete` problem to `P`
-   For problems that are in `NP-hard` only, it'll mean nothing.
    ![](/ox-hugo/20230422182641-complexity_theory-1531315285.png)
-   Public Key [Cryptography]({{< relref "20230417101756-cryptography.md" >}}) will be broken.


### What happens if P != NP? {#what-happens-if-p-np}

-   It'll mean `P` is a proper subset of `NP`
-   Some problems are inherently complex to solve.
    -   `NP-hard` problems cannot not be solved in polynomial time.


## Resources {#resources}

-   [P vs. NP - The Biggest Unsolved Problem in Computer Science - YouTube](https://www.youtube.com/watch?v=EHp4FPyajKQ&t=7s) (Some issues)
-   Simon Singh
-   [NP-Complete isn't (always) Hard](https://www.hillelwayne.com/post/np-hard/#fnref:NP-hard-example)
-   [8. NP-Hard and NP-Complete Problems - YouTube](https://www.youtube.com/watch?v=e2cF8a5aAhE) (Lot of issues)
-   [P vs. NP and the Computational Complexity Zoo - YouTube](https://www.youtube.com/watch?v=YX40hbAHx3s)
-   [Lambda Calculus vs. Turing Machines](https://www.youtube.com/watch?v=ruOnPmI_40g)
-   [NP-Completeness, Cryptology, and Knapsacks](http://www.derf.net/knapsack/#KnapNP)
