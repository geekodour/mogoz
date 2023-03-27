+++
title = "Memory Allocation"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Computer Memory]({{< relref "20221101203327-computer_memory.md" >}}), [Garbage collection]({{< relref "20221101213015-garbage_collection.md" >}})


## writing malloc {#writing-malloc}

-   [Malloc tutorial](https://danluu.com/malloc-tutorial/)
-   [CS170: Lab 0 - MyMalloc()](https://sites.cs.ucsb.edu/~rich/class/cs170/labs/lab1.malloc/)
-   [Memory Allocators 101 - Write a simple memory allocator - Arjun Sreedharan](https://arjunsreedharan.org/post/148675821737/memory-allocators-101-write-a-simple-memory)
-   <http://www.cs.cmu.edu/afs/cs/academic/class/15213-f10/www/lectures/17-allocation-basic.pdf>
-   [Understanding the Memory Layout of Linux Executables](https://gist.github.com/geekodour/543d370e9e7816fe368d264374c86cfc)
-   [Syscalls used by malloc.](https://sploitfun.wordpress.com/2015/02/11/syscalls-used-by-malloc/)
-   [Understanding glibc malloc – sploitF-U-N](https://sploitfun.wordpress.com/2015/02/10/understanding-glibc-malloc/)
-   [Jane Street Tech Blog - Memory allocator showdown](https://blog.janestreet.com/memory-allocator-showdown/)
-   [GitHub - rain-1/awesome-allocators: Awesome links and information about memory allocation](https://github.com/rain-1/awesome-allocators)
-   [Understanding glibc malloc – sploitF-U-N](https://sploitfun.wordpress.com/2015/02/10/understanding-glibc-malloc/)

Nowadays, the heap, where malloc() goes, is backed by mmap() calls which obtain chunks of memory at whatever address the kernel sees fit.
