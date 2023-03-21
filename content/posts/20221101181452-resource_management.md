+++
title = "Resource Management"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Operating Systems]({{< relref "20221101172456-operating_systems.md" >}}), [Linux]({{< relref "20221101150211-linux.md" >}})

Traditionally we had `ulimit` but problems with all that is that it's hard to verify if things are working as expected.

ps uses `/proc`, how is `/proc` populated? kernel populates it from the address space of the process!

The [ulimits]({{< relref "20230225145310-ulimits.md" >}}) shell command is built around `setrlimit`

-   a program can change its own soft limit at any time by calling setrlimit
-   need to read more on soft and hard limit

<https://pubs.opengroup.org/onlinepubs/009695399/functions/setrlimit.html>

Thing to understand about these tools that these are per process and not systemwide


## Link {#link}

-   <https://people.kernel.org/brauner/the-seccomp-notifier-new-frontiers-in-unprivileged-container-development>
-   chrome-extension://klbibkeccnjlkjkiokjodocebajanakg/suspended.html#ttl=cgroups%20-%20Wikipedia&amp;pos=0&amp;uri=<https://en.wikipedia.org/wiki/Cgroups> | cgroups - Wikipedia
-   <https://www.kernel.org/doc/Documentation/cgroup-v1/cgroups.txt> | <https://www.kernel.org/doc/Documentation/cgroup-v1/cgroups.txt>
-   <https://wiki.archlinux.org/index.php/cgroups> | cgroups - ArchWiki
-   <https://www.reddit.com/r/redhat/comments/6flu5n/world_domination_with_cgroups_full_series/> | World Domination with Cgroups - Full Series : redhat
-   <https://www.reddit.com/r/Fedora/comments/dp5vjq/the_current_adoption_status_of_cgroup_v2_in/> | The current adoption status of cgroup v2 in containers : Fedora
-   <http://wiki.linuxquestions.org/wiki/Ulimit> | Ulimit - LQWiki
-   <https://wiki.debian.org/Limits> | Limits - Debian Wiki
-   <https://serverfault.com/questions/265155/soft-limit-vs-hard-limit#:~:text=There%20are%20two%20types%20of,user%20once%20it%20is%20set.&text=A%20soft%20limit%2C%20however%2C%20can,equal%20to%20'hard%20limit>'. | linux - Soft limit vs Hard limit? - Server Fault
-   <https://www.nics.tennessee.edu/faq/general-how-do-i-change-my-default-limits-stack-size-core-file-size-etc#:~:text=The%20soft%20limit%20is%20the,decreased%2C%20but%20its%20not%20recommended>. | General: How do I change my default limits for stack size, core file size, etc.? | National Institute for Computational Sciences
-   <http://geekswing.com/geek/quickie-tutorial-ulimit-soft-limits-hard-limits-soft-stack-hard-stack/> | Quickie tutorial: ulimit, soft limits, hard limits, soft stack, hard stack | geekswing.com
-   <https://unix.stackexchange.com/questions/29577/ulimit-difference-between-hard-and-soft-limits> | open files - ulimit: difference between hard and soft limits - Unix &amp; Linux Stack Exchange
-   <https://serverfault.com/questions/788233/procs-limit-and-ulimit-f-dont-match> | linux - proc's limit and ulimit -f don't match - Server Fault
-   <https://unix.stackexchange.com/questions/303190/prlimit-fails-are-20-processes-not-enough-for-bash> | ulimit - prlimit fails; are 20 processes not enough for bash? - Unix &amp; Linux Stack Exchange
-   <https://superuser.com/questions/404239/setting-ulimit-on-a-running-process> | debug - setting ulimit on a running process - Super User
-   <http://www.linuxfromscratch.org/lfs/view/7.2/chapter06/util-linux.html> | 6.22. Util-linux-2.21.2
-   <https://www.systutorials.com/docs/linux/man/1-prlimit/> | prlimit: get and set process resource limits - Linux Man Pages (1)
-   <https://ops.tips/blog/proc-pid-limits-under-the-hood/> | Process resource limits under the hood | OpsTips
-   <https://www.ibm.com/support/knowledgecenter/SSCRJU_4.1.1/com.ibm.streams.install.doc/doc/ibminfospherestreams-install-operating-system-settings.html> | Guidelines for configuring Linux ulimit settings for InfoSphere Streams
-   <https://askubuntu.com/questions/911693/ubuntu-16-free-command-buffer-cache-difference> | 16.04 - Ubuntu 16 - Free command Buffer/cache difference - Ask Ubuntu
-   <https://www.tldp.org/LDP/sag/html/buffer-cache.html> | The buffer cache
-   <https://unix.stackexchange.com/questions/390518/what-do-the-buff-cache-and-avail-mem-fields-in-top-mean> | linux - What do the "buff/cache" and "avail mem" fields in top mean? - Unix &amp; Linux Stack Exchange


## video {#video}

-   <https://youtu.be/beefUhRH5lU?t=2659> nice separation of resources and limits to services running in a server


## Tools {#tools}

-   `nproc`
