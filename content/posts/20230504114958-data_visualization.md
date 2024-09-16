+++
title = "Data Visualization"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Data Engineering]({{< relref "20230405003455-data_engineering.md" >}}), [Creative Programming]({{< relref "20230326125239-creative_programming.md" >}}), [Database]({{< relref "20221102123145-database.md" >}}), [Web Animation]({{< relref "20221109214315-web_animation.md" >}}), [Geography]({{< relref "20221109130937-geography.md" >}})


## Basics {#basics}

-   Data visualization = Visual communication = story telling


## Statistics info {#statistics-info}

-   See [Statistics]({{< relref "20231017200424-statistics.md" >}})


### Histograms {#histograms}

{{< figure src="/ox-hugo/20231017200424-statistics-1677969152.png" >}}

-   Histogram is for quantitative data (no space between the bars)
-   Can be used to describe a `single variable`
-   It shows the `shape of distribution` of values
-   Axis
    -   `X`: variable of interest
    -   `Y`: Frequency/Relative Frequency/Percent Frequency
-   How
    -   Put the quantitative data into bins that don't overlap
    -   Put the number of observations in that bin to see the resolution which tells us about the distribution
-   Need to find a balance for "how many bins"


#### Bar chart vs Histogram {#bar-chart-vs-histogram}

{{< figure src="/ox-hugo/20230504114958-data_visualization-1967426202.png" >}}

-   Bar chart is for categorical data (space between the bars)


### Pie charts {#pie-charts}

Pie charts are very hard to use, maybe just use them when you have fewer categories


### Crosstabs (Cross tabulation) {#crosstabs--cross-tabulation}

-   Often used to show the relationship between two variables
-   very flexible and can show different types of information
-   The variables can be categorical or quantitative.
    -   Quantitative variables are often placed into bins or classes like in a histogram
-   Size = no. of categories of `A` x no. of categories of `B` (where `A` and `B` are variables)
-   In most software, cross-tabulation is done using `Pivot Tables`


### Box Plots {#box-plots}

![](/ox-hugo/20230504114958-data_visualization-1666400922.png)
![](/ox-hugo/20230504114958-data_visualization-1301896461.png)

-   AKA Whisker plots
-   Helps us visualize shape of data
    -   Normal distribution? Bell curve? Skewed? it can tell u that
-   [I’ve Stopped Using Box Plots. Should You? | Lobsters](https://lobste.rs/s/io4aui/i_ve_stopped_using_box_plots_should_you)


### Dot plots {#dot-plots}

{{< figure src="/ox-hugo/20230504114958-data_visualization-1730277349.png" >}}


### Others {#others}

-   Box plots, Normal prob. plots, Cum Dist plot show `percentiles`


## Libraries/Tools {#libraries-tools}


### Charting/Graphing {#charting-graphing}


#### SVG {#svg}

-   D3, Vega
-   [airbnb/visx](https://github.com/airbnb/visx) : D3 w react
-   Misc
    -   Rough charts
        -   <https://github.com/imkevinxu/xkcdgraphs>
        -   <https://github.com/timqian/chart.xkcd>
        -   <https://github.com/beizhedenglong/rough-charts>


#### CanvasAPI {#canvasapi}

-   ChartJS, [Vega](https://vega.github.io/)


#### WebGL {#webgl}

-   [deck.gl](https://deck.gl/#/)


### Others {#others}


#### PixiJS {#pixijs}

<!--list-separator-->

-  Process

    <!--list-separator-->

    -  An example

        -   Sprite container
            -   Sprite Map : Contain different sprites
        -   Renderer : Paints the sprite container into our `canvas`
        -   Game Loop / Request-Animation-Frame(RAF) loop
            -   Specify duration for tween and call RAF


## Other links {#other-links}

-   [How to pick more beautiful colors for your data visualizations (2020)](https://news.ycombinator.com/item?id=38482486)


## Tools {#tools}


### D3 {#d3}


#### Learning resources {#learning-resources}

-   <https://www.d3indepth.com/gettingstarted/>
-   <https://www.reddit.com/r/sveltejs/comments/126b993/svelte_d3_guides/>
-   <https://www.reddit.com/r/sveltejs/comments/17ieodt/introducing_layerchart/>
-   <https://www.kyrandale.com/bespoke-charts-with-svelte-d3-and-layercake/>
-   <https://reuters-graphics.github.io/example_svelte-graph-patterns/>
