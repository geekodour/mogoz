+++
title = "Custom Protocols"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [System Design]({{< relref "20230113141133-system_design.md" >}}), [Systems]({{< relref "20221101150250-systems.md" >}})

> The descition are itself vague so don't get too pedanctic and this is for personal ref.


## Data serialization {#data-serialization}

-   Data serialization refers to the process of translating data structures or object state(from memory) into a different format capable of being stored (such as a memory buffer or file), or transmitted and reconstructed at a different point.
-   Uses
    -   Storing Data into Databases or on Hard Drives
    -   Transferring Data through the Wires
    -   Detecting Changes in Time-Varying Data
    -   Remote Procedure Call (RPC) via. Interface Definition Language (IDL)
    -   Other uses


### Serialization and De-serialization {#serialization-and-de-serialization}

When you use serialization you also expect de-serialization. These are not part of the serialization format. These are separate things.

-   Serialization/Writing/Generation
    -   Eg. [Construct](https://construct.readthedocs.io/en/latest/)(python only) does both parsing and serialization.
    -   `Boost.Serialization`, `cereal`, `bitsery`, `msgpack` also do serilization and deserialization but they have their own binary format.
-   Deserialization/Reading/Parsing
    -   Eg. [Kaitai](https://doc.kaitai.io/faq.html#writing) just does parsing.


### Serialization formats {#serialization-formats}

These can be binary or plaintext. They can have different tradeoffs like, fixed width integers, varints, length-prefixed strings, circular references, weak references, suppress repeated values, efficient encoding, special-cased encodings, headers or lack of it, having to define schemas on advance etc. etc.

-   [C++ Serialization Overview](https://isocpp.org/wiki/faq/serialization#serialize-overview)
-   Complete list: [Comparison of data-serialization formats](https://en.wikipedia.org/wiki/Comparison_of_data-serialization_formats)
-   Binary format examples: BSON, MessagePack, Protocol Buffers, Thrift, Avro, ...
-   Text format examples: XML, JSON, YAML, ...


### Usecase: File formats {#usecase-file-formats}

-   File formats can be implemented using data serilization formats. Eg. Apache Parquet is implemented using the Apache Thrift framework.
-   Good summary: [Designing File Formats](https://www.fadden.com/tech/file-formats.html)


### Usecase: Network Transmission {#usecase-network-transmission}

-   Example: [Yet another custom binary protocol library implementation](http://www.andrescottwilson.com/yet-another-custom-binary-protocol-library-implementation/)
-   We need to design a `protocl` and we need to design a `protocol handler`
-   **Difference between `Binary protocol` and `text protocol` :**
    -   Is **not** about how binary blobs are encoded.
    -   Is about whether the protocol is oriented around `data structures` or around `text strings`. Eg. HTTP is a text protocol, even though when it sends a jpeg image, it just sends the raw bytes, not a text encoding of it.
    -   Binary protocols
        -   Will always be more space efficient than text protocols.
        -   Examples: RTP, TCP, IP, TLS, SSH.
    -   Text protocols
        -   Examples: SMTP, HTTP, SIP.


### Usecase: RPC {#usecase-rpc}

<div class="book-hint warning small-text">

> Aside about GRPC, Protocol Buffers and REST
>
> GRPC is a RPC framework, PB is a data serialization format. REST is an architectural style for constructing web services. They are different things but seeing how they are different makes me understand them better.
>
> -   GRPC
>     -   Released: 2016
>     -   Essentially a wrapper on top of an HTTP/2 server that communicates using PB
>     -   Because it's a RPC framework, it offers features such as, Streaming, Cancellation, Circuit Breaking, load balancing, tracing, metric collection, header propagation,authorization, IDL etc.
>     -   PB usage is incidental.
> -   PB
>     -   Released: 2001, Opensourced 2008
>     -   You can use PB without GRPC
> -   REST
>     -   REST can be implemented without HTTP, a home-grown binary substitute can be use and you can still be restful.
>     -   You can deploy a RESTful service over ordinary email exchange for instance.
>     -   But using HTTP has benefits, such as you'll have HTTPs caching infrastructure at your disposal.
</div>


## Encoding {#encoding}

Serialization is a specific instance of encoding.


### Binary to Text {#binary-to-text}

Encoding of binary data in a sequence of printable characters.

-   [Binary-to-text encoding - Wikipedia](https://en.wikipedia.org/wiki/Binary-to-text_encoding)
-   [Binary to text encoding -- state of the art and missed opportunities | Lobsters](https://lobste.rs/s/swkp6b/binary_text_encoding_state_art_missed)


## Some Jargon {#some-jargon}

-   Compression
-   proprietary binary format
    -   there are libraries which help in wiriting binary formats: <https://ryan-rsm-mckenzie.github.io/binary_io/>
-   Encoding
-   Text and Binary
-   GRPC and PB
    -   GRPC: 2016
    -   PB: 2001, Opensourced 2008
-   Streaming protocol?
-   [rkyv is faster than {bincode, capnp, cbor, flatbuffers, postcard, prost, serd...](https://david.kolo.ski/blog/rkyv-is-faster-than/)


## Binary protocols {#binary-protocols}


## Text protocols {#text-protocols}
