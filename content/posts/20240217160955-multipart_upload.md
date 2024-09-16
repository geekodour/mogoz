+++
title = "Multipart Upload and HTTP Streaming"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [HTTP]({{< relref "20230222161545-http.md" >}})


## FAQ {#faq}


### Do you need Tus server if you use s3 multipart? {#do-you-need-tus-server-if-you-use-s3-multipart}


### Use of responses in FastAPI {#use-of-responses-in-fastapi}

-   See [python - How do I return an image in fastAPI? - Stack Overflow](https://stackoverflow.com/questions/55873174/how-do-i-return-an-image-in-fastapi)
    -   `StreamingResponse` doesn't make sense when we have the file already in memory!


### Multipart Upload / Download? {#multipart-upload-download}

-   There's nothing called multipart download. This can be sort of emulated with HTTP Range requests.
-   Multipart Upload is a real thing.


### Purpose of Multipart Upload {#purpose-of-multipart-upload}

-   To upload large files (typically over 100 MB) more efficiently
-   To resume interrupted uploads
-   To upload parts of a file in parallel, potentially increasing throughput


## S3 and Multipart Uploads {#s3-and-multipart-uploads}


### S3 based storage &amp; Multipart uploads {#s3-based-storage-and-multipart-uploads}

-   Performance: We can upload multiple chunks in parallel
    -   "S3 uses HTTP/1.1, which means a limit to concurrent connections and your uploads may expire before they are uploaded.", [source](https://uppy.io/docs/aws-s3/#shouldusemultipartfile)
-   Reliability: We can retry parts which fail
-   File limits: S3 has a 5GB limit in a single PUT


### The story with content-length {#the-story-with-content-length}

-   It has to be exact, less it'll error, more it'll truncate!
    -   <https://stackoverflow.com/questions/25991275/limit-size-of-objects-while-uploading-to-amazon-s3-using-pre-signed-url>


### Use of Uppy {#use-of-uppy}

Uppy is a combination of opinionated fronetend library and some backend components and more of an architecture aswell.

-   <https://community.transloadit.com/t/uppy-aws-s3-pre-signed-url-nodejs-complete-example-including-metadata-and-tags/15137>
    -   Using Uppy without `Companion`, makes request to backend for presigned request.
    -   from Uppy docs regarding
-   I honestly don't see a much need to use uppy unless you need the upload from various sources thing. (Eg. box, instagram, drive, others), we can simply use direct upload or some ui only library, keeps things simpler.


## Content Disposition {#content-disposition}


### Usage {#usage}

-   `Response from server`: It's used by the server to indicate whether the file should be downloaded / viewed inline
-   `Multipart Upload`: It's also used as part of multi-part upload.


## HTTP Streaming {#http-streaming}

-   Resources
    -   [HTTP Streaming in Val Town](https://blog.val.town/blog/http-streaming/)
    -   [Notes on streaming large API responses](https://simonwillison.net/2021/Jun/25/streaming-large-api-responses/)
    -   [Improving Performance with HTTP Streaming | by Victor | The Airbnb Tech Blog | Medium](https://medium.com/airbnb-engineering/improving-performance-with-http-streaming-ba9e72c66408)
    -   [HTTP Streaming (or Chunked vs Store &amp; Forward) · GitHub](https://gist.github.com/CMCDragonkai/6bfade6431e9ffb7fe88)
-   This is not a specific technology as such, it's just something to implemented using differernt things. We can use [SSE]({{< relref "20230222180430-sse.md" >}}) or [WebSockets]({{< relref "20230222181643-websockets.md" >}}) or polling etc etc.
-   What?
    -   In a plain HTTP connection, the client establishes a connection with the server, sends some data to it, the server replies, the client reads the response and the connection is closed.
    -   With streaming it is a bit different: the client opens a connection and sends some data, and that part stays the same; the server then sends the response while the connection stays open, and the client and server can exchange more data over the same connection.


### Chunked Transfer Encoding {#chunked-transfer-encoding}

-   See [Chunked transfer encoding - Wikiwand](https://www.wikiwand.com/en/Chunked_transfer_encoding)
-   Chunked transfer encoding makes sense when you don't know the size of your output ahead of time, and you don't want to wait to collect it all to find out before you start sending it to the client.
    -   apply to stuff like serving the results of slow database queries
