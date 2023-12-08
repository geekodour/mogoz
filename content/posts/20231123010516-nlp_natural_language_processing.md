+++
title = "NLP (Natural Language Processing)"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Machine Learning]({{< relref "20230408190056-machine_learning.md" >}}), [Data Engineering]({{< relref "20230405003455-data_engineering.md" >}}), [Open Source LLMs]({{< relref "20230719050449-open_source_llms.md" >}})


## History of NLP {#history-of-nlp}

{{< figure src="/ox-hugo/20230326092427-modern_ai_stack-150746386.png" >}}

-   We did have attention when we were using DNN
-   But with the 2017 paper, we suggested that "attention is all you need", aka Transformers.
-   [AllenNLP - Demo](https://demo.allennlp.org/reading-comprehension/bidaf-elmo)


## General ideas in NLP {#general-ideas-in-nlp}


### Tokenization {#tokenization}


#### Sub word {#sub-word}

-   See [GitHub - google/sentencepiece](https://github.com/google/sentencepiece)
-   Uses `byte-pair encoding` (BPE)
    ![](/ox-hugo/20230326092427-modern_ai_stack-1623535554.png)


#### Token count {#token-count}

-   Large language models such as GPT-3/4, LLaMA and PaLM work in terms of tokens.
-   32k tokens ~ 25k words ~ 100 single spaced pages
-   See [Understanding GPT tokenizers](https://simonwillison.net/2023/Jun/8/gpt-tokenizers/)


### Embeddings vs Tokens {#embeddings-vs-tokens}

-   [The Illustrated Word2vec - A Gentle Intro to Word Embeddings in Machine Learning - YouTube](https://www.youtube.com/watch?v=ISPId9Lhc1g)
-   Tokens
    -   These are inputs
    -   The basic units of text that the language model operates on
    -   "I love cats" would be tokens: ["I", "love", "cats"] if using word level tokenization.
-   Embeddings
    -   Embeddings are learned as part of the model training process.
    -   Refer to the vector representations of tokens in a continuous vector space.
    -   The model maps token to an embedding vector, representing semantic properties.
    -   As a result, two tokens with similar embeddings have similar meaning.
    -   Any deep learning model that uses tokens as input at some point is an embedding model.


### LIMA style training? {#lima-style-training}


## LLM {#llm}

-   Language Models w &gt; 100m parameters
-   They don't have to use Transformers, but many do
-   They take text, convert it into tokens (integers), then predict which tokens should come next.
-   Pre-trained

{{< figure src="/ox-hugo/20230326092427-modern_ai_stack-1054377055.png" >}}


### LLM Types {#llm-types}

{{< figure src="/ox-hugo/20230326092427-modern_ai_stack-332904700.png" >}}

-   Autoencoder LLMs are efficient for encoding (“understanding”) NL
-   Autoregressive LLMs can encode and generate NL, but may be slower
-   Discussion on encoder-decoder: [A BERT for laptops, from scratch | Hacker News](https://news.ycombinator.com/item?id=37425130)


### LLM Implementations/Architectures {#llm-implementations-architectures}

![](/ox-hugo/20230326092427-modern_ai_stack-788841550.png)
![](/ox-hugo/20230326092427-modern_ai_stack-763526078.png)
![](/ox-hugo/20230326092427-modern_ai_stack-2012364792.png)
![](/ox-hugo/20230326092427-modern_ai_stack-950276543.png)
![](/ox-hugo/20230326092427-modern_ai_stack-1807072495.png)


### LLM Training {#llm-training}

Generally LLMs are trained on 1 eval (epoch)


#### Gradient Accumulation {#gradient-accumulation}

{{< figure src="/ox-hugo/20230326092427-modern_ai_stack-1089943995.png" >}}


#### Gradient Checkpointing {#gradient-checkpointing}

{{< figure src="/ox-hugo/20230326092427-modern_ai_stack-170687801.png" >}}


#### Mixed-Precision {#mixed-precision}

{{< figure src="/ox-hugo/20230326092427-modern_ai_stack-1850968713.png" >}}


#### Dynamic Padding &amp; Uniform-Length Batching {#dynamic-padding-and-uniform-length-batching}

{{< figure src="/ox-hugo/20230326092427-modern_ai_stack-1234901233.png" >}}


#### PEFT with Low-Rank Adaptation {#peft-with-low-rank-adaptation}


## RLHF {#rlhf}

-   This is the secret sauce in all new LLMs
-   Reinforcement learning from human feedback


## GPT in production {#gpt-in-production}


### Embedding search + vectorDB {#embedding-search-plus-vectordb}


#### Basic idea {#basic-idea}

-   Embed internal data using the LLM tokenizer(create chunks), load it into a vectorDB
-   Then query the vector DB for the most relevant information
-   Add into the context window.


#### When documents/corpus are too big to fit into prompt. Eg. Because of token limits. {#when-documents-corpus-are-too-big-to-fit-into-prompt-dot-eg-dot-because-of-token-limits-dot}

-   Obtain relevant chunks by similarity search on query from vector DB
-   Find top k most similar chunk embeddings.
-   Stuff as many top k chunks as you can into the prompt and run the query


#### Example {#example}

-   Imagine you have an LLM with a token limit of 8k tokens.
-   Split the original document or corpus into 4k token chunks.
-   Leaf nodes of a "chunk tree" are set to these 4k chunks.
    -   Run your query by summarizing these nodes, pair-wise (two at a time)
    -   Generate parent nodes of the leaf nodes.
    -   You now have a layer above the leaf nodes.
    -   Repeat until you reach a single root node.
    -   That node is the result of tree-summarizing your document using LLMs.


#### Tools {#tools}

-   llmaindex and langchain allow us to do this stuff.
-   OpenAI cookbook suggests this approach, see [gpt4langchain](https://github.com/pinecone-io/examples/blob/master/generation/gpt4-retrieval-augmentation/gpt-4-langchain-docs.ipynb)
-   [pinecode embedded search](https://github.com/openai/openai-cookbook/blob/main/examples/vector_databases/pinecone/Gen_QA.ipynb)
-   [GPT 4: Superpower results with search - YouTube](https://www.youtube.com/watch?v=tBJ-CTKG2dM&t=787s)


### Prompt tuning {#prompt-tuning}

-   Idea is similar to embedding search thing but here, you are allowed to insert the embeddings of the prompt into the LLM.
-   This is not currently possible with OpenAI's API
-   This claims to better perform prompt search


### Finetune {#finetune}

![](/ox-hugo/20230326092427-modern_ai_stack-1346438305.png)
Train a model on how to respond, so you don’t have to specify that in your prompt.


### LLMOps {#llmops}

-   The cost of LLMOps is in inference.
-   Input tokens can be processed in parallel, output is sequential
