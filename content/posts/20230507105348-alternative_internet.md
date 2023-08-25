+++
title = "Alternative Internet"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [peer-to-peer]({{< relref "20221101184751-peer_to_peer.md" >}}), [Archival]({{< relref "20230115032923-archival.md" >}}), [NAT]({{< relref "20221101190313-nat.md" >}}), [Internet]({{< relref "20221101190707-internet.md" >}}), [File Sharing]({{< relref "20230419105440-file_sharing.md" >}})


## Structure {#structure}

{{< figure src="/ox-hugo/20230507105348-alternative_internet-1117137053.png" >}}

-   Calling [a network “decentralized” only defines it by what it is not](https://scribe.rip/decentralized-web/decentralized-social-networks-e5a7a2603f53)
    -   It is not dependent on a single set of servers run by one company.
    -   What it actually is can look like many different things.
-   Centralized and [Distributed]({{< relref "20221102130004-distributed_systems.md" >}}) are easy to understand, Decentralized is a mess but here's what I feel about it. I won't even mention blockchain. The lines are very blurry and things keep changing.
    -   [Federated]({{< relref "20230507135257-federated_systems.md" >}}) &sub; Decentralized
    -   [P2P]({{< relref "20221101184751-peer_to_peer.md" >}}) &sub; Decentralized
        -   Stuff using [NAT]({{< relref "20221101190313-nat.md" >}}) Traversal &sub; [P2P]({{< relref "20221101184751-peer_to_peer.md" >}})
        -   Stuff using local discovery  &sub; [P2P]({{< relref "20221101184751-peer_to_peer.md" >}})
        -   Stuff using overlay network to discover peers  &sub; [P2P]({{< relref "20221101184751-peer_to_peer.md" >}})
        -   Other stuff that is P2P but i can't think of &sub; [P2P]({{< relref "20221101184751-peer_to_peer.md" >}})
    -   { [Federated]({{< relref "20230507135257-federated_systems.md" >}}), [P2P]({{< relref "20221101184751-peer_to_peer.md" >}}) } &sub; Decentralized
-   In the wild software use mix of centralized, distributed and decentralized so it's hard to truly fit an application into these structure.
-   The applications that can be made out of these structure is simply your imagination, filesharing, social networks, chat systems, hosting, identity systems and everything else.


## Decentralized {#decentralized}

-   These systems usually have common things to deal with
    -   Identity
    -   Key management
    -   Moderation
    -   Monetization
-   Decentralization: "For the builders, it’s a core feature. But for almost all users, it’s certainly a detail."


### P2P {#p2p}

-   No distinction between clients and servers.
-   Every user’s device can act as both, making them functionally equivalent as peers.
-   Some nodes may have special roles, like public bootstrap nodes that help new users get connected to the network etc.
-   See [peer-to-peer]({{< relref "20221101184751-peer_to_peer.md" >}})


### Federated {#federated}

-   Users are still interacting with a server
-   But anyone can run a server that interoperates with others servers in the network, giving users more providers to choose from.
-   This gives users more choices for applications, policies, and community cultures.
-   See [Federated systems]({{< relref "20230507135257-federated_systems.md" >}})


### Hybrid {#hybrid}

-   Like I said line is heckin blurry.
-   This is what [nostr]({{< relref "20230507142440-nostr.md" >}})(a growing decentralized social network), mentions in its readme. It's funny.
-   Nostr is not federated(A relay doesn't talk to another relay, only directly to users), doesn't work on p2p principles, still decentralized.

    > It doesn't rely on any trusted central server, hence it is resilient; it is based on cryptographic keys and signatures, so it is tamperproof; it does not rely on P2P techniques, and therefore it works.


## Things on the internet that make the internet {#things-on-the-internet-that-make-the-internet}

![](/ox-hugo/20230507105348-alternative_internet-585557407.png)
![](/ox-hugo/20230507105348-alternative_internet-468539994.png)

-   See this: [alternative-internet-dump](https://github.com/redecentralize/alternative-internet)
-   See: [Ecosystem Overview](https://gitlab.com/bluesky-community1/decentralized-ecosystem/-/blob/master/README.md)
-   This is obviously not exhaustive.
-   These things are complimentary to other things on the internet. Like a centralized/distributed/decentralized/human/social/ai system could make use of them or not.


### Bridges and Gateways {#bridges-and-gateways}

Even when things are not federated, by the nature what these things are we can always creates certain gridges and gateways to things.

-   [Bird.makeup: a Twitter to ActivityPub bridge | Hacker News](https://news.ycombinator.com/item?id=34748669)
-   <https://github.com/snarfed/bridgy-fed>
-   <https://github.com/RSS-Bridge/rss-bridge>
-   <https://github.com/Cameri/smtp-nostr-gateway>


### Fidverse {#fidverse}

-   Fediverse is about software implementations and services being able to talk to each other.
-   This is not a replacement of the idea of indieweb, these can compliment each other.
-   At the moment, anything that supports activitypub is in the fidverse. If you have a mastodon account you're in fidverse.
-   But the specs for indieweb and activitypub come from the same group of ppl.


### Linkback {#linkback}

-   A linkback is a method for Web authors to obtain notifications when other authors link to one of their documents.
-   Different from `backlink`
    -   Backlink: What gets created when a person refers to a page
    -   Linkback: What the publisher of the page being referred to receives.


#### Refback {#refback}

-   Usage of the HTTP referrer header to discover incoming links.


#### Webmentions {#webmentions}

-   X and Y both are webpages/URLs, webmention allows
    -   Y to send notification to X, when Y links to X
    -   X to receive notification from Y, when Y links to X
-   It's was built by the indieweb ppl, later became w3c recom. cool stuff.
-   [Site Update: WebMention Support - Xe Iaso](https://xeiaso.net/blog/webmention-support-2020-12-02)
-   [Receiving Blog Replies from anywhere on the Web](https://www.yusuf.fyi/posts/receiving-blog-replies-from-anywhere)
-   [Adding Webmentions to My Static Hugo Site · Ana Ulin](https://anaulin.org/blog/adding-webmentions/)
-   <https://webmention.rocks/>
-   <https://github.com/zerok/webmentiond>
-   <https://webmention.io/>
-   <https://webmention.net/>
-   [Using the Webmention.io API | Post | Random Geekery](https://randomgeekery.org/post/2020/11/using-the-webmentionio-api/)


#### Others {#others}

[Tracebacks](https://en.wikipedia.org/wiki/Trackback) and [Pingbacks](http://hixie.ch/specs/pingback/pingback-1.0) are relics of the past at this point but mentioning for completeness.


### Indieweb {#indieweb}

{{< figure src="/ox-hugo/20230507105348-alternative_internet-786463851.png" >}}

-   Read this: [Notes on indieweb vs fidverse](http://dustycloud.org/blog/on-standards-divisions-collaboration/) (some politics)
-   IndieWeb is about owning your online presence via your own domain name.


#### Popular names {#popular-names}

-   Webmentions: better pingbacks (see above)
-   ActivityPub: (See [Federated systems]({{< relref "20230507135257-federated_systems.md" >}})), this sort of came out of the same community
-   Micropub: While ActivityPub is protocol describing a decentralized social network, [Micropub](https://indieweb.org/Micropub) is a way for "you" to post content to "your" own website from 3rd party platforms or your own systems that you built.


#### Links {#links}

-   [Standardizing the Social Web • Aaron Parecki](https://aaronparecki.com/2016/06/22/1/osbridge)
-   [Removing Support For The IndieWeb - Kev Quirk](https://kevquirk.com/removing-support-for-the-indieweb/) lol
-   <https://indieweb.org/>
-   [IndieWeb support](https://indiewebify.me/)
-   [PESOS - IndieWeb](https://indieweb.org/PESOS) | [POSSE - IndieWeb](https://indieweb.org/POSSE)
-   [How To Create An IndieWeb Profile - Kev Quirk](https://kevquirk.com/how-to-create-an-indieweb-profile/)
-   [Implementing The IndieWeb Into My Website - Kev Quirk](https://kevquirk.com/implementing-the-indieweb-into-my-website/)
-   [Creating My Own Personal Micropub Client](https://www.jvt.me/posts/2020/06/28/personal-micropub-client/)
-   [A Case For The IndieWeb](https://www.smashingmagazine.com/2020/08/autonomy-online-indieweb/)


### RSS {#rss}


#### Learn more {#learn-more}

-   [Use RSS for privacy and efficiency {rsapkf/www}](https://rsapkf.org/weblog/q2z)
-   [What RSS Gets Right](https://www.charlieharrington.com/unexpected-useless-and-urgent)
-   [Why your blog still needs RSS | Hacker News](https://news.ycombinator.com/item?id=37175192)
-   [Making RSS more visible again with a /feeds page](https://marcus.io/blog/making-rss-more-visible-again-with-slash-feeds)
-   [RSS: The Original Federated Social Network Protocol](https://battlepenguin.com/tech/rss-the-original-federated-social-network-protocol/)
-   [Investing in RSS](https://timkadlec.com/remembers/2023-02-23-investing-in-rss/)
-   [AboutRSS/ALL-about-RSS](https://github.com/AboutRSS/ALL-about-RSS)
-   [Why I Still Use RSS](https://atthis.link/blog/2021/rss.html)
-   [Gripes with RSS after one week | Hacker News](https://news.ycombinator.com/item?id=34198759)
-   [This is the year of the RSS reader? | Hacker News](https://news.ycombinator.com/item?id=34105572)
-   [Making RSS prominent again](https://rubenerd.com/making-rss-prominent-again/)
-   [“RSS” feed without separate XML? | Lobsters](https://lobste.rs/s/d5nlru/rss_feed_without_separate_xml)


#### Tools {#tools}

-   [GitHub - RSS-Bridge/rss-bridge: The RSS feed for websites missing it](https://github.com/RSS-Bridge/rss-bridge)
-   [GitHub - DIYgod/RSSHub: 🍰 Everything is RSSible](https://github.com/DIYgod/RSSHub)
-   [GitHub - umputun/rss2twitter: publish rss updates to twitter](https://github.com/umputun/rss2twitter)
-   [Miniflux - Minimalist and Opinionated Feed Reader](https://miniflux.app/)
-   [Tiny Tiny RSS](https://tt-rss.org/)
-   [FreshRSS, a free, self-hostable feeds aggregator](https://freshrss.org/)
-   [GitHub - stringer-rss/stringer: A self-hosted, anti-social RSS reader.](https://github.com/stringer-rss/stringer)


### Usenet {#usenet}

-   [Usenet over NNCP | Hacker News](https://news.ycombinator.com/item?id=36157287)
-   [Why did Usenet fail? | Hacker News](https://news.ycombinator.com/item?id=36194941)


### HTTP alternatives {#http-alternatives}


#### Gemini {#gemini}

-   [Bye, Gemini | Hacker News](https://news.ycombinator.com/item?id=37049064)
-   [Gemini is Useless](https://alex.flounder.online/gemlog/2021-01-08-useless.gmi)
-   [Why Gemini is not my favorite internet protocol](https://gerikson.com/blog/comm/Why-u-no-gemini.html)
-   [Contributing to Gemini ecosystem](https://pitr.ca/2021-05-29-gemini-ecosystem)
-   [Plaintext HTTP in a Modern World - joshua stein](https://jcs.org/2021/01/06/plaintext)
-   [What is this Gemini thing anyway, and why am I excited about it?](https://drewdevault.com/2020/11/01/What-is-Gemini-anyway.html)
-   [The Gemini protocol seen by this HTTP client person | Lobsters](https://lobste.rs/s/au6bcu/gemini_protocol_seen_by_this_http_client)
-   <https://github.com/makew0rld/amfora>
-   <https://github.com/mbrubeck/agate>
-   [Using Hugo to Launch a Gemini Capsule | Brain Baking](https://brainbaking.com/post/2021/04/using-hugo-to-launch-a-gemini-capsule/)


#### Gopher {#gopher}

-   [Gopherspace in the Year 2020](https://cheapskatesguide.org/articles/gopherspace.html)
-   [Building a legacy search engine for a legacy protocol](https://blog.benjojo.co.uk/post/building-a-search-engine-for-gopher)
-   [Bombadillo](https://rawtext.club/~sloum/bombadillo.html)
-   [Gopher Protocol (2020) | Hacker News](https://news.ycombinator.com/item?id=33447060)


### More weird things {#more-weird-things}


#### Webfinger {#webfinger}

-   Allows for discovery of information about people and things identified by a URI.
-   Designed for HTTP, payload is represented in JSON format.
-   [Fetching ActivityPub Feeds using WebFinger](https://www.gkbrk.com/2018/06/fetching-activitypub-feeds/)


### Offline &amp; Low-tech web {#offline-and-low-tech-web}

-   <https://github.com/Antharia/awesome-lowtech>


### Darkweb {#darkweb}

-   I mean anything that's not public is dark web. My private twitter account is dark web, my ex-es finsta is dark web.
-   But check [Anonymity]({{< relref "20230212154657-anonymity.md" >}}) and [TOR]({{< relref "20230210211719-tor.md" >}}) and [VPN]({{< relref "20230210192007-vpn.md" >}}) if interested


### Billion other things {#billion-other-things}

-   [Dripline: Check the specs: final thoughts on p2p options | Hypha Worker Co-operative](https://hypha.coop/dripline/p2p-primer-part-4/)
-   [The first messenger without user IDs | Hacker News](https://news.ycombinator.com/item?id=37105477)
-   [P2panda: P2P protocol for secure, energy-efficient local-first web applications | Hacker News](https://news.ycombinator.com/item?id=37212462)
-   [The “smolnet”, build for friends and friends of friends | Hacker News](https://news.ycombinator.com/item?id=36292078)
-   [Client-side proxies – a better way to individualise the Internet? (2000) | Hacker News](https://news.ycombinator.com/item?id=36824165)
-   [The problem with federated web apps | Lobsters](https://lobste.rs/s/w2m7pr/problem_with_federated_web_apps)
