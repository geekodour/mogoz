+++
title = "Reverse Engineering"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Security]({{< relref "20221101184454-security.md" >}}), [elf]({{< relref "20221101175420-elf.md" >}})


## Resources {#resources}

-   [Even if you can&amp;#x27;t write assembly, you can read disassembly | Hacker News](https://news.ycombinator.com/item?id=35435811)
-   [CS107 Guide to x86-64](https://web.stanford.edu/class/cs107/guide/x86-64.html)


## Some reddit comment {#some-reddit-comment}

[NSA Ghidra software reverse engineering framework | Hacker News](https://news.ycombinator.com/item?id=35324380)
What you want to know about a strange binary (barring obfuscation, sandbox escapes, and other nasties) is: who does it talk to (ip addresses, hostnames, sockets, etc), what does it open (files, registry entries, api's, services), when does it do these things (eg. runtime conditions, magic packets, port knocks, triggers, checking for other software), where does it write or read data (directories, filehandles, remote sites, etc), why does it do this given it's stated purpose (why does it have an encrypted section, and where is its key, is it using weird encoding to bypass filters, etc.) and then finally the How it does these all things is the effect of answering those other questions.

I think the hardest part of analysis is having an organized way of knowing what you are looking for because we don't know the right questions to ask and we tend to work at the edge of limited knowledge. Should this rando binary be talking some app hosting site, and why? Why would a developer encode endpoint names in a lookup table that only constructs and returns them at runtime? Why would someone use any of these libraries or data formats on purpose? The harder it is to answer these questions, the more suspicious I get.

If you start with the 5-W's, the How falls out of that a lot faster. If you can answer these questions about a binary, you're easily 50% there in determining whether it behaves as expected. Having an organized goal can take you from zero to basically useful if you answer those questions about it. The rest is just screenshots of menu items in ghidra and maybe cyberchef for purely static extraction.

I feel like I should pile on caveats here about how most malware isn't obfuscated or using novel techniques, a lot of it is just spyware capabilities you clicked through to accept, or a repackaged legit binary with some downloaded RAT attached and some nested compressed libraries. I'm sure someone who is more serious about this will say, "that's misleadingly simple!" but once you have a why and a what, the how is a work problem.

Dynamic debugging and stepping through is the next stage. It's also basic, but when you are goal oriented instead of being able to reproduce all usable code paths, it's more achievable. If you get the IP addresses out of random binary and what protocols it's talking, and maybe what files it accesses, it means you've set up your analysis environment and done the initial checks, and that's valuable grunt work you can pass on to someone with deeper skills.

If you can go from zero to this, that's an afternoon well spent, imo. It's not trivial, as it assumes a lot of knowledge about system architecture and network protocols, but the questions above necessarily have answers, so I can guarantee you can find them with some directed effort. I don't mean to trivialize more advanced analysis, this isn't the same thing, but as an entry point, this is how I would recommend approaching it.
