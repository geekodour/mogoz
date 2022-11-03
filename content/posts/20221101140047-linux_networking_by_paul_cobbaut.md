+++
title = "Linux Networking by Paul Cobbaut"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Book]({{< relref "20220728201439-book.md" >}})

By Paul Cobbaut

> This book is from 2015 and I am reading this book in 2020.


## Table of contents <span class="tag"><span class="TOC">TOC</span></span> {#table-of-contents}

-   [Summary](#summary)
-   [Chapter 1: General Networking](#chapter-1-general-networking)
-   [Chapter 2. Interface configuration](#chapter-2-interface-configuration)
-   [Chapter 7. Introduction to Networking](#chapter-7-introduction-to-networking)
-   [Chapter 9. Introduction to squid](#chapter-9-introduction-to-squid)


## Summary {#summary}

It's 300 pages long and it introduces itself as a book for newbie Linux System Admins who want to learn more about Networking, so this book is trying to be a teacher here. Sadly this book is not IPv6 centric, has a lot of obsolete commands. I was surprised because the author mentions that the tools are obsolete and still goes on explaining them by command snippets and not explaining a lot about the underlying concepts, which I think is good sometimes but I would like it the other way round. The way this book is written seems more like a blogpost and could possibly be better presented as a multi-part blog post. I found this book randomly on the Internet, I should stop ranting about it. It's 3:37 AM.

I'd rate this book 3/10 because a lot of information is kind of obsolete now, maybe I'd give it more if I read it 5 years ago. If you want to read this book, I'd suggest finding a better alternative because even though it's useful information, it's poorly presented and a lot of the things are obsolete. I think the author knows his stuff(?) but the presentation sucked and it tried teaching too many things. brutal honest.


## Chapter 1: General Networking {#chapter-1-general-networking}

This chapter gives a basic intro to the OSI and TCP/IP models. We can see the stacking of different layers of the network from this output of Wireshark for `DHCP` packet,=NTP= packet and `ARP` broadcast respectively:

```text
[Protocols in Frame: eth:ip:udp:bootp]
[Protocols in frame: eth:ip:udp:ntp]
[Protocols in frame: eth:arp]
```

This section also introduces **unicast, multicast, broadcast and anycast**, the book totally skims over the ideas. I've written about [Data Traversal]({{< relref "20221101141901-data_traversal.md" >}})


## Chapter 2. Interface configuration {#chapter-2-interface-configuration}

Obsolete but useful command demos of the same commands in different linux distributions. I kind of got lost interest in the pages and skimmed though the book when Chapter 7 caught my attention.


## Chapter 7. Introduction to Networking {#chapter-7-introduction-to-networking}

A book about networking and the 7th chapter is titled "Introduction to Networking". This chapter starts off with explaining `iptables`.


## Chapter 9. Introduction to squid {#chapter-9-introduction-to-squid}

This chapter again caught my attention, section `9.6 upside down images`.

a-book-about-linux-networking going haywire. I think the DNS part that followed were good, even if it was shallow.
