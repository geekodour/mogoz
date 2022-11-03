+++
title = "Linux Security Constraints"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Linux]({{< relref "20221101150211-linux.md" >}}), [Security]({{< relref "20221101184454-security.md" >}})

Unix permissions, capabilities, SELinux, AppArmor, seccomp, etc.

-   cat /proc/PID/cgroup, you see that the process is in a cgroup
-   If you look at /proc/PID/status, you see capabilities.
-   If you look at /proc/self/attr/current, you see SELinux labels.
-   If you look at /proc/PID/ns, you see the list of namespaces the process is in.


## Useful links {#useful-links}

-   <http://habitatchronicles.com/2017/05/what-are-capabilities/>
-   <https://www.cs.uic.edu/~jbell/CourseNotes/OperatingSystems/14_Protection.html>
-   <https://k3a.me/linux-capabilities-in-a-nutshell/>
-   [rosen: censorship-resistant proxy tunnel](https://spacetime.dev/rosen-censorship-resistant-proxy-tunnel)
