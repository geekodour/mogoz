+++
title = "Local First Software (LoFi)"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Human Computer Interaction ( HCI )]({{< relref "20230806231355-human_computer_interaction_hci.md" >}}), [peer-to-peer]({{< relref "20221101184751-peer_to_peer.md" >}}), [Alternative Internet]({{< relref "20230507105348-alternative_internet.md" >}}), [WebAssembly]({{< relref "20230510200213-webassembly.md" >}}),  [Synchronization]({{< relref "20240816134029-synchronization.md" >}})

I like how Kyle Mathews [describes local first software](https://bricolage.io/some-notes-on-local-first-development/), most of this doc is extracting things out of his blogpost:

> “local-first” as shifting reads and writes to an embedded database in each client via“sync engines” that facilitate data exchange between clients and servers.
>
> Useful for applications that demand stuff to be either of but not limited to real-time, collaborative(multiplayer), or offline.
>
> Did people have to be online to collaborate online? Or could they work offline and collaborate peer-to-peer?

-   nice ecosystem review: [GitHub - arn4v/offline-first: A list of projects in the offline-first storage, sync &amp; realtime collaboration/multiplayer space.​](https://github.com/arn4v/offline-first)


## Ecosystem concepts {#ecosystem-concepts}


### Sync Engines {#sync-engines}

See [Synchronization]({{< relref "20240816134029-synchronization.md" >}})


### Distributed state machine / Replicated state machine (RSM) / State machine replication {#distributed-state-machine-replicated-state-machine--rsm--state-machine-replication}

> -   [State machine replication - Wikipedia](https://en.wikipedia.org/wiki/State_machine_replication)
> -   This is a variant of Paxos. See [Consensus Protocols]({{< relref "20231118205116-consensus_protocols.md" >}})
> -   See [Signals and Threads | State Machine Replication, and Why You Should Care](https://signalsandthreads.com/state-machine-replication-and-why-you-should-care/) 🌟

-   Towards "Handle writes that need an authoritative server"
-   By emulating API request/response patterns through: A distributed state machine running on a replicated object.
-   i.e we write interactions w external services in a way so that requests/responses have the same multiplayer, offline, real-time sync properties as the rest of the app.
-   This synchronization can be at the application, network or other levels of the stack


#### 2 Primary idea that makes synchronization easy {#2-primary-idea-that-makes-synchronization-easy}

-   **A reliable, ordered message stream**: Every machine in the system sees the messages in the same order.
-   **A fully-deterministic compute environment**: Given the same inputs always result in the same outputs


### Partially replication {#partially-replication}

-   Query-based sync to partially replicate


### UI/UX ecosystem around local first {#ui-ux-ecosystem-around-local-first}

-   [GitHub - TanStack/optimistic: Optimistic UI library for sync engines](https://github.com/TanStack/optimistic?tab=readme-ov-file) (This can be used with ElectricSQL)
-   ElectricSQL itself can sort of replace TanStack query but this `optimistic ui` library is different and can be combined with


### Personal &amp; Local software {#personal-and-local-software}

See [Software Possession for Personal Use | olano.dev](https://olano.dev/blog/software-possession-for-personal-use/)


## Basics {#basics}


### Architecture for LoFi {#architecture-for-lofi}

-   Instead of always assuming that the server is the authortative source, we assumed that the user's local device is the authoritative source of information
-   The default consistency mode is [Eventual Consistency]({{< relref "20231117135755-eventual_consistency.md" >}})
    -   This means that state and compute can naturally exist at the edge
    -   Only brought to the "center" when there is a need for strong consistency


### Challenges {#challenges}

From [Why SQLite? Why Now? 🐇 - Tantamanlands](https://tantaman.com/2022-08-23-why-sqlite-why-now.html#enabling-the-relational-model-for-more-use-cases)

-   How much data can you store locally?
-   How do you signal to the user that their local set of data could be incomplete from the perspective of other peers?
-   How do we bless certain peers (or servers) as authoritative sources of certain sets of information?
-   What CRDTs are right for which use cases?


## Approaches {#approaches}


### Categorization {#categorization}


#### Replicated protocols {#replicated-protocols}

-   This is what Replicache currently does, client JS library along with a replication protocol.


#### Replicated Data Structures {#replicated-data-structures}

-   Building block [Data Structures]({{< relref "20230403192236-data_structures.md" >}})
-   Provide APIs similar to native Javascript maps and arrays but `guarantees` state updates are replicated to other clients and to the server.
-   Most replicated data structures rely on [crdt]({{< relref "20230607045339-crdt.md" >}}) algorithms to merge concurrent and offline edits from multiple clients.
-   If not a replicated data structure, we'd have to pass that info though websockets/requests/messaging services etc manually.


#### Replicated Database {#replicated-database}

-   Write to your database while offline. I can write to mine while offline. We can then both come online and merge our databases together, without conflict. See [Data Replication]({{< relref "20231021151742-data_replication.md" >}}).
-   Some of these just do syncing, some do partial sync, some do client side storage as-well etc. It's a mixed bag.


#### Offline/Browser only database {#offline-browser-only-database}

In this architecture you basically don't really do sync but just use a [WebAssembly]({{< relref "20230510200213-webassembly.md" >}}) browser ([duckdb](https://motherduck.com/blog/olap-database-in-browser/), sqlite, pglite  etc) but don't sync back. This is more like local-only instead of local first. See [this](https://lobste.rs/s/yn7pbi/serverfree_architecture_run_backend) for an example.


### Tools/Implementations {#tools-implementations}

> -   See <https://gist.github.com/pesterhazy/3e039677f2e314cb77ffe3497ebca07b>
> -   See (2020) <https://jaredforsyth.com/posts/in-search-of-a-local-first-database/>
> -   See ElectricSQL's Alternative page

| Category                       | Tool Name                                                                                          | Type / Sub-category | Description/Notes                                                                                                                                                                                                                                                                                                           | Interesting? |
|--------------------------------|----------------------------------------------------------------------------------------------------|---------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------|
| **Replicated Protocols**       | [Replicache](https://replicache.dev/)                                                              | Service             | Client JS library and replication protocol. Sync engine requires some setup ("some assembly required").                                                                                                                                                                                                                     |              |
| **Replicated Data Structures** | [Yjs](https://news.ycombinator.com/item?id=42731582)                                               | OSS                 | Relies on CRDTs to merge concurrent/offline edits. Provides APIs similar to native JS maps/arrays.                                                                                                                                                                                                                          |              |
|                                | [Automerge](https://automerge.org/)                                                                | OSS                 | Relies on CRDTs. Allows sync across devices + local persistence with minimal code changes in React apps.                                                                                                                                                                                                                    |              |
|                                | [jazz](https://jazz.tools/)                                                                        | OSS                 | Described as a replicated data structure.                                                                                                                                                                                                                                                                                   |              |
|                                | Liveblocks                                                                                         | Service             | Listed as a service providing replicated data structures.                                                                                                                                                                                                                                                                   |              |
|                                | Partykit                                                                                           | Service             | Listed as a service providing replicated data structures.                                                                                                                                                                                                                                                                   |              |
| off-the-shelf                  | [InstantDB](https://www.youtube.com/watch?v=6FikTQf8qho)                                           | Other               | modern Firebase. See [explanation.](https://stopa.io/post/296), inspired by Clojure and Datomic                                                                                                                                                                                                                             | 🌟           |
|                                | [ElectricSQL](https://electric-sql.com/)                                                           | Postgres-SQLite     | Replicates writes from PostgreSQL to client-side SQLite. Supports write-back and partial replication.                                                                                                                                                                                                                       | 🌟           |
|                                | [PowerSync](https://www.powersync.co/)                                                             | Postgres-SQLite     | Replicates writes from databases (incl. PostgreSQL) to client-side SQLite. Supports write-back, partial replication, sync from multiple DBs.                                                                                                                                                                                |              |
|                                | [tinybase](https://tinybase.org/)                                                                  | Other               | the main dev has a yatch. Here are some [slides](https://tripleodeon.com/2022/11/closing-the-gap-between-your-users-and-their-data)                                                                                                                                                                                         |              |
|                                | [rxdb](https://rxdb.info/)                                                                         | Other               | I find rxdb to look visually similar to tinybase                                                                                                                                                                                                                                                                            |              |
|                                | [zerosync](https://zero.rocicorp.dev/)                                                             | Other               |                                                                                                                                                                                                                                                                                                                             |              |
|                                | [Ditto](https://docs.ditto.live/home/about-ditto)                                                  | Service             | database with edge device connectivity and resiliency, synchronize `without relying on a central server`, so [crdt]({{< relref "20230607045339-crdt.md" >}}) + [peer-to-peer]({{< relref "20221101184751-peer_to_peer.md" >}})                                                                                              | 🌟           |
|                                | Google Firebase                                                                                    | Service             | Google offers two realtime databases under the Firebase brand. Cloud Firestore and Firebase Realtime Database.                                                                                                                                                                                                              |              |
|                                | [couchdb](https://docs.couchdb.org/en/stable/intro/index.html) and [pouchdb](https://pouchdb.com/) |                     | Couchdb is a database based around replication. Pouchdb offers an in-browser database with server replication, and did so before it was cool.                                                                                                                                                                               |              |
|                                | [aws app-sync](https://www.youtube.com/watch?v=KcYl6_We0EU)                                        |                     |                                                                                                                                                                                                                                                                                                                             |              |
| Replicated Database            |                                                                                                    |                     |                                                                                                                                                                                                                                                                                                                             |              |
|                                | [sqledge](https://news.ycombinator.com/item?id=37063238)                                           | Postgres-SQLite     | Sync engine possibly for readonly replication from Postgres. From the creators of [Ably](https://ably.com/).                                                                                                                                                                                                                |              |
|                                | [cr-sqlite](https://github.com/vlcn-io/cr-sqlite)                                                  | SQLite-SQLite       | CRDT-based replication between SQLite instances.                                                                                                                                                                                                                                                                            | 🌟           |
|                                | [sqlsync](https://github.com/orbitinghail/sqlsync)                                                 | SQLite-SQLite       | Provides a custom storage layer for SQLite sync. Original version supported full DB sync only with a simpler engine.                                                                                                                                                                                                        |              |
|                                | [graft](https://github.com/orbitinghail/graft)                                                     | SQLite-SQLite       | From the same team as sqlsync; allows partial sync/replication. Check [this thread](https://news.ycombinator.com/item?id=43537272) which [discusses](https://sqlsync.dev/posts/stop-syncing-everything/#consistency-sync-safely) the [consistency model]({{< relref "20231113121413-concurrency_consistency_models.md" >}}) | 🌟           |
|                                | [Mycelial](https://www.mycelial.com/platform)                                                      | SQLite-SQLite       | Platform for replicating SQLite databases.                                                                                                                                                                                                                                                                                  |              |
|                                | [Evolu](https://www.evolu.dev/docs)                                                                | Other (SQLite/OPFS) | Seems to use SQLite on top of OPFS (Origin Private File System) for replication.                                                                                                                                                                                                                                            |              |
|                                | [Triplit](https://news.ycombinator.com/item?id=40788648)                                           | Other (IndexedDB)   | Uses IndexedDB for storage and replication. Also listed initially as a Replicated Data Structure service.                                                                                                                                                                                                                   |              |
| **Offline/Browser Only DB**    | [duckdb](https://motherduck.com/blog/olap-database-in-browser/)                                    | Browser DB (Wasm)   | Example of a WebAssembly database for browser use, typically local-only without sync-back in this context.                                                                                                                                                                                                                  |              |
|                                | sqlite                                                                                             | Browser DB (Wasm)   | Example of a WebAssembly database (like DuckDB) for browser-only use.                                                                                                                                                                                                                                                       |              |
|                                | pglite                                                                                             | Browser DB (Wasm)   | Example of a WebAssembly database (like DuckDB/SQLite) for browser-only use.                                                                                                                                                                                                                                                |              |


## War stories {#war-stories}


### HN Comment 1 {#hn-comment-1}

-   Initially we tried to use IndexDB to give us more of the local-first features by caching between loads, but it was more hassle than it was worth.
    -   <https://gist.github.com/nolanlawson/dc80e449079c2bc33170>
-   Instead we settled on live queries using Hasrua (we were a very early user / paying customer). We preload all the data that the user is going to need on app boot and then selectively load large chunks as they open their projects. These are then keeping mobx models up to date.
-   For mutating data we have a simple transaction system that you wrap around models to update them. It records and sends the mutations and makes sure that outstanding mutations are replayed over model changes locally.


### Others {#others}

-   Offline support just kinda happened for free. Once I added a service worker to serve the app code offline, Automerge can just persist writes to local IndexedDB and then sync when network is back again, not a big deal. Classic local-first win


## Links, Tools and Resources {#links-tools-and-resources}


### Community {#community}

-   [Lo.Fi (Local First) Meetups - YouTube](https://www.youtube.com/playlist?list=PLTbD2QA-VMnXFsLbuPGz1H-Najv9MD2-H)
    -   [Local First Podcast - YouTube](https://www.youtube.com/@localfirstfm)


### Tools {#tools}

-   [Alternatives - ElectricSQL](https://archive.is/dAfxh)
-   [pazguille/offline-first](https://github.com/pazguille/offline-first) (offline first is different set of things than local first i think, this is pre-lofi movement)
