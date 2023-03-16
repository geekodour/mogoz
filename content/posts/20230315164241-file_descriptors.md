+++
title = "File Descriptors"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Systems]({{< relref "20221101150250-systems.md" >}})


## Intro {#intro}

<div class="warning small-text">

> FD is not related to an inode, except as such may be used internally by particular file-system driver.
</div>

-   FD is an abstract indicator to access a file or other input/output resources. It decouples a file path (more correctly, an inode) from a file object inside a process and the Linux kernel.
-   Allows for opening the same file
    -   An arbitrary number of times
    -   For different purposes
    -   With various flags
    -   At different offsets.
-   Each running program has its own list of file descriptors; they aren't shared.


### std[in,out,err] {#std-in-out-err}

-   `/dev/stdin`, `/dev/stdout`, `/dev/stderr` are `filenames` for `fd` for each process.
-   `/proc/self/fdinfo` contains per file descriptor info.

<!--listend-->

```shell
λ ll /dev/ | rg fd
lrwxrwxrwx      13 root      13 Mar 18:45  fd -> /proc/self/fd
lrwxrwxrwx      15 root      13 Mar 18:45  stderr -> /proc/self/fd/2
lrwxrwxrwx      15 root      13 Mar 18:45  stdin -> /proc/self/fd/0
lrwxrwxrwx      15 root      13 Mar 18:45  stdout -> /proc/self/fd/1
λ ll /proc/self/fd/
lrwx------    64 geekodour 15 Mar 15:44  0 -> /dev/pts/1
lrwx------    64 geekodour 15 Mar 15:44  1 -> /dev/pts/1
lrwx------    64 geekodour 15 Mar 15:44  2 -> /dev/pts/1
λ lsof -d 0 +fg # same fd points to different files
COMMAND      PID      USER   FD   TYPE FILE-FLAG DEVICE SIZE/OFF    NODE NAME
systemd      663 geekodour    0r   CHR        LG    1,3      0t0       4 /dev/null
emacs        676 geekodour    0r   CHR        LG    1,3      0t0       4 /dev/null
alacritty    933 geekodour    0u   CHR  RW,AP,LG    4,1      0t0      20 /dev/tty1
fish         947 geekodour    0u   CHR     RW,ND  136,0      0t0       3 /dev/pts/0
```


### sharing of fd {#sharing-of-fd}

-   Each running process has its own fd table. But this is an exception with child processes.
-   After `fork()` or a `clone() (wo CLONE_FILES set)`, a child and a parent have an equal set of fd(s)
