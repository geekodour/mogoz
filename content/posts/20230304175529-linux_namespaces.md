+++
title = "Linux Namespaces"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Containers]({{< relref "20230218104617-containers.md" >}}) , [Linux]({{< relref "20221101150211-linux.md" >}})


## Intro {#intro}

-   A namespace(NS) "wraps" some global resource to provide isolation of that resource.
-   At any time, a system can have multiple instances of NS
-   Processes can belong to namespace instances
    -   A process **cannot** be part of multiple NS of same type instances at the same time. Eg. P1 cannot belong to UTSNS1 and UTSNS2
    -   A process **can** be part of multiple different NS type instances at the same time. Eg. P1 can belong to UTSNS1, IPCNS2, TIMENS1, CGROUPNS22
-   Processes inside a NS are unaware of what's happening in other NS in the system
-   Each **non user NS** is owned by **some user NS** instance.


## Usage {#usage}

-   It is possible to use individual NS on their own
-   But often, NS depend on each other so you might end up using multiple NS. Eg. PID, IPC or cgroups NS need mount NS.


## Privilege and Permission for creating NS {#privilege-and-permission-for-creating-ns}

-   No privilege needed for `User` NS
-   For all other NS, you need: `CAP_SYS_ADMIN` capability


## Related System calls {#related-system-calls}

-   `fork()` : The new process created resides in the same NS.
-   `clone()` : Create new (child) process in new NS(s)
-   `unshare()` : Create new NS(s) and move caller(process/thread) into it/them. (i.e disassociate itself)
-   `setns()` : Move calling process/thread into another (existing) NS.
-   There are analogous commands such as `unshare` and `nsenter`


## APIs and other interfaces {#apis-and-other-interfaces}

-   Each process has symlinks in `/proc/PID/ns/<ns_type>/`
-   Namespaces are implemented by a [filesystem](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/nsfs.c) internal to the kernel. This symlink points to the `inode` number [specific](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/nsfs.c) to the `NS`.
-   This `inode` number is unique for a `NS` instance
-   `lsns -T` command


## Types (8) {#types--8}


### Mount `CLONE_NEWNS` (2002) {#mount-clone-newns--2002}

-   All it does is provide a set of mount points
-   There can be many NS that mount the **same** FS
-   Two different mount NS happen to mount the same FS, changes in one will be reflected in another.
-   **FS is not being isolated**
-   `CLONE_NEWNS` instead of `CLONE_NEWMNT` because back in the day when it was being implemented nobody thought there will be other namespace types
-   Isolation of `set of mountpoints` as seen by processes. Processes in different Mount NS(s) see different filesystem trees
-   `mount` and `umount` had to be refactored to only affect processes in same mount NS.


### UTS `CLONE_NEWUTS` (2006) {#uts-clone-newuts--2006}

-   Hostname and NIS domain name
-   See manpage

![](/ox-hugo/CAPTURE-20230304175529-linux_namespaces-1552259156.png)
In the picture, changes to `hostname` in `UTS NS X` won't be visible to other `UTS NS` (es)


### IPC `CLONE_NEWIPC` (2006) {#ipc-clone-newipc--2006}

-   System V IPC (Message queues, semaphore, and shared memory)
-   POSIX message queues
-   Process in IPC NS instance share set of IPC objects. Can't see objects in other IPC NS.


### PID `CLONE_NEWPID` (2008) {#pid-clone-newpid--2008}

-   Isolate Process ID number space. i.e Processes in different NS can have same PID
-   Max nesting depth: 32

![](/ox-hugo/20230304175529-linux_namespaces-374814166.png)
Picture clearly shows that PIDs just don't get created inside the container, it'll have ancestors back to the initial namespace. But the parent will not be visiable from the child process using things like `getppid()`


### Network `CLONE_NEWNET` (2009) {#network-clone-newnet--2009}

-   Useful for providing containers with their own virtual network and network device (`veth`)
-   Useful when you want to place a process in a NS with no network device
-   Isolates whole bunch of network resources like
    -   IP addresses
    -   IP routing tables
    -   `/proc/net` , `/sys/class/net`
    -   netfilter FW rules
    -   `socket port no space`
    -   unix domain sockets


### User `CLONE_NEWUSER` (2013) {#user-clone-newuser--2013}

One of the most complex NS implementations. User NS are hierarchical like PID NS

-   Relationship w Parent user NS determine capabilities

{{< figure src="/ox-hugo/20230304175529-linux_namespaces-401374030.png" >}}

-   When a new user NS is created, first process inside NS has **all** capabilities
-   Each **non user NS** is owned by **some user NS** instance.🌟
    -   When creating new **non user NS**, kernel marks **non user NS** as owned by **user NS** of the process creating the new **non user NS**
    -   Process operating on non user NS resources; Permission check done to the process's caps in **user NS** that owns the **non user NS**


#### What are `uid_map` and `gid_map` {#what-are-uid-map-and-gid-map}

-   There are rules about what values can be written to the `uid_map` and `gid_map` files. To guide what they permit there are standard `/etc/subuid` and `/etc/subgid` files(which define which ranges of (outer namespace) UIDs and GIDs)
-   This is one of the first steps to do when creating a user NS.
-   One could use `newuidmap` to set these.
-   Done by writing to `/proc/PID/uid_map` and `/proc/PID/gid_map`

<!--listend-->

```text
id-inside-ns    id-outside-ns   length

id-inside-ns + length = range of ids inside ns to be mapped
id-outside-ns = start of corresponding mapped range outside ns
```

Examples:

```text
0 1000 1 # root mapping
# 1 User : 0(ns) = 1000(outer)
0 1000 10
# 10 User : 0(ns) = 1000(outer), 1(ns) = 1001(outer),...9(ns) = 1009(outer)
```


#### What is `eUID`? {#what-is-euid}

When running on set-uid.

-   `eUID`: Effective UID is the user you changed to
-   `UID`: The original user.


#### What happens when `unshare -Ur -u <prog>?` {#what-happens-when-unshare-ur-u-prog}

{{< figure src="/ox-hugo/20230304175529-linux_namespaces-1914011448.png" >}}

<div class="book-hint warning small-text">

> =ep : All sets of capabilities
</div>

In this case,

-   `X` is part of new `UTS` and `User` NS
-   `X` is part of old/initial `IPC`, `Network`, `Time`, `cgroups`, etc.
-   With the capabilities(`=ep`) `X` has
    -   `X`'s capabilities will only work in the NS(s) **owned** by the new user NS. `X` is a member of the new user NS.
    -   If `X` tries to change `hostname`, it'll be able to. (`CAP_SYS_ADMIN`)
    -   If `X` tries to bind a reserved socket port, it'll **not** be able to. (`CAP_NET_BIND_SERVICE`)
-   See `ioctl_ns`


### Cgroup `CLONE_NEWCGROUP` (2016) {#cgroup-clone-newcgroup--2016}

-   Before we understand [cgroups]({{< relref "20230304201630-cgroups.md" >}}) NS, we need to understand what cgroups are.
-   Certain path names that appear in certain proc files are being virtualized


### Time `CLONE_NEWTIME` (2020) {#time-clone-newtime--2020}

Boot and monotonic clocks
