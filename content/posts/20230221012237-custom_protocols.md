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


### Relationship between `encoding`, `serialization`, `formats` and `protocols` {#relationship-between-encoding-serialization-formats-and-protocols}

> **In essence:** You _encode_ data elements, arrange them according to a _format_ to represent a structure, and exchange messages containing this formatted data according to the rules of a _protocol_.


#### 1. Encoding {#1-dot-encoding}

-   **What it is:** The most fundamental layer. Encoding is the process of transforming data from one representation to another. It's about _how_ individual pieces of data (like numbers, characters, or raw bytes) are represented.
-   **Purpose:** Can be for efficiency (`variable-length integers`), compatibility (binary-to-text like `Base64`), or fundamental representation (how a CPU stores numbers like `Little Endian` vs. `Big Endian`, how text characters are represented as bytes like `UTF-8`).
-   **Examples from the text:**
    -   **Little Endian vs. Big Endian:** How the bytes of a multi-byte number are ordered in memory. Little Endian helps CPUs extend numbers easily (e.g., `11 22 33 44` becomes `11 22 33 44 00 00 00 00`).
    -   **Variable-length encoding:** Schemes where smaller numbers use fewer bytes than larger numbers (used in `Protocol Buffers`, Go's `binary` package).
    -   **Binary-to-text encoding (e.g., `Base64`):** Representing arbitrary binary data using only printable characters, often for transmission through systems designed for text.
    -   **Text-to-binary encoding:** How text characters (like in a string) are represented as sequences of bytes (e.g., ASCII, UTF-8). This is fundamental computer operation.
-   **Key Idea:** Transformation of representation, often at a low level or for specific constraints.


#### 2. Format (Data Serialization Format) {#2-dot-format--data-serialization-format}

-   **What it is:** A defined structure or set of rules for organizing and arranging data (which has been encoded) into a coherent message or file. It specifies _how_ different data elements (numbers, strings, lists, objects/structs) are laid out sequentially.
-   **Purpose:** To take complex data structures from application memory and turn them into a sequence of bytes (or characters) suitable for storage (files) or transmission (networks), and allow them to be reconstructed later (deserialization).
-   **Examples from the text:**
    -   **Binary Formats:** `BSON`, `MessagePack`, `Protocol Buffers` (Protobuf), `Thrift`, `Avro`, `Parquet`, `CBOR`. These use compact binary encodings for data types and structure.
    -   **Text Formats:** `JSON` (mentioned implicitly via BSON comparison), `XML`, `YAML`, `Markdown`, `.txt`. These use human-readable characters to represent data and structure.
-   **Relationship to Encoding:** A format _uses_ specific encodings for its constituent parts (e.g., `Protobuf` uses variable-length encoding for integers, UTF-8 for strings, and specific byte markers for structure). The format defines the _overall grammar_ of the serialized data.
-   **Key Idea:** Structure and rules for laying out serialized data.


#### 3. Protocol {#3-dot-protocol}

-   **What it is:** A set of rules and conventions governing the _communication_ and _interaction_ between systems. It defines the sequence of messages, their meaning, expected actions, error handling, and how a conversation proceeds.
-   **Purpose:** To enable different systems (or components) to exchange information and coordinate actions reliably and predictably over a network or other communication channel.
-   **Examples from the text:**
    -   **Text Protocols:** `HTTP`, `SMTP`, `SIP`. These primarily use text-based commands and structures for control messages, even if they transfer binary payloads. They are often designed to be somewhat human-readable.
    -   **Binary Protocols:** `TCP`, `IP`, `TLS`, `SSH`, `MQTT`, `RTP`. These use binary structures for their messages for efficiency and compactness.
    -   **gRPC:** Described as an RPC _framework_ that acts like a protocol. It defines how remote procedures are called, including aspects like streaming, cancellation, and uses `HTTP/2` (an underlying protocol) for transport and `Protocol Buffers` (a format) for data.
-   **Relationship to Format:** A protocol often _uses_ a specific data format to structure the payload (the actual data being sent) within its messages. For instance, `HTTP` (protocol) often carries payloads formatted as `HTML`, `JSON`, or `XML` (formats). `gRPC` (protocol/framework) mandates `Protocol Buffers` (format).
-   **Distinction from Format:** The protocol is about the _entire interaction_ – the handshake, request/response sequence, headers, status codes, error handling, session management – whereas the format is just about the _structure of the data payload_ itself. The text notes a protocol isn't primarily about how _binary blobs_ are encoded, but whether the _interaction logic_ is text-oriented or binary-oriented.
-   **Key Idea:** Rules of engagement for communication between systems.


#### Mapping it Out {#mapping-it-out}

-   **Foundation:** **Encoding** is the most basic concept – how individual data items are represented.
-   **Structure:** **Formats** build on encodings to define how structured data (like objects or records) is laid out sequentially. **Serialization** is the _process_ of encoding data structures into a specific format.
-   **Interaction:** **Protocols** define the rules for exchanging messages between systems. These messages often contain data structured according to a specific **format**.


#### Overlaps {#overlaps}

1.  **Serialization:** As the text states, "Serialization is a specific instance of encoding." It specifically refers to encoding data structures into a format for storage/transmission. So, it sits between the general concept of encoding and the resulting format.
2.  **RPC Frameworks (like `gRPC`):** These often blend protocol and format concepts. `gRPC` _is_ a protocol in the sense that it defines rules for remote calls, streaming, etc., but it _relies on_ another protocol (`HTTP/2`) for transport and _mandates_ a specific format (`Protocol Buffers`) for the data.
3.  **Binary vs. Text Protocols:** The distinction isn't always absolute. A "text protocol" like `HTTP` can carry raw binary data (like an image) in its body. The "text" part refers more to the control messages (headers, methods, status lines) being human-readable strings, whereas binary protocols use byte fields for these. Parsing text protocols often involves state machines looking for delimiters, while binary protocols often read fixed-size fields or length-prefixed data.
4.  **File Formats:** These often use data serialization formats as their building blocks (e.g., Apache `Parquet` uses `Thrift` structures). The file format standard might add extra layers like metadata, magic numbers, indexing structures, etc., beyond what the basic serialization format defines.


## Encoding {#encoding}

Serialization is a specific instance of encoding. How serialization relates to the term "encoding" is slightly vague.


### Binary to Text (Eg. Base64) {#binary-to-text--eg-dot-base64}

Encoding of binary data in a sequence of printable characters.

-   [Binary-to-text encoding - Wikipedia](https://en.wikipedia.org/wiki/Binary-to-text_encoding)
-   [Binary to text encoding -- state of the art and missed opportunities | Lobsters](https://lobste.rs/s/swkp6b/binary_text_encoding_state_art_missed)
-   [Base32 Encoding Explained | ptrchm](https://ptrchm.com/posts/base32-explained/)
-   [GitHub - qntm/base2048: Binary encoding optimised for Twitter](https://github.com/qntm/base2048)


### Text to Binary {#text-to-binary}

This is what computers do anyway.


### Fun experiments {#fun-experiments}

-   [keith-turner/ecoji](https://github.com/keith-turner/ecoji)
-   <https://goshify.tny.im/>
-   <https://github.com/alcor/itty-bitty>
-   [Writing an MP4 Muxer for Fun and Profit | Hacker News](https://news.ycombinator.com/item?id=40951187)


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

> Tools
>
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

-   BSON, MessagePack, [Protocol Buffers]({{< relref "20230522131118-protocol_buffers.md" >}}), Thrift, Parquet(column based), Avro(row based), ..., <https://cbor.io/>


#### Text formats {#text-formats}

-   `.txt`, `markdown`, `yaml`, `xml`


## Protocols {#protocols}

-   When we design a `protocol`, we need to design a `protocol handler`
-   Is **not** about how binary blobs are encoded. (They're always binary for networking)
-   Is about whether the protocol is oriented around `data structures` or around `text strings`. Is it supposed to be readable by humans or by machines is the question to ask. Eg. HTTP is a text protocol, even though when it sends a jpeg(binary) image, it just sends the raw bytes, not a text encoding of it.


### Binary protocols {#binary-protocols}

-   Will always be more space efficient than text protocols.
-   Examples: RTP, TCP, IP, TLS, SSH, MQTT.
-   RITP: [Reliable Immutable Transfer Protocol — binarycat](https://paper.wf/binarycat/reliable-immutable-transfer-protocol)


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


### Some Theory {#some-theory}

-   [What are the prospects of process calculi and the actor model? : compsci](https://www.reddit.com/r/compsci/comments/mnps0y/what_are_the_prospects_of_process_calculi_and_the/)
-   [A Theory of Composing Protocols (2023) | Hacker News](https://news.ycombinator.com/item?id=39954059)
-   [Process calculus - Wikipedia](https://en.wikipedia.org/wiki/Process_calculus)


## RPC {#rpc}

-   [X] Data Serialization Formats
-   [X] Protocols
-   RPC sort of combines both.
    -   Not really, depends on implementation but you get the idea.
    -   Some data of some format is getting transferred via some protocol


### gRPC {#grpc}

-   GRPC(2016) is a RPC framework
-   PB/[Protocol Buffers]({{< relref "20230522131118-protocol_buffers.md" >}})(2001) is a data serialization format.
-   See [grpc, protocol buffers and friends]({{< relref "20240122204747-grpc_protocol_buffers_and_friends.md" >}})


#### What about GRPC? {#what-about-grpc}

-   A wrapper on top of an [HTTP/2]({{< relref "20230222161545-http.md#http-2" >}}) (atm) server that communicates using PB
-   Offers features such as, Streaming, Cancellation, Circuit Breaking, load balancing, tracing, metric collection, header propagation,authorization, IDL etc.


#### REST vs GRPC {#rest-vs-grpc}

REST is not at all an RPC framework, it is an architectural style for constructing web services. So in an way, it's an apples to oranges comparison. But there are usecases where you might want to use GRPC over REST and vice versa. Here's a table from the internets.

{{< figure src="/ox-hugo/20230221012237-custom_protocols-950531753.png" >}}

-   See [REST / RESTful / REpresentational State Transfer]({{< relref "20230302195820-api_design.md#rest-restful-representational-state-transfer" >}})
-   With a PRC system peculiarities of serialization (like, say, JSON’s lack of 64-bit numbers) are a non-issue
-   REST can be implemented without HTTP, a home-grown binary substitute can be use and you can still be restful.
-   You can deploy a RESTful service over ordinary email exchange for instance.
-   But using HTTP has benefits, such as you'll have HTTPs caching infrastructure at your disposal.
-   [A detailed comparison of REST and gRPC | Hacker News](https://news.ycombinator.com/item?id=35711196)
