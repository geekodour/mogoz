+++
title = "Multiprocessing"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Computer Architecture]({{< relref "20221101201615-computer_architecture.md" >}}), [Operating Systems]({{< relref "20221101172456-operating_systems.md" >}}), [Concurrency]({{< relref "20221126204257-concurrency.md" >}})


## VAS for different architectures {#vas-for-different-architectures}

{{< figure src="/ox-hugo/20221101202303-multiprocessing-1361409453.png" >}}

-   `32/64/48` address space, each bit can be `1` or `0`, hence \\(2^{no. of address bits}\\). See [Permutations &amp; Combinations]({{< relref "20230513203749-permutations_combinations.md" >}}).
-   IA-32/x86_32/x86/i386
    -   \\(2^{32}\\) ~= 4GB (32 bit address size)
    -   [32 bit machines can still support more ram.(PAE)](https://en.wikipedia.org/wiki/Physical_Address_Extension)
-   x86_64/amd64
    -   \\(2^{64}\\) ~= 18EB (64 bit addresses)
    -   \\(2^{48}^{}\\) ~= 16EB (48 bit addresses)
    -   For our use tho, we get only 128TB. Which is not "only" tbf.
    -   [Why do x86-64 systems have only a 48 bit virtual address space?](https://stackoverflow.com/questions/6716946/why-do-x86-64-systems-have-only-a-48-bit-virtual-address-space)
    -   <https://www.kernel.org/doc/Documentation/x86/x86_64/mm.txt>


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


## x86 Microarchitecture levels (march) {#x86-microarchitecture-levels--march}

-   See [x86-64 - Wikipedia](https://en.wikipedia.org/wiki/X86-64#Microarchitecture_levels)
-   See [x86 Options (Using the GNU Compiler Collection (GCC))](https://gcc.gnu.org/onlinedocs/gcc/x86-Options.html)
-   See [x86-64 Microarchitecture Feature Levels](https://www.phoronix.com/news/GCC-11-x86-64-Feature-Levels)
-   [uops.info](https://uops.info/)
-   We can tell compilers about available instruction-set to optimize for using `march` flag
-   These features have to be supported by the CPU in the first place. You can search for your CPU at [CPU-World](https://www.cpu-world.com) and see supported features.
-   Enabled features can be found at `cat /proc/cpuinfo`
-   You can check supported levels with `/lib/ld-linux-x86-64.so.2 --help`
    ```shell
      x86-64-v4
      x86-64-v3 (supported, searched)
      x86-64-v2 (supported, searched)
    ```
-   The v2-v4 levels are arbitrary names defined by grouping different instruction sets based on their age and usefulness.

{{< figure src="/ox-hugo/20221101202303-multiprocessing-1641806259.png" >}}


### x86-64-baseline {#x86-64-baseline}

-   CMOV, CMPXCHG8B, FPU, FXSR, MMX, FXSR, SCE, SSE, SSE2


### x86-64-v2 {#x86-64-v2}

-   CMPXCHG16B, LAHF-SAHF, POPCNT, SSE3, SSE4.1, SSE4.2, SSSE3
-   close to Nehalem
-   Basically mandatory for modern OS


### x86-64-v3 {#x86-64-v3}

-   AVX, AVX2, BMI1, BMI2, F16C, FMA, LZCNT, MOVBE, XSAVE
-   close to Haswell
-   Nice to haves


### x86-64-v4 {#x86-64-v4}

-   AVX512F, AVX512BW, AVX512CD, AVX512DQ, AVX512VL
-   Cutting edge enterprise feature sets


## Word {#word}

-   See wordsize w `$ getconf WORD_BIT` and `LONG_BIT` (`32` on my computer)
-   WORD (16 bits/2 bytes)
-   DWORD (32 bits/4 bytes)
-   QWORD (64 bits/8 bytes)


## Registers {#registers}

{{< figure src="/ox-hugo/20221101202303-multiprocessing-1403386611.png" >}}


## Glossary {#glossary}


### Chipset {#chipset}

-   Thing that's in the motherboard that manages the data flow between the processor, memory and peripherals. i.e I/O Bridge.


### Others {#others}

-   [Clock rate - Wikipedia](https://en.wikipedia.org/wiki/Clock_rate)
-   Also see
    -   [System on module - Wikipedia](https://en.wikipedia.org/wiki/System_on_module)
    -   [System on a chip - Wikipedia](https://en.wikipedia.org/wiki/System_on_a_chip)
