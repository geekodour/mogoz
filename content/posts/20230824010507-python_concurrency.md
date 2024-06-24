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
-   Eg. <https://skipperkongen.dk/2016/09/09/easy-parallel-http-requests-with-python-and-asyncio/>
    -   This uses asyncio and Threadpool executor together


### How to run python code on multiple processors? {#how-to-run-python-code-on-multiple-processors}

-   `multiprocessing` module
    -   This [article](https://superfastpython.com/python-use-all-cpu-cores/) is all about using `multiprocessing` module to use all cpu cores. It's true.
    -   Since this is essentially multiple processes they can just run on multiple cores as per need etc.
-   `threading` module
    -   There's some [confusion around](https://www.reddit.com/r/learnpython/comments/17vym1l/multithreading_and_multiple_cpu_cores_utilization/) `threading` module only using one CPU
    -   This is not entirely true
    -   It has to do with the GIL
        -   When we write Python code, we have no control over the GIL.
        -   But a built-in function or an extension(c/other lang) interfacing the Python/C API can "release the GIL". In which case the operation that doesn't need to use the python interpreter can fully use whatever OS allows it to.
-   `asyncio` module
    -   Things similar to `threading`
    -   Similar to threading module, if the operation itself(eg. I/O) operation doesn't need the python interpreter that may go ahead and use what the OS allows it to
        -   Eg. [if the app that](https://www.reddit.com/r/learnpython/comments/173j3al/async_io_with_multiple_threading/) pulls data from about 200 web api's simultaneously using asyncio. While the python code is single threaded, the OS schedules the network driver code across all of the CPUs.


### When using threading, do I need to use a worker pool/threading pool? {#when-using-threading-do-i-need-to-use-a-worker-pool-threading-pool}

-   The pool is an object that will start, hold and manage x threads transparently for you.


### WTF GIL? {#wtf-gil}

-   Read this: [What Is the Python GIL and Will They Get Rid of It?](https://www.backblaze.com/blog/the-python-gil-past-present-and-future/)

> The GIL is a lock held by the python interpreter process whenever bytecode is being executed unless it is explicitly released. I.e. the design of the cpython interpreter is to assume that whatever that occurs in the cpython process between bytecodes is dangerous and not thread-safe unless told otherwise by the programmer. This means that the lock is enabled by default and that it is periodically released as opposed to the paradigm often seen in many multi-threaded programs where locks are generally not held except when specifically required in so-called "critical sections" (parts of code which are not thread-safe).

-   It can be considered as a mutex on the running python interpreter. It controls access to the python interpreter.
-   It's a thing about `CPython`, if you use a different python interpreter(eg.Jython/IronPython). It [also exists](https://doc.pypy.org/en/latest/faq.html#does-pypy-have-a-gil-why) with `PyPY` interpreter.
    -   Multi-threading in cpython "time shares" the interpreter


#### Pros and Cons {#pros-and-cons}

<!--list-separator-->

-  Pros

    -   Provides useful safety guarantees for internal object and interpreter state.
    -   Allows only a `single OS thread` to run the central `Python bytecode interpreter loop`
        -   In cases(other languages) where there's no GIL, programmer would need to implement fine grained locks to prevent one thread from stomping on the state set by another thread
        -   When there's the GIL in place, this extra work from the programmer is not needed
            -   If `T1` is using the interpreter
            -   `T2` cannot access the interpreter and hence cannot access/mutate any shared state
    -   Helps avoid deadlocks and other complications

<!--list-separator-->

-  Cons

    -   Restricts `parallel processing (CPU bound)` of only pure python code.
    -   GIL is a blocker for you if you want to do CPU bound work with the python interpreter. i.e Till the python code that does the CPU bound task is finished the thread will keep holding the lock(unless there's a timeout etc.)
    -   [see this thread for more info](https://discuss.python.org/t/running-a-process-inside-multithreading-while-multithreading-is-uses-100-of-cpu-resources/15204/2)


#### GIL FAQ {#gil-faq}

<!--list-separator-->

-  How does the GIL float around?

<!--list-separator-->

-  What does "releasing the GIL" mean? OR Why is the `threading` module even useful?

    ![](/ox-hugo/20230824010507-python_concurrency-657643381.png)
    ![](/ox-hugo/20230824010507-python_concurrency-31183502.png)
    ![](/ox-hugo/20230824010507-python_concurrency-2048490006.png)

    -   "Release and Acquire the GIL" has to do with `some operation` that no longer needs the python interpreter its operation(eg. syscall) may release the GIL so that anything else which needs the python interpreter may use it.
        -   Now the operation itself can use as may cores or whatever the OS allows it to do
        -   But the python interpreter is still running there on a single core, one OS thread thing. Which keeps on going like that. But its not as bad as it sounds, because we can do a lot of things by the "release &amp; acquire GIL" thing
    -   Things that "release the GIL"
        -   Every Python standard library function that makes a syscall releases the GIL.
        -   This includes all functions that perform disk I/O, network I/O, and time.sleep().
            -   Eg. You can spin a thread that does network I/O. It'll automatically release the GIL and main thread can go on do its thing.
        -   CPU-intensive functions in the NumPy/SciPy libraries
        -   compressing/decompressing functions from the zlib and bz2 modules, also release the GIL
        -   Eg. you could freely write a multithreaded prime number search program in Rust, and use it from Python
            -   Check `Py_BEGIN_ALLOW_THREADS`


## Approaches {#approaches}

See [this thread](https://www.reddit.com/r/Python/comments/wbdtim/how_to_choose_the_right_python_concurrency_api/?share_id=6R86EWPDdti6zPFT6EebK)
![](/ox-hugo/20230824010507-python_concurrency-414654377.png)

| Name               | GIL            | Remark                                                                                            | Type            |
|--------------------|----------------|---------------------------------------------------------------------------------------------------|-----------------|
| asyncio            | doesn't matter | More efficient than threads for certain kind of I/O ops                                           | coroutine-based |
| threading          | full matters   | Useful most times when not doing python-only CPU bound tasks                                      | thread-based    |
| multiprocessing    | doesn't matter | Useful if doing python-only CPU bound tasks                                                       | process-based   |
| subprocess         | doesn't matter | similar to multiprocessing [but diffelant](https://youtu.be/aSPqIH7I-As?si=EXNzeBbW578vh73d&t=83) |                 |
| concurrent.futures | mixed          | wrapper around threading and processing                                                           | mixed           |
| vectorization      | -              | specialized                                                                                       |                 |


### Asyncio {#asyncio}

> -   There's a lot of [criticism around](https://charlesleifer.com/blog/asyncio/) asyncio. Must use with caution.
> -   The criticism is specifically around asyncio module not asynchronous programming using coroutines in general
> -   Some people suggest alternative libraries like gevent offer a better api etc. Again, need to do my own research.


#### How it runs {#how-it-runs}

-   asyncio runs in a single thread(the event queue runs in only a single thread). It only uses the main thread.
    -   Concurrency is achieved through cooperative multitasking by using Python generators
    -   See [Coroutines]({{< relref "20230516192836-coroutines.md" >}}) (See the blocking and non-blocking section)


#### AsyncIO and CPU bound tasks {#asyncio-and-cpu-bound-tasks}

-   asyncio is useful when you're doing practically zero processing on your data.
    -   Designed for when there is some external process triggering events - like a user interactive with a UI, or incoming web requests.
-   AsyncIO helps with I/O bound things, for CPU bound things we still would need to resort to multiprocessing or similar things.
-   If what's being run by `asyncio` is pure-python cpu-bound, and if we don't pause it manually, other stuff to be run by the loop will be waiting. Eg. If the web-request takes 2 second cpu-time, then even if its using `asyncio` it'll be waiting and ultimately the server will be slow as entire event loop runs in a single thread. This is not a problem when the operations are not CPU bound.


#### Comparisons {#comparisons}

{{< figure src="/ox-hugo/20230824010507-python_concurrency-1602508317.png" >}}

<!--list-separator-->

-  AsyncIO vs Threads

    -   It eliminating the downside of thread overload and allowing for considerably more connections to run at the same time. (Even though a lot of threads is not really a problem (in most cases))
    -   When you use `threads`, you would have 50 threads spawned, each waiting on read() for a socket
        -   But with `asyncio` you can then have an arbitrarily huge number of sockets open while not having to build up an OS-level thread for each
        -   This saves us a lot of resources that threads may consume, such as memory, spawn time, context-switching, (GIL release, acquire time) etc.
    -   The race between threads and asyncio then becomes who can context-switch more efficiently.
        -   The efficiency in being able to context switch between different IO-bound tasks, which are not impacted by the GIL in any case.

<!--list-separator-->

-  AsyncIO vs concurrent.futures

    -   `concurrent.futures` pre-dates `asyncio`
    -   What `concurrent.futures` is to threads and processes is what `asyncio.future` is to asyncio
    -   You can run asyncio tasks in a `concurrent.futures.Executor`


#### Asyncio alternatives {#asyncio-alternatives}

-   We have the python provided event loop, that's asyncio
    -   [How Python Asyncio Works: Recreating it from Scratch](https://jacobpadilla.com/articles/recreating-asyncio)
-   crio
-   trio
-   gevent
    -   gevent transforms all the blocking calls in your application into non-blocking calls that yield control back to the event loop
    -   [What the heck is gevent? (Part 1 of 4) | by Roy Williams | Lyft Engineering](https://eng.lyft.com/what-the-heck-is-gevent-4e87db98a8)
    -   [Asyncio, twisted, tornado, gevent walk into a bar | Hacker News](https://news.ycombinator.com/item?id=37226360)


#### Usage {#usage}

without asyncio

```python
import time
def sleepy_function():
    print("Before sleeping.")
    time.sleep(1)
    print("After sleeping.")
def main():
    for _ in range(3):
        sleepy_function()
main()
```

with asyncio

```python
import asyncio
async def sleepy_function():
    print("Before sleeping.")
    await asyncio.sleep(1)
    print("After sleeping.")
async def main():
    await asyncio.gather(*[sleepy_function() for _ in range(3)])
asyncio.run(main())
```

-   As can be seen in the above example, to use asyncio we had to [transform/color](https://journal.stuffwithstuff.com/2015/02/01/what-color-is-your-function/) almost the entirety of the program
    -   When you use `asyncio` module every function that `await` for something should be defined as async
    -   Any synchronous call within your async functions will block the event loop
    -   Code that runs in the asyncio event loop must not block - all blocking calls must be replaced with non-blocking versions that yield control to the event loop. So you have to find alternative libraries in cases if the library at use is blocking.
        -   i.e libraries like psycopg2, requests will not work directly
        -   You can however use `BaseEventLoop.run_in_executor` to run blocking libraries with asyncio. There's also `to_thread`
    -   See [Coroutines]({{< relref "20230516192836-coroutines.md" >}}) for more info on this

<!--list-separator-->

-  Main ideas

    -   Coroutine is defined using the keyword `async`
    -   Just calling the coroutine will not work
        -   We need to use asyncio to run it: `asyncio.run`
        -   `asyncio.run` is the event loop.
    -   `await` keyword signals asyncio that we want to wait for some event, and that it can execute other stuff
        -   We can use `await` for an `Awaitable`.
        -   `coroutines~(functions with ~async` keyword), `task` and `futures` are examples of `Awaitable`
    -   `task` are created with `asyncio.create_task`
        -   We can think of `task` as a coroutine that executes in the background. Helps make things faster.
        -   Instead of using `create_task` + `await` combo, we can simply use `TaskGroup` for more ez API.
            -   `TaskGroup` also helps with error handling.

<!--list-separator-->

-  Plain coroutines vs coroutine+create_task

    ```python
    # takes 3s
    async def say_after(delay, what):
        await asyncio.sleep(delay)
        print(what)

    async def main():
        print(f"started at {time.strftime('%X')}")

        await say_after(1, 'hello')
        await say_after(2, 'world')

        print(f"finished at {time.strftime('%X')}")

    asyncio.run(main())
    ```

    vs

    ```python
    # takes 1s
    async def main():
        task1 = asyncio.create_task(
            say_after(1, 'hello'))

        task2 = asyncio.create_task(
            say_after(2, 'world'))

        print(f"started at {time.strftime('%X')}")

        # Wait until both tasks are completed (should take
        # around 2 seconds.)
        await task1
        await task2

        print(f"finished at {time.strftime('%X')}")
    ```

    -   The second example here is 1s faster because the `tasks` are executed in background, while in the first example we `await` till the completion of the coroutine.


#### Example {#example}

-   "Writes to [sqlite]({{< relref "20230702184501-sqlite.md" >}}) are then sent to that thread via a queue, using an open source library called Janus which provides a queue that can bridge the gap between the asyncio and threaded Python worlds."
-   <https://github.com/aio-libs/janus>


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
-   State sharing etc becomes harder because its different processes


### concurrent.futures {#concurrent-dot-futures}

-   This is more like wrappers around threads and multiprocess support in python.
-   The ergonomics seems to be better than using threads and multiprocessing directly


#### components {#components}

{{< figure src="/ox-hugo/20230824010507-python_concurrency-893739706.png" >}}

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


#### ThreadPoolExecutor {#threadpoolexecutor}

<!--list-separator-->

-  Error handling

    ```python
    # TODO: Issue is this is only ever being run after all of the fetches which
    #       is sequential, we need a thread safe variable to indicate failure to the
    #       main thread now
    # NOTE: We want to fail the entire fetch pipeline if we get any exception,
    #       this is done because of the nature of the data, half of the data is
    #       not useful to us
    # TODO: In the ideal case, len(done) will be 1, but if in any case, wait
    #       itself is called after the fist exception len(done) will not be 1
    done, _ = futures.wait(worker_updates, return_when=futures.FIRST_EXCEPTION)
    if len(done) == 1:
        maybe_exception = done.pop()
        if maybe_exception.exception():
            # shutdown pool and can all futures
            # NOTE: We don't need to separately use cancel() here
            executor.shutdown(wait=True, cancel_futures=True)
            # NOTE: Cancelling non-running jobs is enough for our usecase,
            #       running workers will run till completion or not. we don't
            #       have to use threading.Event to write custom logic to stop
            #       already running jobs when this exception occurs based on how
            #       our jobs tables are structured.
            # NOTE: We could however do it just so that we don't un-nessarily
            #       push to s3 but it'll need our code to handle a threadsafe
            #       event variable now and do not want to do that atm

            # re-raise exception so that whatever's executing the process is
            # notified of it. For some reason calling result() was not raisnig
            # the error as expected
            raise maybe_exception.exception()
    ```

<!--list-separator-->

-  Resources

    -   [6 Usage Patterns for the ThreadPoolExecutor in Python - Super Fast Python](https://superfastpython.com/threadpoolexecutor-usage-patterns/)
    -   [4 ThreadPoolExecutor Common Errors in Python - Super Fast Python](https://superfastpython.com/threadpoolexecutor-common-errors/)
    -   [How to Handle Exceptions With the ThreadPoolExecutor in Python - Super Fast Python](https://superfastpython.com/threadpoolexecutor-exception-handling/)
    -   [How to Stop All Tasks if One Task Fails in the ThreadPoolExecutor in Python - Super Fast Python](https://superfastpython.com/threadpoolexecutor-stop-if-task-fails/)
    -   [How to Shutdown the ThreadPoolExecutor in Python - Super Fast Python](https://superfastpython.com/threadpoolexecutor-shutdown/)
    -   [How to Cancel Tasks with the ThreadPoolExecutor in Python - Super Fast Python](https://superfastpython.com/threadpoolexecutor-cancel-task/)


### queue {#queue}


### Vectorization {#vectorization}

-   See [The limits of Python vectorization as a performance technique](https://pythonspeed.com/articles/vectorization-python-alternatives/)
-   [SIMD in Pure Python | Blog](https://www.da.vidbuchanan.co.uk/blog/python-swar.html)
    -   [From slow to SIMD: A Go optimization story](https://sourcegraph.com/blog/slow-to-simd)
-   In order for vectorization to work, you need low-level machine code both driving the loop over your data, and running the actual operation. Switching back to Python loops and functionality loses that speed.


## Reading links {#reading-links}

-   [500 Lines or LessA Web Crawler With asyncio Coroutines](https://aosabook.org/en/500L/a-web-crawler-with-asyncio-coroutines.html)
