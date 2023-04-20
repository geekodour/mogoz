+++
title = "Concurrency in Golang"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Concurrency]({{< relref "20221126204257-concurrency.md" >}}), [Golang]({{< relref "20221101220915-golang.md" >}})


## Goroutines {#goroutines}

-   Execute tasks independently.


## goroutine-safe ? {#goroutine-safe}

See [Goroutine-safe vs Thread-safe](https://groups.google.com/g/golang-nuts/c/ZA0IK1k6UVk)

-   `goroutine-safe` is not well-established term. While `thread-safe` is, and it means safe for concurrent access.
-   You can freely substitute "thread-safe" with "goroutine-safe" in Go docs, unless documentation very explicitly refers to actual threads
-   See [Threads]({{< relref "20221101173032-threads.md" >}})


## Channels {#channels}

-   We want a `goroutine-safe` FIFO object.
    -   A queue with a lock will suffice that requirement
    -   That's exactly what channels are.
-   We use channels for communication &amp; synchronization among goroutines
-   Defined by the `hchan` struct, at runtime this is allocated on the `heap`.
    -   So we essentially get a `pointer` to the `channel`


### Buffered (Asynchronous) {#buffered--asynchronous}

```go
ch := make(chan int, 3)
```

{{< figure src="/ox-hugo/20230412015037-concurrency_in_golang-394322227.png" >}}

-   Don't use buffer channels unless you're sure you need to


#### Memory safety {#memory-safety}

-   See [Thread Safety]({{< relref "20221101173032-threads.md#thread-safety" >}})
-   Enqueue and Dequeue are "memory copy". This gives us memory safety. Because, no shared memory except the `hchan` and `hchan` is protected by its lock.
    ![](/ox-hugo/20230412015037-concurrency_in_golang-507010490.png)


### Unbuffered (Synchronous) {#unbuffered--synchronous}

```go
ch := make(chan int)
```

{{< figure src="/ox-hugo/20230412015037-concurrency_in_golang-1427803735.png" >}}


### Other {#other}

-   Q: How channel blocks/unblocks goroutines
-   What is this: `ch := make(chan int, 0)`
-   Channels orchestrate; mutexes serialize.
-   What good for?
    -   Process an endless stream of things
    -   Easily serve multiple goroutines
    -   Receive a notification of something at some point in the future
-   Channel Tips
    -   Always close channels from sending side.
    -   Good to pass a channel as a parameter. (You have control over the channel)


## Shared state?? {#shared-state}

-   Using locks


## More info on Go Concurrency {#more-info-on-go-concurrency}

-   Has a [Race Detector](http://blog.golang.org/race-detector)
-   [The Behavior Of Channels](https://www.ardanlabs.com/blog/2017/10/the-behavior-of-channels.html)
-   [Concurrency in Go {Book}](https://www.oreilly.com/library/view/concurrency-in-go/9781491941294/)
-   <https://github.com/plagioriginal/concurrency-in-go>
-   [Share memory by communicating · The Ethically-Trained Programmer](https://blog.carlmjohnson.net/post/share-memory-by-communicating/)
-   [Internals of Go Channels. Inner workings of Go channels | by Shubham Agrawal ...](https://shubhagr.medium.com/internals-of-go-channels-cf5eb15858fc)


## Links on goroutines {#links-on-goroutines}

-   <https://povilasv.me/go-memory-management/>
-   <https://www.reddit.com/r/golang/comments/1efjs0/how_does_gos_gc_interact_with_virtual_memory/>
-   <https://deepu.tech/memory-management-in-golang/>
-   <https://blog.cloudflare.com/how-stacks-are-handled-in-go/>
-   <https://matklad.github.io/2021/03/12/goroutines-are-not-significantly-smaller-than-threads.html>
-   <https://www.reddit.com/r/golang/comments/117a4x7/how_can_goroutines_be_more_scalable_than_kernel/>
-   <https://www.youtube.com/watch?v=KBZlN0izeiY&t=536s>
-   <https://news.ycombinator.com/item?id=25997506>
-   <https://www.reddit.com/r/golang/comments/tifbow/50_million_virtual_threads_massive_virtual/>
-   <https://www.reddit.com/r/golang/comments/cgkg66/releasing_memory_in_goroutine_stacks/>
-   <https://www.reddit.com/r/golang/comments/10320aq/do_goroutines_typically_run_ontop_of_operating/>
-   <https://katherine.cox-buday.com/concurrency-in-go/>
-   <https://www.reddit.com/r/golang/comments/yww0t7/why_a_goroutine_is_not_a_thread_but_a_green/>
-   <https://news.ycombinator.com/item?id=26461765>
-   <https://news.ycombinator.com/item?id=26440334>
-   <https://eklitzke.org/goroutines-nonblocking-io-and-memory-usage>
