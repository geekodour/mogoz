+++
title = "Garbage collection"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Computer Memory]({{< relref "20221101203327-computer_memory.md" >}}), [Operating Systems]({{< relref "20221101172456-operating_systems.md" >}})


## Others {#others}

-   Compilers use a technique called escape analysis to determine if something can be allocated on the stack or must be placed on the heap.
-   Heap fragmentation can have a substantial impact on the CPU
-   It turns out that for modern operating systems, sweeping (freeing memory) is a very fast operation, so the GC time for Go's mark-and-sweep GC is largely dominated by the mark component and not sweeping time.


## Parallel, incremental and concurrent {#parallel-incremental-and-concurrent}

-   parallel GC is also blocking STW collector, that runs using several threads, each thread handles its own heap part. Special care should be taken as every datastructure can be handled in parallel.
-   incremental GC is also blocking STW, but it can be interrupted by the Mutator before the end of the gc pause.
-   concurrent/almost concurrent collectors, these can run concurrently with the mutator but use some kind of gc barrier for sync and even though at some times it will need to gc pause aswell.


### Approaches to garbage collection {#approaches-to-garbage-collection}

-   STW : Mutator is completely blocked and usually **single** collector thread.
-   Concurrent
-   Incremental


## Go's Garbage collection {#gos-garbage-collection}

> As of this writing, the latest is `Go1.14`, but some of these ideas are old. More importantly, take all of these with a big grain of salt because it keeps evolving!

There's some layering here:

-   Go-level memory metrics exposed by [runtime.MemStats](https://golang.org/pkg/runtime/#MemStats)
-   OS level memory use matters because it influences things like how much real memory your program needs and how likely it is to be killed by the OS in a low-memory situation, but there has always been a disconnect between OS level information and Go level information.

---

-   Since v1.5, Go has incorporated a `concurrent mark-and-sweep` GC.
-   As of version 1.12, the Go programming language uses a non-generational concurrent tri-color mark and sweep collector.
-   This was originally based on tcmalloc, but has diverged quite a bit.
-   tcmalloc is a memory allocator that's optimized for high concurrency situations. The tc in tcmalloc stands for thread cache.
-   Like most modern allocators, tcmalloc is page-oriented, meaning that the internal unit of measure is usually pages rather than bytes.
-   The Go GC uses a pacer to determine when to trigger the next GC cycle.
-   Go's default pacer will try to trigger a GC cycle every time the heap size doubles., The 2x value comes from a variable GOGC the runtime uses to set the trigger ratio.
-   `src/runtime/malloc.go` : This was originally based on tcmalloc, but has diverged quite a bit now.

<https://www.jamesgolick.com/2013/5/19/how-tcmalloc-works.html#footnote1>

<https://github.com/golang/go/blob/master/src/runtime/malloc.go>

<https://utcc.utoronto.ca/~cks/space/blog/programming/GoProgramMemoryUse> (some practical ideas on arena etc.)

-   <https://news.ycombinator.com/item?id=23214535> MMU gang wars


### memory man {#memory-man}

Turns out that Go organizes memory in spans, which are contiguous regions of memory of 8K or larger. There are 3 types of Spans:

-   1.  idle -- span, that has no objects and can be released back to the OS, or reused for heap allocation, or reused for stack memory.

-   2.  in use -- span, that has atleast one heap object and may have space for more.

-   3.  stack -- span, which is used for goroutine stack. This span can live either in stack or in heap, but not in both.
