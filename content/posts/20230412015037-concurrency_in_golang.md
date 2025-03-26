+++
title = "Concurrency in Golang"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Concurrency]({{< relref "20221126204257-concurrency.md" >}}), [Golang]({{< relref "20221101220915-golang.md" >}})

100% chances of things being wrong here.


## Go concurrency tips {#go-concurrency-tips}


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
-   Good to pass a channel as a parameter. (You have control over the channel)
-   Closing channels
    -   Closing channels is not necessary, only necessary if the receiver must know about it. Eg `range` on the channel.
    -   Always close channels from sending side.


### Implementation {#implementation}

-   Defined by the `hchan` struct, at runtime this is allocated on the `heap`.
-   Enqueue and Dequeue are "memory copy". This gives us memory safety. Because, no shared memory except the `hchan` and `hchan` is protected by its lock.
    ![](/ox-hugo/20230412015037-concurrency_in_golang-507010490.png)


### Buffered &amp; Unbuffered {#buffered-and-unbuffered}

> The difference between a buffered and unbuffered channel is only in how the channel is initialized, not in how it is declared in the struct.


#### Unbuffered (Synchronous) {#unbuffered--synchronous}

```go
ch := make(chan int)
ch := make(chan int, 0) // same as above
```

{{< figure src="/ox-hugo/20230412015037-concurrency_in_golang-1427803735.png" >}}

-   Combines communication w synchronization


#### Buffered (Asynchronous) {#buffered--asynchronous}

```go
ch := make(chan int, 3)
// ch := make(chan int, x>0)
```

{{< figure src="/ox-hugo/20230412015037-concurrency_in_golang-394322227.png" >}}

-   Don't use buffer channels unless you're sure you need to
-   Can be used as a semaphor, eg. limit throughput in a webserver
-   if we want the producer to be able to make more than one piece of Work at a time, then we may consider buffered


#### Blocking in buffered and unbuffered {#blocking-in-buffered-and-unbuffered}

```go
func main() {
    ch := make(chan int, 1)
    ch <- 32 // if unbuf, things will not move post this! deadlock.
	// ch <- 88 // this will block an buf(1) ch! (channel full)
    <-ch     // if unbuf, this must be called from another goroutine
    fmt.Println("Hello, 世界")
}
```

-   Buffered
    -   S: Until the receiver has received the value
    -   R: Blocks if nothing to receive
-   Unbuffered
    -   S: Blocks when the buffer is full, something must receive now.
    -   R: Blocks if empty buffer


#### Send and receive channels {#send-and-receive-channels}

```go
TransactionChan() <-chan message.Transaction
```

This declares a function that returns a receive-only channel of message.Transaction. You can only receive values FROM this channel, not send TO it.


### `select` and `ctx.Done()` &amp; Handling multiple channels {#select-and-ctx-dot-done-and-handling-multiple-channels}

> When in a for loop:
>
> -   `select` statement just selects a case that can proceed (and runs it), and then it ends
> -   `select` does NOT run and listen for the different `cases` in parallel.
> -   when multiple ready channels `select` picks one at random. There's no oderding.
> -   If a `case` is chosen and `select` is under a `for` loop, the particular `case` has to finish, only then we get back to `for` loop and the selection happens again. For this reason, we want the time spent under each `case` to be very minimal.
>     -   i.e If we trying to empulate something like parallel execution, we probably need to use some managed goroutine thingy like errgroup etc.

-   `select`, this is similar to unix `select(2)`, hence the name.
-   It's often used inside an infinite loop (say, in a consumer) to grab data from any available channel.
-   chooses one at random if multiple are ready. If one "case" is chosen, others are not picked for that iteration.
-   waiting on `ctx.Done()` is same as any other channel, if we want to have some priority w it we might use this trick. This way done channel is always checked. There's also: <https://stackoverflow.com/questions/46200343/force-priority-of-go-select-statement>
    ```go
    for {
        select {
        case <-ctx.Done():
            return ctx.Err()
        default:
            // Now use a non-blocking select for other operations
            select {
            case <-ctx.Done():
                return ctx.Err()
            case v := <-ch1:
                // Handle ch1
            case v := <-ch2:
                // Handle ch2
            default:
                // Optional: do some non-blocking work
            }
        }
    }
    ```


#### `select` vs `select loop` {#select-vs-select-loop}

-   `select` can be run without a loop but often can be seen inside a bounded `for` loop or unbounded `for {}` loop
-   We're talking about the select loop here, you are waiting on one of two things to happen:
-   Await the closing of the channel returned by Done(): This happens only when there's a timeout or the context is cancelled.
-   select statement just selects a case that can proceed (and runs it), and then it ends, it doesn't do anything else you are "trying again" with your for


#### Example of an issue (see explanation) {#example-of-an-issue--see-explanation}

```go
// NOTE: My assumptions here is wrong, see explanation
package main

import (
	"context"
	"fmt"
	"time"
)

func worker(a, b chan struct{}, ctx context.Context) error {
	for {
		select {
		case <-ctx.Done():
			fmt.Println("cancelled")
			return nil
		case <-a:
			fmt.Println("running A")
			time.Sleep(4 * time.Second)
			fmt.Println("sleep A finish")
		case <-b:
			fmt.Println("running B")
			time.Sleep(2 * time.Second)
		}
	}
}

func main() {
	a := make(chan struct{})
	b := make(chan struct{})
	ctx := context.Background()

  // USECASE #1
  // this ends immediately after printing running A
	ctx, can := context.WithCancel(ctx)
	go worker(a, b, ctx)
	a <- struct{}{}
	fmt.Println("cancelling") // this does NOT wait till A finishes and cancel is done immediately
	can()

  // USECASE #2
  // following waits till A sleep and wakes up and then only triggers B
	go worker(a, b, ctx)
	a <- struct{}{}
	fmt.Println("launching b") // this will keep waiting till A finishes
	b <- struct{}{}

}
```

<!--list-separator-->

-  Explanation

    But it seems like select waits till the current case completes and then picks one at random etc etc.
    not quite, a select statement just selects a case that can proceed (and runs it), and then it ends, it doesn't do anything else
    you are "trying again" with your for

    So I wanted to understand why ctx.Done behaves differently under select
    it doesn't, it's just a channel, there is no special behaviour

    when main returns the program exits, regardless of how many goroutines are still running
    that is the issue with your playground (edited)
    NEW
    [7:41 AM]zhayes: additionally, calling cancel doesn't wait for anything, if you want to wait for the cancelled goroutine to exit, you need to do that yourself


### Guarantees {#guarantees}

-   Channels should not be passed as pointers, they're alreay internally impplemented as pointers(reference types like maps)

> chatgpt
>
> Go's channel implementation ensures that each item sent on a channel is received by exactly one receiver.
> This is a fundamental property of Go channels, whether buffered or unbuffered.
>
> How It Works:
>
> When a goroutine tries to receive from a channel, it is blocked until data is available.
> Once data is sent on the channel, exactly one of the waiting goroutines will be unblocked to receive that data.
> The runtime handles the synchronization and ensures no duplication.


### Resources {#resources}

-   [The Behavior Of Channels](https://www.ardanlabs.com/blog/2017/10/the-behavior-of-channels.html)
-   [Share memory by communicating · The Ethically-Trained Programmer](https://blog.carlmjohnson.net/post/share-memory-by-communicating/)
-   [Internals of Go Channels. Inner workings of Go channels](https://shubhagr.medium.com/internals-of-go-channels-cf5eb15858fc)
-   <https://dave.cheney.net/2013/04/30/curious-channels>
-   <https://dave.cheney.net/2014/03/19/channel-axioms>
-   <https://www.dolthub.com/blog/2024-06-21-channel-three-ways/>


## More resources {#more-resources}

-   [Synchronization Constructs in the Go Standard Library | Lobsters](https://lobste.rs/s/tccc6h/synchronization_constructs_go_standard) 🌟
-   [Go Memory Management – Povilas Versockas](https://povilasv.me/go-memory-management/)
-   [Visualizing memory management in Golang | Technorage](https://deepu.tech/memory-management-in-golang/)
-   <https://github.com/plagioriginal/concurrency-in-go>
-   [Threads and Goroutines | Lobsters](https://lobste.rs/s/jr48n1/threads_goroutines)
-   [Notes on structured concurrency, or: Go statement considered harmful — njs blog](https://vorpus.org/blog/notes-on-structured-concurrency-or-go-statement-considered-harmful/?s=35#what-is-a-go-statement-anyway)
