+++
title = "Memory Hierarchy"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Computer Memory]({{< relref "20221101203327-computer_memory.md" >}}), [Memory Design]({{< relref "20221101202144-memory_design.md" >}})

{{< figure src="/ox-hugo/memloc.png" >}}

Two types, volatile and non-volatile. This document mostly contains info about **semiconductor memory**, but non-volatile memory which are not based on solid-state IC technology are also out there. Such as:

-   **CD-ROM** which is read-only (analogous to masked ROM).
-   **CD-R** is Write Once Read Many (analogous to PROM)
-   **CD-RW** supports erase-rewrite cycles (analogous to EEPROM)


## Non Volatile {#non-volatile}

These are used to store firmware programs(BIOS, network card firmware, I/O device controllers which can store instructions and data etc.), SSDs.


### ROM {#rom}

-   read-only memory / We're mostly talking about Mask ROM here.
-   Mask ROM, the contents are programmed by the ic manufacturer and almost impossible to change.
-   The one-time masking cost is high and there is a long turn-around time from design to product phase.


### PROM {#prom}

-   programmable read-only memory
-   FPGA sprouted out from here.


### EPROM {#eprom}

-   Erasable programmable read-only memory
-   Need to be completely erased before being rewritten.


### EEPROM {#eeprom}

-   Electrically erasable programmable read-only memory
-   Can be erased, written and read in blocks (or pages) which are generally much smaller than the entire device.
-   Flash Memory was invented based on EEPROM in 1980.


### NVRAM {#nvram}

-   Non-volatile random-access memory (NVRAM) is random-access memory that retains data without applied power.


## Volatile {#volatile}

These are basically `RAMs`;

-   Traditionally packaged as a `chip` or sometimes embedded as part of processor chip
-   Basic storage unit is normally a `cell` (one bit per cell).
-   Multiple RAM `chips` form a memory.


### DRAM {#dram}

Dynamic random-access memory (DRAM) is a type of random access semiconductor memory that stores each bit of data in a memory cell consisting of a tiny capacitor and a transistor, both typically based on metal-oxide-semiconductor (MOS) technology.


#### SDRAM {#sdram}

Synchronous dynamic random-access memory (SDRAM) is any dynamic random-access memory (DRAM) where the operation of its external pin interface is coordinated by an externally supplied clock signal.


#### DDR {#ddr}

Double Data Rate SDRAM. It has `DDR{1...4}`


#### GDDR {#gddr}

GDDR is a type of SDRAM specifically designed for graphics processing units (GPUs). It has `GDDR{1...6}`


#### HBM {#hbm}

High Bandwidth Memory (HBM) is a high-performance RAM interface for 3D-stacked SDRAM. Is this supposed to be some kind of breakthrough? idk, have to read more on this one.


### SRAM {#sram}

-   The term static differentiates SRAM from DRAM which must be periodically refreshed(some voltage constantly needs to keep hitting the DRAM, otherwise it loses its charge!).
-   SRAM is faster and more expensive than DRAM
-   Requires more transistors than DRAM.
-   It is typically used for **CPU cache** while DRAM is used for a computer's main memory.
-   More about [cache lines](https://www.quora.com/What-is-a-cache-line-actually)


## HDDs {#hdds}

> Data are r/w in units of `sector`

In disks(HDDs), access time is dominated by **seektime** and **rotational latency**, i.e first bit in a sector is expensive, the rest are free.

```text
Taccess = Tavg seek + Tavg rotation + Tavg transfer
Taccess = 9 ms + 4 ms + 0.02 ms // taking average practical numbers.
```

But modern disks give us a more useful/simpler abstraction to the `(cylinder/surface/track/sector)` gemeotry. It presents the disk to the cpu as a sequence of `logical blocks`, where each block is a multiple of a sector size. The mapping between **logical blocks** and **physical sectors** are maintained by firmware device called `disk controller`


### Steps of seeking something from disk {#steps-of-seeking-something-from-disk}

-   CPU initiates **disk read** by sending a (`logical block no.`, `memory address`,=command that disk controller understands=) through `bus interface` -&gt; `I/O bridge` -&gt; `I/O bus` -&gt; `disk controller`
-   `disk controller` executes the command and uses `DMA` to send that data over to memory.
-   Once the transfer is done `disk controller` sends an [interrupt](/docs/notes/study/os/interrupts) informing that transfer was done.


## SSDs {#ssds}

> Data are r/w in units of `page`

-   SSDs have something called the `flash translation layer` which serves the same purpose as the `disk controller` in HDDs.
-   Instead of `(surface/track/sector)`, SSDs use `blocks/pages=(=pages` live inside `blocks`); these are different from the virtual memory pages and the `logical blocks` abstraction idea mentioned above.
-   Interestingly `pages` can only be written once its `block` has been erased; This makes `writes` in SSDs pretty complicated.
-   We can do small writes on ssds but small writes on SSDs can kill them aswell. So it's good idea to batch things in memory before writing to ssd.

> -   `Seq. access` faster than `random access`.
> -   Random `writes` are slower due to the reason mentioned above. Earlier the `r/w` access gaps were much larger, today we don't need to really worry about it that much. They are almost the same due to optimizations.


## What happened in 2003? {#what-happened-in-2003}

Till 2003, `clock frequency` and `cpu cycle time` basically increased exponentially every 18months; but the `power` you consume is proportional to the `clock frequency`; so you'll need a LOT (800W!!) to keep increasing clock freq, this is when we said _"processor freq. hit the powerwall"_, so manufacturers started putting multiple cores.

{{< figure src="/ox-hugo/2003.png" >}}

> Effective cycle time = cycletime/no. of cores.


## Locality {#locality}

[Programs tend to use](https://en.wikipedia.org/wiki/Locality_of_reference) data and instructions with addresses near or equal to those they have used recently. Two types, Temporal and Spatial. There are various access patterns based on this principle of locality. These not only refer to data but **also to the instructions** that get loaded into the CPU. As software developers we should have a good qualitative sense of locality; determine if a piece of code has good locality.

> [Caches work because](http://www.pixelbeat.org/programming/profiling/) of the idea of memory hierarchy [and locality.](https://www2.cs.duke.edu/courses/cps104/spring11/lects/19-cache-sw2.pdf)

{{< figure src="/ox-hugo/locality.png" >}}

```C
// This has BAD spatial locality!
// c stores arrays in row major order.
static char array[800][1000];

int main (void)
{
  int i, j;
  for (j = 0; j < 1000; j++)
    for (i = 0; i < 800; i++)
       array[i][j]++;
       // for NxN arrays, just swapping the indexes do the same thing
       // as changing the order of the `for` loops.
  return 0;
}
```

```C
// This has GOOD spatial locality!
static char array[800][1000];

int main (void)
{
  int i, j;
  for (i = 0; i < 800; i++)
    for (j = 0; j < 1000; j++)
       array[i][j]++;
  return 0;
}
```

**Output:**

```text
// for the bad locality
λ perf stat --repeat 100 -e cycles:u -e instructions:u -e L1-dcache-loads:u  -e L1-dcache-load-misses:u ./a.out

 Performance counter stats for './a.out' (100 runs):

         7,295,033      cycles:u                                                      ( +-  0.25% )
        18,529,344      instructions:u            #    2.54  insn per cycle           ( +-  0.00% )
         5,632,207      L1-dcache-loads                                               ( +-  0.00% )
           833,339      L1-dcache-load-misses     #   14.80% of all L1-dcache hits    ( +-  0.58% )

          0.003322 +- 0.000167 seconds time elapsed  ( +-  5.03% )
```

```text
// for the good locality
λ perf stat --repeat 100 -e cycles:u -e instructions:u -e L1-dcache-loads:u  -e L1-dcache-load-misses:u ./a.out

 Performance counter stats for './a.out' (100 runs):

         6,682,657      cycles:u                                                      ( +-  0.14% )
        18,527,945      instructions:u            #    2.77  insn per cycle           ( +-  0.00% )
         5,631,837      L1-dcache-loads                                               ( +-  0.00% )
             2,300      L1-dcache-load-misses     #    0.04% of all L1-dcache hits    ( +-  1.06% )

          0.003421 +- 0.000215 seconds time elapsed  ( +-  6.30% )
```


## Links {#links}

-   <https://www.brendangregg.com/blog/2021-05-09/poor-disk-performance.html>
