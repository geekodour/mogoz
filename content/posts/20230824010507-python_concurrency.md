+++
title = "Python Concurrency"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Python]({{< relref "20221231140207-python.md" >}}), [Concurrency]({{< relref "20221126204257-concurrency.md" >}}), [Multiprocessing]({{< relref "20221101202303-multiprocessing.md" >}})


## FAQ {#faq}


### Can different approaches be used together {#can-different-approaches-be-used-together}

-   Yes ofc.
-   Eg.


### How to run python code on multiple processors? {#how-to-run-python-code-on-multiple-processors}


### When using threading, do I need to use a worker pool/threading pool? {#when-using-threading-do-i-need-to-use-a-worker-pool-threading-pool}


### WTF GIL? {#wtf-gil}


## Approaches {#approaches}

| Name               | GIL            | Remark                                  | Type            |
|--------------------|----------------|-----------------------------------------|-----------------|
| asyncio            | doesn't matter |                                         | coroutine-based |
| threading          |                |                                         | thread-based    |
| multiprocessing    | doesn't matter |                                         | process-based   |
| concurrent.futures | -              | wrapper around threading and processing |                 |
| vectorization      |                | specialized                             |                 |


### Asyncio {#asyncio}

-   asyncio runs in a single thread. It only uses the main thread.
    -   Concurrency is achieved through cooperative multitasking by using Python generators
    -   See [Coroutines]({{< relref "20230516192836-coroutines.md" >}})
-   Usecase
    -   Writes to [sqlite]({{< relref "20230702184501-sqlite.md" >}}) are then sent to that thread via a queue, using an open source library called Janus which provides a queue that can bridge the gap between the asyncio and threaded Python worlds.
-   Resources
    -   [How Python Asyncio Works: Recreating it from Scratch](https://jacobpadilla.com/articles/recreating-asyncio)
    -   [What the heck is gevent? (Part 1 of 4) | by Roy Williams | Lyft Engineering](https://eng.lyft.com/what-the-heck-is-gevent-4e87db98a8)


### Threads {#threads}

See [Threads]({{< relref "20221101173032-threads.md" >}})


#### Daemon and non-daemon threads {#daemon-and-non-daemon-threads}

```python
# non-daemon, no join.
# prints yoyo, prints server start, waits
# main thread finished, thread runnig
t = threading.Thread(target=serve, args=[port])
t.start()
print("yoyo")

# non-daemon, join.
# prints server start, waits.
# main thread waiting, thread running
t = threading.Thread(target=serve, args=[port])
t.start()
t.join()
print("yoyo")

# daemon, no join.
# prints server start, prints yoyo, quits.
# thread runs, main runs and finished, both exit
t = threading.Thread(target=serve, args=[port])
t.daemon = True
t.start()
print("yoyo")
```

-   Non-daemon threads
    -   Expected to complete their execution before the main program exits.
    -   This is usually achieved by waiting for the thread using `join` in the main thread
    -   Using `join` is not mandatory, `join` is only needed for synchronization. Eg. the correctness of the program depends on the thread completing its execution and then we go on with the main thread. Without `join`, we'll spin the thread and it'll keep running and then we'll continue running the main thread aswell.
-   Daemon threads
    -   Abruptly terminated when the main program exits, regardless of whether they have completed their tasks or not.
    -   It's just a flag on a normal thread
    -   You can actually call `.join` on daemon threads, but it's generally considered to be not good practice.


### Processes {#processes}

[Processes]({{< relref "20221101172944-processes.md" >}})

-   This is using the multiprocessing library which is literally just using multiple processes.
-   Effectively side-stepping the Global Interpreter Lock by using subprocesses instead of threads.
    -   Now each process gets its own GIL
-   Take care of `if __name__ == "__main__"` when using `multiprocessing`


### concurrent.futures {#concurrent-dot-futures}

-   This is more like wrappers around threads and multiprocess support in python.
-   The ergonomics seems to be better than using threads and multiprocessing directly


#### components {#components}

-   `Executor`
    -   submit
    -   shutdown
    -   `map`
        -   `map` is not super flexible with error handling
        -   If usecase requires error handling, better use `submit` with `as_completed` (See official example)
-   `ThreadPoolExecutor` (Subclass of Executor)
    -   Based on `threads`
-   `ProcessPoolExecutor` (Subclass of Executor)
    -   Based on `multiprocessing`


### queue {#queue}


### Vectorization {#vectorization}

-   See [The limits of Python vectorization as a performance technique](https://pythonspeed.com/articles/vectorization-python-alternatives/)
-   [SIMD in Pure Python | Blog](https://www.da.vidbuchanan.co.uk/blog/python-swar.html)
    -   [From slow to SIMD: A Go optimization story](https://sourcegraph.com/blog/slow-to-simd)
-   In order for vectorization to work, you need low-level machine code both driving the loop over your data, and running the actual operation. Switching back to Python loops and functionality loses that speed.


## Reading links {#reading-links}

-   [500 Lines or LessA Web Crawler With asyncio Coroutines](https://aosabook.org/en/500L/a-web-crawler-with-asyncio-coroutines.html)
-   [Asyncio, twisted, tornado, gevent walk into a bar | Hacker News](https://news.ycombinator.com/item?id=37226360) | [Asyncio, twisted, tornado, gevent walk into a bar | Lobsters](https://lobste.rs/s/lfkxmg/asyncio_twisted_tornado_gevent_walk_into)
