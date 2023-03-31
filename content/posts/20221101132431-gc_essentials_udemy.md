+++
title = "GC Essentials Udemy"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Courses]({{< relref "20221101124038-courses.md" >}}), [Garbage collection]({{< relref "20221101213015-garbage_collection.md" >}})


## Allocation Types {#allocation-types}

Two broad types, Static and Dynamic. (Stack and Heap are Dynamic allocations)


### Static {#static}

-   The layout is known at compile time
-   Early 1950s (Fortran)
-   No runtime allocation
-   Fixed Size and variables bound to initial memory locations
-   No Recursion


### Stack {#stack}

-   Was introduced to support recursive calls with ALGOL
-   Grows downwards ⬇️
-   Stack pointer and base [pointer are manually worked on **in Assembly**](https://en.wikipedia.org/wiki/Function_prologue)
-   Stack allocation is automatically managed **in languages like C**


### Heap {#heap}

-   Any memory chunk can pass around
-   We can consume memory when needed
-   Grows upwards ⬆️
-   🐉 Issues: Dangling Pointers and Memory Leak, which can be solved by GC.
-   **Dangling Pointers**: When a pointer is pointing to a memory location that's been freed! (Free objects too early)
-   **Memory Leak**: More memory on the heap than needed. A chunk is just there in the memory taking space and nothing is pointing to it. (Forget to free needed object)
-   **Usage:** C: `malloc` and `free`, C++: `new` and `delete`, Go: `escape analysis` and `GC`


## Object Header {#object-header}

A datastructure used to maintain the state of each object for the allocator/collector purpose. It can contain things like markbit, ref count, freeblock flag etc.

> ![](/ox-hugo/objheader.png) &gt; _On x86_32, W=4bytes, so 5 bytes of `malloc(5)` needs 3 bytes of padding, the object header then will take another +N bytes on top of that. So were're actually adding some overhead to whatever memory we request_


## Memory Layout {#memory-layout}

Also see [Virtual Memory]({{< relref "20221101214011-virtual_memory.md" >}})


### Stack {#stack}

{{< figure src="/ox-hugo/stackframe1.png" >}}

credit: eli's [blog](https://eli.thegreenplace.net/2011/02/04/where-the-top-of-the-stack-is-on-x86/#id4).

[`ebp` is the](https://stackoverflow.com/questions/1395591/what-is-exactly-the-base-pointer-and-stack-pointer-to-what-do-they-point) frame pointer/base pointer and `esp` is the stack pointer. When we say "top of the stack" on x86, we actually mean the lowest address in the memory area, hence the negative offset. `esp` points to the top of the stack.

> `rbp` and `rsp` are just the 64-bit equivalents to the 32-bit [`ebp`](https://practicalmalwareanalysis.com/2012/04/03/all-about-ebp/) and `esp` variables.


### Heap {#heap}

Similar to the stack pointer(`esp`) the top of the heap is called the **program break**. Moving the **program break** `up` allocates memory and moving it `down` deallocates memory.

> Writing to higher addresses than the program break will result in segfaults for ovious reasons.

We have a syscall to do this, `brk` and `sbrk` (wrapper around `brk` that allows a increment rather than direct address unlike `brk`), when we are using `brk` it gives us new memory based on the page size(see obj header diagram above)

Another syscall relevant here is `mmap`, it allows your program to allocate more memeory aswell but gives you more options than just to bump up/down the **program break**.


#### The C standard Library {#the-c-standard-library}

-   `malloc()`: This library functions gives us access to the memory allocator, it uses `brk()` and `mmap()` behind the scenes based on the implementation.
-   `free()` might put the block into an internal pool for recycling by malloc(), or it can be given back to the kernel (which can then free up the underlying physical pages).


## Mechanisms for Memory Allocation {#mechanisms-for-memory-allocation}


### Sequential(Bump) {#sequentialbump}

Does not try reuse any of the existing free blocks of memory, just keep bumping the allocation pointer whenever new memory is requested. It's fast but not every system supports it as it involves relocating objects of the GC cycle.

-   **Example Allocators**: Pool Allocator.
-   **Example Collectors**: Mark Compact, Copying GC, Generational GC


### Free list {#free-list}

Maintains list like data structuire of data structures of free blocks it reuses the freed blocks of memory. There are several ways the search mechanism for free blocks can be done: FirstFit, NextFit, BestFit, Segregate Fit(probably the best so far)

-   **Example Collectors**: Mark Sweep, Manual Memory Management, Ref. Count GC
-   FirstFit
    -   First block that is large enough to satisfy the request is allocated.
-   NextFit
    -   Search starts from the last block that was allocated
    -   Looks for the next block that is large enough to satisfy the request.
-   BestFit
    -   The block that is closest in size to the requested size is allocated.
-   Segregate Fit
    -   Free blocks are divided into several lists according to their sizes
    -   Search starts from the list of blocks that are closest in size to the requested size.


## Garbage Collector {#garbage-collector}

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

Has better cache locality and faster memory allocation and has two phases, **Marking Phase**, similar to Mark phase in MarkSweep but this store additional info in the object header for relocation.

The **Compacting Phase** has again a lot of algorithms like 2 fingers, The lisp2(most used),Threaded and Onepass.


### Copying Collector/Sem-Space Collector {#copying-collectorsem-space-collector}

This trades storage for speed and requires half of the heap to be reserved for the collector! It's sometimes referred to as the CopyingGC


### Ref.Count GC {#refcount-gc}

-   This is the most naive garbage collection algorithm. This algorithm reduces the problem from determining whether or not an object is still needed to determining if an object still has any other objects referencing it.
-   An object is said to be "garbage", or collectible if there are zero references pointing to it.
-   It is a direct collector which is able to identify the garbage directly.
-   **Circular references are a common cause of memory leaks.**
-   IE6 and IE7 are known to have reference-counting garbage collectors, which have caused memory leaks with circular references. **No modern browser engine uses reference-counting for garbage collection anymore.** but programming languages do.


## Examples by Language {#examples-by-language}

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
