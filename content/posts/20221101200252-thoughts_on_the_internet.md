+++
title = "Thoughts on the Internet"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Internet]({{< relref "20221101190707-internet.md" >}})


## What is a protocol? {#what-is-a-protocol}

A network protocol primarily has to decide on two primary things:

-   What should be the structure of the packet to be sent.
-   What should be the communication pattern thereafter.

The communication between layers is defined by protocols.

Let's talk about `TCP/IP` and `UDP`, `IP` protocol by itself does not provide **reliabilty, ordering, naming(Ports), flow-control** but `TCP/IP` does provide these four. `UDP` has different features, mostly used when `TCP/IP` is not the best choice for that kind of data transfer. `IP` provides naming in terms of IP addresses, TCP and UDP provide naming in terms of port numbers.


### Internet Protocol Suit {#internet-protocol-suit}

The Internet protocol suite is the conceptual model and some core protocols in it are `TCP/IP`,=UDP/IP=,=ICMP= etc.


## End to End Principle {#end-to-end-principle}

If you're on the internet, you'll need to be using the `IP` protocol. What brings in ordering and realiability to `IP` is `TCP`, and `TCP` does not run in the core of the internet(the network), `TCP` runs in the end user systems (in the endpoints).

The idea of end-to-end principle is that _"push as much functionality as possible to the ends of the network"_. It's super easy to roll-out new protocols on the internet because of the end-to-end principle.


## Robustness Principle {#robustness-principle}

Protocol implementations should try to be as accomodating as possible, i.e handle any unexpected packet or response gracefully.

The way protocols are arranged on the internet can be termed as the _Internet Protocol Stack_, this stack tries to achieve two primary goals: Separation of concerns and Reuse good ideas. Eg. `TCP/IP` is implemented at OS level whereas `HTTP` is an application level protocol.


## Last mile problem {#last-mile-problem}

The core of the internet is very fast, if you're facing slow connection it's mostly because of some kind of congestion between you and your internet provider or the similar problem on the other end of which the content you're trying to access. So, if you can get speed on the edge, you can really improve performance.


### Deep web and Dark web {#deep-web-and-dark-web}

In a social context, we can separate deep web as something that requires authentication(mail/social-media etc.) on the other hand, dark web is something that requires you to have special software. The line is not very clear.


## TCP Fairness {#tcp-fairness}

TCP does slow start and allows multiple clients to share internet resources, TCP does this by increasing the speed unless it sees packet loss. Violation of **Net neutrality** would mean exploitation of TCP Fairness in a way.


## Multihoming {#multihoming}

Multihoming is the practice of connecting a host or a computer network to more than one network. This can be done in order to increase reliability or performance.


## Web of Trust {#web-of-trust}

The web of trust concept was first put forth by PGP creator Phil Zimmermann in 1992, it is used to establish the authenticity of the binding between a public key and its owner.


## `circuit-switched` vs `packet-switched` {#circuit-switched-vs-packet-switched}

Old telephone networks, a telephone operator would physically connect your call to the person you wanted to talk to. Packet switched network instead splits the user data into packets and sends that over. This way we can utilize our network more.

In `circuit-switching` we can do `sub-channel` division multiplexing or `time` division multiplexing.

**Packets** are basically fixed size unit of data. In `packet-switching` data and address is sent as a packet, each packet goes one hop at a time. No bandwidth is wasted as no bandwidth is allocated to any user, it's used on demand based on `statistical-time` division multiplexing. It's great for brusty data.


## Onion routing {#onion-routing}

Main goal is to establish a conn. between `A` and `B` but all the routers in between don't know where the packet is destined to go or where it came from. All it knows about is _"Which router sent the packet"_ and _"Which router it send the packet to"_. Typical core internet routers don't do onion routing, we need computers to act as onion routers to form this network. Eg. `Tor` network.


## IP Address {#ip-address}

Routers maintain a routing table(these can't be too large), we know that there are `2^32(~4Bn)` IPv4 addresses. The hierarchical structure of the IP address helps keep the routing table smaller, just by looking at the prefix the router is able to determine which `AS` should this packet be sent to.

Private and unroutable IP addresses play a very important role in scaling the internet.


## store-and-forward {#store-and-forward}

Store and forward is a telecommunications technique in which information is sent to an intermediate station where it is kept and sent at a later time to the final destination or to another intermediate station. The intermediate station, or node in a networking context, verifies the integrity of the message before forwarding it. The dropping of packets when the buffer is full is either `drop-tail` or `drop-head`.


## Routing {#routing}

The function of the `Router` is to determine where packets should go. The core internet routers just talk in `IP`.


## The physical infrastructure {#the-physical-infrastructure}

Even though you're interacting digitally through the cyberspace, that data, that signal does interact with some physical infrastructure sitting somewhere in some part of the world.

Twisted pair cables are interesing because the way they are twisted ultimately impact the performance of the cable. Fiber optics cable are [pretty vulnerable](https://www.youtube.com/watch?v=X-hAtc-ku-Y) without encryption though.

Telephone lines, Cable lines can be used to deliver internet to people, this is using preexisting infrastructure.


## Internet of Things {#internet-of-things}

The interconnection via the Internet of computing devices embedded in everyday objects, enabling them to send and receive data.


## Social Aspect {#social-aspect}

Internet is full of information and at the same time it is also full of misinformation.


## Source {#source}

-   [internet-class](https://www.youtube.com/watch?v=_KrCQPR2I4s&list=PLk97mPCd8nvayBmPKnaIdgdYIKpuhpJoe&index=9)


## Links {#links}

-   [How the Internet works: Submarine fiber, brains in jars, and coaxial cables](https://arstechnica.com/information-technology/2016/05/how-the-internet-works-submarine-cables-data-centres-last-mile/)
