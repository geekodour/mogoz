+++
title = "Protocol Buffers"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Custom Protocols]({{< relref "20230221012237-custom_protocols.md" >}}), [API Design]({{< relref "20230302195820-api_design.md" >}})


## OpenAPI {#openapi}

-   New name of Swagger is OpenAPI
-   It includes most of JSON schema (data struct part)
-   Network API part is different. (TODO)


## What? {#what}

PB is 2 things


### Data serialization format {#data-serialization-format}

-   The tools to deal with the PB serialization format are low-level, since it's a google thing, outside of google we only have access to protobuf piece but not the rest of the stack. Which makes it little difficult to work w it.
-   <https://buf.build/> is a good way ig


### A way to define schema for data {#a-way-to-define-schema-for-data}

-   PB can be compared to JSON Schema in this regard. Except it supports more stuff than JS native types in JSON API in JSON schema. JSON schema also has all the parent schema and linking stuff, ig PB doesn't have all that. More self sufficient types.


## Using {#using}

-   You can use pb to send and accept json (Using it for APIs)
