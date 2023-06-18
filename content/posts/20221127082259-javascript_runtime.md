+++
title = "Javascript Runtime and Browser"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Web Development]({{< relref "20221108105344-web_development.md" >}}), [Javascript]({{< relref "20221126085225-javascript.md" >}}), [DOM]({{< relref "20230614133347-dom.md" >}})


## FAQ {#faq}


### Javascript Engines {#javascript-engines}

-   Chrome: v8 + UI part, Skia
-   Firefox: Spidermonkey, webrender
-   Node.js: V8 + I/O parts


### Concurrency in Javascipt {#concurrency-in-javascipt}

-   See [Concurrency]({{< relref "20221126204257-concurrency.md" >}})
-   The single-threaded model has made Node.js a popular choice for server-side programming due to its non-blocking IO, making handling a large number of database or file-system requests very performant.
-   However, CPU-bound (computationally intensive) tasks that's pure JavaScript will still block the main thread.
-   To achieve real paralleling, you may need to use [workers](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Using_web_workers).
-   See [Web workers]({{< relref "20230503160302-web_performance.md#web-workers" >}})


### Communication between runtimes {#communication-between-runtimes}

-   These can communicate using [postMessage](https://developer.mozilla.org/en-US/docs/Web/API/Window/postMessage)
-   Eg. iframes, webworkers etc etc.


### Why setTimeout is not accurate? {#why-settimeout-is-not-accurate}

-   Event loop only runs after the `call stack` is empty
-   `setTimeout` is not a `guaranteed-time-to-execution` but instead a `minimum-time-to-execution`


## Runtime {#runtime}

-   Only do one thing at a time, single threaded.
-   UI updates handled in the same main thread.

![](/ox-hugo/20221126085225-javascript-1697497250.png)
![](/ox-hugo/eventloppv2.png)


### When your code is executed {#when-your-code-is-executed}

-   If it's synchronous call
    -   it'll be in the `call stack` and it'll run to completion.
    -   These can make asyc calls.
-   If it's async external/browser API call
    -   If `callbacks`, it will add your callback code to the `Macrotask queue`
    -   If `promises.then()`, it will add your then code to the `Microtask queue`
-   As soon as the `call stack` has finished current tick (stack empty)
    -   The `event loop` feeds it with a `new tick`
    -   `new tick`
        -   `1 task` (oldest) from `Macrotask queue`
        -   `All tasks` from `Microtask queue`
        -   `All/Partial tasks` from `Render queue`
-   Order of processing `new tick`
    -   Process all of `microtask queue` (incl. newly added during run)
    -   Process `Render queue`
    -   Process `Macrotask queue` w the `oldest task`


## Event Loop {#event-loop}

{{< figure src="/ox-hugo/20221127082259-javascript_runtime-1624550197.png" >}}


### Types {#types}


#### Browser {#browser}

-   Window(each `origin` gets its own eventloop)
-   Worker
-   Worklet (See [Web workers]({{< relref "20230503160302-web_performance.md#web-workers" >}}))


#### NodeJS {#nodejs}

-   Main loop/Main thread
    -   Internally there's no queue. [It's epoll](https://nodejs.org/en/docs/guides/dont-block-the-event-loop#how-does-nodejs-decide-what-code-to-run-next)!
-   Worker pool/Thread pool (Implemented using libuv, See [Disk I/O]({{< relref "20230402013722-disk_i_o.md" >}}))
    -   This uses an actual queue
-   Node.js automatically uses the Worker Pool to handle cpu/io expensive tasks.
-   NodeJS's synchronous APIs are intended for scripting use, not to be used in server context because they block the event loop


### Event loop components {#event-loop-components}

JavaScript has a runtime model based on an event loop. It's responsible for executing the code, collecting and processing events, and executing queued sub-tasks


#### Call stack {#call-stack}

-   When writing synchronous code, we just use the stack.
-   Pushes and Pops functions in and out of it
-   `one thread = one call stack = one thing at a time`
-   Run to completion
    -   whenever a function runs, it cannot be preempted and will run entirely before any other code runs.
    -   This differs from C, for instance, where if a function runs in a thread, it may be stopped at any point by the runtime system to run some other code in another thread.


#### Macro task/Callback/Event Queue {#macro-task-callback-event-queue}

-   Every time you add a callback (ex. setTimeout/AJAX APIs/input events), it is added to this queue


#### Microtask Queue/Job queue {#microtask-queue-job-queue}

-   `Promise` initialize and resolve are synchronous, only `.then` callbacks are sent to `microtask queue`
-   Callbacks added with `then()` or `mutation observer` will never be invoked before the completion of the current run of the event loop. Even already-resolved promises will be invoked only after the current run of the event loop for consistency.
    ```js
    Promise.resolve().then(() => console.log(2));
    console.log(1);
    // Logs: 1, 2
    ```
-   It is a prioritized queue
    -   Execute this code later (asynchronously)
    -   But as soon as possible! (before the next Event Loop)
    -   i.e `microtask queue` will be executed before `macrotask queue` and `render queue`


### Blocking the event loop {#blocking-the-event-loop}

-   Since `event loop` can only run when the `call stack` is empty. If we do not allow the `call stack` to be empty, we'll be blocking the `event loop`.
    -   i.e Running synchronous code will keep blocking the `event loop`.
    -   The `event loop` puts `render queue` calls to the stack
    -   if the `call stack` is not empty it does not get a chance to `render queue` so our browsers sort of pause when synchronous things are happening.
-   Running the `current tick` contains the `full microtask queue`
    -   You can block the `event loop` from going to the `next tick` if you continuously add new tasks to the `microtask queue`
    -   microtasks can enqueue new microtasks and those new microtasks will execute before the end of the current event loop iteration.


## DOM Parsing {#dom-parsing}

-   See [DOM]({{< relref "20230614133347-dom.md" >}}) and [this](https://frarizzi.science/journal/web-engineering/browser-rendering-queue-in-depth)


### Whole DOM creation process {#whole-dom-creation-process}

{{< figure src="/ox-hugo/20221126085225-javascript-2098551911.png" >}}

-   **DOM parsing**
    -   Parse the HTML code into a machine-understandable tree, called DOM (Document Object Model)
-   **CSS parsing**
    -   Parse the CSS code into another machine-understandable tree.
-   **CSSOM creation**
    -   Merge between the previously parsed DOM and CSS, called CSSOM (CSS Object Model).
    -   Contains the information of all the DOM elements, along with their styles (critical for the next step, keep reading);
-   **Render tree creation**
    -   Cleaned CSSOM
    -   Eg. Some DOMNode is styled with `display: none;` in the CSSOM, it won't be in this tree as it won't be rendered.
-   **Layouting**
    -   Process of calculating the sizing and positions of every single element from the Render tree
    -   Also referred as `Reflow`
-   **Layer tree creation**
    -   It is not granted that there will be only one final raster of the page.
    -   The browser (or you using some imperative styling rule ex. `will-change: transform;`, not to pre-optimize) can decide that for the given page it is better to split it into different layers (rasters).
    -   This is usually done for performance reasons.
    -   If a raster has to be changed many times while the others must remain unchanged
        -   Creating layers(rasters) can avoid un-needed repaints of un-changed items.
        -   This process figures out how many layers need to be created and which elements will fall inside each one;
-   **Painting**
    -   At this stage we know everything of our code
    -   Everything has been reordered into digestible trees and we are ready to actually paint the pixels in rasters (Chrome: Skia, Firefox: webrender)
-   **GPU sync**
    -   The fresh painted rasters from the Painting stage are sent to the GPU memory with all the necessary management information
-   **Composition**
    -   The GPU positions every single raster in the right position and with the right effects applied (ex. opacity), creating the final frame on the screen.


### More on Render Queue {#more-on-render-queue}

-   Read [this](https://blog.xnim.me/event-loop-and-render-queue)

![](/ox-hugo/20221127082259-javascript_runtime-803558407.png)
The Rendering UI Queue is the process by which:

-   Browsers manage to transform your abstract code (HTML + CSS + JavaScript) into raster images to show to the end user.
-   This process is sometimes referred also as `rendering path` or `critical rendering path`
-   This process consists of a long pipeline of different operations needed to interpret the code
    -   Respond to animations and user interactions (events)
    -   Keep everything consistent
    -   Create the final raster(s) for the given frame
    -   Sync with the GPU (send the so-constructed raster to the GPU, which will take care of displaying it on the screen).
-   This pipeline has not to be executed in his totality, in order to save precious time and gain performance, the browser executes only the strictly needed operations.


### Optimizing renders {#optimizing-renders}


#### Avoid layout thrashing {#avoid-layout-thrashing}

```javascript
//The wrong way:
for ( let i = 0; i < 10; i++ ) {
    changeHeight();
    readWidth();
}

//The right way:
//Using two loops is way more performant than forcing reflows!
for ( let i = 0; i < 10; i++ ) {
    //Do all the changes first.
    changeHeight();
}
for ( let i = 0; i < 10; i++ ) {
    //Read all them after.
    readWidth();
}
```


#### Use appropriate CSS properties {#use-appropriate-css-properties}

-   Different CSS properties trigger different phase of the rendering pipeline.
-   We would usually want to avoid `reflow` by using properties that would only trigger `composition` or `paint` which will result in faster websites. Eg. For instance, a change in background-image doesn’t require any layout changes, but does require paint and composite.
-   **If you must use a property that triggers layout or paint, it is unlikely that you will be able to make the animation smooth and high-performance.**
-   See [How CSS works - Learn web development | MDN](https://developer.mozilla.org/en-US/docs/Learn/CSS/First_steps/How_CSS_works)
-   See [CSS Triggers | CSS-Tricks - CSS-Tricks](https://css-tricks.com/css-triggers/)
-   See [Rendering Performance](https://web.dev/rendering-performance/)
-   See [Stick to Compositor-Only Properties and Manage Layer Count](https://web.dev/stick-to-compositor-only-properties-and-manage-layer-count/)
-   See [Eliminate content repaints with the new Layers panel in Chrome](https://blog.logrocket.com/eliminate-content-repaints-with-the-new-layers-panel-in-chrome-e2c306d4d752/)
-   See [How to create high-performance CSS animations](https://web.dev/animations-guide/)


## Memory management {#memory-management}

-   Understanding JS memory management also helps in understanding closures.


### Heap and Stack {#heap-and-stack}

-   **There's no practical stack/heap distinction in JS. That would be an implementation detail of the JS engine.**
-   Function calls, however, work on what is referred to as the `call stack`, much as in most languages.
    -   This is **not** the memory stack in languages like golang.
    -   `Arguments` and `local variables` may continue to exist after a `function` is out of the `call stack` because they are stored **outside** the `call stack`


### Allocations {#allocations}

-   Declaring a function also allocates memory as function is just a callable object
-   Function expressions also allocate an object. (eg. specifying a function to `addEventListener`)
-   Some function calls result in object allocation. (eg. `new Date()`)
