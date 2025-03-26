+++
title = "Synchronization"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Local First Software (LoFi)]({{< relref "20230915141853-local_first_software.md" >}}), [Distributed Systems]({{< relref "20221102130004-distributed_systems.md" >}})


## Different Architectures {#different-architectures}


## Building sync engine {#building-sync-engine}

-   [Rearchitecting: Redis to SQLite | Wafris](https://wafris.org/blog/rearchitecting-for-sqlite)


## FAQ {#faq}


### How does Figma do it? {#how-does-figma-do-it}

-   "Our servers currently spin up a separate process for each multiplayer document which everyone editing that document connects to."
    -   [The next evolution of serverless is stateful • Solving the decision problem](https://sunilpai.dev/posts/the-future-of-serverless/)


### How does PartyKit do it? {#how-does-partykit-do-it}

> "With a model like PartyKit, building a system that can synchronise state is straightforward: Hold that state in memory, let websockets (or http requests!) connect to the same process. When clients “send” changes to said state, broadcast those changes to all connected clients. Depending on the usecase, you can use fancier data structures to model the state (like CRDTs or OTs), setup state machines to model workflows, or use a pubsub model to broadcast events."

-   This draws the boundaries nicely about the network aspect, and the managing the state Aspect.


### Some Usecases {#some-usecases}

-   See <https://sunilpai.dev/posts/the-future-of-serverless/>
-   Multiplayer
    -   A single person with multiple devices can be multiplayer, would expect their devices to be in sync


## Related tech {#related-tech}

-   WebDAV
-   <https://en.wikipedia.org/wiki/Session_Initiation_Protocol>
-   [Easy file-sharing with WebDAV](https://scvalex.net/posts/70/)
-   [Atomic Attributes in Local-First Sync – Adam Wulf](https://adamwulf.me/2022/04/atomic-attributes-in-local-first-sync/)
