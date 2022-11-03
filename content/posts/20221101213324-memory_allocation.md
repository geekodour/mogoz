+++
title = "Memory Allocation"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Computer Memory]({{< relref "20221101203327-computer_memory.md" >}})


## writing malloc {#writing-malloc}

-   <https://danluu.com/malloc-tutorial/>
-   <https://sites.cs.ucsb.edu/~rich/class/cs170/labs/lab1.malloc/>
-   <https://arjunsreedharan.org/post/148675821737/memory-allocators-101-write-a-simple-memory>
-   <http://www.cs.cmu.edu/afs/cs/academic/class/15213-f10/www/lectures/17-allocation-basic.pdf>
-   [Understanding the Memory Layout of Linux Executables](https://gist.github.com/geekodour/543d370e9e7816fe368d264374c86cfc)
-   [Syscalls used by malloc.](https://sploitfun.wordpress.com/2015/02/11/syscalls-used-by-malloc/)
-   <https://sploitfun.wordpress.com/2015/02/10/understanding-glibc-malloc/>
-   <https://blog.janestreet.com/memory-allocator-showdown/>
-   <https://github.com/rain-1/awesome-allocators>

Nowadays, the heap, where malloc() goes, is backed by mmap() calls which obtain chunks of memory at whatever address the kernel sees fit.
