+++
title = "Causal Inference"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Machine Learning]({{< relref "20230408190056-machine_learning.md" >}}), [Statistics]({{< relref "20231017200424-statistics.md" >}})


## FAQ {#faq}


### "correlation does not implies causation" meme {#correlation-does-not-implies-causation-meme}

-   "correlation does not implies causation" : Yes, commonly said
-   But causation also does not imply correlation too. There can be hidden variables.


### What are associations? {#what-are-associations}

-   `correlation` is a limited measure of `association`
    -   `variables` can be `associated` but have no `correlation`
-   `association` are bi-directional: `associations` between `variables` run in both direction


## Basics {#basics}


### What is Causal Interference {#what-is-causal-interference}

-   What happens when some intervention is done
-   Can only be done if we have a causal model


#### Causal Prediction {#causal-prediction}

-   Different from normal prediction
-   Predicting the effect
    -   Being able to `predict the consequences` of an `intervention`.
    -   Eg. `Movement of the trees` and `wind` are statically `associated`. But nothing in the data tells you that `wind` causes the trees to move.
-   What if I do this?


#### Causal Imputation {#causal-imputation}

-   Knowing the cause
    -   Being able to `construct` some `unobserved counterfactual outcome`
-   What if I had done something else?


### Related topics to [Causal Inference]({{< relref "20231017204511-causal_inference.md" >}}) {#related-topics-to-causal-inference--20231017204511-causal-inference-dot-md}

-   Description (of `population`)
    -   The `sample` is `caused` by `things`
-   Design (of research project)
    -   `things` need to be drawn w a causal logic which will help us `design/calculate` around them
    -   thinking about why `sample` differs from the `population`


## Models {#models}


### DAGs {#dags}

{{< figure src="/ox-hugo/20231017204511-causal_inference-805620288.png" >}}

-   Example
    -   Here `A` influences the treatment `X`
    -   Here `B` influences the outcome `Y`
    -   Here `C` influences both `X` and `Y` (Confound, we'd want to control it)
-   We can ask multiple questions to this model
-   DAGs are intuition pumps: get head out of data, into science
-   Gives you a strategy for which `control variables` you need to play with


### GOLEMS {#golems}

![](/ox-hugo/20231017200424-statistics-1469983409.png)
statistical models to produce scientific insight

-   They require additional `scientific (causal) models`
-   The `reasons` are not found in the data, but rather in the `causes` of the data
    -   i.e We should not try to infer the reason in the data.
-   `No causes in(the data), No causes out(from the data)`


#### Decision Tree/Flowchart {#decision-tree-flowchart}

-   We use it for selecting an appropriate statistical procedure.

{{< figure src="/ox-hugo/20231017204511-causal_inference-1728675806.png" >}}

-   But this kind of using a decision tree to select the statistical procedure is not much helpful for a research scientist because this quite limiting
-   Each of these procedures can have bayesian and frequestist version of them
-   Mostly useful in industrial testing
