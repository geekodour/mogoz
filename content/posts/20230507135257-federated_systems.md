+++
title = "Federated systems"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Distributed Systems]({{< relref "20221102130004-distributed_systems.md" >}}), [Alternative Internet]({{< relref "20230507105348-alternative_internet.md" >}}), [peer-to-peer]({{< relref "20221101184751-peer_to_peer.md" >}}), [Email]({{< relref "20221101183655-email.md" >}})


## Examples {#examples}


### Email {#email}

-   A federated protocol that everyone on the internet uses.


#### Usage {#usage}

-   Gmail
    -   A centralized service
    -   But if you use a different provider you can still communicate with anyone with an email address.


### ActivityPub {#activitypub}

-   Protocol defining a set of "social network" interactions
-   Any entity implementing this protocol can communicate with the rest of the network.
-   The entire constellation of instances that can interoperate is called the “Fediverse”.


#### Concepts {#concepts}

-   "restful + linked data" stack
    -   ActivityPub + Linked Data Notifications
    -   Using ActivityStreams as its core vocabulary


#### Development {#development}

-   [Activity Pub vs Web Frameworks – Dan Palmer](https://danpalmer.me/2023-01-08-activitypub-vs-web-frameworks/)
-   [Guide for new ActivityPub implementers](https://socialhub.activitypub.rocks/t/guide-for-new-activitypub-implementers/479)


#### Usage {#usage}

-   Mastodon
-   <https://github.com/linkeddata/dokieli>
-   <https://github.com/forgefed/forgefed>
-   [Gitlab's ActivityPub architecture blueprint | Hacker News](https://news.ycombinator.com/item?id=39201453)


### Matrix {#matrix}

-   Protocol designed more for chat than for social networks
-   An open standard for real time communication, like chat and video.
-   For proprietary stuff, there are gateway services which allow Matrix to communicate with existing services but these do have limited functionality.
-   How Matrix does identity is interesting
    -   Users have a Matrix user id
    -   But can also use 3rd party ids.
    -   A Matrix account links to ids such as email addresses, social accounts, and phone numbers.
    -   A globally federated cluster of trusted identity servers verify and replicate the mappings.
-   They now have a P2P implementation too: [Introducing P2P Matrix](https://matrix.org/blog/2020/06/02/introducing-p-2-p-matrix)
-   [FAQ | Matrix.org](https://matrix.org/faq/#what-is-the-difference-between-matrix-and-xmpp)
-   [What happens when a Matrix server disappears?](https://blog.erethon.com/blog/2023/06/21/what-happens-when-a-matrix-server-disappears/)
-   [why not matrix? – Telegraph](https://telegra.ph/why-not-matrix-08-07)


#### Usage {#usage}

-   Element
-   Bridges


### AT Protocol {#at-protocol}

-   Primarily the base for Bluesky
-   A network that aims to enables global long-term public conversations at scale.
-   [How Does BlueSky Work?](https://steveklabnik.com/writing/how-does-bluesky-work)
-   [First impressions of Bluesky's AT Protocol](https://educatedguesswork.org/posts/atproto-firstlook/)
-   [Federation Architecture Overview - Bluesky](https://blueskyweb.xyz/blog/5-5-2023-federation-architecture) (2023)
-   [A Self-Authenticating Social Protocol - Bluesky](https://blueskyweb.xyz/blog/3-6-2022-a-self-authenticating-social-protocol) (2022)
-   [FAQ | AT Protocol](https://atproto.com/guides/faq)
-   2024
    -   <https://newsletter.pragmaticengineer.com/p/bluesky>
    -   <https://jazco.dev/2024/04/15/in-memory-graphs/>
    -   <https://jazco.dev/2024/04/20/roaring-bitmaps/>
-   [ATProto for distributed systems engineers - AT Protocol](https://atproto.com/articles/atproto-for-distsys-engineers)


### IRC {#irc}

-   [Discord vs IRC Rough Notes | Lobsters](https://lobste.rs/s/l7u1j4/discord_vs_irc_rough_notes)


## Resources {#resources}

-   [Beyond Mastodon and Bluesky: Toward a Protocol-Agnostic Federation | Lobsters](https://lobste.rs/s/6ck6of/beyond_mastodon_bluesky_toward_protocol)
-   [Ask HN: Can decentralized social networks scale? | Hacker News](https://news.ycombinator.com/item?id=40773027)
