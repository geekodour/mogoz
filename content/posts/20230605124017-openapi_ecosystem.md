+++
title = "OpenAPI Ecosystem"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [API Design]({{< relref "20230302195820-api_design.md" >}}), [Custom Protocols]({{< relref "20230221012237-custom_protocols.md" >}})


## FAQ {#faq}


### Swagger vs OpenAPI {#swagger-vs-openapi}

New name of Swagger is OpenAPI


### Do you need open API? {#do-you-need-open-api}

-   It's a documentation thing, you can roll without it, but if the API is getting too big, something like open API can help. It'll help you generate automated docs, mocks etc etc.
-   You can just document it with things like org-mode verb, just using postman collections etc.
-   "OpenAPI tries too hard to cover every base and has become the SOAP of this generation." - some internet person


### Relation of spec and programming languages {#relation-of-spec-and-programming-languages}

The spec(openapi.yaml) file is standalone, it's independent of programming language. This is true if using spec for only spec and documentation. But for codegen, there are too many tools in different languages w different levels of support and implementation.


### API Design first or code first? {#api-design-first-or-code-first}

This is not OpenAPI specific, it can be about any specification in general.


#### Why API Design first? {#why-api-design-first}

-   Sometimes its costly for code first APIs, we need people to be on the same page about it.
-   In that case, we can do a API design first approach and we can use it as ref when writing code.


#### Why Code first? {#why-code-first}

-   Historically it's code first and then we document our API with something like OpenAPISpec.
-   Issue w writing specs before code is that u are not aware of what the api looks like finally (incremental)


## Components {#components}


### Data part {#data-part}

-   This is where you define the schema of the things that can be accessible via the API
-   This uses JSONSchema, [Protocol Buffers]({{< relref "20230522131118-protocol_buffers.md" >}}) can be an alternative for this data part.


### Network part {#network-part}

-   `server` and `paths` of the API


### Structure part {#structure-part}

Open API is about describing the API, if you want to structure the API responses, you can use JSON API.

-   JSON API
    -   API spec for building apis in json
    -   Gives more structure to the "response" itself
    -   OpenAPI can be used with JSON API. They compliment each other if needed.
    -   See [OpenAPI 3.0 spec that conforms to JSON:API - JSON API](https://discuss.jsonapi.org/t/openapi-3-0-spec-that-conforms-to-json-api/1803)


## OpenAPI related tools {#openapi-related-tools}


### Writing the spec {#writing-the-spec}

-   You can handwrite it, but it tedious
-   Postman and Insomnia has some support also
-   [Stoplight Studio](https://stoplight.io/studio) is good if you buy it
-   Use codegen


### Documentation {#documentation}

-   [ReDoc](https://redocly.github.io/redoc/) (doc gens:[speccy](https://github.com/wework/speccy)(old))
-   [slate](https://github.com/slatedocs/slate) (doc gens: [widdershins](https://github.com/mermade/widdershins))


### Codegen {#codegen}

-   You need to find a generator that works for you, here are some options
-   `Client = SDK`, `Sever = Server stub`


#### Spec to Code (Boilerplate generation) {#spec-to-code--boilerplate-generation}

-   Multi-lang: [kiota](https://github.com/microsoft/kiota)(client), [openapi-generator](https://github.com/OpenAPITools/openapi-generator)(client&amp;server)
-   Go: [deepmap/oapi-codegen](https://github.com/deepmap/oapi-codegen)(client&amp;server), [ogen](https://github.com/ogen-go/ogen/discussions/783#discussioncomment-4919088)(client&amp;server), [go-swagger](https://github.com/go-swagger/go-swagger)(client&amp;server but v2)
-   TS: [openapi-typescript-codegen](https://github.com/ferdikoomen/openapi-typescript-codegen), [openapi-typescript](https://github.com/drwpow/openapi-typescript), [openapi-codegen](https://github.com/fabien0102/openapi-codegen), [swagger-typescript-api](https://github.com/acacode/swagger-typescript-api)
-   protocol buffers: [gnostic](https://github.com/google/gnostic)


#### Code to Spec (Spec generation, more realistic for small use-cases) {#code-to-spec--spec-generation-more-realistic-for-small-use-cases}

-   Go: [fizz](https://github.com/wI2L/fizz), [swago](https://github.com/swaggo/swag)(v2)
-   TS: [tsoa](https://tsoa-community.github.io/docs/)
-   Rust: [utopia](https://github.com/juhaku/utoipa)


### Mock server {#mock-server}

-   [prism](https://github.com/stoplightio/prism)


## Alternatives? {#alternatives}


### Async {#async}

-   OpenAPI not fit for documenting event driven APIs, It's mostly meant for REST
-   <https://github.com/asyncapi/spec>


### Fern {#fern}

-   For REST, but tries to be better than OpenAPI
-   <https://github.com/fern-api/fern>


### GraphQL {#graphql}


### Goa {#goa}

-   <https://github.com/goadesign/goa>


### Protocol Buffers {#protocol-buffers}

-   See [Protocol Buffers]({{< relref "20230522131118-protocol_buffers.md" >}})
