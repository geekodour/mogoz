+++
title = "Javascript Runtime and Browser"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Web Development]({{< relref "20221108105344-web_development.md" >}}), [Javascript]({{< relref "20221126085225-javascript.md" >}})


## Runtime {#runtime}

> The Javascript Runtime can only do one thing at a time because it is single threaded. This means The UI updates and interactions are handled in the same main thread.

{{< figure src="/ox-hugo/20221126085225-javascript-1697497250.png" >}}

When your code is executed:

-   It may call the Browser’s APIs to interact with the DOM or schedule some async task.
-   Those async tasks are added to the `event queue` or to the `prioritized Job queue` (if using `Promises`).
-   As soon as the the `call stack` has finished to process the current tick (is empty), the `event loop` feeds it with a new Tick.
    -   new tick = `ONE callback` + `the FULL job queue` + `the POSSIBILITY to call, fully or only some parts, the Render queue`


### Call stack {#call-stack}

-   When writing synchronous code, we just use the stack.
-   Pushes and Pops functions in and out of it
-   one thread = one call stack = one thing at a time
-   Run to completion: whenever a function runs, it cannot be preempted and will run entirely before any other code runs (and can modify data the function manipulates). This differs from C, for instance, where if a function runs in a thread, it may be stopped at any point by the runtime system to run some other code in another thread.


### Task/Callback/Event Queue {#task-callback-event-queue}

every time you add a callback (ex. via the setTimeout or the AJAX APIs), it is added to this queue


### Job Queue {#job-queue}

-   This queue is reserved for promise’s thens
-   It is a prioritized queue
    -   execute this code later (= asynchronously), but as soon as possible! (= before the next Event Loop tick)


### Event loop {#event-loop}

JavaScript has a runtime model based on an event loop. It's responsible for executing the code, collecting and processing events, and executing queued sub-tasks

-   Look at the `call stack` and looks at the `task/callback queue`.
    -   If the `call stack` is **empty**, it takes the first thing from the `task queue` and pushes it into the `call stack`
    -   Because event loop only runs after the `call stack` is empty, because of this `setTimeout` is not a `guaranteed-time-to-execution` but instead a `minimum-time-to-execution`
-   TODO: [Understanding the Event Loop, Callbacks, Promises](https://www.taniarascia.com/asynchronous-javascript-event-loop-callbacks-promises-async-await/)


#### Blocking the event loop {#blocking-the-event-loop}

-   Since `event loop` can only run when the `call stack` is empty. If we do not allow the `call stack` to be empty, we'll be blocking the `event loop`.
-   i.e Running synchronous code will keep blocking the `event loop`. The `event loop` puts `render queue` calls to the stack, if the `call stack` is not empty it does not get a chance to `render queue` so our browsers sort of pause when synchronous things are happening.
-   Since running the `current tick(call stack)` runs the `full job queue(promises)`, you may inadvertently block the `event loop` from going to the `next tick` if you continuously add new jobs to the `job queue`
-   Also read [Don't Block the Event Loop (or the Worker Pool) | Node.js](https://nodejs.org/en/docs/guides/dont-block-the-event-loop/)
-   Also read [Node.js, lots of ways to block your event-loop (and how to avoid it)](https://medium.com/voodoo-engineering/node-js-lots-of-ways-to-block-your-event-loop-and-how-to-avoid-it-b41f41deecf5)


### External APIs {#external-apis}

-   The browser is more than just the JS runtime
-   Asynchronous code: Functions in the `call stack` can call webapis. Once the timer/whatever the external API had to do is finished, the callback is pushed to the `task/callback queue`
-   Based on how the Web API is called:
    -   If `callbacks`, it will add your callback code to the `Event queue`
    -   If `promises`, it will add your then code to the `Job queue`


## Render Queue {#render-queue}

{{< figure src="/ox-hugo/20221126085225-javascript-2098551911.png" >}}

The Rendering UI Queue is the process by which:

-   Browsers manage to transform your abstract code (HTML + CSS + JavaScript) into raster images to show to the end user.
-   This process is sometimes referred also as `rendering path` or `critical rendering path`
-   This process consists of a long pipeline of different operations needed to interpret the code
    -   Respond to animations and user interactions (events)
    -   Keep everything consistent
    -   Create the final raster(s) for the given frame
    -   Sync with the GPU (send the so-constructed raster to the GPU, which will take care of displaying it on the screen).
-   This pipeline has not to be executed in his totality, in order to save precious time and gain performance, the browser executes only the strictly needed operations.


## DOM Parsing {#dom-parsing}

> Source: [Francesco Rizzi's Journal | Browser Rendering Queue in-depth.](https://frarizzi.science/journal/web-engineering/browser-rendering-queue-in-depth)

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
