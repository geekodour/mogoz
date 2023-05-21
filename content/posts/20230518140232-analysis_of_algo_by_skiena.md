+++
title = "Analysis of Algo by Skiena"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Algorithms]({{< relref "20230205172402-algorithms.md" >}}), [Courses]({{< relref "20221101124038-courses.md" >}})


Source: [Skiena's Algorithms](https://www3.cs.stonybrook.edu/~skiena/373/videos/)


## Lecture 1 {#lecture-1}

-   We seek algorithms which are correct and efficient.
-   No efficient, correct algorithm exists for the traveling salesman problem.
-   Proving that an algorithm in [NP complete](https://www.hillelwayne.com/post/np-hard/) [will help](https://matklad.github.io/2023/02/21/why-SAT-is-hard.html) you sleep well at night because you'll know that there exists **no fast** algorithm for that problem vs thinking you're being stupid while coming up with the algorithm to solve the problem.


### Algorithm designer skills {#algorithm-designer-skills}

-   Proving Incorrectness
    -   We have a heuristic and then we try to disprove the correctness
    -   Proving incorrectness(eg. come up with counter examples, instance that breaks the algorithm)
    -   Heuristic: A algorithm that isn't correct or may not be correct
    -   The easier and smaller the counter example is the better
-   Proving correctness
    -   Failing to find a counter example != the algorithm is correct
    -   Induction is a useful way to prove correctness of **recursive algorithms**
    -   Proof by contradiction


## Lecture 2 {#lecture-2}


### RAM Model of computation {#ram-model-of-computation}

-   Enables us to design algorithms in machine independent manner
-   It's not an accurate model but it's simple to work with and has a lot of truth to it
-   We measure the run time of an algorithm by counting the number of steps.
-   Assumptions
    -   Each “simple” operation (+, -, =, if, call) takes 1 step.
    -   Loops and subroutine calls are not simple operations.
    -   Each memory access takes exactly 1 step.


### Issues with RAM model {#issues-with-ram-model}

In the RAM model of complexity

-   we sometimes may have bumps in functions. i.e in different input sizes results may vary
-   Complexity is typically expressed as a function of the size of the input but sometimes it's too much detail to specify precisely
    -   eg. `T (n) = 12754n2 + 4353n + 834 lg2 n + 13546`
-   So we instead go with Asymptotic notation using [Big Oh Notation]({{< relref "20230423114200-big_oh_notation.md" >}}).
-   See [Complexity Theory]({{< relref "20230422182641-complexity_theory.md" >}})


## Lecture 3 {#lecture-3}


### Analysis {#analysis}

When we say nothing infront of "running time", we usually mean worst case.


#### Worst case analysis {#worst-case-analysis}

-   For `selection sort`
    -   \\(n \times n \to O(n^{2})\\) : It's **No worse than \\(n^{2}\\)**
    -   \\(n/2 \times n/2 \to n^{2}/4 \to \Omega(n^{2})\\) : It's **No better than** \\(n^{2}\\)
    -   \\(n/2 \times n/2 \to n^{2}/4 \to \Theta(n^{2})\\) : It **is** \\(n^{2}\\)

{{< figure src="/ox-hugo/20230205172402-algorithms-219328318.png" >}}

-   There's no discussion about best case etc here. i.e It's analyzing the worst case by trying to figure out the upper and lower bounds.
-   `DOUBT`: I am still confused about how we come up with \\(\Omega\\), esp for insertion sort.


#### Logarithm {#logarithm}

In the context of algorithms, [Logarithm]({{< relref "20221101154748-logarithm.md" >}})s reflect:

-   How many times we can `double` something util we get to `n`
-   How many times we can `half` something util we get to `1`
-   If the input halves at each step, its likely O(LogN) or O(NIogN). Eg. Binary search is \\(log(n)\\), Binary tree height is \\(log(n)\\)
