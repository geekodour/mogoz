+++
title = "Deploying ML applications (applied ML)"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Machine Learning]({{< relref "20230408190056-machine_learning.md" >}}), [Modern AI Stack]({{< relref "20230326092427-modern_ai_stack.md" >}}), [Open Source LLMs (Transformers)]({{< relref "20230719050449-open_source_llms.md" >}}), [Infrastructure]({{< relref "20221101183735-infrastructure.md" >}})


## Development/Tooling {#development-tooling}

-   counting tokens: <https://github.com/simonw/ttok>
-   CLI for embeddings and text classification/[Clustering]({{< relref "20241227082910-clustering.md" >}}): <https://github.com/taylorai/aiq>
-   Compression: <https://news.ycombinator.com/item?id=42517035>
-   Prototyping
    -   <https://github.com/paradigmxyz/flux>
    -   <https://github.com/neuml/txtai>
        -   [T2x – a CLI tool for AI-first text operations | Hacker News](https://news.ycombinator.com/item?id=42555953)
    -   <https://simonwillison.net/2024/Oct/29/llm-multi-modal/>
-   emacs integration: [gptel: a simple LLM client for Emacs | Hacker News](https://news.ycombinator.com/item?id=42034675)
-   [ML in Go with a Python sidecar - Eli Bendersky's website](https://eli.thegreenplace.net/2024/ml-in-go-with-a-python-sidecar/)
-   Price calculator: <https://tools.simonwillison.net/llm-prices>
-   <https://huggingface.co/spaces/NyxKrage/LLM-Model-VRAM-Calculator>
-   <https://artefact2.github.io/llm-sampling/>
-   FE: <https://github.com/SillyTavern/SillyTavern>
-   Benchmarks
    -   [Show HN: Countless.dev – A website to compare every AI model: LLMs, TTSs, STTs | Hacker News](https://news.ycombinator.com/item?id=42348513)


## Security and Jailbreaking LLMs {#security-and-jailbreaking-llms}

-   [Lessons From Red Teaming 100 Generative AI Products | Lobsters](https://lobste.rs/s/bbrgdy/lessons_from_red_teaming_100_generative)


## Ecosystem {#ecosystem}


### Convert to LLM'able text {#convert-to-llm-able-text}

-   See [Scraping]({{< relref "20230115032823-scraping.md" >}})
-   <https://www.firecrawl.dev/>
-   <https://github.com/microsoft/markitdown>
-   <https://github.com/yamadashy/repomix> (code repos into single file)


### Others {#others}

-   <https://llmstxt.site/>
-   <https://llmstxt.org/>


## Deploy/Inference {#deploy-inference}

> -   vLLM is the fastest overall with batching, and has decent (but not SOTA) 4 bit quantization.
> -   Llama.cpp has the best hybrid CPU/GPU inference by far, has the most bells and whistles, has good and very flexible quantization, and is reasonably fast in CUDA without batching (but is getting batching soon). It has opencl and rocm backends, but support is focused on CUDA/Metal/CPU. Its the best backend for dGPUs that wont fit the whole model, and is otherwise a jack of all trades.
> -   MLC-LLM (with the TVM Vulkan backend) is the king of speed on IGPs, mobile devices and AMD/Intel dGPUs without having to fuss with a ROCM install. Its extremely fast on Nvidia dGPUS even without CUDA. It theoretically has "easy" support for webGPU and exotic hardware like FPGAs or AI blocks. But its 4-bit quantization was not as good as llama.cpp, last I checked.
> -   exLLAMAv2 has, by far, the best quantization for squeezing models onto small GPUs, and is the fastest CUDA (and ROCM?) backend with no batching. Its feature rich with a frontend like text-gen-ui
> -   Plain HF Transformers is... a fine default, but the master of none. The best use case is probably for testing research implementations.


### Deployment Styles {#deployment-styles}


#### Managed {#managed}

-   <https://modal.com/> (You still need to setup vLLM yourself)
-   <https://replicate.com/docs/guides/push-a-model> (Uses [CoG](https://github.com/replicate/cog))


#### Selfhosted {#selfhosted}

-   Ray + vLLM
-   In general my approach to that is to use AWS EC2 Image Builder to create images with llama.cpp and your fine-tuned model, then use Auto Scaler to add/remove EC2 instances as needed. If you project does not have a lot of users yet you can setup Auto Scaling from 0 to 1, so you won't pay for it (a lot) while you are not using it.
-   <https://github.com/distantmagic/paddler>
-   <https://llmops-handbook.distantmagic.com/>


#### Quantization {#quantization}

![](/ox-hugo/20241130100028-deploying_ml_applications_applied_ml-152111264.png)
<https://github.com/mit-han-lab/llm-awq>
<https://github.com/casper-hansen/AutoAWQ>

-   Example: <https://huggingface.co/parlance-labs/hc-mistral-alpaca-merged-awq>


### Challenges in Deploy {#challenges-in-deploy}


#### What makes LLMs slow? {#what-makes-llms-slow}

> -   Kernels are just functions that run on a [GPU]({{< relref "20230408051445-gpgpu.md" >}})
> -   Flash attention, page attention etc are just better implementation of attention.

LLM operations need to transfer data from slow memory to fast memory caches. This takes the most time.
![](/ox-hugo/20241130100028-deploying_ml_applications_applied_ml-1348250746.png)

-   Solution
    -   Smarter cuda kernels(flash attention, paged attention, softmax etc.)
    -   Smaller data(quantization! etc.)


#### Making LLMS fast {#making-llms-fast}

| Category                | Techniques             |
|-------------------------|------------------------|
| Low-level optimizations | - Kernel fusion        |
|                         | - Kernel optimization  |
|                         | - CUDA Graphs          |
| Run-time optimizations  | - Continuous batching  |
|                         | - KV Caching           |
|                         | - Hardware upgrades    |
| Tricks                  | - Speculative decoding |
|                         | - Shorter outputs      |
|                         | - Shorter inputs       |

-   [Bringing K/V Context Quantisation to Ollama | smcleod.net](https://smcleod.net/2024/12/bringing-k/v-context-quantisation-to-ollama/)


### Multistep Reasoning {#multistep-reasoning}

[Scaling test-time compute - a Hugging Face Space by HuggingFaceH4](https://huggingface.co/spaces/HuggingFaceH4/blogpost-scaling-test-time-compute)

> For problems that require multi-step reasoning, standard LLMs seem to be stuck. The field is increasingly interested in models like o1 that output many "guesses" to find the right one. Currently open-source does not know how to do this, but we are reimplementing several possible directions to try. This replicates one important path using search and a verifier model.


## Training {#training}

-   train: <https://huggingface.co/autotrain>


## Tokenization {#tokenization}

See [NLP (Natural Language Processing)]({{< relref "20231123010516-nlp_natural_language_processing.md" >}})


## Prompt Eng {#prompt-eng}

-   We want to prompt in the right way and stack things in the right way
-   <https://docs.ell.so/>


### DSPy {#dspy}

> DSPy is task independent, infact task-adaptive.

-   [DSPy in Production | LLMs in Prod BLR - YouTube](https://www.youtube.com/watch?v=_vGKSc1tekE)
-   [DSPy – Programming–not prompting–LMs | Hacker News](https://news.ycombinator.com/item?id=42343692)


#### The idea {#the-idea}

-   You can do things like: "I want a chain of thought model which has "this" signature", and then use that in your application code as if it was a function.
-   With the DSPy, the focus is on finding the right primitive, the right modules.

<!--list-separator-->

-  Analogy w NN

    -   Suppose you want to solve a problem with NN + BERT, you have these 2 different components.
    -   But for something very specific, you'd want a specific layer from that NN and not the entire NN
    -   Analogous to that, modules in DSPy is that layer that can be picked individually. Eg. CoT is a module.

<!--list-separator-->

-  How CoT works with DSPy?

    DSPy's Chain of Thought feature automatically teaches language models to break down complex reasoning tasks by:

    -   Internally generating few-shot examples that demonstrate step-by-step thinking for your specific task
    -   Using these examples either through few-shot prompting or fine-tuning
    -   Handling all this automatically within DSPy's programming model

    This differs from simply adding "let's think step by step" to prompts - instead, it's a systematic way to teach models how to approach your particular problem through demonstration.

<!--list-separator-->

-  Iterative Development

    The key concept is that DSpy development is iterative. Here's how it works:

    -   Start by building your initial DSpy program and testing it with prompts.
    -   When you encounter issues (like cost concerns or consistent errors), DSpy gives you clear options to iterate:
        -   If the program works but is too expensive, you can tune the parameters
        -   If it's making consistent mistakes, you can either:
            -   Add exception handling in your DSpy code for those edge cases
            -   Switch to a more resilient DSpy module
            -   Modify your DSpy metrics to catch and optimize away those specific errors
    -   DSpy's framework gives you these well-defined paths for improvement, rather than expecting perfect performance on the first attempt.

    The power of DSpy is that it provides these structured ways to iterate and improve your language model programs over time, making the development process more systematic and manageable.

<!--list-separator-->

-  Fine Tuning

    -   DSPy also does fine tuning, I am not sure exactly how but it's a better approach than blindly finetuning according to Omar.


#### Modules {#modules}

-   There are builtin modules(eg. CoT) and new modules can be added easily
-   Modules take in `signature`
    -   `signature` = specification of `input` &amp; `output` behavior.
    -   `signature` = a very simple prompt (5-6 words, not long prompts).
        -   Eg. "input:long document output:summary", "input:english text output:german translation"
    -   The types of `input` &amp; `output` are specified in natural language.
-   Once you give the module the `signature`, it'll give back a function that you can call.


#### Optimizer {#optimizer}

<https://dspy.ai/learn/optimization/optimizers/>

-   Once DSPy has you I/O, it'll try to get to the desired result using an optimizer.
-   This optimizes the prompt, LM weights etc.


#### Compiling {#compiling}

-   Needs `data` / `prompts` for the various modules &amp; a specific `LLM`
-   Eg. The same DSPy program could be a zero-shot prompt to `gpt4` and a few-shot prompt to say `llama3`. This also has a cost aspect to it, you could possibly achieve the similar results from both the models because you've defined input/output/constraints and it'll try to fit things into it.
-   Whether you use fine-tuning or prompting when you use DSPy is not usually relevant, because the compiler will try to optimize for the input/output that was described in the `signature` anyway.


### Other techniques {#other-techniques}


#### Prompt chaining {#prompt-chaining}

-   Making language models compositional and treating them as tiny reasoning engines, rather than sources of truth.
-   Combines language models with other tools like web search, traditional programming functions, and pulling information from databases. This helps make up for the weaknesses of the language model.
-   Source: [Squish Meets Structure: Designing with Language Models](https://maggieappleton.com/squish-structure)

![](/ox-hugo/20230719050449-open_source_llms-1152254522.png)
![](/ox-hugo/20230719050449-open_source_llms-2071394261.png)


#### Chain of thoughts {#chain-of-thoughts}

<https://www.promptingguide.ai/techniques/cot>
Chain of Thought prompting is exceptionally powerful if you need a structured response. I can give 2 examples from my own use.

1.  I was trying to summarize, for fun, the entire story of Final Fantasy XIV into json documents that I could then have a small program RAG against. That was going to get tiring really fast, so I did two CoT examples and then gave it a big chunk of story. I produced the JSON perfectly. That was Nous-Capybara-34b
2.  Im working on a project where I need a 1 word answer to something. I give it a block of text, I get 1 word back. Of course, models love to NOT do that, and instead talk your ear off. But with CoT, you can give 3 or 4 examples of giving it text and then getting 1 word back, and boom- you get 1 word back. When you're writing code dependent on that result, it's SUPER useful.


#### Others {#others}

-   [How to Make LLMs Shut Up | Greptile Blog](https://www.greptile.com/blog/make-llms-shut-up)


## RAG {#rag}

See [RAG]({{< relref "20241227084628-rag.md" >}})

-   smol RAG toolkit: <https://github.com/superlinear-ai/raglite> (dependency free)
    -   Uses <https://github.com/BerriAI/litellm>
    -   Under the hood uses liteLLM which uses <https://openrouter.ai/>
-   Handing multimodal data
    -   <https://rerun.io/?s=35>


### Document processing {#document-processing}

-   <https://github.com/abgulati/LARS>


## Agent {#agent}


### What? {#what}

They are fundamentally just programs with a loop structure. Their key characteristic is different modules making decisions about calling tools.

The Evolution Analogy:

-   Current approach to agents is like trying to build a transformer without understanding basic concepts like convolutions or attention
-   We're attempting to create general-purpose architectures (like GPT) before mastering simpler, well-defined tasks
-   While exploration is valuable, 90% of current use cases don't actually require agents and would perform better without them
-   The field needs to focus on mastering fundamentals before jumping to complex agent architectures


### Resources &amp; Tools {#resources-and-tools}

-   blogs
    -   [Building effective agents](https://simonwillison.net/2024/Dec/20/building-effective-agents/)
    -   [Ask HN: Examples of agentic LLM systems in production? | Hacker News](https://news.ycombinator.com/item?id=42431361)
    -   [Introducing smolagents: simple agents that write actions in code.](https://huggingface.co/blog/smolagents)
    -   [[2411.05285] AgentOps: Enabling Observability of LLM Agents](https://arxiv.org/abs/2411.05285)
-   aws: <https://github.com/awslabs/multi-agent-orchestrator>
-   az: <https://github.com/ai16z/eliza>
-   ms: <https://github.com/microsoft/autogen>
-   langchain: <https://langchain-ai.github.io/langgraph/>
-   uni: <https://github.com/langroid/langroid>


## gateway {#gateway}

> To build such a service, they need traditional API Gateway features like rate limiting, access rules, and also AI-specific features like universal API to multiple LLM providers, universal routing, central guardrails, AI-native observability + central dashboard for other stakeholders, and more.
>
> It can absolutely be a plugin on top of existing Gateways.. like we've explored putting Portkey on Kong, but the need for a dedicated AI Gateway still remains, that can do all of these things I described in an easier way.

-   <https://openrouter.ai/>
-   [Show HN: Arch – an intelligent prompt gateway built on Envoy | Hacker News](https://news.ycombinator.com/item?id=41864014)
-   <https://portkey.ai/>


## Vector DB/Semantic Search {#vector-db-semantic-search}

See [Embeddings]({{< relref "20240916155700-embeddings.md" >}})

-   puffer something??
-   <https://github.com/wizenheimer/tinkerbird>
-   another framework: <https://github.com/neuml/txtai>


## Observability in AI {#observability-in-ai}

-   <https://www.brendangregg.com/blog//2024-10-29/ai-flame-graphs.html>
-   <https://news.ycombinator.com/item?id=41980894>


## Others {#others}

<https://www.enzyme.garden/>
