+++
title = "Multiprocessing"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Computer Architecture]({{< relref "20221101201615-computer_architecture.md" >}}), [Operating Systems]({{< relref "20221101172456-operating_systems.md" >}})

Multiprocessing is the use of two or more central processing units (CPUs) within a single computer system. Everyone gets that, I am always confused by the terminologies around multiple CPUs. So here are some common terms, some terms are outside the scope of multiprocessing but will put them here anyway:

First thing to understand is that there is a difference between a physical CPU and a logical CPU.

Physical Socket: CPU socket or CPU slot contains one or more mechanical components providing mechanical and electrical connections between a microprocessor and a printed circuit board (PCB) Logical Socket:

-   CPU
-   Processor
-   Uniprocessor (single core machine) (SISD) <https://en.wikipedia.org/wiki/Uniprocessor_system>
-   Common example used to be Vector processors (SIMD), Modern processors have SSE/MMX that do limited SIMD.
-   Stream Processor (MIMD)
-   MIMD (Normal multiprocessor/multi-cores)
-   Multiprocessor
-   Microprocessor
-   Microcontroller
-   Package
-   Core
-   Clock rate
-   Chipset <https://en.wikipedia.org/wiki/Chipset> or I/O bridge, think they are the same thing.
-   Overclocking
-   Hyperthreading
-   SMT

<https://en.wikipedia.org/wiki/Simultaneous_multithreading> <https://en.wikipedia.org/wiki/Superscalar_processor> <https://en.wikipedia.org/wiki/Multithreading_(computer_architecture)> <https://en.wikipedia.org/wiki/MMX_(instruction_set)> <https://en.wikipedia.org/wiki/Advanced_Vector_Extensions>

In a low-level microcontroller, the chip might lack protection modes and have no memory management unit (MMU). In these chips, the execution context of an interrupt handler will be essentially the same as the interrupted program, which typically runs on a small stack of fixed size (memory resources have traditionally been extremely scant at the low end).

CPU Topology

Quickpath, AMD uses Infinity fabric,

Threadripper is probably the first mainstream CPU that has a configurable topology, i.e you can switch between UMA and NUMA

This is also related to The Meltdown and Spectre vulnerabilities.

lstopo, lscpu, lscpi command

lscpu shows the logic cpu count

what is ARM vs c86/

<https://en.wikipedia.org/wiki/System_on_module> <https://en.wikipedia.org/wiki/System_on_a_chip>

ARM is a family of reduced instruction set computing (RISC) architectures.

In contrast to multi-core systems, the term multi-CPU refers to multiple physically separate processing-units <https://en.wikipedia.org/wiki/Die_(integrated_circuit)>

Due to SMT and Hyperthreading, lstopo the PU you see inside CPU block is what the os reports as "logical" cores. <https://en.wikipedia.org/wiki/Simultaneous_multithreading>

<https://en.wikipedia.org/wiki/Uniprocessor_system> <https://en.wikipedia.org/wiki/Symmetric_multiprocessing> <https://en.wikipedia.org/wiki/Massively_parallel> <https://en.wikipedia.org/wiki/Embarrassingly_parallel> <https://en.wikipedia.org/wiki/Asymmetric_multiprocessing>

-   <https://kb.iu.edu/d/avfb>

-   <https://superuser.com/questions/324284/what-is-meant-by-the-terms-cpu-core-die-and-package>

-   <https://en.wikipedia.org/wiki/Clock_rate>

-   <https://www.howtogeek.com/177790/why-you-cant-use-cpu-clock-speed-to-compare-computer-performance/>

-   <https://unix.stackexchange.com/questions/88283/so-what-are-logical-cpu-cores-as-opposed-to-physical-cpu-cores>

-   <https://en.wikipedia.org/wiki/Hyper-threading#History>

-   <https://baiweiblog.wordpress.com/2017/10/27/how-many-physical-and-logical-cpu-cores-in-your-computer/>

-   <https://www.howtogeek.com/194756/cpu-basics-multiple-cpus-cores-and-hyper-threading-explained/>

-   <https://www.daniloaz.com/en/differences-between-physical-cpu-vs-logical-cpu-vs-core-vs-thread-vs-socket/>

-   <https://en.wikipedia.org/wiki/CPU_socket>

-   <https://uops.info/>

-   parallelism,

-   instruction-level parallelism (ILP)

-   thread-level parallelism (TLP) method

-   read more on clock rates

<https://news.ycombinator.com/item?id=23446543>
