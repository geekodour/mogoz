+++
title = "Local First Software (LoFi)"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Human Computer Interaction ( HCI )]({{< relref "20230806231355-human_computer_interaction_hci.md" >}}), [peer-to-peer]({{< relref "20221101184751-peer_to_peer.md" >}}), [Alternative Internet]({{< relref "20230507105348-alternative_internet.md" >}})

I like how Kyle Mathews [describes local first software](https://bricolage.io/some-notes-on-local-first-development/), most of this doc is extracting things out of his blogpost:

> “local-first” as shifting reads and writes to an embedded database in each client via“sync engines” that facilitate data exchange between clients and servers.
>
> Useful for applications that demand stuff to be either of but not limited to real-time, collaborative(multiplayer), or offline.
>
> Did people have to be online to collaborate online? Or could they work offline and collaborate peer-to-peer?


## Related Ideas {#related-ideas}


### Sync Engines {#sync-engines}

-   Robust database-grade syncing technology to ensure that data is consistent and up-to-date.
-   To fully replace client-server APIs, sync engines need
    -   Robust support for fine-grained access control
    -   Complex write validation


#### Issues {#issues}

-   Clients tend to have unrestricted write access and updates are immediately synced to other clients. While this is generally fine for text collaboration or multiplayer drawing, this wouldn’t work for a typical ecommerce or SaaS application.
-   Sync engines can drive consistency within a system but real-world systems also need an authoritative server which can enforce consistency within external constraints and systems.


#### CRDT based {#crdt-based}

-   See [crdt]({{< relref "20230607045339-crdt.md" >}})


### Distributed state machine {#distributed-state-machine}

-   See [Signals and Threads | State Machine Replication, and Why You Should Care](https://signalsandthreads.com/state-machine-replication-and-why-you-should-care/)
-   Towards "Handle writes that need an authoritative server"
-   By emulating API request/response patterns through: A distributed state machine running on a replicated object.
-   i.e we write interactions w external services in a way so that requests/responses have the same multiplayer, offline, real-time sync properties as the rest of the app.
-   This synchronization can be at the application, network or other levels of the stack


#### 2 Primary idea that makes synchronization easy {#2-primary-idea-that-makes-synchronization-easy}

-   **A reliable, ordered message stream**: Every machine in the system sees the messages in the same order.
-   **A fully-deterministic compute environment**: Given the same inputs always result in the same outputs


### Partially replication {#partially-replication}

-   Query-based sync to partially replicate


## Basics {#basics}

-   Instead of always assuming that the server is the authortative source, we assumed that the user's local device is the authoritative source of information
-   The default consistency mode is eventual consistency
    -   This means that state and compute can naturally exist at the edge
    -   Only brought to the "center" when there is a need for strong consistency


### Challenges {#challenges}

From [Why SQLite? Why Now? 🐇 - Tantamanlands](https://tantaman.com/2022-08-23-why-sqlite-why-now.html#enabling-the-relational-model-for-more-use-cases)

-   How much data can you store locally?
-   How do you signal to the user that their local set of data could be incomplete from the perspective of other peers?
-   How do we bless certain peers (or servers) as authoritative sources of certain sets of information?
-   What CRDTs are right for which use cases?


## Approaches {#approaches}


### Replicated protocols {#replicated-protocols}

-   This is what Replicache currently does, client JS library along with a replication protocol.


#### Projects {#projects}

-   Services
    -   [Replicache](https://replicache.dev/) (Replicated protocol): sync engine is “some assembly required”


### Replicated Data Structures {#replicated-data-structures}

-   Building block [Data Structures]({{< relref "20230403192236-data_structures.md" >}})
-   Provide APIs similar to native Javascript maps and arrays
    -   Guarantee state updates are replicated to other clients and to the server.
-   Most replicated data structures rely on [crdt]({{< relref "20230607045339-crdt.md" >}}) algorithms to merge concurrent and offline edits from multiple clients.
-   If not a replicated data structure, we'd have to pass that info though websockets/requests/messaging services etc.


#### Projects {#projects}

-   OSS
    -   Yjs, [Automerge](https://automerge.org/)(updated!)
        -   Automerge: Add a few lines of code to your react app, and you get sync across devices + local persistence!
    -   [jazz](https://jazz.tools/) (Replicated data structure)
-   Services: Liveblocks, Partykit, Triplit, Ditto etc.


### Replicated Database {#replicated-database}

Write to your database while offline. I can write to mine while offline. We can then both come online and merge our databases together, without conflict. See [Data Replication]({{< relref "20231021151742-data_replication.md" >}}). Also see [Riffle Systems](https://riffle.systems/)


#### Postgres-SQlite {#postgres-sqlite}

Write to [PostgreSQL]({{< relref "20221102123302-postgresql.md" >}}) and replicate to a client side db such as [sqlite]({{< relref "20230702184501-sqlite.md" >}})

-   [ElectricSQL](https://electric-sql.com/) (write back)
-   [powersync](https://www.powersync.co/) (white back)
-   [sqledge](https://news.ycombinator.com/item?id=37063238) (readonly? from the creators of [ably](https://ably.com/spaces))


#### sqlite - sqlite {#sqlite-sqlite}

-   [cr-sqlite](https://github.com/vlcn-io/cr-sqlite)
    -   [Trying out cr-sqlite on macOS | Simon Willison’s TILs](https://til.simonwillison.net/sqlite/cr-sqlite-macos)
-   <https://github.com/orbitinghail/sqlsync>
-   [Mycelial](https://www.mycelial.com/platform)


## War stories {#war-stories}


### HN Comment 1 {#hn-comment-1}

-   Initially we tried to use IndexDB to give us more of the local-first features by caching between loads, but it was more hassle than it was worth.
-   Instead we settled on live queries using Hasrua (we were a very early user / paying customer). We preload all the data that the user is going to need on app boot and then selectively load large chunks as they open their projects. These are then keeping mobx models up to date.
-   For mutating data we have a simple transaction system that you wrap around models to update them. It records and sends the mutations and makes sure that outstanding mutations are replayed over model changes locally.


### Others {#others}

-   Offline support just kinda happened for free. Once I added a service worker to serve the app code offline, Automerge can just persist writes to local IndexedDB and then sync when network is back again, not a big deal. Classic local-first win


## Links and Resources {#links-and-resources}

-   [Local-First Web Development](https://localfirstweb.dev/)
-   [Alternatives - ElectricSQL](https://archive.is/dAfxh)
-   [pazguille/offline-first](https://github.com/pazguille/offline-first)
-   <https://braid.org/> (wg)
    -   See <https://braid.org/meeting-2>
