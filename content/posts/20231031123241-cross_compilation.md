+++
title = "Cross Compilation"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Linkers, Loaders and Libraries]({{< relref "20221101173858-linkers_loaders_and_libraries.md" >}}), [WebAssembly]({{< relref "20230510200213-webassembly.md" >}}), [Golang]({{< relref "20221101220915-golang.md" >}}), [Systems]({{< relref "20221101150250-systems.md" >}}), [syscalls]({{< relref "20230330194208-syscalls.md" >}})


## General cross compilation ideas {#general-cross-compilation-ideas}

-   Cross compiler: Compiler capable of creating executable code for a platform other than the one on which the compiler is running on.
-   Levels (can be one or many)
    -   Architecture: MIPS/x86/arm
    -   Vendors: Mostly `unknown`
    -   OS/Platform: FreeBSD/Linux
    -   ABI: msul libc/glibc
-   The levels are usually just `3`, called the `platform target triple`, the ABI is sometimes added.
-   `sysroot`: Directory which is considered to be the root directory for the purpose of locating headers and libraries.
-   `toolchain`: The set of compiler, linker, shared libs, any tools needed to produce the executable for the target.


## Cross Compilation in Python {#cross-compilation-in-python}

-   See [Python]({{< relref "20221231140207-python.md" >}})
-   CPython interpreter you run when you type python3 is for a specific `platform target triple`
-   PEP11 mentions the [different support tiers](https://peps.python.org/pep-0011/#support-tiers)
