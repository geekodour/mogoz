+++
title = "Multiprocessing"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Computer Architecture]({{< relref "20221101201615-computer_architecture.md" >}}), [Operating Systems]({{< relref "20221101172456-operating_systems.md" >}}), [Concurrency]({{< relref "20221126204257-concurrency.md" >}})


## vCPUs {#vcpus}

You always have at least one core, one die and one package.

| Name    | What                                                                                               |
|---------|----------------------------------------------------------------------------------------------------|
| Package | What you get when you buy a single processor. Contains one or more dies.                           |
| Die     | Actual silicon. A die can contain any number of cores                                              |
| Socket  | The physical connector linking the processor to the computer’s motherboard. There can be multiple. |
| Core    | Independent execution unit that can run one program thread at a time in parallel with other cores. |
| vCPU    | vCPUs are compute threads that process execution for running os/vm.                                |


### vCPU calculation {#vcpu-calculation}

-   `(# Sockets)` \* `(# Cores)` = `(# pCPU)` (Physical CPU)
-   `(# pCPU)` \* `(2 Threads)` = `(# vCPU)` (Virtual CPU)

<!--listend-->

```text
Thread(s) per core:  2
Core(s) per socket:  4
Socket(s):           1
On-line CPU(s) list:   0-7 (8)

pCPU = 1 * 4 = 4
vCPU = 4*2 = 8
```

<div class="book-hint warning small-text">

> **VMs and Hypervisors**
>
> Now the term vCPU is widely used in hypervisors etc. In those cases, most hypervisors will let you overprovision cores. That means, you could assign 1 vCPU per VM, but the hypervisors also allow you overcommit every vcpu if you think your workload could handle that.
</div>


## Glossary {#glossary}

-   Uniprocessor
    -   single core machine
    -   SISD
-   Multiprocessing
    -   Use of two or more central processing units (CPUs) within a single computer system.
    -   Vector processors (SIMD): Modern processors have SSE/[MMX](https://en.wikipedia.org/wiki/MMX_(instruction_set)) that do limited SIMD.
    -   Stream Processor (MIMD) (Normal multiprocessor/multi-cores)
-   Chipset
    -   Thing that's in the motherboard that manages the data flow between the processor, memory and peripherals. i.e I/O Bridge.
-   Parallelism
    -   instruction-level parallelism (ILP)
    -   thread-level parallelism (TLP) method
    -   [Massively parallel - Wikipedia](https://en.wikipedia.org/wiki/Massively_parallel)
    -   [Embarrassingly parallel - Wikipedia](https://en.wikipedia.org/wiki/Embarrassingly_parallel)
-   [Simultaneous multithreading - Wikipedia](https://en.wikipedia.org/wiki/Simultaneous_multithreading)
-   [Multithreading (computer architecture) - Wikipedia](https://en.wikipedia.org/wiki/Multithreading_(computer_architecture))
-   [Hyper-threading - Wikipedia](https://en.wikipedia.org/wiki/Hyper-threading#History)
-   [Clock rate - Wikipedia](https://en.wikipedia.org/wiki/Clock_rate)
-   Also see
    -   [System on module - Wikipedia](https://en.wikipedia.org/wiki/System_on_module)
    -   [System on a chip - Wikipedia](https://en.wikipedia.org/wiki/System_on_a_chip)
    -   [Advanced Vector Extensions - Wikipedia](https://en.wikipedia.org/wiki/Advanced_Vector_Extensions)
    -   [uops.info](https://uops.info/)
