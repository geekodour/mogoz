+++
title = "Protocol Buffers"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Custom Protocols]({{< relref "20230221012237-custom_protocols.md" >}}), [API Design]({{< relref "20230302195820-api_design.md" >}}), [OpenAPI]({{< relref "20230605124017-openapi_ecosystem.md" >}})


## Resources {#resources}

-   [Protobuf Is Almost Streamable | Lobsters](https://lobste.rs/s/rthy7b/protobuf_is_almost_streamable)
-   [java - How to duplicate fields names with proto3 oneof feature? - Stack Overflow](https://stackoverflow.com/questions/58667829/how-to-duplicate-fields-names-with-proto3-oneof-feature)  (Lack of conditional oneof support)


## FAQ {#faq}


### How doe PB relate to RPC? {#how-doe-pb-relate-to-rpc}

-   Protobuf is tree-shaped
-   RPC systems that make use of PB, stream PB at the message-level.
-   PRC systems that use PB are GRPC, Twirp etc.


### buf connect, grpc-web, grpc, twirp? what are all these? {#buf-connect-grpc-web-grpc-twirp-what-are-all-these}

-   See [grpc, protocol buffers and friends]({{< relref "20240122204747-grpc_protocol_buffers_and_friends.md" >}})


### What is the buf ecosystem? {#what-is-the-buf-ecosystem}

-   Individual company trying to make PB better


#### Tools and Libraries {#tools-and-libraries}

-   `buf`: PB compiler (alternative to `protoc`)
-   `protobuf-es`: Implementation of PB in TypeScript, for web browsers and Node.js
-   `connect`
    -   Library: Connect is a slim library for building browser- and gRPC-compatible HTTP APIs.
        -   `connect-es`: `connect` for the browser, uses `protobuf-es`
        -   `connect-go`
    -   Protocol


## What is PB? {#what-is-pb}

PB is 2 things (and it's more than just a binary encoding format)


### A way to define schema for data (IDL, Interface Description Language) {#a-way-to-define-schema-for-data--idl-interface-description-language}

-   PB can be compared to JSON Schema in this regard.
-   Except it supports more stuff than JS native types in JSON API in JSON schema.
-   JSON schema also has all the parent schema and linking stuff, ig PB doesn't have all that. More self sufficient types.


### Data serialization format (Codegen in N languages) {#data-serialization-format--codegen-in-n-languages}

-   The tools to deal with the PB serialization format are low-level
-   Since it's a google thing, outside of google we only have access to protobuf piece but not the rest of the stack. Which makes it little difficult to work w it.
-   <https://buf.build/> is a good way ig


## Versioning {#versioning}

-   Real-world practice has also shown that quite often, fields that originally seemed to be "required" turn out to be optional over time,
-   In a [Distributed System]({{< relref "20221102130004-distributed_systems.md" >}}), you cannot update both sides of a protocol simultaneously. So incremental versioning that PB has helps.


## Using {#using}

-   You can use pb to send and accept json (Using it for APIs)
