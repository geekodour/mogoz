+++
title = "Linkers, Loaders and Libraries"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Systems]({{< relref "20221101150250-systems.md" >}})


## C compilation process {#c-compilation-process}

![](/ox-hugo/compiler_driver.png) [credits](https://people.cs.pitt.edu/~xianeizhang/notes/Linking.html)

> Note about GCC
>
> The executable named gcc is just a compiler driver/compiler system that selects the "real" compiler and invokes the other components of gcc when needed. It does many things like [preprocessing(cpp)](https://linux.die.net/man/1/cpp), [compiling(cc1/cc1plus/cc1obj)](https://gcc.gnu.org/legacy-ml/gcc/2003-05/msg00484.html), [assembling(as)](https://linux.die.net/man/1/as) and [linking(ld)](https://linux.die.net/man/1/ld)
>
> -   Quick note about gcc frontends and backends
>     -   You can write your own frontend/backend for gcc
>     -   frontend is machine independent but language specific
>     -   backend is language independent but machine specific
>     -   For example, if you have a C++ front end and a Java front end, you can accept input in C++ and Java. If you have an x86 back end and a MIPS back end, you can produce executables for both x86 and MIPS CPUs.
>     -   The compilers such as cc1/cc1plus are both the frontend and the backends, they are linked into one executable.

```shell
# Preprocessor converts source code into ascii intermediate file.
# Also called the Translation unit
# https://en.wikipedia.org/wiki/Translation_unit_%28programming%29
$ cpp main.c main.i
$ gcc -E main.c -o main.i # same as the previous command

```

```shell
# Compiler converts ascii intermediate file into assembly file.
# In reality you don't call directly cc1, gcc calls cc1 for you.
$ cc1 main.i -o main.s
```

```shell
# Assembler translates assembly file to binary reloc. obj file
$ as -o main.o main.s
```

In the linking phase, we have two [compilation flavours/envs](https://wiki.osdev.org/C_Library) to think about:

-   **Hosted(`-fhosted`)** where the c standard library is available. Usually provided by the OS.
-   **Freestanding(`-ffreestanding`)** where only a few headers are usable that contains only defines and types. This is mostly the case with embedded systems.

> **Aside about CRT (C Runtime)**
>
> In a hosted environment, a program is loaded into memory by a loader which is responsible for setting up the ELF segments etc. once the segments are loaded the [crt0](https://en.wikipedia.org/wiki/Crt0)(`.s=/`.o=) can do its initilization stuff(populate `argv` etc.) and setup the C runtime environment and then call `main=(=libc.so.6:__libc_start_main` then calls out `main`). `main` function is an idea of the c language not relating to assembly language or the linker. `crt0` is like a shim layer between the program loader(eg. `execve`) and your program.
>
> The linker controls the program's entrypoint and in general gcc points the entrypoint to `_start` and [`crt0` defines the content of the `_start`](https://en.wikipedia.org/wiki/Crt0#Example_crt0.s). If the linker cannot not find the `_start` symbol, it'll set the entrypoint to the beginning of the `.text` segment.

<!--quoteend-->

> 🔌 For embedded environment, since there is no loader available the `crt0` has more work to do, such as exception vector setup, initilizing the stack and frame pointers etc. It's also useful to supply your own `_start` when you want to write really tiny programs or programs that do unconventional things.

```shell
# Linker combines other obj, shared obj and generates the exec obj.
# Following commands won't work because how the C standard library is linked.
# run gcc with the -v to see the linker commad that gcc runs
# collect2 is alias for ld.
$ ld -o main main.o
$ ld -e main -dynamic-linker /usr/lib64/ld-linux-x86-64.so.2 main.o -lc
```

```shell
# Loader executes the program
$ ./main
# Also could see the loading with:
$ strace ./main
```


### Assembly Code {#assembly-code}

Human readable code, that has 1:1 analogous to machine instructions. **assembler** is used convert assembly code to relocatable object code.

It is possible to have different syntax for assembly language. Eg. for x86, In original Intel syntax `add eax,[ebx]` will add memory data to a register; whereas this would be written as `addl (%ebx),%eax` in the AT&amp;T syntax, both of them would map to the same machine instruction. The [assembler decides](https://linux.die.net/man/1/as) which syntax to support, it can also support multiple syntax.


### Machine code {#machine-code}

Machine code is code that is directly executable by the computer's physical processor without further translation. Load into memory and go. Languages like C generate machinecode in the end rather than something like bytecode.


### Object Code {#object-code}

-   These are binary files but not necessrily machine code which contain additional metadata that will enable a linker, loader to assemble it with other object code modules into executable machine code or bytecode.
-   **Relocatable object files(`.o`)** and \*shared object files(`.so`)\*(_relocatable object files that can be linked dynamically_) are generated by _compiler_ or _assembler_.
-   **Executable object files(`a.out`, usually no extension)** are generated by _Linker_. These can be directly copied into memory and executed.
-   Can have various formats, `a.out=(historical), =PE`, `Mach-O`, `ELF`. But `ELF` is super common and is a common formot for all the 3 types of object files mentioned.


### Bytecode {#bytecode}

Byte code is code that can be executed and understood by a virtual machine/runtime. The virtual machine implementation reads the bytecode and performs the operations it specifies within a virtual environment. Byte code is typically slower than machine code but is **portable across platforms**. Languages/runtime that use bytecode include Java, Python, [Dalvik/ART](https://en.wikipedia.org/wiki/Android_Runtime), Lua, WebAssembly etc.

Eg. Bytecode is sort of the object code for the JVM. But, an object code isn't necessarly bytecode.

{{< figure src="/ox-hugo/x-code-ven.png" >}}


## Background and Jargons {#background-and-jargons}


### Flat Binary {#flat-binary}

Binary files are just sequence of bytes in a file instead of text files. They can be compiled computer programs aswell as images, videos etc. Usually binary files contain some header for metadata which can contain some **magic number** to identify the format of the binary file. Binaries that do not contain any header are called **flat binaries.**


### Binary and Executables {#binary-and-executables}

[When speaking casually](https://www.reddit.com/r/linux/comments/56mc2d/the_101_of_elf_binaries_on_linux_understanding/d8l38rv/) we sometimes mix binaries and executables, they are not the same. Not all binaries are executables. eg. Object code are binaries but they are not executables, on the other hand a directory can be an executable. ELF can be used both for executables and non-executable binaries. To confuse this even more, some references use the terms /relocatable object file/(for object files) and /executable object file/(for executables obtained from relocatable object file).


### Loader {#loader}

Loader is a program in the operating system that takes a **program** from disk and loads it into memory. In linux world we can use [execve() system call](https://itdobelikethat.org/post/exec-family/) to invoke the program loader.

Loader has many things to do such as:

-   Check permissions, Allocate space for the program's stack
-   Allocate space for the program's heap, Initialize registers (e.g., stack pointer)
-   Push argc, argv, and envp onto the program stack, Map virtual address spaces
-   Dynamic linking, Relocations, Call pre-initialization functions

Once it does all this, just call into the entrypoint which is generally `_start`

Linux loads the `.text` section into memory only once, no matter how many times an application is loaded(`forked=(?)). This reduces memory usage and launch time and is safe because the code doesn't change. For that reason, the =.rodata` section, which contains read-only initialized data, is packed into the same segment that contains the `.text` section. The `.data` section contains information that could be changed during application execution, so this section must be copied for every instance.

> Loader loads the segments, [not the sections]({{< relref "20221101175420-elf#section-and-segments" >}}).Load the segment if it is of type `PT_LOAD` / `LOAD`.


## Symbols {#symbols}

When you write a program in any language above direct machine code, you give symbolic names to functions and data and the compiler turns these things into code. At the machine level, they are known only by their address (offset within the file) and their size. But we need some way to refer to these, Symbols.

In the C compilation process:

-   **The compiler(cc1)** generates assembly file(`.s`) which contains the symbols in text format, the compiler may do any sort of name mangling here(_eg. sometimes it optimizes unused variables/extern vars so they never make to the symbol table!_)
-   Now **the Assembler** takes the `.s` file and creates the obj file. While doing so, it creates the symbol table in the `.symtab` section of the ELF object. In ELF64, `.symtab` contains an array entries of struct `Elf64_Sym`.
-   Now **the linker/static linker/link editor** will look into `.symtab`, `.rel.text`, `.rel.data` to perform symbol resolution and relocation, for dynamic executables it'll leave some of the linking to the loader/dynamic linker.
-   **The loader** makes use of the `program header table` to determine what things to put in memory for creating process images etc. Later(in the case of dynamic executables) the [dynamic linker](https://man7.org/linux/man-pages/man8/ld-linux.8.html) uses \*lazy loading\*(which is the common case) to resolve the symbols using `GOT` and `PLT`, we could also use `-fno-plt` to resolve all external symbols at load time.

> **Dynamic Symbol Table**
>
> `.dynsym` is a smaller version of `.symtab` that only contains global dynamic symbols. They are kept separate to ease the operation of relocation. The information found in the `.dynsym` is therefore also found in the `.symtab`, while the reverse is not necessarily true. For storing null-terminated strings, `.dynstr` is used with `.dynsym`. The symbols in `.dynsym` are called **dynamic linker symbols**, well because the dynamic linker makes use of these.
>
> `.dynsym` is found in shared objects and dynamic executables but not found in regular relocatable object files. The relocation operation with dynamic symbols also relies on two extra tables which are namely:
>
> -   `.rela.dyn` : Relocation for dynamically linked objects (data or procedures), if PLT is not used.
> -   `.rela.plt` : List of elements in the PLT, which are liable to the relocation during the dynamic linking.

```shell
# some observations
$ gcc main.c # .dynsym .dynstr .rela.dyn .rela.plt
$ gcc -fno-plt main.c # .dynsym .dynstr .rela.dyn
$ gcc -static main.c # .rela.plt (?)
$ gcc -static -fno-plt main.c # .rela.plt (?)
# bonus: see md5 sums, or use the size command
```

> some [good historical context](https://blogs.oracle.com/solaris/inside-elf-symbol-tables-v2)


### Symbol Sections {#symbol-sections}

I don't think there is a thing called "symbol section", but symbol table just contains references and information about the symbol while the real value of the symbol can exists in different sections of the object file. Eg. `.text`, `.data` etc. Symbols use the `st_shndx` field to specify the section header index of the section where the value lives in. When doing `readelf -s` it's the `Ndx` column.

There are a few pseudosections which are not defined by ELF, such as `UNDEF`, `COMMON`, `ABS` in to which the symbol may reference its value to. Unsure but most probably this is based on the `st_info` described below.

> The number of such sections depends on the hardware platform. On an x86_64 system over 30 special sections are defined, while on an ARM system there are about ten. One could define their own special section in linux.


### Symbol Information {#symbol-information}

`st_info` field contains symbol's type and binding attributes, these are very useful for the link-editor.


#### Symbols Types {#symbols-types}

`STT_NOTYPE`, `STT_OBJECT`, `STT_FUNC`, `STT_SECTION`, `STT_FILE`, `STT_COMMON`, `STT_TLS`, `STT_LOOS`, `STT_HIOS`, `STT_LOPROC`, `STT_SPARC_REGISTER`, `STT_HIPROC`

See [Undefined, Tentative(`STT_COMMON`), Defined.](https://docs.oracle.com/cd/E23824_01/html/819-0690/chapter6-79797.html#scrolltoc)


#### Symbol Bindings {#symbol-bindings}

`STB_LOCAL`, `STB_GLOBAL`, `STB_WEAK`, `STB_LOOS`, `STB_HIOS`, `STB_LOPROC`, `STB_HIPROC`

<!--list-separator-->

-  Strong and Weak Symbols

    When multiple global variables are declared on object files, linker uses the idea of strong and weak symbols to choose which one to use.

    ```C
    int x; // weak global symbol - STB_WEAK
    int y=10; // strong global symbol - STB_GLOBAL
    ```

<!--list-separator-->

-  Global, Local and Extern

    -   Global Symbols : **Defined** by `m` which can be referenced by other modules. `STB_GLOBAL`
    -   External Symbols : `Global Symbols` that are **referenced** by `m`, but by some other module. `STB_GLOBAL`
    -   Local Symbols : **Defined and referenced** exclusively by `m`, `STB_LOCAL`

    |                     | `static`                                               | non-`static`                       |
    |---------------------|--------------------------------------------------------|------------------------------------|
    | **Global Variable** | Local Symbol                                           | Global Symbol                      |
    | **Local Variable**  | Local Symbol w unique name(stored in `.data` / `.bss`) | Maintained at runtime on the stack |
    | **Global Function** | Local Symbol                                           | Global Symbol                      |
    | **Local Function**  | No such thing                                          | No such thing                      |


## Symbol Resolution {#symbol-resolution}

The purpose of symbol resolution is to associate each symbol reference with exactly one symbol definition. There are three places where symbol resolution can happen. **run-time, link-time and compile-time.** We call it dynamic linking, when it's happening at loadtime or runtime.


### Compile Time Symbol Resolution {#compile-time-symbol-resolution}

The compiler just looks at the ascii intermediate code and generates symbols in the assembly file. It does not not create the symbol table yet. _Sometimes compile-time is referenced for Link-time aswell._


### Link Time Symbol Resolution {#link-time-symbol-resolution}

As we know that the **assembler** puts the symbols generated by the **compiler** into symbol table at the `.symtab` section in the elf object file which the **linker** then uses, so these symbols at the `.symtab` are sometimes also refered to as **linker symbols**.

Static Linker (which alwas [be using linker scripts](http://sourceware.org/binutils/docs/ld/Scripts.html)) uses the [symbol information](#symbol-information) and reloc. info to make decisions to how to reference and relocate things. Sometimes it does it absolutely and sometimes it does the linking partially so that the dynamic linker(`ld.so`) can do rest of the linking.

```C
void swap() {...} /* define symbol swap */
swap();           /* reference symbol swap */
int *xp = &x;     /* define symbol xp, reference x */
```


### Load Time Symbol Resolution {#load-time-symbol-resolution}

The Static Linker(ld) creates the executable but does not link the shared libraries but does make a note of which shared lbraries to load so that the loader/runtime can load them as required. This is partially linking. The loader(execve syscall) inturn calls the **dynamic linker (`ld-linux.so`)**, now the dynamic linker can lazyload the symbols for functions from shared libraries which makes use of both `GOT` and `PLT`.


### Run Time Symbol Resolution {#run-time-symbol-resolution}

One could resolve symbols while the program is running aswell with functions such as `dlopen`.


## PIC, ASLR, PIE, GOT and PLT {#pic-aslr-pie-got-and-plt}

These things are related, it's interesting to know how and it is related [how addressing works](https://stackoverflow.com/questions/18026333/what-does-compiling-with-pic-dwith-pic-with-pic-actually-do).


### PIC {#pic}

The idea [behind PIC](https://eli.thegreenplace.net/2011/11/03/position-independent-code-pic-in-shared-libraries/) is simple - **add an additional level of indirection to all global data and function references in the code**. It's an old concept that we needed when we needed to load multiple programs into the same physical address space but became less useful as we moved to virtual address spaces, but with **shared libraries** we have the need to use PIC again since we don't want shared libraries to be overlapping and we do not know which virtual address that shared library will run at.

Before PIC we're using [load time relocation for shared libraries](#shared-libraries) which made the dynamic linker do a lot of relocation during runtime. PIC practicaly eliminates all absolute addressing, replacing it with either relative addressing or a small jump table that can be forked for each process and for different processes, the same shared library will run at different address, depending on the decisions made by the dynamic linker.

It is related to how the assembler/gcc assembles the symbols and not related to the linker. One could generate PIC code by using the `-fpic` or `-fPIC` flags. There is a [difference between both of those flags](https://stackoverflow.com/questions/3544035/what-is-the-difference-between-fpic-and-fpic-gcc-parameters?rq=1).


#### Library Intent Table {#library-intent-table}

| ELF Type  | Intent                          | Note                                                                                                                                                                                                                                                                 |
|-----------|---------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `ET_REL`  | Relocatable Object Files (`.o`) | These are generated based on code generation options available. `-fPIC`,=-fPIE=,=-fno-pie=                                                                                                                                                                           |
| Not ELF   | Static Library (`.a`)           | Static libraries are just archives(`.a`) which can contain any or mix of PIE/PIC/non-PIC relocatable object files, but mixing is usually not the best thing to do.                                                                                                   |
| `ET_DYN`  | Shared Library (`.so`)          | Code used for shared libraries **must be** generated using `-fPIC`, if the shared library is supposed to link against another static library the object files in the static library should be compiled using `-fPIC` aswell.                                         |
| `ET_DYN`  | Static PIE Exec                 | May only be created from PIC/PIE objects (`.o`) and PIC/PIE static libraries (`.a`), this was not possible until the `-static-pie` flag was added. But this is something one would not use often. `ldd` shows statically linked but the ELF type is `ET_DYN`! weird. |
| `ET_EXEC` | Static non-PIE Exec             | This is the traditional way how static libraries are used as they already have the symbols resolved. The objects here can be non-PIC/PIC/PIE. One simply needs to use the `-static` flag for this.                                                                   |
| `ET_DYN`  | Dynamic PIE Exec                | This is the most common thing one would encounter. May only be created from PIC/PIE objects (.o) and PIC/PIE static libraries (.a) It uses `-pie` which is added by default in GCC these days.                                                                       |
| `ET_EXEC` | Dynamic non-PIE Exec            | One needs to use `-no-pie` flag, the object files can be PIC/non-PIC/PIE. `ldd` will show the dynamically linked libraries.                                                                                                                                          |

Some take-aways:

-   Code compiled with `-fPIC` can be used in anything, from shared libraries to executables (PIE or not)
-   non-PIE executables can be created from any objects or static libraries.
-   If both static and shared libraries are found, the linker gives preference to linking with the shared library unless the `-static` option is used.
-   When creating **PIE executables** its better to use `-fPIE` for code generation for some small optimizations over `-fPIC`.
-   When creating **non-PIE executables** using PIC/PIE object file is possible but makes less sense and adds some bloat.
-   Mixing of non-PIC and PIC objects is for sure a [very weird usecase](https://stackoverflow.com/questions/36460420/is-it-valid-to-link-non-pic-objects-into-an-executable-with-pic-objects?rq=1)


### ASLR {#aslr}

The primary idea is that appications run in a randomized address space. Out of many things, [having ASLR](https://en.wikipedia.org/wiki/Address_space_layout_randomization) makes it hard for the attacker to guess the address space of a program. It solves additional secutity problems such as [NX bit](https://en.wikipedia.org/wiki/NX_bit) cannot prevent [return to libc attacks](https://en.wikipedia.org/wiki/Return-to-libc_attack), but ASLR can make it very difficult to perform.

> When debugging with gdb, it kind of disables ASLR so if you run, if you want gdb to use ASLR address better used the pid

```shell
λ sudo sysctl -a | grep 'randomize_va_space'
146:kernel.randomize_va_space = 2
λ ldd a.out
        linux-vdso.so.1 (0x00007ffc37974000)
        libc.so.6 => /usr/lib/libc.so.6 (0x00007fe87a9df000)
        /lib64/ld-linux-x86-64.so.2 => /usr/lib64/ld-linux-x86-64.so.2 (0x00007fe87abe1000)
λ ldd a.out
        linux-vdso.so.1 (0x00007ffe6e1f9000) # notice the address change.
        libc.so.6 => /usr/lib/libc.so.6 (0x00007f1e91303000)
        /lib64/ld-linux-x86-64.so.2 => /usr/lib64/ld-linux-x86-64.so.2 (0x00007f1e91505000)
```

To enable ASLR for executables, the OGs decided to extend PIC to executables and call it PIE. Infact when compile a program without PIE (`-no-pie` linker option) you get an ELF object of type `ET_EXEC` and when you comple with PIE (`-pie`, default nowadays) you get the executable with type `ET_DYN`, which is the same type as of shared objects.

It appears that the main effect of `ET_EXEC` vs `ET_DYN` in the Linux kernel / dynamic loader is to inform if the executable can be placed in random memory locations or not with ASLR.


### PIE {#pie}

Before the early 2000s, PIC was limited to shared libaries. Then PIE came to solve some security concerns(allowing ASLR). PIE executables are sort of a hack using a shared object with an entry-point which do be using relative addressing instead of absolute addressing. Interesting thing is PIE can be done in both the code generation phase(`-fPIE`) and in the linking phase(`-pie`). Other than security usage, PIE can also have other uses like making binaries more appropriate for MMU-less systems.

The only real difference between PIE and PIC is that you are [allowed to interpose symbols in PIC](https://www.drdobbs.com/building-library-interposers-for-fun-and/184404926), but not in PIE. They are pretty much equivalent except some optimizations that are sort of negligible, but the produced code has [certain places that it can be used as mentioned in this table](#library-intent-table).

The presence of the `PHDR` and `INTERP` program headers(`readelf -l`) indicates that the executable is PIE, this is probably what `file` uses. Additionally, [`Scrt1.o` is used](/txt/crt.txt) in place of `crt1.o` when generating PIEs but a shared library is normally not. But there is nothing to prevent a shared library to be linked with Scrt1.o as well,


### PLT {#plt}

PLT stands for Procedure Linkage Table which is, put simply, used to call **external procedures/functions** whose address isn't known in the time of linking, and is left to be resolved by the dynamic linker. (PLT does not deal with variables, only procedures)

PLT and PIC are not as tightly coupled as some sources say. For calls made from PIC code, the PLT is not really needed. The compiler could just was well generate a GOT lookup and indirect call to the address obtained from the GOT. Using a PLT tends to make the code slightly more efficient though.

In the common senario, the dynamic linker checks the address of shared libraries, and hacks up the GOT and PLT so that it will point correctly to the required shared library symbol that the running program is asking for.

The Procedure Linkage Table resides in `.plt` section and is mapped to a read-only segment in memory. So during program running this tables' entry do not need to change.

Links:

-   [PLT and GOT](https://www.technovelty.org/linux/plt-and-got-the-key-to-code-sharing-and-dynamic-libraries.html)
-   [Confusion about PIC and virtual address space](https://stackoverflow.com/questions/62530865/confusion-about-virtual-address-space-and-position-indepedent-code-pic)
-   [What does [cite/t:@plt] mean](https://stackoverflow.com/questions/5469274/what-does-plt-mean-here/5469334#5469334)
-   [glibc at runtime](http://dustin.schultz.io/how-is-glibc-loaded-at-runtime.html)

> Doubt: How is PLT used for non-PIC code


### GOT {#got}

Modern operating systems has two GOT (Global Offset Tables)s for each process. One is named `.got` and the other `.got.plt`. We have `.got.plt` section in a writable segment. There is one GOT per compilation unit or object module, and it is located at a fixed offset from the code (although this offset is not known until the library is linked). When a linker links modules to create a shared library, it merges the GOTs and sets the final offsets in code. Just like the linker merges the `.text` sections into one.

Global Offset Table is used **for global and static variables**. For every reference to a global variable from PIC, the compiler will generate a load from the GOT to get the address of the variable, followed by a second load to get the actual value of the variable.

The link editor will create the dynamic relocations(`.dynsym`) which the dynamic linker will use to initialize the GOT at runtime. Unlike the PLT, the dynamic linker always fully initializes the GOT when the program starts, it's mostly lazy loading for PLT these days.

> Doubt: Interestingly, GOT and PLT sections can be seen even when `-no-pie` and `-fno-pic` are used. Need to clear my confusion about GOT and PLT with non-PIC code.


## Libraries {#libraries}

When writing programs we need some way to package commonly used functions, for this we need libraries. Just like [symbol resolution](#symbol-resolution), libraries can be loaded in three different ways: **Compile time, Load time, Run time** because loading libraries is essentialy resolving symbols and relocating references.

> **About the C standard library**
>
> The files that we include using the `#include` directives are just header files that consists of defines and types, these are added to the ascii intermendiate file in the preprocessing phase itself. For eg. `#include<stdio.h>` The functions mentioned in this header file need to be implemented by the C standard library, which is later linked by the dynamic linker. There can be multiple implementation of the [C standard library.](https://wiki.osdev.org/C_Library)


### Library Naming Convention {#library-naming-convention}

Some observations:

-   The convention of these library names is that you need to prefix with `lib<name>.a` same for `lib<name>.so`. Eg. `libc.so`, `libm.a` etc. This prefix-suffix is not actually mandated, it's a convention and based on how the `-l` flag does lookup for libraries.
-   Some `.so` and `.a` flags are ld scripts! Eg. `/usr/lib/libm.so` the real library filename in this case is `/usr/lib/libm.so.6`

> Need to read more on SONAME and versioning `(TODO)` Allows incremental updates just by recompiling and rearchiving.


### Static Libraries {#static-libraries}

These are the `.a` (archive) files or a collection of `.o` files. Basically concats the relocatable object files into one file with and index (called archive). These are not ELF files but rather archive files generated by the `ar` command.


#### Linking static libraries {#linking-static-libraries}

Linking against a static library is roughly the same as just adding more .o files to the linker line. If symbol is found to be in one of the reloc files from the index, it'll link the entire objectfile to the executable(?). Ordering of `-l` flag matters, best practice is to place `-l` flags towards the end based on how `ld` does symbol lookup.


#### Static Libraries vs Static Executables {#static-libraries-vs-static-executables}

In Unix, the default compilation mode for programs is to use the systems shared library, instead of [pre-linking](https://en.wikipedia.org/wiki/Prelink) everything necessary in the executable. When compiling a program with `gcc`, for instance, you pass the `-static` flag if you wish it to be a fully linked static executable, instead of having unresolved symbolic references.

This means [we could be using static libraries and be creating a dynamic executable](https://gist.github.com/geekodour/9ec2eee223b4704aed5f69fee22561b8)! to create a static executable we need to use the `-static` flag. When compiling generally without any flags, if both static and shared libraries are found, the linker gives preference to linking with the shared library unless the `-static` option is used.

Be aware that statically linking glibc is strongly advised against by the glibc maintainers, and some features of glibc will not work when statically linked.


### Shared Libraries {#shared-libraries}

{{< figure src="/ox-hugo/64bitaddressspace.png" >}}

Shared libraries have many names - shared libraries, shared objects, dynamic shared objects (DSOs), dynamically linked libraries(DLLs). With shared libraries we face a problem, each program can use any number of shared libraries, and there's simply no way to know in advance where any given shared library will be loaded in the process's virtual memory. There are two well known ways to resolve this:

-   [Load-time relocation](https://eli.thegreenplace.net/2011/08/25/load-time-relocation-of-shared-libraries/#id14) : x86-64 no longer supports load time relocation for shared objects, it'll still work on i386. This will cause the program linker to generate a lot of relocation information, and cause the dynamic linker to do a lot of processing at runtime.
-   [Position Independent Code (PIC)](https://eli.thegreenplace.net/2011/11/03/position-independent-code-pic-in-shared-libraries/)

Links:

-   [How to Write Shared Libraries](https://software.intel.com/sites/default/files/m/a/1/e/dsohowto.pdf) by [Ulrich Drepper](https://de.wikipedia.org/wiki/Ulrich_Drepper)(ex glibc maintainer)


### Usage of PIC, PIE, `-shared`, `-static` {#usage-of-pic-pie--shared--static}

This confused me to hell and back when I first looked all these flags at the same time. nothing made sense, tbh the naming could have been better. So if you're at my place and you see this section by luck, you'll be saving up on 3 smokes total.

The following options are described in more details in `gcc` man page.


#### Code Generation Options {#code-generation-options}

-   `-fpic`, `-fPIC`: Generate pic code for object files.
-   `-fpie`, `-fPIE`: Generate pie code for object files.
-   `-fno-pic` : No PIC, no PIE code. Not listed in `gcc`'s man page as such though. One could use `md5sum=/=size=/=objdump` to see the differences in these three options.
-   `--no-pic` : There is no such option, idk where I came across this.


#### Options for linking {#options-for-linking}

-   `-pie` : Generate PIE executable, `ET_DYN`
-   `-no-pie` : Generate non-PIE executable, `ET_EXEC`
-   `-static-pie` : Generate static PIE executable, this has many quirks, just look them up. `ET_DYN`
-   `-static` : Generate static non-PIE executable and overrides `-pie`, has nothing to do with generating static libraries, we also see a missing [`.dynamic` section](https://docs.oracle.com/cd/E19683-01/817-3677/chapter6-42444/index.html) when using this option. `ET_EXEC`
-   `-shared` : Used when generating shared libraries.
-   `-rdynamic` : TODO


#### Some Takeaways {#some-takeaways}

-   Most distos nowadays have gcc configured with `--enable-default-pie` which makes gcc use `-fPIE` and `-pie` by default.
-   We need both `-fPIE` and `-pie` because you see, they do different things. If we just use `-pie` and it should fail because then the generated code will be using absolute addressing which is not compitable with PIE executables. So the following fails:

<!--listend-->

```shell
$ gcc -fno-pic -pie main.c
/usr/bin/ld: /tmp/ccTOkUR5.o: relocation R_X86_64_32 against `.rodata' can not be used when making a PIE object; recompile with -fPIE
collect2: error: ld returned 1 exit status
```

```shell
# Tell linker which libraries to load
# -L tells Linker which directory to look for library first
# -l does the lookup based on the convention i mentioned above.
# ordering matters with static libraries
```


### Env &amp; Setting up of Libraries {#env-setting-up-of-libraries}

-   `LDFLAGS`, `CFLAGS` : These are a convention that comes from the [predefined rules for Makefiles](http://web.mit.edu/gnu/doc/html/make_toc.html#SEC88)
-   `LD_LIBRARY_PATH`: A colon-separated set of directories where libraries should be searched for first, before the standard set of directories. Handy for development and testing, but shouldn't be modified by an installation process for [normal use by normal users](http://www.visi.com/~barr/ldpath.html)
-   `LD_PRELOAD`: It lists shared libraries with functions [that override the standard set](http://www.goldsborough.me/c/low-level/kernel/2016/08/29/16-48-53-the*-ld_preload-_trick/), just like `/etc/ld.so.preload`.
-   `LD_DEBUG` : Triggers the `dl*` functions so that they give verbose information, can [have different values](https://tldp.org/HOWTO/Program-Library-HOWTO/shared-libraries.html).
-   `ldconfig` : It reads the content of `/etc/ld.so.conf`, creates the appropriate symbolic links in the dynamic link directories, and then writes a cache to `/etc/ld.so.cache` which is then easily used by other programs. We [need to run this everytime we update `ld.so.conf`](https://www.youtube.com/watch?v=RmdvkUWQ78g)
-   `/etc/ld.so.preload` : Serves the [same purpose](https://superuser.com/questions/1183037/what-is-does-ld-so-preload-do) as setting the `LD_PRELOAD` variable, i.e. as a means to temporarily linking in a different library than usual.
-   When using shared libraries, we need to use the shared library both when **compiling** and when **running** our program. When compiling we use the combination of the `-L` and `-l` flag to specify the shared library so that the linker is able to find the symbols. For running we need to update `ld.so.conf` and run `ldconfig` so that when running our program, the dynamic linker is able to find the shared libraries and hence the symbols we're using.
-   `rpath` : TODO


## Linker's Work {#linkers-work}

First thing to know is that, there is the [link editor](https://linux.die.net/man/1/ld) and the [dynamic linker](https://linux.die.net/man/8/ld-linux.so).

The linker merges together all sections of the same type included in the input object files into a single section and assigns an initial address to it. For instance, the `.text` sections of all object files are merged together into a single `.text` section, which by default contains all of the code in the program. The GNU Binutils linker always uses a [linker script](http://sourceware.org/binutils/docs/ld/Scripts.html). If you do not supply one yourself, the linker will use a default script that is compiled into the linker executable.

It primarily does two thing symbol resolution(which [was discussed previously](#symbol-resolution)) and relocation.


### Relocation {#relocation}

Relocations are entries in binaries that are left to be filled in later. The link editor relocates the symbols by associating a mem location with each symbol definition, and then modifying all of the references to those symbols so that they point to this mem loc.

When an assembler generates an obj module, it does not know where the code and data will ultimately be stored in memory. Nor does it know the location of any externally defined funcs or global vars that are referenced by the module. So it calculates creates reminders to the linker called the relocation entries which are stored in .rel.data and .rel.text that the linker can later use.

Dynamic relocation is done my `ld.so` (the dynamic linker), Not only shared objects but also dynamic (non-static) executables may have dynamic relocations. All the `.dynsym` discussion done previously is relevant here.


## Misc {#misc}


### Making small executables {#making-small-executables}

The section table(`.symtab`) can be [stripped](https://sourceware.org/binutils/docs/binutils/strip.html) for executables or shared objects because it is nither used by the \*dynamic linker\*(`ld.so`) not by the os loader. It's only used by the \*static linker/link-editor\*(`ld`).

Relocation info(`.rel_text`,=.rel_data=) already stripped by the linker after relocating. One could also use "-n" (also known as "-nmagic") linker option. This basically tells ld to not worry about aligning program sections on page boundaries. Further to strip, one could also use `sstrip`.

You you're creating an dynamic excutable, you can't get rid of dynamic tables and related tables such as `.rela.plt` and `.rela.dyn` unless you want the dynamic linking to be done differently.


### How memory is laid out {#how-memory-is-laid-out}

The starting point address is part of a set of conventions which describe how memory is laid out. The linker, when it produces an executable binary, must know these conventions as it dectates how the executable is formed. This memory layout conventions can be changed if needed. On Linux, the default address for `x86_64` binaries is `0x400000`, and so the `.text` ends up not far from there.

> Why .text segment be loaded at 0x400000;
>
> Linux segfaults us if the `.text` is too low. If this were not present, it would be 0, and that is [too low and segfaults.](https://stackoverflow.com/questions/39689516/why-is-address-0x400000-chosen-as-a-start-of-text-segment-in-x86-64-abi/39692117)

```shell
# x86_64 chooses 0x400000
# 32bit chooses 0x08048000
λ ld -verbose | grep -i text-segment
25:  PROVIDE (__executable_start = SEGMENT_START("text-segment", 0x400000)); . = SEGMENT_START("text-segment", 0x400000) + SIZEOF_HEADERS;
```


### vdso(vDSO) {#vdsovdso}

`linux-vdso.so.1` is a virtual library that is automatically mapped in the address space of a process by the kernel, it does not have a filename but has and address when we do ldd.

```shell
λ ldd /bin/ls
        linux-vdso.so.1 (0x00007ffc40f03000) # no filename!
        libcap.so.2 => /usr/lib/libcap.so.2 (0x00007fcf9616a000)
        libc.so.6 => /usr/lib/libc.so.6 (0x00007fcf95fa4000)
        /lib64/ld-linux-x86-64.so.2 => /usr/lib64/ld-linux-x86-64.so.2 (0x00007fcf961cf000)
```

It's an way to export kernel space routines to userspace. The main reason is to reduce the system call overhead. Typically when a system call happens it requires some expensive operations like switching mode from user to kernel, copying data from userspace to kernelspace etc. To reduce these sorts of overhead VDSO is used, just by reading that vdso memory space result could be extracted i.e it's possible to `gettimeofday()` without doing a real system call!

> DOUBT: `vsyscall` came first, vdso overcomes its limitations. vsyscall is still used why?


### Different Libraries {#different-libraries}

-   [glibc/libc, gnulib, and glib/Glib are different things!](https://stackoverflow.com/questions/2240120/glibc-glib-and-gnulib)
-   [GObject](https://en.wikipedia.org/wiki/GObject)


## Links {#links}

-   [Linking](https://people.cs.pitt.edu/~xianeizhang/notes/Linking.html)
-   [ELF: dynamic struggles](http://michalmalik.github.io/elf-dynamic-segment-struggles)
-   [Tools for examining different phases of compiling and running a C program](https://www.cs.swarthmore.edu/~newhall/unixhelp/compilecycle.html)
-   [Hosted vs Freestanding Environments](https://stackoverflow.com/questions/30825151/is-there-a-meaningful-distinction-between-freestanding-and-hosted-implementation)
-   [20 Part Seies on Linkers and Loaders](https://www.airs.com/blog/archives/41)
-   [Linkers and loaders book.](https://www.goodreads.com/book/show/1103509.Linkers_and_Loaders)
-   [About ELF -- PIE, PIC and else](https://codywu2010.wordpress.com/2014/11/29/about-elf-pie-pic-and-else/)
-   [X86 psABI](https://github.com/hjl-tools/x86-psABI/wiki/X86-psABI)
-   [Building And Using Static And Shared "C" Libraries](http://docencia.ac.upc.edu/FIB/USO/Bibliografia/unix-c-libraries.html#libraries)
-   [various mechanisms to protect against buffer overflow exploits.](https://www.win.tue.nl/~aeb/linux/hh/protection.html)
-   [Drew on Dynamic Linking](https://drewdevault.com/dynlib.html)
-   [Traditional Unix Toolchain](https://bsdimp.blogspot.com/2020/07/traditional-unix-toolchains.html?m=1)
-   <https://begriffs.com/posts/2021-07-04-shared-libraries.html?hn=2>
-   <https://seenaburns.com/building-c-programs/>


## Tools {#tools}

`nm`, `size`, `file`, `execstack`, `readelf`, `ldd`, `hexdump`, `objdump`
