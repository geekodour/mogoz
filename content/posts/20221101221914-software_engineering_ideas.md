+++
title = "Software Engineering Ideas"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [General Programming]({{< relref "20230122140847-general_programming.md" >}})

> Some general development ideas/words/jargons that i come across. Most of them are just me reading its wikipedia page and writing whatever i understood here.


## Unread {#unread}

-   [Dynamic Scoping](https://wiki.c2.com/?DynamicScoping)
-   [Rusty's API Design Manifesto](http://sweng.the-davies.net/Home/rustys-api-design-manifesto)
-   <https://wiki.c2.com/?LongFunctionsDiscussion>
-   [John Carmack on Inlined Code](http://number-none.com/blow/blog/programming/2014/09/26/carmack-on-inlined-code.html)
-   [Some Property Testing Tricks](https://throughascreendarkly.com/2020/09/01/some-property-testing-tricks/)


## Databases {#databases}

-   [Water mark](https://en.wikipedia.org/wiki/Watermark_(data_file)) : a method for ensuring data integrity.
-   [Tombstone](https://en.wikipedia.org/wiki/Tombstone_(data_store)): A tombstone is a deleted record in a replica of a distributed data store.


## Memory {#memory}

-   [Thread-local storage(TLS)](https://en.wikipedia.org/wiki/Thread-local_storage) : It's just storage specific to the running thread, many threads can have a variable called `a`; `a` is local to each thread. One usage can be multiple threads accumulating information into a global variable with some kind of sync ofc.
-   [Rotational Latency](https://en.wikipedia.org/wiki/Hard_disk_drive_performance_characteristics#Rotational_latency): Time waiting for the first bit of target sector to pass under `r/w head`. Delay waiting for the rotation of the disk to bring the required(eg. requested by cpu) disk sector under the `r/w head` is the **Seek time**.
-   [Stride of an array](https://en.wikipedia.org/wiki/Stride_of_an_array) : The stride determines the distance between two elements, which will be greater than or equal to the `size` of the element. Sometimes sequential access is also called `stride-1 pattern=/=stride-unit pattern`.

{{< figure src="/ox-hugo/stride-padding.png" >}}

```text
[a,b,c,d] // say elements are `int64`; here stride is 4bytes if there is no padding.
[a,b,c,d] // say elements are some `struct`; here stride is size of the structs; having padding will change the stride.
```

-   [Scratchpad memory](https://en.wikipedia.org/wiki/Scratchpad_memory) : Not very popular apparently, something like L1 cache ig.


## Programming {#programming}

-   [Re-entrancy](https://en.wikipedia.org/wiki/Reentrancy_(computing)): Subroutine is called reentrant if multiple invocations can safely run concurrently, i.e execution and then safely be called again/re-enter before its previous invocations complete execution.
-   [Loop Unrolling](https://en.wikipedia.org/wiki/Loop_unrolling): Technique that attempts to optimize a program's execution speed at the expense of its binary size. It increase a program's speed by reducing or eliminating instructions that control the loop. [Duff's device](https://stackoverflow.com/questions/514118/how-does-duffs-device-work) is a way of manually implementing loop unrolling.


## Software Architecture {#software-architecture}

-   C4 : <https://c4model.com/>
-   [Active record pattern](https://en.wikipedia.org/wiki/Active_record_pattern) : The RoR ActiveRecords are implementation of this pattern! Martin Flower coined this.
-   <https://en.wikipedia.org/wiki/Design_by_contract>
-   <https://edmz.org/personal/2021/05/27/small_things_that_make_apis_a_little_bit_better.html>
