+++
title = "Multipart Upload and HTTP Streaming"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [HTTP]({{< relref "20230222161545-http.md" >}}), [WebSockets]({{< relref "20230222181643-websockets.md" >}}), [SSE]({{< relref "20230222180430-sse.md" >}})


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

> This is not a specific technology as such, it's just something to implemented using different things. We can use [SSE]({{< relref "20230222180430-sse.md" >}}) or [WebSockets]({{< relref "20230222181643-websockets.md" >}}) or polling etc etc.


### Concerns/FAQ {#concerns-faq}


#### How is it different from normal requests? {#how-is-it-different-from-normal-requests}

-   In a plain HTTP connection, the client establishes a connection with the server, sends some data to it, the server replies, the client reads the response and the connection is closed.
-   With streaming it is a bit different: the client opens a connection and sends some data, and that part stays the same; the server then sends the response while the connection stays open, and the client and server can exchange more data over the same connection.


#### Some formats are easier than others {#some-formats-are-easier-than-others}

-   CSV and TSV are pretty easy to stream, as is newline-delimited JSON.
-   Regular JSON requires a bit more thought


#### Streaming vs Buffered? {#streaming-vs-buffered}

Imagine we had a spigot and two options:

-   Fill a big cup, and then pour it all down the tube (the “buffered” strategy)
-   Connect the spigot directly to the tube (the “streaming” strategy)

Now, streaming has benefits but needs additional engineering effort required to break the page into independent chunks.


### Types {#types}


#### Core HTTP-Level Streaming Mechanisms: The Foundation {#core-http-level-streaming-mechanisms-the-foundation}

<!--list-separator-->

-  HTTP/1.1 Chunked Transfer Encoding

    -   **What it is:** The bedrock of much of HTTP streaming. Instead of sending a response with a pre-calculated `Content-Length`, the server sends the data in a series of "chunks." Each chunk is prefixed with its size, and the stream ends with a special zero-length chunk. The header `Transfer-Encoding: chunked` signals this.
    -   **How it works:** The server can send parts of the response as they become available, flushing each chunk to the network. The client (e.g., a browser) can start processing these chunks immediately.
    -   **Pros:**
        -   Essential for sending data when the total size isn't known beforehand (e.g., live log updates, dynamically generated content).
        -   Reduces Time to First Byte (TTFB) and allows browsers to start rendering pages or processing data much faster.
        -   Saves server memory, as the entire response doesn't need to be buffered. Val Town's move to support unlimited response sizes is a direct benefit of this, as they no longer buffer and store entire responses.
    -   **Cons:**
        -   Slight overhead due to chunk metadata.
        -   Buffering by intermediate proxies or web servers (like nginx) can negate streaming benefits unless configured correctly (e.g., nginx's `proxy_buffering off;` or `X-Accel-Buffering: no;`).
        -   Very small, frequent chunks can be inefficient and might run into network-level optimizations (like Nagle's algorithm) that can introduce latency.
    -   **Use Cases:** Dynamically generated HTML, streaming large API responses (JSON, CSV), and as the underlying mechanism for Server-Sent Events (SSE). The ability to proxy large files, like the Webb Telescope image example from Val Town, relies on this.
        ```javascript
             // Val Town Example: Proxying a large image (conceptual)
             // export default async function (req: Request) {
             //   return fetch(
             //     "https://live.staticflickr.com/65535/53782948438_9b85e57a6c_o_d.png"
             //   );
             // }
        ```

        -   **Relation to HTTP:** A fundamental part of HTTP/1.1 for sending dynamically sized responses.

<!--list-separator-->

-  Byte Serving (HTTP Range Requests)

    -   **What it is:** Allows clients to request only specific portions (byte ranges) of a resource using the `Range` HTTP header. The server responds with a `206 Partial Content` status.
    -   **How it works:** Ideal when the total `Content-Length` is known. The client requests, for example, "bytes 1000-1999."
    -   **Pros:**
        -   Enables resumable downloads.
        -   Allows clients to fetch only necessary parts of large files (e.g., seeking in a video).
        -   Can be combined with chunked encoding for streaming partial responses.
    -   **Cons:**
        -   Requires server support and knowledge of the total content length.
    -   **Use Cases:** Video and audio streaming, PDF viewers, large file downloads.
    -   **Relation to HTTP:** A standard HTTP feature.


#### Application-Level Streaming Protocols &amp; Techniques over HTTP {#application-level-streaming-protocols-and-techniques-over-http}

<!--list-separator-->

-  Server-Sent Events (SSE)

    -   **What it is:** A W3C standard enabling servers to push real-time updates to clients over a single, unidirectional (server-to-client) HTTP connection. Clients use the `EventSource` API in JavaScript.
    -   **How it works:** The server maintains an open HTTP connection (using chunked encoding) and sends messages formatted as `data: <message>\n\n`. It can also send event names and IDs. The `Content-Type` is typically `text/event-stream`.
    -   **Pros:**
        -   Simpler to implement than WebSockets for server-to-client data push.
        -   Automatic reconnection by the browser if the connection drops (though advanced control over retries often needs custom solutions or libraries like "Fetch Event Source").
        -   Built on standard HTTP, making it firewall-friendly.
    -   **Cons:**
        -   Unidirectional (server-to-client only).
        -   Limited number of concurrent connections per domain in older HTTP/1.1 scenarios (HTTP/2 mitigates this).
        -   Primarily for text-based events.
    -   **Use Cases:**
        -   Live notifications, activity feeds, stock tickers.
        -   **Streaming LLM Responses:** A classic use case highlighted by Val Town. LLMs generate responses token by token, and SSE is perfect for sending these partial responses.
            ```javascript
                   // Val Town Example: Streaming OpenAI LLM Response
                   // import { OpenAI } from "https://esm.town/v/std/openai";
                   // export default async function (req: Request): Promise<Response> {
                   //   const openai = new OpenAI();
                   //   const stream = await openai.chat.completions.create({
                   //     stream: true,
                   //     messages: [
                   //       {
                   //         role: "user",
                   //         content: "Write a poem in the style of beowulf about the DMV",
                   //       },
                   //     ],
                   //     model: "gpt-3.5-turbo",
                   //     max_tokens: 2048,
                   //   });
                   //   return new Response(
                   //     new ReadableStream({
                   //       async start(controller) {
                   //         for await (const chunk of stream) {
                   //           controller.enqueue(
                   //             new TextEncoder().encode(chunk.choices[0]?.delta?.content)
                   //           );
                   //         }
                   //         controller.close();
                   //       },
                   //     }),
                   //     { headers: { "Content-Type": "text/event-stream" } }
                   //   );
                   // }
            ```
        -   Real-time data updates, like the `robpike.io` clone or the `multiplayerCircles` example from Val Town.
            ```javascript
                   // Val Town Example: robpike.io clone (SSE)
                   // const msg = new TextEncoder().encode("💩");
                   // const initialDelay = 20;
                   // export default async function (req: Request): Promise<Response> {
                   //   let timerId: number | undefined;
                   //   const body = new ReadableStream({
                   //     start(controller) {
                   //       let currentDelay = initialDelay;
                   //       function writeToStream() {
                   //         currentDelay *= 1.03;
                   //         controller.enqueue(msg);
                   //         timerId = setTimeout(writeToStream, currentDelay);
                   //       }
                   //       writeToStream();
                   //     },
                   //     cancel() {
                   //       if (typeof timerId === "number") {
                   //         clearInterval(timerId);
                   //       }
                   //     },
                   //   });
                   //   return new Response(body, {
                   //     headers: {
                   //       "Content-Type": "text/event-stream",
                   //     },
                   //   });
                   // }
            ```
    -   **Relation to HTTP:** Operates over a standard HTTP connection, using chunked encoding implicitly.

<!--list-separator-->

-  Streaming Large Request Bodies

    -   **What it is:** The ability for a server to process an incoming request body as a stream, without needing to load the entire body into memory first.
    -   **How it works:** The server reads the request body in chunks using APIs like `req.body.getReader()`. This is crucial for handling large file uploads or extensive data submissions.
    -   **Pros:**
        -   Allows processing of request bodies larger than available server memory (Val Town increased its limit from 2MB to 100MB by implementing this).
        -   Improves server scalability and resilience.
    -   **Cons:**
        -   Requires the server framework and application code to be designed to handle streamed input.
    -   **Use Cases:** Uploading large files, submitting large JSON payloads, data ingestion pipelines.
        ```javascript
             // Val Town Example: Reporting request body size by streaming
             // export default async function (req: Request): Promise<Response> {
             //   if (req.method !== "POST") {
             //     return new Response("Method not allowed", { status: 405 });
             //   }
             //   const reader = req.body.getReader();
             //   let totalBytes = 0;
             //   while (true) {
             //     const { done, value } = await reader.read();
             //     if (done) break;
             //     totalBytes += value.byteLength;
             //   }
             //   return new Response(`${totalBytes}`);
             // }
        ```
    -   **Relation to HTTP:** Relies on the client sending data (potentially chunked) and the server having stream-reading capabilities for the request body.


#### Separate Bidirectional Streaming Protocols {#separate-bidirectional-streaming-protocols}

<!--list-separator-->

-  WebSockets

    -   **What it is:** A distinct protocol (RFC 6455) providing full-duplex (two-way) communication channels over a single, long-lived TCP connection. It starts with an HTTP "upgrade" request.
    -   **How it works:** After the initial HTTP handshake, the connection is upgraded, and both client and server can send messages independently and concurrently.
    -   **Pros:**
        -   True bidirectional, low-latency communication.
        -   Efficient for high-frequency, small messages.
        -   Supports binary data natively.
    -   **Cons:**
        -   More complex to implement and manage than SSE.
        -   Can be more resource-intensive on servers due to persistent connections.
    -   **Use Cases:** Real-time chat applications, multiplayer online games, collaborative editing tools, live financial data requiring client interaction. Val Town notes that their new HTTP streaming architecture paves the way for future WebSocket support.
    -   **Relation to HTTP:** Uses HTTP only for the initial handshake.


#### HTML Streaming Techniques for Enhanced Web Page Performance &amp; UI {#html-streaming-techniques-for-enhanced-web-page-performance-and-ui}

<!--list-separator-->

-  Early Flush (Streaming the `<head>`)

    -   **What it is:** Sending the initial part of an HTML document, specifically the `<head>` section containing critical CSS links, preload hints, and synchronous JavaScript, as the very first chunk(s).
    -   **Pros:**
        -   Allows the browser to start discovering and downloading critical assets much earlier.
        -   Significantly improving perceived performance and metrics like First Contentful Paint (FCP).
    -   **Cons:**
        -   Requires careful server-side application structuring to generate the head independently and quickly.
        -   HTTP headers (like status code, redirects) must be finalized before the first chunk is sent.
    -   **Relation to HTTP:** Relies on chunked transfer encoding to send HTML in parts.

<!--list-separator-->

-  Streaming HTML Body / Deferred Data

    -   **What it is:** After an early flush of the head, the server can continue to stream the HTML body in parts. This can include rendering a basic page structure or loading states first, and then streaming data-dependent content or embedding data directly into the HTML stream (e.g., within `<script type`"application/json"&gt;= tags).
    -   **Pros:**
        -   Allows parallel server-side rendering and data-fetching. Users see content faster.
        -   Can avoid client-side data-fetching waterfalls. The `thesephist/webgen` Val Town example (ask ChatGPT to generate a website and watch it render bit by bit) demonstrates this principle.
    -   **Cons:**
        -   Adds complexity to server rendering logic and client-side hydration if data is embedded.
    -   **Relation to HTTP:** Relies on chunked transfer encoding.

<!--list-separator-->

-  Streaming Full HTML Responses for Real-time UI (e.g., "Chat sans JS")

    -   **What it is:** Continuously writing new HTML fragments (e.g., `<li>new message</li>`) to an open HTTP response, often displayed within an `<iframe>`. The browser renders these as they arrive.
    -   **Pros:**
        -   Creates real-time UI updates with minimal or no client-side JavaScript for the rendering part.
        -   Highly compatible with older browsers or when JavaScript is disabled (for the core update mechanism).
    -   **Cons:**
        -   Can be clunky for complex UIs.
        -   Ensuring the main page properly indicates "loading complete" can be tricky if the stream is long-lived or indefinite.
    -   **Relation to HTTP:** Leverages chunked transfer encoding to push HTML updates.


#### API Response Streaming for Large Datasets {#api-response-streaming-for-large-datasets}

<!--list-separator-->

-  Streaming Large JSON/CSV/TSV API Responses

    -   **What it is:** Instead of traditional pagination where clients make many small requests to fetch a large dataset, a single API endpoint streams the entire dataset directly.
    -   **Pros:**
        -   Massively faster for bulk data export compared to repeated pagination.
        -   Reduces request overhead on both client and server.
        -   Can be very memory-efficient on the server if data is piped directly from the database (or other source) to the network stream without full buffering.
    -   **Cons:**
        -   Error handling mid-stream is more complex as the HTTP 200 OK status code has already been sent. Errors typically need to be embedded within the stream format itself (e.g., an error object in a JSON stream, or a specific marker in CSV).
        -   Resumability is harder to implement. Clients might need custom logic, or the server might need to support a parameter like `?since=<last_processed_id>` to restart the stream.
        -   Server restarts can interrupt long downloads, potentially leaving clients with incomplete data.
    -   **Use Cases:** Bulk data export features ("download all my data"), data synchronization tasks, feeding large datasets to data processing pipelines or other services.
    -   **Relation to HTTP:** Typically uses chunked transfer encoding.


#### Architectural Patterns Leveraging Streaming {#architectural-patterns-leveraging-streaming}

<!--list-separator-->

-  Background Task Processing with Queues &amp; Streaming Updates

    -   **What it is:** For long-running operations (e.g., video processing, report generation, your voice transcription example), the client makes an initial request. The server acknowledges it quickly (often returning a Job ID), queues the task for asynchronous background workers (often managed via message queues like RabbitMQ, SQS, Kafka). Updates on the task's progress or the final result are then streamed back to the client as they become available.
    -   **How it works:**
        1.  Client initiates task via API (e.g., uploads file, sends parameters).
        2.  API server validates, creates a job record, places a message on a queue, and returns a Job ID to the client.
        3.  Client subscribes to updates for that Job ID using a real-time mechanism (SSE or WebSockets).
        4.  Background worker(s) consume tasks from the queue.
        5.  As the worker processes the task, it updates the job status/results in a database or sends intermediate progress events.
        6.  A notification service (or the workers themselves) pushes these updates/results to the subscribed client via SSE/WebSockets.
    -   **Pros:**
        -   Highly scalable (workers can be scaled independently).
        -   Resilient (tasks can be retried if a worker fails).
        -   Decouples frontend from backend processing, providing a responsive UX as the client isn't blocked waiting for a long HTTP response.
    -   **Cons:**
        -   More complex to set up due to multiple components (API, message queue, workers, notification service, real-time communication layer).
    -   **Relation to HTTP:** The initial request is HTTP. Subsequent updates are typically via SSE or WebSockets (which use HTTP for handshake/transport).

<!--list-separator-->

-  Generate and Serve from Cloud Storage (Alternative for Bulk Exports)

    -   **What it is:** For very large, non-real-time exports, instead of directly streaming the data from the application server, a background task generates the full export file (e.g., CSV, JSON dump, ZIP archive) and saves it to cloud storage (like AWS S3, Google Cloud Storage). The client is then given a link (e.g., a pre-signed URL) to download this static file.
    -   **Pros:**
        -   Very robust and scalable for extremely large files.
        -   Leverages cloud storage's efficient download capabilities (CDNs, built-in resumability via range requests).
        -   Decouples the resource-intensive export generation from the application server, preventing it from being tied up with long-running streaming connections.
        -   Simplifies handling of server restarts and errors during generation (the download is of a complete, verified file).
    -   **Cons:**
        -   Less "real-time" – the client has to wait for the entire file to be generated before download can begin.
        -   Not suitable if the data needs to be truly live or reflect the absolute latest state at the moment of request.
    -   **Relation to HTTP:** The final download is a standard HTTP GET request to the cloud storage provider.


### Resources {#resources}

-   [ ] [AsyncIterator - JavaScript | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/AsyncIterator)
    -   [ ] [HTTP Streaming in Val Town](https://blog.val.town/blog/http-streaming/)
-   [X] [Using WebSockets with React Query | TkDodo's blog](https://tkdodo.eu/blog/using-web-sockets-with-react-query)
-   [X] [The Cursed Art of Streaming HTML – rinici.de](https://rinici.de/posts/streaming-html)
-   [X] [Notes on streaming large API responses](https://simonwillison.net/2021/Jun/25/streaming-large-api-responses/)
-   [X] [Improving Performance with HTTP Streaming | by Victor | The Airbnb Tech Blog | Medium](https://medium.com/airbnb-engineering/improving-performance-with-http-streaming-ba9e72c66408)
-   [ ] [HTTP Streaming (or Chunked vs Store &amp; Forward) · GitHub](https://gist.github.com/CMCDragonkai/6bfade6431e9ffb7fe88)
