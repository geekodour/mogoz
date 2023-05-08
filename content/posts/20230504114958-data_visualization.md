+++
title = "Data Visualization"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Data Engineering]({{< relref "20230405003455-data_engineering.md" >}}), [Creative Programming]({{< relref "20230326125239-creative_programming.md" >}}), [Database]({{< relref "20221102123145-database.md" >}}), [Web Animation]({{< relref "20221109214315-web_animation.md" >}}), [Geography]({{< relref "20221109130937-geography.md" >}})


## Basics {#basics}

-   Data visualization = Visual communication = story telling


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
