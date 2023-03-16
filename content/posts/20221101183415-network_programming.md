+++
title = "Network Programming"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Networking]({{< relref "20221101143905-networking.md" >}}), [Operating Systems]({{< relref "20221101172456-operating_systems.md" >}})


## Section 1 {#section-1}

-   **What is a file descriptor?** A file descriptor is simply an integer associated with an open file. But (and here's the catch), that file can be a network connection, a FIFO, a pipe, a terminal, a real on-the-disk file, or just about anything else.
-   **socket()** return the socket descriptor and we can use **send()** and **recv()** socket calls to communicate through it. You can even use **read()** and **write()** but **send()** and **recv()** gives more control.
-   Different types of sockets:
    -   Internet sockets (DARPA sockets, INET Sockets)
        -   Stream Socket (`SOCK_STREAM`)
            -   Reliable two way connected communication
            -   Order is maintained
            -   Error free
            -   **Examples:** telnet, http
            -   Uses TCP and IP
            -   **send()\*** system call
        -   Datagram Socket (`SOCK_DGRAM`)
            -   Sometimes called connectionless sockets, but you can use **connect()** with it.
            -   Error free
            -   Uses UDP and IP
            -   **Examples:** tftp, dhcpcd, games, streaming audio, video conf etc.
            -   **sendto()** system call and just encaptulate the data with a method of choice.
        -   Raw socket
        -   more.
    -   path names on a local node (Unix sockets)
        -   Unix domain sockets use the file system as their address name space.
        -   Processes reference Unix domain sockets as file system inodes
        -   In addition to sending data, processes may send file descriptors across a Unix domain socket connection using the sendmsg() and recvmsg() system calls.
        -   This allows the sending processes to grant the receiving process access to a file descriptor for which the receiving process otherwise does not have access to.
    -   X.25 sockets .. and more.
    -   Netlink socket
        -   Successor to `ioctl`
        -   Netlink is designed and used for transferring miscellaneous networking information between the kernel space and userspace processes.
-   The actual network hardware and topology is transparent to the socket programmer
-   OSI Model

<!--listend-->

```text
  - Application
  - Presentation
  - Session
  - Transport
  - Network
  - Data Link
  - Physical
```


## Section 2 {#section-2}


### IPv4 and IPv6 {#ipv4-and-ipv6}

```text
2001:0db8:c9d2:0012:0000:0000:0000:0051
2001:db8:c9d2:12::51

2001:0db8:ab00:0000:0000:0000:0000:0000
2001:db8:ab00::

0000:0000:0000:0000:0000:0000:0000:0001
::1
```

-   The address `::1` is the loopback address. It always means "this machine I'm running on now". In IPv4, the loopback address is 127.0.0.1.
-   Other than complete ipv4 and ipv6 address there's a compatibility mode to represent ipv4 address in ipv6
    -   192.0.2.33 can be written as `::ffff::192.0.2.33`
-   netmask
    -   netmask is always a bunch of 1-bits followed by a bunch of 0-bits.
-   When about to transmit data, assume that data is in wrong host byte order; that way each time you transmit put the data in a conversion function that arranges data in big endian order.
    -   htons()
    -   htonl()
    -   ntohs()
    -   ntohl() all these are for 32 bit variant


### Data types used by the socket interface {#data-types-used-by-the-socket-interface}

-   a socket descriptor `int`
-   addrinfo `struct` : Prepare the socket address structure.
    -   `getaddrinfo()` returns pointer to a LL of this structure
    -   `ai_addr` field is a pointer to struct `sockaddr`
        -   `sockaddr` : Dealing with `sockaddr` is done with struct `sockaddr_in` or `sockaddr_in6` for ipv6 -&gt; they can be cast vice versa
            -   The `connect()` system by default takes in `sockaddr`
            -   `sockaddr_in` is therefore used as an replacement for `sockaddr`
            -   `sockaddr_in` is padded with 0s in `sin_zero[8]` field using the `memset()` function
                -   if using `sockaddr_in6` there is no `sin_zero` field
            -   `sockaddr_in`'s `sin_port` should be in network byte order.
            -   `sockaddr_in` has `sin_addr` struct which has `s_addr` field which is a `uint32_t`


### IP Address related functions {#ip-address-related-functions}

-   `inet_pton()` : converts an IP address in numbers and dots to `sin_addr`
-   `inet_ntop()` : converts a `sin_addr` to printable IP address in numbers and dots
-   Printable to Network (pton)
-   Network to Printable (ntop)
-   `getaddrinfo` prefered over `gethostbyname()` ??????
-   `getnameinfo` prefered over `gethostbyaddr()` ??????


## System calls finally! {#system-calls-finally}

<!--list-separator-->

-  `getaddrinfo()`

    It helps setup the `structs` you need later on, it does not do any network setup.


## Algorithms {#algorithms}

-   <https://en.wikipedia.org/wiki/Nagle%27s_algorithm>
-   <https://en.wikipedia.org/wiki/TCP_congestion_control#TCP_Tahoe_and_Reno>
