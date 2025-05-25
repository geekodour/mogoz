+++
title = "Modal Labs Serverless GPU"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Deploying ML applications (applied ML)]({{< relref "20241130100028-deploying_ml_applications_applied_ml.md" >}}), [GPGPU]({{< relref "20230408051445-gpgpu.md" >}})


## Modal basics {#modal-basics}


### Defining infra and code w Modal {#defining-infra-and-code-w-modal}

-   Modal’s goal is to make running code in the cloud feel like you’re running code locally.
-   Integrated Code: Modal merges infrastructure definitions (dependencies, GPUs, secrets) directly with your Python application logic. It follows a [infra-from-code](https://github.com/ehsanmok/awesome-infrastructure-from-code) model.
    -   For job processing, you need to deploy the "worker"(function)
    -   But then you make a call to it using `spawn`
-   Python Object Returns: Remotely executed Modal functions return actual Python objects (lists, dicts, custom objects, etc.) directly to your client code.


### Types of Jobs/Execution Models in Modal Labs {#types-of-jobs-execution-models-in-modal-labs}

Modal provides a flexible platform for running a variety of computational tasks without managing infrastructure. Here's a breakdown of the primary ways you can execute code:


#### 1. Immediate Inference / Synchronous Functions (Functions for Single Request/Response) {#1-dot-immediate-inference-synchronous-functions--functions-for-single-request-response}

-   **Use Case:** Designed for workloads where you send a single request and expect a single response in return, typically with low latency requirements. Common for API endpoints, interactive applications, and serving machine learning models.
-   **Execution:** A client calls a Modal function and waits for the result.
-   **Autoscaling:** Modal automatically scales these function deployments based on demand.

<!--list-separator-->

-  Dynamic Batching (`@modal.batched()`)

    > -   Batching increases throughput at a potential cost to latency.
    > -   This only helps with the batching, it does not automatically put thing thing in GPU, that's app code responsibility
    > -   When actually CALLING the method, we don't need to pass items as a list. We just pass the individual item in the `.remote/.remote.aio` call and Modal automatically handles the batching/stacking those items into a list for us.

    -   Purpose: Optimizes synchronous functions for higher throughput and lower cost by batching requests, especially for GPU tasks.
    -   Agnosticism: Modal's batching is unaware of your function's internal logic (e.g., GPU use); it only groups inputs into a list.
    -   Generality vs. Framework-Specific Batching: It's a general tool, but use a framework's (e.g., vLLM's) own batching for optimal performance and avoid Modal's batching with them.

<!--list-separator-->

-  How Dynamic Batching works

    -   **How it Works (Modal's Role):**
        -   You decorate your Modal function with `@modal.batched(max_batch_size=N, wait_ms=T)`.
        -   Modal intercepts individual incoming calls to this function.
        -   It queues these requests internally.
        -   When the queue either reaches `max_batch_size` or the oldest request has waited for `wait_ms`, Modal triggers an execution.
        -   **Crucially, Modal calls your underlying Python function \*once** for the entire formed batch.\*
        -   It passes a **list of all the input items** from the batched requests to your function.
        -   After your function processes the batch and `returns a list of results`, Modal demultiplexes these individual results and sends each one back to the correct original caller.
    -   **Your Function's Responsibility with `@modal.batched()`:**
        -   Your function code **must**
            -   be designed to accept a list of inputs
            -   return a list.
        -   Inside your function, **you are responsible for processing this list of inputs.** This often involves:
            -   Iterating through the list.
            -   For ML/GPU tasks: Collating/stacking individual input items (e.g., image tensors) into a single batch tensor (e.g., using `torch.stack()`).
            -   Moving the batched data to the GPU (e.g., `.to("cuda")`).
            -   Running your model or computation on the entire batch.
            -   Deconstructing the batched output back into a list of individual results.


#### 2. Job Queues / Asynchronous Tasks {#2-dot-job-queues-asynchronous-tasks}

> -   I honestly don't get the appeal of the "Job Queue" feature of Modal.
> -   the job queue is an inherent part of Modal's infrastructure for handling asynchronous tasks. When you call .spawn(), you are adding a job to this queue. Modal then handles the processing of these jobs, scaling as necessary to manage the workload. There is no need for you to set up a separate job queue; Modal provides this functionality as part of its service.
> -   This CAN probably work in tandem with dynamic dispatch

-   **Use Case:** Ideal for tasks that do not require immediate results, can be processed independently (and often in parallel), or need to be offloaded from a main application to avoid blocking. Examples include batch data processing, model training runs, report generation, video transcoding.
-   **Execution:**
    -   You submit tasks to a function using `FunctionName.spawn(input)`. This returns a `FunctionCall` object immediately, allowing your client code to continue without waiting.
    -   You can later check the status or retrieve the result using methods on the `FunctionCall` object (e.g., `function_call.get(timeout=...)`).
    -   Supports massive parallelism using `.map()` to apply a function over a large number of inputs concurrently.
-   **Benefits:** Scalability (Modal spins up workers as needed), reliability (built-in retries, error handling), and decoupling of task submission from task execution.
-   The pattern involves checking back on the response etc.


#### 3. Scheduled Jobs (Cron Jobs) {#3-dot-scheduled-jobs--cron-jobs}

-   **Use Case:** For tasks that need to run automatically at regular intervals (e.g., every hour, daily at a specific time). Examples include periodic data ingestion, retraining models, generating nightly reports, system maintenance.
-   **Execution:**
    -   You define a function and schedule it using `@stub.schedule()`, providing a cron expression or a fixed period (e.g., `modal.Period(days=1)`).
    -   Once deployed, Modal ensures these functions are triggered according to their schedule without manual intervention.


#### How to Choose {#how-to-choose}

-   **Need an immediate answer to a request?** Use **Immediate Inference / Synchronous Functions**.
    -   If these functions perform operations that benefit from batching (especially on GPUs) and you're not using a framework with its own superior batching (like vLLM), then enhance with **Modal's Dynamic Batching (`@modal.batched()`)**.
    -   If using a framework like vLLM, let it handle its own batching, and use Modal to serve and scale the vLLM instance.
-   **Need to run many tasks that can complete in the background?** Use **Job Queues**.
-   **Need to run tasks automatically on a recurring schedule?** Use **Scheduled Jobs**.


## Specific features {#specific-features}


### Scaling Modal Functions {#scaling-modal-functions}

-   Autoscaling
    -   Every Modal Function corresponds to an autoscaling pool of containers.
    -   The autoscaler will spin up new containers when there is no capacity available for new inputs.
    -   This can be also used to keep things warm/cold.
-   Map(`Function.Map`):
    -   If something is actually parallel.(eg. same function repeatedly with different independent inputs)
    -   Maintains order
    -   Early error possible, just marking the error also possible
    -   There's a `starmap` variant for when your input data is already "pre-packaged" as an iterator of argument groups. Nice for handling functions with multiple arguments.
    -   `.map()` invocation can process at most 1000 inputs concurrently.


### Asynchronous {#asynchronous}

-   All Modal functions have async variant to be used with asyncio if needed
-   When writing Modal function, it can be sync or async def, if sync make sure function is thead safe becuase if run with modal input conceurrency, it'll be run using python threads. If async, it'll be run using asyncio so needs not to block the event loop.


#### What to async? {#what-to-async}

<!--list-separator-->

-  Client-Side (e.g., your local_entrypoint or an external script calling the Modal app):

    -   Use async def for your calling function (e.g., async def main():).
    -   Call the Modal class method using await instance.method_name.remote.aio().
    -   Purpose: Makes the call non-blocking from the client's perspective, allowing the client script to perform other async tasks while waiting for the Modal method to complete.
    -   This does not require the Modal class method itself to be async.

<!--list-separator-->

-  Modal Class Method (e.g., def predict(...) or @modal.enter() def load_model(...)):

    -   Make a class method async def only if that method internally needs to perform await-able asynchronous operations. Examples:
    -   Calling external services with aiohttp: await http_client.get(...)
    -   Interacting with async database drivers: await db_conn.execute(...)
    -   Using await asyncio.sleep(...)
    -   Calling another async function: await some_other_async_function()
    -   If the method's internal work is purely synchronous (e.g., a standard transformers.pipeline() call, CPU-bound computations, synchronous file I/O), it does not need to be async def.
    -   Reason: Modal handles concurrency for multiple incoming requests to your synchronous methods by scaling containers or processing requests efficiently. You don't make a method async just so Modal can call it multiple times.


#### aync, sync &amp; dynamic dispatch {#aync-sync-and-dynamic-dispatch}

<!--list-separator-->

-  Example: sync + dynamic batching

    ```python
    ...classdef
    @modal.method()
    @modal.batched(max_batch_size=5, wait_ms=5000)
    def predict(self, texts_dataset) -> list:
        from transformers.pipelines.pt_utils import KeyDataset
        print("current batch: ", texts_dataset)
        final_dataset = self.pipeline(
            KeyDataset(texts_dataset, "text"),
            padding=True,
            truncation=True,
        )
        res = []
        for _, result in enumerate(final_dataset):
            res.append({
                "score": result["score"],
            })

        return res

    @app.local_entrypoint()
    def main():
        magic = Model()
        res1 = magic.predict.remote({"text": "abc"})
        print("called res1")
        res2 = magic.predict.remote({"text": "zyx"})
        print("called res2")
        res3 = magic.predict.remote({"text": "pqr"})
        print("called res3")
        print(res1)
        print(res2)
        print(res3)
    ```

    Output

    ```nil
    ✓ Created objects.
    ├── 🔨 Created mount PythonPackage:src
    ├── 🔨 Created function download_model.
    └── 🔨 Created function Model.*.
    Device set to use cuda:0
    current batch:  [{'text': 'abc'}]
    called res1
    called res2
    current batch:  [{'text': 'zyx'}]
    current batch:  [{'text': 'pqr'}]
    called res3
    {'score': 0.6363425254821777}
    {'score': 0.5392951965332031}
    {'score': 0.6883134245872498}
    Stopping app - local entrypoint completed.
    ```

<!--list-separator-->

-  Example: async + dynamic batching (gather, unordered)

    ```python
    #... the predict methods remains the same (sync method in a class, to be executed in the modal)
    # We only change the client code to run async
    async def main():
        magic = Model()
        res1 = magic.predict.remote.aio({"text": "abc"})
        print("called res1")
        res2 = magic.predict.remote.aio({"text": "zyx"})
        print("called res2")
        res3 = magic.predict.remote.aio({"text": "pqr"})
        print("called res3")
        all = [res1, res2, res3]
        results = await asyncio.gather(*all)
        print(results)
    ```

<!--list-separator-->

-  Example: async + dynamic batching (gather, unordered) + Multiple separate processes

    -   What happens if we call the modal function from 2 completely separate processes?
        -   does dynamic batching consider inputs from both the processes?
    -   If you're running ephemeral functions (non-deployed), then the end function in modal are diff functions so it won't be distributed.
    -   BUT if you have DEPLOYED, then dynamic batching plays out nicely!

<!--list-separator-->

- <span class="org-todo todo TODO">TODO</span>  Example: async but iterated (as_completed)

<!--list-separator-->

-  Example: async but iterated (remote_gen &amp; map.aio)

    Instead of handling the iteration yourself using as_completed, Modal gives you convenience method `map`, `map.aio` etc.

    ```python
    @app.function()
    async def classify_dataset(dataset):
        batched_bert = Model()
        async for cls in batched_bert.classify.map.aio(dataset):
            yield cls

    @app.function()
    async def fetch_and_process_twig(dataset):
        scores = []
        for result in classify_dataset.remote_gen(dataset):
            scores.append(result)
        return scores
    ```


### Concurrency Model {#concurrency-model}

-   By default, each `container` will be assigned one `input` at a time. Scaling happens at container level of unit.
-   If you want to process multiple inputs in the same container, you can configure the "input concurrency"
    -   You'd want to do something like this if you run `vLLM` which does `continious batching`


### Distributed KV &amp; Queue {#distributed-kv-and-queue}

> -   that .put and .get are aliases for the overloaded indexing operators on Dicts, but you need to invoke them by name for asynchronous calls.
> -   These are just distributed(optionally persistent) data structures that we can use in our application code if needed.

-   Dict gotcha: Unlike with normal Python dictionaries, updates to mutable value types will not be reflected in other containers unless the updated object is explicitly put back into the Dict. As a consequence, patterns like chained updates (my_dict["outer_key"]["inner_key"] = value) cannot be used the same way as they would with a local dictionary.
-   Queue
    -   FIFO
    -   No pub/sub
    -   These `Queue` have something called `partition`, which is like "consumer groups", you can filter by it when trying to retrieve from the queue.
    -   There are limits around how many items per queue etc.


## Training on Modal {#training-on-modal}

-   Training on modal works just fine
-   Modal currently supports multi-GPU training on a single machine, with multi-training in closed beta
-   Depending on which framework you are using, you may need to use different techniques to train on multiple GPUs.


## Deployment {#deployment}


### Modal App Fundamentals {#modal-app-fundamentals}

-   `modal.App`: The core object representing your application, associating all functions and classes. (Replaces legacy `modal.Stub`).
-   Two Main Types:
    -   Ephemeral Apps: Temporary, for script duration.
    -   Deployed Apps: Persistent, until manually deleted.


### Ephemeral Apps (Temporary) {#ephemeral-apps--temporary}

-   Creation:
    -   `modal run script.py` (CLI): Creates a temporary app. Use `--detach` to keep it running after client exits.
    -   `app.run()` (Python SDK): Runs app from within Python. Use `with modal.enable_output():` to see logs.
-   Entrypoints (for `modal run`):
    -   Define the initial code to execute.
    -   `@app.local_entrypoint()`: Runs locally.
    -   `@app.function()`: Can be a remote entrypoint (global scope local, function remote).
    -   Selection for `modal run`:
        -   Automatic: If one unique `@app.local_entrypoint()` or (if none) one unique `@app.function()`.
        -   Manual: Specify with `modal run script.py::app.function_name`.
-   Argument Parsing (for entrypoints called with `modal run`):
    -   Automatic: For primitive types (e.g., `def main(foo: int)` allows `modal run ... --foo 123`).
    -   Manual: If function takes `*arglist`, Modal passes raw CLI args for custom parsing (e.g., with `argparse`).


### Deployed Apps (Persistent) {#deployed-apps--persistent}

-   Creation: `modal deploy script.py` (CLI).
-   Naming: Named via `app = modal.App("my-app-name")`. Re-deploying to an existing name updates it.
-   No "Entrypoints" (like `modal run`):
    -   Deployed apps don't have a single starting "entrypoint" that runs on deployment.
    -   Instead, individual functions within the deployed app are invoked directly through:
        -   Schedules: Functions run automatically based on their defined schedule.
        -   Web Endpoints: Functions are triggered by HTTP requests.
        -   Python Client: Functions are called remotely from other Python code (e.g., `DeployedApp.lookup(...).func.remote()`). `modal.Function.from_name(`
            -   MODAL_TOKEN_ID MODAL_TOKEN_SECRET
