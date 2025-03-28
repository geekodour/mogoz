+++
title = "Network Programming"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Networking]({{< relref "20221101143905-networking.md" >}}), [Operating Systems]({{< relref "20221101172456-operating_systems.md" >}}), [Subnetting]({{< relref "20230309094219-subnetting.md" >}}), [TCP&amp;UDP]({{< relref "20231206115227-tcp_udp.md" >}})


## Building blocks {#building-blocks}


### File Descriptors {#file-descriptors}

-   See [File Descriptors]({{< relref "20230315164241-file_descriptors.md" >}})
-   A file descriptor is simply an integer associated with an open file. But (and here's the catch), that file can be a network connection, a FIFO, a pipe, a terminal, a real on-the-disk file, or just about anything else.


### Socket {#socket}

Means different things

-   Kernel: Endpoint of communication
-   Application
    -   socket() return the `socket descriptor` and we can use **send()** and **recv()** socket calls to communicate through it.
    -   You can even use **read()** and **write()** but **send()** and **recv()** gives more control.
    -   Client and Server communicate via reading/writing to `socket descriptors`
-   [Disk I/O]({{< relref "20230402013722-disk_i_o.md" >}}) and Socket I/O differs in how we `open` the socket descriptor.


### OSI model {#osi-model}

-   The actual network hardware and topology is transparent to the socket programmer


### Network algorithms {#network-algorithms}

-   [Nagle's algorithm - Wikipedia](https://en.wikipedia.org/wiki/Nagle%27s_algorithm)
-   [TCP congestion control - Wikipedia](https://en.wikipedia.org/wiki/TCP_congestion_control#TCP_Tahoe_and_Reno)


### Ports {#ports}


#### Meta {#meta}

-   There is no such thing as a port being open or closed. Ports aren't real.
-   They are just a two byte label in a network packet that tell both the router and client what to do with it.


#### Open ports {#open-ports}

-   In both TCP and UDP, source and destination ports are of 16bit (2byte)
-   Max number of open ports in an IP is 2<sup>16</sup> = 65536 =&gt; 65535
-   If a computer gets another IP assigned to it, in that case it gets another 65535 ports.
-   So the no. of open ports a computer can have = `no. of ip * 65535`


#### Listening ports {#listening-ports}

-   If you connect to some port which is listening, you don't consume the remote port. (In case of [Web Server]({{< relref "20230310200327-web_server.md" >}}) there's additional things that happen)
    -   It remains open for others and also for you.
    -   Each connection you make, makes a `4-tuple` combination and when you make a connection to `sever_ip:80`
        -   connection1: `your_local_ip:random_port1` &lt;=&gt; `server_ip:80`
        -   connection2: `your_local_ip:random_port2` &lt;=&gt; `server_ip:80`
        -   See this in action w `ss -tpn`


### TCP and UDP {#tcp-and-udp}

> To learn TCP, read the RFCs to understand the design, then dive into the Linux
> kernel’s TCP code. Build your own TCP stream replay tool (around 1,000 lines of
> code), and within a year, you'll be ahead of 99.99% of people in this field.
>
> wangbin579
>
> <https://github.com/session-replay-tools/tcpcopy>

See [TCP&amp;UDP]({{< relref "20231206115227-tcp_udp.md" >}})


## Different types of sockets {#different-types-of-sockets}


### Internet sockets (DARPA sockets, INET Sockets) {#internet-sockets--darpa-sockets-inet-sockets}


#### Stream Socket (`SOCK_STREAM`) {#stream-socket--sock-stream}

-   Reliable two way connected communication
-   Order is maintained
-   Error free
-   Uses TCP and IP
-   `send()` syscall
-   **Examples:** telnet, http


#### Datagram Socket (`SOCK_DGRAM`) {#datagram-socket--sock-dgram}

-   Sometimes called connectionless sockets, but you can use **connect()** with it.
-   Error free
-   Uses UDP and IP
-   `sendto()` just encaptulate the data with a method of choice
-   **Examples:** tftp, dhcpcd, games, streaming audio, video conf etc.


#### Raw socket {#raw-socket}


#### Other sockets {#other-sockets}


### Unix sockets {#unix-sockets}

-   **Unix sockets are faster than TCP sockets over loopback**
-   path names on a local node (Unix sockets)
-   Unix domain sockets use the file system as their address name space.
-   Processes reference Unix domain sockets as file system inodes
-   In addition to sending data, processes may send file descriptors across a Unix domain socket connection using the sendmsg() and recvmsg() system calls.
-   This allows the sending processes to grant the receiving process access to a file descriptor for which the receiving process otherwise does not have access to.


### X.25 sockets {#x-dot-25-sockets}


### Netlink socket {#netlink-socket}

-   Successor to `ioctl`
-   Netlink is designed and used for transferring miscellaneous networking information between the kernel space and userspace processes.


## Network API {#network-api}


### Endian ordering {#endian-ordering}

-   When about to transmit data, assume that data is in wrong host byte order; that way each time you transmit put the data in a conversion function that arranges data in big endian order.
-   32 bit variant examples: htons(), htonl(), ntohs(), ntohl()


### IP Address related functions {#ip-address-related-functions}

-   `inet_pton()` : converts an IP address in numbers and dots to `sin_addr`
-   `inet_ntop()` : converts a `sin_addr` to printable IP address in numbers and dots
-   Printable to Network (pton)
-   Network to Printable (ntop)
-   `getaddrinfo` prefered over `gethostbyname()` ??????
-   `getnameinfo` prefered over `gethostbyaddr()` ??????


### <span class="org-todo todo TODO">TODO</span> Data types used by the socket interface {#data-types-used-by-the-socket-interface}

-   a socket descriptor `int`
-   addrinfo struct : Prepare the socket address structure.
    -   `getaddrinfo()` returns pointer to a LL(Link local??) of this structure
    -   `ai_addr` field is a pointer to struct `sockaddr`
        -   `sockaddr` : Dealing with `sockaddr` is done with struct `sockaddr_in` or `sockaddr_in6` for ipv6 -&gt; they can be cast vice versa
            -   The `connect()` system by default takes in `sockaddr`
            -   `sockaddr_in` is therefore used as an replacement for `sockaddr`
            -   `sockaddr_in` is padded with 0s in `sin_zero[8]` field using the `memset()` function
                -   if using `sockaddr_in6` there is no `sin_zero` field
            -   `sockaddr_in`'s `sin_port` should be in network byte order.
            -   `sockaddr_in` has `sin_addr` struct which has `s_addr` field which is a `uint32_t`


## tun/tab/linux {#tun-tab-linux}

-   <https://www.kernel.org/doc/Documentation/networking/tuntap.txt>
-   [TUN/TAP - Wikipedia](https://en.wikipedia.org/wiki/TUN/TAP)
-   [Tun/Tap interface tutorial](https://backreference.org/2010/03/26/tuntap-interface-tutorial/)


## Use-cases {#use-cases}


### Bidirectional socket {#bidirectional-socket}

-   [What's the read logic when I call recvfrom()](https://stackoverflow.com/questions/65269499/whats-the-read-logic-when-i-call-recvfrom-function-in-c-c)
-   [Maintaining a bidirectional UDP connection](https://stackoverflow.com/questions/15794271/maintaining-a-bidirectional-udp-connection)
-   [The SO_REUSEPORT socket option {LWN.net}](https://lwn.net/Articles/542629/) (Diff applications, listen on the same socket)


### Network Programming for Games {#network-programming-for-games}

-   <https://github.com/ValveSoftware/GameNetworkingSockets>
-   [networkprotocol/netcode](https://github.com/networkprotocol/netcode)


## Links {#links}

-   [Quake 3 Source Code Review: Network Model (2012) | Hacker News](https://news.ycombinator.com/item?id=42218532)
-   [The trouble with struct sockaddr's fake flexible array [LWN.net]​](https://lwn.net/Articles/997094/)
