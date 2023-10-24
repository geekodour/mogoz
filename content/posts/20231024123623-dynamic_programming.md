+++
title = "Dynamic Programming"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Algorithms]({{< relref "20230205172402-algorithms.md" >}}), [Algorithm Problems]({{< relref "20230407001048-algorithm_problems.md" >}}), [Recursion]({{< relref "20230429205506-recursion.md" >}}), [Problem solving Strategies in Algorithms]({{< relref "20231024124212-problem_solving_strategies_in_algorithms.md" >}})


## Tips from internet {#tips-from-internet}

My biggest insight about recursion came in my graduate algorithms course. I had a great professor who was talking about dynamic programming. I think that most people can agree that DP is one of the hairier subjects. When I'm griding Leetcode I mostly used to skip these problems and then just hope in an interview I'm never asked about it.

My prof cleared everything up though. He said that DP is what naturally happens whenever you take a recursive algorithm and refactor it to put all the recursive calls into their own data structure. When you are doing recursive fibonacci, you are really just using the call stack as a linked list. So instead of making the recursive call, figure out how value N in the list relies on the previous values and then compute that directly.

For more complicated algorithms where the recursive call has N arguments, that means you need a N-dimensional array (worst case) to store your calls in.

After that lecture I was never scared of dynamic programming because I had a meta-algorithm to produce the DP solution.

1.  Write a recursive algo (probably exponentially inefficent)

2.  Figure out how to store recursive call data in a data structure

3.  Figure out how to populate field (a,b) of the data structure, normally by combining/minimizing/maximizing (a,b-1), (a-1,b)

4.  Figure out how to get the answer out of the data structure once you have filled it in
