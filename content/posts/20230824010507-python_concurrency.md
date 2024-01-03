+++
title = "Python Concurrency"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Python]({{< relref "20221231140207-python.md" >}}), [Concurrency]({{< relref "20221126204257-concurrency.md" >}}), [Multiprocessing]({{< relref "20221101202303-multiprocessing.md" >}})


## Approaches {#approaches}


### Asyncio {#asyncio}

-   Writes to [sqlite]({{< relref "20230702184501-sqlite.md" >}}) are then sent to that thread via a queue, using an open source library called Janus which provides a queue that can bridge the gap between the asyncio and threaded Python worlds.


### Threads {#threads}

See [Threads]({{< relref "20221101173032-threads.md" >}}), [Processes]({{< relref "20221101172944-processes.md" >}})


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


### concurrent.futures {#concurrent-dot-futures}

-   Executor
    -   submit
    -   shutdown
    -   `map`
        -   `map` is not super flexible with error handling
        -   If usecase requires error handling, better use `submit` with `as_completed` (See official example)
-   ThreadPoolExecutor (Subclass of Executor)
    -   Based on `threads`
-   ProcessPoolExecutor (Subclass of Executor)
    -   Based on `multiprocessing`


### queue {#queue}


### Vectorization {#vectorization}

-   See [The limits of Python vectorization as a performance technique](https://pythonspeed.com/articles/vectorization-python-alternatives/)
-   In order for vectorization to work, you need low-level machine code both driving the loop over your data, and running the actual operation. Switching back to Python loops and functionality loses that speed.


## Reading links {#reading-links}

-   [500 Lines or LessA Web Crawler With asyncio Coroutines](https://aosabook.org/en/500L/a-web-crawler-with-asyncio-coroutines.html)
-   [The easy way to concurrency and parallelism with Python stdlib](https://www.bitecode.dev/p/the-easy-way-to-concurrency-and-parallelism)
-   [charles leifer | AsyncIO](https://charlesleifer.com/blog/asyncio/)
-   [What the heck is gevent? (Part 1 of 4) | by Roy Williams | Lyft Engineering](https://eng.lyft.com/what-the-heck-is-gevent-4e87db98a8)
-   [Asyncio, twisted, tornado, gevent walk into a bar | Hacker News](https://news.ycombinator.com/item?id=37226360) | [Asyncio, twisted, tornado, gevent walk into a bar | Lobsters](https://lobste.rs/s/lfkxmg/asyncio_twisted_tornado_gevent_walk_into)
