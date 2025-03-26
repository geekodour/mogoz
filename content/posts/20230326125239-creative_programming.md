+++
title = "Creative Programming"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [General Programming]({{< relref "20230122140847-general_programming.md" >}}), [Web Animation]({{< relref "20221109214315-web_animation.md" >}}), [Human Computer Interaction ( HCI )]({{< relref "20230806231355-human_computer_interaction_hci.md" >}})


## Tool list {#tool-list}

-   Poor attempt at curating the interesting ones here. This is filtered from my secondary toolchest. For data viz specific libraries, see [Data Visualization]({{< relref "20230504114958-data_visualization.md" >}})
-   Good comparision here: [Canvas Engines Comparison](https://benchmarks.slaylines.io/pixi.html)


### CanvasAPI only wrappers {#canvasapi-only-wrappers}

-   Popular ones: [paper.js](https://github.com/paperjs/paper.js), [Fabric.js](http://fabricjs.com/), [CreateJS](https://createjs.com/)
-   Random: [metafizzy/zdog](https://github.com/metafizzy/zdog)


### Wrappers (canvas+webgl) {#wrappers--canvas-plus-webgl}

-   These are wrappers around canvasAPI/webGL/webGPU which gives additional features and easy access to the underlying APIs.


#### P5js {#p5js}

-   Mostly used for 2D but can also be used for 3D
-   Sits of top of canvasAPI, can use webGL if needed
-   p5.js is a reboot of original processing using JS syntax, deviates from original processing syntax. There used to be processing.js which is [no longer maintained](https://happycoding.io/tutorials/p5js/which-processing).
-   p5.js is good for JS, if python there's [py5](https://py5coding.org/) which uses JPype to connect the Processing Jars (Java).


#### PIXIjs {#pixijs}

-   Mostly used for 2D but can also be used for 3D
-   Sits of top of webGL, can fallback to canvasAPI
-   Performance is usually better than p5.js


#### ThreeJS {#threejs}

-   Sits on top of webGL. Handles linear algebra / matrix-math behind scenes
-   Mostly used for 3D
-   {{< figure src="/ox-hugo/20230326125239-creative_programming-538498346.png" >}}
-   {{< figure src="/ox-hugo/20230326125239-creative_programming-1125600894.png" >}}
-   {{< figure src="/ox-hugo/20230326125239-creative_programming-57592272.png" >}}


#### BabylonJS {#babylonjs}

-   Sits on top of webGL. Alternative to ThreeJS


### Games {#games}


#### Native engines {#native-engines}

This is not very relevant for me but to summarize. But using these native engines will need to send over like 10-20MB atleast even without your game. Something to be aware of before anything else.

-   Unreal: More batteries than unity (Usually AAA)
-   Unity: Less batteries than unreal (Usually AA)
    -   2023 May Update: WebGL player is too heavy for phones atm.
-   Godot: Open source, good for indie games etc.
-   Others: [PlayCanvas](https://playcanvas.com/) | [A-Frame](https://aframe.io/)


#### JS engines {#js-engines}

These are usually lightweight. And you can use things like tauri/electron to package and release these also.

-   Phaser
    -   One of the more popular ones
    -   This used to use PIXI.js ealier but now has its own rendering shit going on
-   Others: [Kontra.js](https://straker.github.io/kontra/getting-started) | [Ct.js](https://ctjs.rocks/) | [Kaboom](https://kaboomjs.com/) | [excalibur](https://excaliburjs.com//)0


### Additional tooling {#additional-tooling}

-   [gltfpack](https://meshoptimizer.org/gltf/) : gltfpack is a tool that can automatically optimize glTF files


### Website Building {#website-building}

-   [Slingcode](https://slingcode.net/) :  Slingcode is a personal computing platform in a single html file.


### Live programming {#live-programming}

-   <https://strudel.cc/>
-   <https://glicol.org/>


## Explorable Explanations {#explorable-explanations}

have a diff page

-   <https://pudding.cool/2018/04/birthday-paradox/>
