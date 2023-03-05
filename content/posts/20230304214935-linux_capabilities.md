+++
title = "Linux Capabilities"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Linux Permissions]({{< relref "20230223124320-linux_permissions.md" >}}), [Linux Security Constraints]({{< relref "20221101184550-linux_security_constraints.md" >}})


## Past and background {#past-and-background}

Traditionally, UNIX privilege divides things into two

-   Normal users
-   Super user (UID0)

Delegating privilege usually done via [setuid and setgid bits]({{< relref "20230223124320-linux_permissions.md#setuid-and-setgid-bits" >}}). This is powerful but dangerous.
As one can see delegating privilege via `setuid` and `setgid` bits is coarse. i.e if we want to give a program the ability to change system time we should now also give it the ability to do everything else!

Capabilities try to solve this.


## Intro {#intro}

-   Divide power of super user into small pieces
-   Capabilities are a per-thread attribute.
-   Stored in the file's inode like other linux permission attributes
-   Can be assigned to files, see manpage


## Inspecting {#inspecting}

Capabilities for a process can be seen at `/proc/PIC/status`

```shell
λ cat /proc/1/status | grep Cap
# CapInh: 0000000000000000
# CapPrm: 000001ffffffffff
# CapEff: 000001ffffffffff
# CapBnd: 000001ffffffffff
# CapAmb: 0000000000000000
λ capsh --decode=000001ffffffffff
# 0x000001ffffffffff=cap_chown,cap_dac_override,cap_dac_read_search,cap_fowner,cap_fsetid,cap_kill,cap_setgid,cap_setuid,cap_setpcap,cap_linux_immutable,cap_net_bind_service,cap_net_broadcast,cap_net_admin,cap_net_raw,cap_ipc_lock,cap_ipc_owner,cap_sys_module,cap_sys_rawio,cap_sys_chroot,cap_sys_ptrace,cap_sys_pacct,cap_sys_admin,cap_sys_boot,cap_sys_nice,cap_sys_resource,cap_sys_time,cap_sys_tty_config,cap_mknod,cap_lease,cap_audit_write,cap_audit_control,cap_setfcap,cap_mac_override,cap_mac_admin,cap_syslog,cap_wake_alarm,cap_block_suspend,cap_audit_read,cap_perfmon,cap_bpf,cap_checkpoint_restore

# other utils: setcap, getpcaps, getcap
```


## Resources {#resources}

-   [Understanding Linux Capabilities](https://tbhaxor.com/understanding-linux-capabilities/)
