+++
title = "Python Concurrency"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Python]({{< relref "20221231140207-python.md" >}}), [Concurrency]({{< relref "20221126204257-concurrency.md" >}}), [Multiprocessing]({{< relref "20221101202303-multiprocessing.md" >}})


## Asyncio {#asyncio}

-   Writes to [sqlite]({{< relref "20230702184501-sqlite.md" >}}) are then sent to that thread via a queue, using an open source library called Janus which provides a queue that can bridge the gap between the asyncio and threaded Python worlds.


## Reading links {#reading-links}

-   [500 Lines or LessA Web Crawler With asyncio Coroutines](https://aosabook.org/en/500L/a-web-crawler-with-asyncio-coroutines.html)
-   [The easy way to concurrency and parallelism with Python stdlib](https://www.bitecode.dev/p/the-easy-way-to-concurrency-and-parallelism)
-   [charles leifer | AsyncIO](https://charlesleifer.com/blog/asyncio/)
-   [What the heck is gevent? (Part 1 of 4) | by Roy Williams | Lyft Engineering](https://eng.lyft.com/what-the-heck-is-gevent-4e87db98a8)
-   [Asyncio, twisted, tornado, gevent walk into a bar | Hacker News](https://news.ycombinator.com/item?id=37226360) | [Asyncio, twisted, tornado, gevent walk into a bar | Lobsters](https://lobste.rs/s/lfkxmg/asyncio_twisted_tornado_gevent_walk_into)
