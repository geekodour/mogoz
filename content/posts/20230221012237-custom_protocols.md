+++
title = "Custom Protocols"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [System Design]({{< relref "20230113141133-system_design.md" >}}), [Systems]({{< relref "20221101150250-systems.md" >}}), [Codec]({{< relref "20230221191655-codec.md" >}})

> The description are itself vague so don't get too pedantic and this is for personal ref.


## FAQ {#faq}


### Why Little Endian useful? {#why-little-endian-useful}

-   It helps CPU increase length of numbers easily.
    ```text
    44 33 22 11 (little end, int32)
    44 33 22 11 00 00 00 00 (little end, int64)
    ```
-   You can't do this shit w big endian, it'll change the number.
-   This is mostly useful at the compiler/cpu level but not so much useful at the protocol level.


### What's the deal with variable-length encoding? {#what-s-the-deal-with-variable-length-encoding}

-   Main idea: small numbers should take up less space than big numbers.
-   There are different schemes for doing so. [Golang]({{< relref "20221101220915-golang.md" >}})'s `binary` package does the same what [Protocol Buffers]({{< relref "20230522131118-protocol_buffers.md" >}}) does.


### More resources {#more-resources}

-   <https://phoboslab.org/log/2021/12/qoi-specification>
-   <https://rachelbythebay.com/w/2023/09/19/badlib/>


## Encoding {#encoding}

Serialization is a specific instance of encoding. How serialization relates to the term "encoding" is slightly vague.


### Binary to Text (Eg. Base64) {#binary-to-text--eg-dot-base64}

Encoding of binary data in a sequence of printable characters.

-   [Binary-to-text encoding - Wikipedia](https://en.wikipedia.org/wiki/Binary-to-text_encoding)
-   [Binary to text encoding -- state of the art and missed opportunities | Lobsters](https://lobste.rs/s/swkp6b/binary_text_encoding_state_art_missed)


### Text to Binary {#text-to-binary}

This is what computers do anyway.


### Fun experiments {#fun-experiments}

-   [keith-turner/ecoji](https://github.com/keith-turner/ecoji)
-   <https://goshify.tny.im/>
-   <https://github.com/alcor/itty-bitty>


## Data serialization {#data-serialization}

Data serialization refers to the process of translating data structures or object state(from memory) into a different format capable of being stored (in-memory or file), or transmitted and reconstructed at a different point.


### Use-cases {#use-cases}

-   Transferring Data through the Wires
-   Creating file formats
-   Network Transmission
-   RPC via. Interface Definition Language (IDL)
-   Other uses


## Formats {#formats}

<div class="warning small-text">

> How to
>
> -   [Designing File Formats](https://www.fadden.com/tech/file-formats.html)
> -   [Binary formats and protocols: LTV is better than TLV | Lobsters](https://lobste.rs/s/lfbey9/binary_formats_protocols_ltv_is_better)
> -   [Visual Programming with Elixir: Learning to Write Binary Parsers](https://hansonkd.medium.com/building-beautiful-binary-parsers-in-elixir-1bd7f865bf17)
> -   [Zip – How not to design a file format (2021)](https://news.ycombinator.com/item?id=37897444)
> -   [binary_io](https://ryan-rsm-mckenzie.github.io/binary_io/) : Not a data serialization library but a library to help write binary formats
> -   [bincode](https://github.com/bincode-org/bincode)
</div>

-   File formats can be implemented using data serilization formats. Eg. Apache Parquet is implemented using the Apache Thrift framework.


### Serialization and De-serialization {#serialization-and-de-serialization}

When you use serialization you also expect de-serialization. These are not part of the serialization format. These are separate things.


#### Serialization/Writing/Generation {#serialization-writing-generation}

-   Eg. [Construct](https://construct.readthedocs.io/en/latest/)(python only) does both parsing and serialization.
-   `Boost.Serialization`, `cereal`, `bitsery`, `msgpack` also do serilization and deserialization but they have their own binary format.


#### Deserialization/Reading/Parsing {#deserialization-reading-parsing}

-   Eg. [Kaitai](https://doc.kaitai.io/faq.html#writing) just does parsing.


### Serialization formats {#serialization-formats}

These can be binary or plaintext. They can have different tradeoffs like, fixed width integers, varints, length-prefixed strings, circular references, weak references, suppress repeated values, efficient encoding, special-cased encodings, headers or lack of it, having to define schemas on advance etc. etc.

-   [C++ Serialization Overview](https://isocpp.org/wiki/faq/serialization#serialize-overview)
-   Complete list: [Comparison of data-serialization formats](https://en.wikipedia.org/wiki/Comparison_of_data-serialization_formats)
-   [rkyv benchmark](https://david.kolo.ski/blog/rkyv-is-faster-than/)


#### Binary formats {#binary-formats}

-   BSON, MessagePack, [Protocol Buffers]({{< relref "20230522131118-protocol_buffers.md" >}}), Thrift, Avro, ..., <https://cbor.io/>


#### Text formats {#text-formats}

-   `.txt`, `markdown`, `yaml`, `xml`


## Protocols {#protocols}

<div class="warning small-text">

> How to
>
> -   [custom binary protocol library implementation](http://www.andrescottwilson.com/yet-another-custom-binary-protocol-library-implementation/)
> -   [Visual Programming with Elixir: Learning to Write Binary Parsers](https://hansonkd.medium.com/building-beautiful-binary-parsers-in-elixir-1bd7f865bf17)
> -   Bare Metal Programming Series 7.1 - YouTube]]
</div>

-   When we design a `protocol`, we need to design a `protocol handler`
-   Is **not** about how binary blobs are encoded. (They're always binary for networking)
-   Is about whether the protocol is oriented around `data structures` or around `text strings`. Is it supposed to be readable by humans or by machines is the question to ask. Eg. HTTP is a text protocol, even though when it sends a jpeg(binary) image, it just sends the raw bytes, not a text encoding of it.


### Binary protocols {#binary-protocols}

-   Will always be more space efficient than text protocols.
-   Examples: RTP, TCP, IP, TLS, SSH, MQTT.


### Text protocols {#text-protocols}

-   Examples: SMTP, HTTP, SIP.


### Binary vs Text protocols {#binary-vs-text-protocols}

Not strict def. but general idea.

-   How a computer parses JSON:
    -   You're kind of like advancing one rune at a time
    -   And kind of maintaining some look back, looking for a bunch of object delimiters
    -   Keeping state for how deeply nested in this object you are etc.
    -   complicated, stateful process.
-   How a computer parses Binary data:
    -   It'll say, hey, the next field coming up is a string, and it's 70 bytes long.
    -   Then the parser just like grabs the next 70 bytes
    -   Interprets them as a string in memory and is done.


## RPC {#rpc}

-   [X] Data Serialization Formats
-   [X] Protocols
-   RPC sort of combines both.
    -   Not really, depends on implementation but you get the idea.
    -   Some data of some format is getting transferred via some protocol


### gRPC {#grpc}

-   GRPC(2016) is a RPC framework
-   PB/[Protocol Buffers]({{< relref "20230522131118-protocol_buffers.md" >}})(2001) is a data serialization format.


#### What about GRPC? {#what-about-grpc}

-   A wrapper on top of an [HTTP/2]({{< relref "20230222161545-http.md#http-2" >}}) (atm) server that communicates using PB
-   Offers features such as, Streaming, Cancellation, Circuit Breaking, load balancing, tracing, metric collection, header propagation,authorization, IDL etc.


#### REST vs GRPC {#rest-vs-grpc}

REST is not at all an RPC framework, it is an architectural style for constructing web services. So in an way, it's an apples to oranges comparison. But there are usecases where you might want to use GRPC over REST and vice versa. Here's a table from the internets.

{{< figure src="/ox-hugo/20230221012237-custom_protocols-950531753.png" >}}

-   REST can be implemented without HTTP, a home-grown binary substitute can be use and you can still be restful.
-   You can deploy a RESTful service over ordinary email exchange for instance.
-   But using HTTP has benefits, such as you'll have HTTPs caching infrastructure at your disposal.
-   [A detailed comparison of REST and gRPC | Hacker News](https://news.ycombinator.com/item?id=35711196)
