+++
title = "grpc, protocol buffers and friends"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [OpenAPI Ecosystem]({{< relref "20230605124017-openapi_ecosystem.md" >}}), [Custom Protocols]({{< relref "20230221012237-custom_protocols.md" >}}), [Protocol Buffers]({{< relref "20230522131118-protocol_buffers.md" >}})


## What's all this madness? {#what-s-all-this-madness}


### Structured RPC frameworks {#structured-rpc-frameworks}

-   Code generation from schema
-   These use a communication protocol (usually [HTTP]({{< relref "20230222161545-http.md" >}})) and a data serialization format (Eg. [Protocol Buffers]({{< relref "20230522131118-protocol_buffers.md" >}}))
-   See the section on structured RPC: [Twirp: a sweet new RPC framework for Go](https://blog.twitch.tv/en/2018/01/16/twirp-a-sweet-new-rpc-framework-for-go-5f2febbf35f/)
-   Examples are grpc, twirp, buf connect etc.


### [OpenAPI Ecosystem]({{< relref "20230605124017-openapi_ecosystem.md" >}}) and grpc? {#openapi-ecosystem--20230605124017-openapi-ecosystem-dot-md--and-grpc}

-   Single source of truth is defined in protobuf(schema).
-   `grpc -> grpc-gateway -> swagger`
    -   See this for [generate openapi spec](https://github.com/grpc-ecosystem/grpc-gateway/tree/main/protoc-gen-openapiv2) from grpc-gateway
-   Instead of `grpc-gateway` you could also use [grpc-web](https://github.com/grpc/grpc-web) or buf [connect](https://github.com/bufbuild/connect-go)
-   [Protocol Buffers]({{< relref "20230522131118-protocol_buffers.md" >}}) provides automatic documentation, client/server stub generation etc.


### grpc-web vs grpc-gateway vs grpc-go? {#grpc-web-vs-grpc-gateway-vs-grpc-go}

Both(not-together) `grpc-web` and `grpc-gateway` can be used to access a grpc server from the browser. They work differently.

| Name         | Description                                                                 | Use-case                                                        |
|--------------|-----------------------------------------------------------------------------|-----------------------------------------------------------------|
| grpc-web     | A spec patch that makes GRPC/Protobuf communication possible in the browser | Browser client                                                  |
| grpc-gateway | Exposes a more conventional RESTful/JSON API                                | Expose JSON endpoints                                           |
| grpc-go      | go runtime that's needed to use grpc                                        | Use grpc in [Golang]({{< relref "20221101220915-golang.md" >}}) |


#### grpc-web (official, a protocol and implementation) {#grpc-web--official-a-protocol-and-implementation}

![](/ox-hugo/20240122204747-grpc_protocol_buffers_and_friends-170062242.png)
![](/ox-hugo/20240122204747-grpc_protocol_buffers_and_friends-1223297026.png)

-   Official answer from the gRPC project to the question of using gRPC in the browser.
-   This can be thought of a extension of the original `grpc` spec
-   Provides a JS client library that supports the same API as gRPC-Node to access a gRPC service.
-   Differences with original grpc: [check this](https://github.com/grpc/grpc/blob/master/doc/PROTOCOL-WEB.md)
-   Also requires a proxy (Envoy)
-   gRPC makes extensive use of [HTTP]({{< relref "20230222161545-http.md" >}}) [trailers](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Trailer). Because browsers don't support trailers, no code running in a browser can speak the gRPC protocol. To work around this, the gRPC team introduced the gRPC-Web protocol, which encodes trailers at the end of the response body.


#### grpc-gateway (non-official, a plugin for protoc) {#grpc-gateway--non-official-a-plugin-for-protoc}

{{< figure src="/ox-hugo/20240122204747-grpc_protocol_buffers_and_friends-608568543.png" >}}

-   A plugin of `protoc`
-   Reads a gRPC service definition
    -   Generates a reverse-proxy server
    -   RP server translates a RESTful JSON API into gRPC.
-   gRPC-Gateway project also includes an OpenAPIv2 generator


#### grpc-go (a runtime) {#grpc-go--a-runtime}

-   `grpc-go` runtime requires a particular version of the Go protobuf library
-   twirp and buf connect don't use `grpc-go`


### <span class="org-todo todo TODO">TODO</span> grpc alternatives {#grpc-alternatives}

These are complete different RPC protocols, all based on [Protocol Buffers]({{< relref "20230522131118-protocol_buffers.md" >}}). But grpc has a good marketshare so it has something of a grpc-ecosystem with things like `grpc-go`, `grpc-gateway`, `grpc-web`, openapi spec generation etc. (All these are structured rpc frameworks)


#### grpc (2016) {#grpc--2016}

-   Lacks interoperability with the rest of the Go ecosystem.
-   gRPC implements structured RPCs
-   Hard requirement on [HTTP/2]({{< relref "20230222161545-http.md#http-2" >}})
-   Dependency on `grpc-go` runtime (generated code and the runtime library are tightly linked)


#### twirp (2018) {#twirp--2018}

> -   all plain HTTP 1.1
> -   Every request is a POST
> -   URLs are static strings identifying the right method in the right service.
> -   The body is either JSON- or binary-encoded protobuf, and so is the response.
> -   A header identifies the encoding of the body.

-   Twirp is a structured RPC framework
-   Can be used with our favorite Go routers: go-chi/chi, gorrila/mux or plain old standard library.
-   Better interoperability with the Go HTTP ecosystem.
-   Does not have streaming support, makes file upload/download harder to do.
-   error metadata string only while grpc error metadata is more verbose(?)


#### buf connect (2021) {#buf-connect--2021}

Can be considered a mix of twirp+grpc but taking only the good parts. Has QoL improvements. Eg. access to the request/response headers (Does not use `Context` for headers)

-   [Schema First API development](https://buf.build/blog/api-design-is-stuck-in-the-past) built around [Protocol Buffers]({{< relref "20230522131118-protocol_buffers.md" >}})
    -   So you want some sort of tool to produce code from a schema.
-   Tooling includes `buf` cli and `connect` itself.
-   Better interoperability with the Go HTTP ecosystem: everything is an http.Handler or http.Client. (similar to twirp)
    -   compatible with `net/http`, but does not support `grpc-go` interceptor APIs
-   Supported protocols: `grpc`, `grpc-web` protocols and `connect` protocol
    -   In case of twirp, it has less compatibaility with the grpc ecosystem
-   You don't need `grpc-gateway`, server automatically supports a REST-ish HTTP API.
-   Can talk to `grpc` servers but needs the `WithGRPC` config. otherwise uses `Connect`'s own protocol.

<!--list-separator-->

-  Connect protocol vs connect implementation

    -   Connect protocol is similar to gRPC-Web, but with fewer limitations.
    -   Connect implementations allow you to set up servers/clients for all three protocols at once (gRPC, grpc-web and Connect).

<!--list-separator-->

-  Using connect with flutter apps

    {{< figure src="/ox-hugo/20240122204747-grpc_protocol_buffers_and_friends-1762813457.png" >}}


#### Others {#others}

-   drpc
-   starpc


## <span class="org-todo todo TODO">TODO</span> Schema compatibility {#schema-compatibility}

-   <https://yokota.blog/2021/03/29/understanding-json-schema-compatibility/>
-   <https://archive.is/20220530062503/https://stevenheidel.medium.com/backward-vs-forward-compatibility-9c03c3db15c9>
-   <https://martin.kleppmann.com/2012/12/05/schema-evolution-in-avro-protocol-buffers-thrift.html>
