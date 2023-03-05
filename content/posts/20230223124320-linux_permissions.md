+++
title = "Linux Permissions"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Linux]({{< relref "20221101150211-linux.md" >}})


## Permission sets {#permission-sets}

3 sets of traditional permissions: `user`, `group`, `other`.

-   `user` : Determines what the owner of the file can do.
-   `group` : Determines what members of the file's group can do.
-   `other` : Determines what everybody else can do.


### Common permissions {#common-permissions}

| Decimal | Binary | Meaning |
|---------|--------|---------|
| 4       | 100    | r--     |
| 7       | 111    | rwx     |
| 6       | 110    | rw-     |
| 5       | 101    | r-x     |
| 1       | 001    | --x     |
| 2       | 010    | -w-     |

So they are combined like `655`, `777` etc for `user`, `group` and `other`
Eg. 655 means

-   6: `rw-` for `user/owner`
-   5: `r-x` for the `group`
-   5: `r-x` for the `other`


### Special modes/flags {#special-modes-flags}

There are 3 additional permission/mode/flag bits

```text
 0 ----------
 1 ---------T (sticky)
 2 ------S--- (setgid)
 3 ------S--T
 4 ---S------ (setuid)
 5 ---S-----T
 6 ---S--S---
 7 ---S--S--T
```


#### Sticky bit {#sticky-bit}

-   sticky bit for **files** has become obsolete due to swapping optimization.
-   `t` bit set instead of `x` : Both the `execute` and `sticky` bits set
-   `T` bit set instead of `x` : Only `sticky` bit set
-   Nobody can delete or rename anybody else's files from that directory, even though they have write permission on the directory.


#### setuid and setgid bits {#setuid-and-setgid-bits}

-   These 2 permission bits cause programs to **be executed with different privileges** than those of the person who ran them.
-   They allow admin to permit **trusted privileged programs** to be run by unprivileged users.

<!--list-separator-->

-  setuid

    <div class="warning small-text">

    > Example of setuid program: `passwd(1)`
    >
    > -   Lets users change their passwords
    > -   It can modify `/etc/passwd` file, So the passwd program is very carefully written
    </div>

    -   Executable w `setuid` bit enabled runs as the program's owner (UID), no matter who runs it.
    -   `s` bit set instead of `x` : Both the `execute` and `setuid` bits set
    -   `S` bit set instead of `x` : Only `setuid` bit set
    -   The setuid bit has **no** meaning on a directory

<!--list-separator-->

-  setgid

    -   Executable w `setgid` bit enabled runs as the program's group (GID).
    -   The setgid bit does have meaning in a directory
    -   Eg. `xterm(1)`


### Directories {#directories}

How directories behave can differ by operating systems!

-   Read permission: Only lets you get a listing of the filenames in that directory
-   Write permission: Only lets you create, rename or delete files in that directory
    -   This allows another user to **delete** files owned by another user
-   Execute permission: Allows you to `chdir(2)` (`cd`) into a directory, and also allows you to open or stat the files therein. Opening a file also requires the appropriate permissions on the file itself. :


## umask {#umask}

-   Simply `a number` which tells the kernel which permissions bits you **do not want** enabled whenever you make a new file.
-   Every process has a umask number. i.e your shell will have a `umask` number. Try running `umask`
-   022 : `----w--w-`, meaing **don't want** group and other writable by default


## Resources {#resources}

-   <https://mywiki.wooledge.org/Permissions>
