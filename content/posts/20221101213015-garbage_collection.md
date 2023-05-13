+++
title = "Garbage collection"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Computer Memory]({{< relref "20221101203327-computer_memory.md" >}}), [Operating Systems]({{< relref "20221101172456-operating_systems.md" >}})


## Intro {#intro}

Terms that comeup often when talking about GC, mutator, collector, allocator. The Allocator and the collector need to kind of agree on how both will handle things Eg. For Marksweep collector to be at use, we need to be using freelist allocation.

{{< figure src="/ox-hugo/mca_cycle.png" >}}

-   **Mutator**: Shows how and where things should be allocated by the allocator.
-   **Allocator**: `memalloc`, handles dynamic memory alloc, returns pouinter
-   **Collector**: GC, reclaims memory and preserves mutator view.


### Approaches to GC {#approaches-to-gc}

> The primary reason of having different approaches is to minimize GC pause, such as running the collector concurrently.

-   Different approaches to garbage collection can be used with different types of garbage collectors.
-   Choice of approach and collector depends on the specific requirements of the system, such as the size of the heap, the performance requirements, and the complexity of the program.
-   Eg. STW + mark-and-sweep, concurrent or incremental + generational garbage collector.


#### Stop the World (STW) {#stop-the-world--stw}

All the threads in the mutator(user program) are blocked during collection. i.e GC Pause


#### Incremental {#incremental}

-   Divides the garbage collection process into smaller, incremental steps.
-   GC examines a portion of the heap in each step and then pauses the mutator before moving on to the next portion.


#### Concurrent {#concurrent}

-   Collection and freeing memory occurs while the mutator is still running.


### Garbage Types {#garbage-types}

We know that our objects aswell as the garbage live in the Heap area.

-   **Semantic Garbage**: Alive but unused objects. Eg. non-invalidated cache, bugs in the program such as a variable that is in the program but is unused.
-   **Syntactic Garbage**: Data that cannot be reached by our code. GC **only** works on these kind of garbages.


### Collector Types {#collector-types}

-   **Tracing**: Scans the heap to search for live objects and treat everything else as garbage. It starts its analysis from the `root`, in a `STW` collector, trace happens during GC pause.
-   **Direct**: No explicit GC pause is there, it is deeply integrated with the mutator such as maintaing a list of references to an object to directly collect when needed.


## GC Algorithms {#gc-algorithms}

-   **Tracing Collectors**: MarkSweep, MarkCompact, CopyingGC
-   **Direct Collectors**: Ref Count


### MarkSweep {#marksweep}

Two phases, **Mark** traces the live objects and **Sweep** reclaims the garbage. It uses the object header to store a `mark-bit`; if object is alive, this flag will be set.

The mark phase marks the live objects and traverses the entire heap from a `root` to find unmarked objects and adds them into the freelist. It's a **non-moving** (live objects are not relocated) collection algorithm, which is nice for languages exposing pointer semantics.

This prevents circular references.

Main Issue: Fragmentation, fixed by Mark compact and CopyingGC


### MarkCompact {#markcompact}

Has better cache locality and faster memory allocation and has two phases, **Marking Phase**, similar to Mark phase in MarkSweep but this store additional info in the object header for relocation. i.e It's a moving GC.

The **Compacting Phase** has again a lot of algorithms like 2 fingers, The lisp2(most used),Threaded and Onepass.


### Copying Collector/Sem-Space Collector {#copying-collector-sem-space-collector}

This trades storage for speed and requires half of the heap to be reserved for the collector! It's sometimes referred to as the CopyingGC


### Ref.Count GC {#ref-dot-count-gc}

-   This is the most naive garbage collection algorithm. This algorithm reduces the problem from determining whether or not an object is still needed to determining if an object still has any other objects referencing it.
-   An object is said to be "garbage", or collectible if there are zero references pointing to it.
-   It is a direct collector which is able to identify the garbage directly.
-   **Circular references are a common cause of memory leaks.**
-   IE6 and IE7 are known to have reference-counting garbage collectors, which have caused memory leaks with circular references. **No modern browser engine uses reference-counting for garbage collection anymore.** but programming languages do.


## GC for different languages {#gc-for-different-languages}

| Language | GC Algorithm                       |
|----------|------------------------------------|
| Java     | STW Mark-and-Sweep                 |
| C#       | STW Mark-and-Sweep                 |
| Python   | Reference Counting, Mark-and-Sweep |
| Ruby     | Mark-and-Sweep                     |
| JS       | Mark-and-Sweep                     |
| Go       | Concurrent Mark-and-Sweep          |
| Kotlin   | SWT Mark-and-Sweep                 |
| Swift    | Auto Ref Counting                  |
| PHP      | Ref. Count, Mark and Sweep         |
| C++      | Manual Memory Management, No GC    |


### Golang (Outdated) {#golang--outdated}

-   v1.5: A concurrent mark-and-sweep GC.
-   v1.12: A non-generational concurrent tri-color mark and sweep collector.
-   This was originally based on tcmalloc, but has diverged quite a bit.
-   The Go GC uses a pacer to determine when to trigger the next GC cycle.
-   Go's default pacer will try to trigger a GC cycle every time the heap size doubles.
    -   The 2x value comes from a variable `GOGC` the runtime uses to set the trigger ratio.
