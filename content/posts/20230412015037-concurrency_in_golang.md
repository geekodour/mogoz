+++
title = "Concurrency in Golang"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Concurrency]({{< relref "20221126204257-concurrency.md" >}}), [Golang]({{< relref "20221101220915-golang.md" >}})

100% chances of things being wrong here.


## Go concurrency tips {#go-concurrency-tips}


### Control {#control}

-   Always close channels from sending side.
-   Good to pass a channel as a parameter. (You have control over the channel)


### Handling multiple channels {#handling-multiple-channels}

-   `select`, this is similar to unix `select(2)`, hence the name. It's often used inside an infinite loop (say, in a consumer) to grab data from any available channel.


### Detecting data races {#detecting-data-races}

-   If two goroutines try to modify a shared variable, we have a race condition.
-   go has a built-in data race detector which can help us detect it. See [Race Detector](http://blog.golang.org/race-detector).


## Runtime and Scheduler other parts {#runtime-and-scheduler-other-parts}

> Go runtime creates OS threads. The Go scheduler schedules goroutines on top of these OS threads.


### Go runtime {#go-runtime}


### Go scheduler {#go-scheduler}

-   Watch: [Dmitry Vyukov — Go scheduler](https://www.youtube.com/watch?v=-K11rY57K7k)


#### Initial attempts {#initial-attempts}

-   1:1 threading: 1 goroutine. To expensive. syscalls, memory, no infinite stacks.
-   Thread pools: faster goroutine creation. But more memory consumption, performance issues, no infinite stacks.


#### M:N threading {#m-n-threading}

{{< figure src="/ox-hugo/20230412015037-concurrency_in_golang-1500572695.png" >}}

-   We multiplex goroutines on the threads
-   If we have 4 OS threads, they can run 4 goroutines at the same time


#### M:N Scheduler {#m-n-scheduler}

-   Because OS doesn't know anything about our goroutines, we need to come up w our own scheduler
-   We need to keep track of
    -   Run Queue: Runnable Goroutines
        ![](/ox-hugo/20230412015037-concurrency_in_golang-2104350229.png)
-   We **don't** need to keep track of Blocked goroutines as channels have their own wait queue. When we unblock a goroutine, it's moved to the scheduler run queue.
    ![](/ox-hugo/20230412015037-concurrency_in_golang-1067858354.png)
-   Syscalls

    -   When a goroutine does a syscall, and things go into the kernel we have lost control over the goroutine. We'll only know if it returns back.
    -   If all threads are doing syscalls, then we can't even schedule new stuff now. And if one of a runnable goroutine holds the lock, we have a artificial deadlock. This issue is common for any scheduler w fixed number of threads.
        ![](/ox-hugo/20230412015037-concurrency_in_golang-1701281784.png)

    <!--listend-->

    -   Solution to this, in the last thread, it'll start another os thread, which will start re-flow of the runqueue
        -   If we have 5 threads, we only want to run 4


#### Distributed M:N Scheduler {#distributed-m-n-scheduler}

-   M:N Scheduler doesn't scale as multiple threads try to access just one mutex
-   So we give each thread its own M:N scheduler
    ![](/ox-hugo/20230412015037-concurrency_in_golang-862708014.png)
-   Which distributed scheduler, we now have the problem of having an unified view of the Run Queue.
    -   Local run-queue &rArr; Global run-queue &rArr; Steal work of other schedulers
    -   So we also got some load balancing now
-   This still not enough because checking for work stealing involves syscalls and now each thread needs to syscalls and will result in cpu being busy for nothing.


#### Go Processor M:P:N {#go-processor-m-p-n}

-   P: `GOMAXPROCS` env var
-   `go_processor`: A artificial resource required to run Go code. No. of `go_processor` objects == cores.
-   If goroutine is executing syscall, it does not need a `go_processor`, it's only needed for goroutines running go code.
    ![](/ox-hugo/20230412015037-concurrency_in_golang-1058699396.png)
-   With this, threads only need to check fixed number of `go_processor`. So work stealing becomes scalable.
    ![](/ox-hugo/20230412015037-concurrency_in_golang-1699084938.png)


### Go GC {#go-gc}

-   See [GopherCon 2022: Madhav Jivrajani - Control Theory and Concurrent GC](https://www.youtube.com/watch?v=We-8RSk4eZA)
-   See [Garbage collection]({{< relref "20221101213015-garbage_collection.md" >}})


## Concurrency in go, what are my options/primitives? {#concurrency-in-go-what-are-my-options-primitives}

-   There are no [Threads]({{< relref "20221101173032-threads.md" >}}). But we have some sort of [Coroutines]({{< relref "20230516192836-coroutines.md" >}}) + Green [Threads]({{< relref "20221101173032-threads.md" >}}) combination. They're called `goroutines`. You probably will interact with os threads w cgo ig.


### Communication {#communication}

-   Shared state: Atomics, Mutex and friends
-   Message passing: channels


### Synchronizations {#synchronizations}

-   You can always use shared state for synchronization. Can also go [lockfree maybe](https://www.sobyte.net/post/2021-07/implementing-lock-free-queues-with-go/).
-   Channels too can be used for synchronization, as reading from channel is a blocking call.


### When to use what? {#when-to-use-what}

Some general guidelines

-   Understand what data structure you're working w. Eg. Go Maps are not goroutine-safe, you need to use a RWMutex if you use it to share data across goroutines.
-   Try avoiding shared state, if cannot avoid, deal things at max w one mutex.
-   If you take a lock in your function, and call something else that takes a lock, that's two locks. If you need two locks might aswell switch to channels. (Not my words, I don't even understand this deeply but sounds wise, have to think more why this is the way it is)


## goroutines {#goroutines}

-   `go` keyword is the only api for goroutines
-   Users can't specify stack size for goroutines.
-   When a go-routine
    -   sleeps/blocked: underlying thread can be used by another go-routine.
    -   wakes up: It might be on a different thread.
    -   Go handles all this behind the scenes.


### Benefits over kernel threads {#benefits-over-kernel-threads}

-   w M:N scheduling &amp; channels, we get efficiency due low overhead in context switching.
-   Lower memory allocation per go routine vs os threads


### goroutine-safe/thread-safe data structure(`X`)? {#goroutine-safe-thread-safe-data-structure--x}

<div class="warning small-text">

> -   See [Goroutine-safe vs Thread-safe](https://groups.google.com/g/golang-nuts/c/ZA0IK1k6UVk)
> -   See [Threads]({{< relref "20221101173032-threads.md" >}})
> -   `goroutine-safe` is not well-established term. While `thread-safe` is, and it means safe for concurrent access.
> -   You can freely substitute "thread-safe" with "goroutine-safe" in Go docs, unless documentation very explicitly refers to actual threads
</div>

-   Here `X` can be some data structure.
-   If `X` can be accessed by multiple goroutines without causing any conflict, we can say `X` is goroutine safe. `X` itself manages the data and ensures the safety of concurrent access.
-   Eg. Go's `channel` are a goroutine-safe FIFO object.


## Channel {#channel}

-   Channel is a queue(FIFO) with a lock. It's goroutine safe.
-   Multiple writers/readers can use a single channel without a mutex/lock safely.
-   When we get a channel, we essentially get a `pointer` to the `channel`.


### Implementation {#implementation}

-   Defined by the `hchan` struct, at runtime this is allocated on the `heap`.
-   Enqueue and Dequeue are "memory copy". This gives us memory safety. Because, no shared memory except the `hchan` and `hchan` is protected by its lock.
    ![](/ox-hugo/20230412015037-concurrency_in_golang-507010490.png)


### Unbuffered (Synchronous) {#unbuffered--synchronous}

```go
ch := make(chan int)
```

{{< figure src="/ox-hugo/20230412015037-concurrency_in_golang-1427803735.png" >}}


### Buffered (Asynchronous) {#buffered--asynchronous}

```go
ch := make(chan int, 3)
```

{{< figure src="/ox-hugo/20230412015037-concurrency_in_golang-394322227.png" >}}

-   Don't use buffer channels unless you're sure you need to
-   if we want the producer to be able to make more than one piece of Work at a time, then we may consider buffered


### Questions &amp; Resources {#questions-and-resources}

-   What is this: `ch := make(chan int, 0)`
-   [The Behavior Of Channels](https://www.ardanlabs.com/blog/2017/10/the-behavior-of-channels.html)
-   [Share memory by communicating · The Ethically-Trained Programmer](https://blog.carlmjohnson.net/post/share-memory-by-communicating/)
-   [Internals of Go Channels. Inner workings of Go channels](https://shubhagr.medium.com/internals-of-go-channels-cf5eb15858fc)


## More resources {#more-resources}

-   [Go Memory Management – Povilas Versockas](https://povilasv.me/go-memory-management/)
-   [Visualizing memory management in Golang | Technorage](https://deepu.tech/memory-management-in-golang/)
-   <https://github.com/plagioriginal/concurrency-in-go>
