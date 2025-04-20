+++
title = "NLP (Natural Language Processing)"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Machine Learning]({{< relref "20230408190056-machine_learning.md" >}}), [Data Engineering]({{< relref "20230405003455-data_engineering.md" >}}), [Open Source LLMs]({{< relref "20230719050449-open_source_llms.md" >}}), [Information Retrieval]({{< relref "20231123014416-information_retrieval.md" >}}), [Information Theory/Knowledge]({{< relref "20221101222235-information_theory.md" >}})


## NLP Tasks {#nlp-tasks}

| Task                    | Description                                                                                                     |
|-------------------------|-----------------------------------------------------------------------------------------------------------------|
| Document classification | Supervised learning, Assigns documents to known categories                                                      |
| Clustering              | Unsupervised learning, Groups similar documents together based on patterns, Discovers natural groupings in data |
| Sentiment Analysis      |                                                                                                                 |


### More on document classification vs clustering {#more-on-document-classification-vs-clustering}

|            | Clustering                                           | Document Classification                                              |
|------------|------------------------------------------------------|----------------------------------------------------------------------|
| Usecase    | organize articles, customer segmentation on feedback | spam detection, sentiment analysis,                                  |
|            | themes in social media                               | topic categorization, language identification                        |
|            |                                                      |                                                                      |
| Evaluation | Silhouette score, Davies-Bouldin index               | Accuracy, Precision, Recall, F1-score, Confusion matrix              |
|            | Inertia, Inter/intra cluster distance                |                                                                      |
|            |                                                      |                                                                      |
| Algorithms | K-means, Hierarchical clustering, DBSCAN, Mean-shift | Naive Bayes, Support Vector Machines, Random Forest, Neural Networks |
|            |                                                      |                                                                      |


#### Flow {#flow}

-   Clustering:
    -   Raw Documents → Feature Extraction → Clustering Algorithm → Document Groups (K-means, hierarchical)
-   Classification:
    -   Training: Labeled Documents → Feature Extraction → Train Classifier → Model
    -   Testing:  New Document → Feature Extraction → Trained Model → Predicted Label


### Sentiment Analysis {#sentiment-analysis}

> Averaging out sentiments may be erroneous. The important aspect is to look at totality of sentiments, degree of sentiments and also mixed sentiment. Here are two examples -
>
> eg1. Your product is bad (moderate degree)
>
> Your product is very bad (higher degree of bad)
>
> Your product is terrible (highest degree of bad)
>
> eg2. Your product is great but support is terrible.

another one

> &gt; (sentiment analysis) on news articles, should I do it sentence by sentence?
>
> No.
>
> Sentiment in one sentence often depends much on the context from the other sentences.
>
> I think you'd be better off breaking it up into overlapping chunks. Perhaps for each sentence include both the preceding two sentences and the following sentence.
>
> &gt; news articles
>
> That makes it even harder.
>
> Often news articles have the patterns
>
> -   Things were going wonderfully well, until they turned out horribly bad. Or
> -   Things were going badly, but then they ended up mostly OK (which is happy considering the circumstances, but would otherwise be sad).
>
> The approach of averaging sentences will miss the main idea in both of those scenarios.
>
> Instead of averaging them, you might be better off looking for trends of which direction the sentiment was heading from beginning to end.
>
> Consider a news article with sentences like
>
> -   "She was a straight A student in high school." [positive sentiment]
> -   "...[a couple more background paragraphs]..."
> -   "Her kidnappers tortured her for 6 months." [whoa - very negative]
> -   "...[a couple more recent paragraphs]..."
> -   "She took his gun and shot him and fled." [tough for BERT to guess unless it has context]
>
> Unless BERT knows to value the life of the victim more than the suspect, and has the context of who was who, it'll do extremely poorly.


## History of NLP {#history-of-nlp}

{{< figure src="/ox-hugo/20230326092427-modern_ai_stack-150746386.png" >}}

-   We did have attention when we were using DNN
-   But with the 2017 paper, we suggested that "attention is all you need", aka Transformers.
-   [AllenNLP - Demo](https://demo.allennlp.org/reading-comprehension/bidaf-elmo)


## General ideas in NLP {#general-ideas-in-nlp}


### Tokenization {#tokenization}

[Byte Latent Transformer: Patches Scale Better Than Tokens | Hacker News](https://news.ycombinator.com/item?id=42415122) (possible future of tokenization)


#### What? {#what}

Tokenization is string manipulation. It is basically a for loop over a string with a bunch of if-else conditions and dictionary lookups. There is no way this could speed up using a GPU. Basically, the only thing a GPU can do is tensor multiplication and addition. Only problems that can be formulated using tensor operations can be accelerated using a GPU.

The default tokenizers in Huggingface Transformers are implemented in Python. There is a faster version that is implemented in Rust.


#### Sub word {#sub-word}

-   See [GitHub - google/sentencepiece](https://github.com/google/sentencepiece)
    -   [You could have designed state of the art positional encoding | Hacker News](https://news.ycombinator.com/item?id=42166948)
    -   Uses `byte-pair encoding` (BPE)
        ![](/ox-hugo/20230326092427-modern_ai_stack-1623535554.png)


#### Token count {#token-count}

-   Large language models such as GPT-3/4, LLaMA and PaLM work in terms of tokens.
-   32k tokens ~ 25k words ~ 100 single spaced pages
-   See [Understanding GPT tokenizers](https://simonwillison.net/2023/Jun/8/gpt-tokenizers/)


### Embeddings vs Tokens {#embeddings-vs-tokens}

-   See [Embeddings]({{< relref "20240916155700-embeddings.md" >}})
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


### <span class="org-todo todo TODO">TODO</span> LIMA style training? {#lima-style-training}


## Old Age {#old-age}

See [Information Retrieval]({{< relref "20231123014416-information_retrieval.md" >}})


## New Age (post 2018 tech) {#new-age--post-2018-tech}

{{< figure src="/ox-hugo/20230326092427-modern_ai_stack-332904700.png" >}}

-   Autoencoder LLMs are efficient for encoding (“understanding”) NL
-   Autoregressive LLMs can encode and generate NL, but may be slower


### Meta Ideas {#meta-ideas}


#### encoder-only, encoder-decoder, decoder-only {#encoder-only-encoder-decoder-decoder-only}

There are mainly 3 overarching paradigms of model architectures in the past couple of years.

-   encoder-only models (e.g., BERT)
-   encoder-decoder models (e.g., T5)
-   decoder-only models (e.g., GPT series).
-   See [What happened to BERT &amp; T5? On Transformer Encoders, PrefixLM and Denoising Objectives — Yi Tay](https://www.yitay.net/blog/model-architecture-blogpost-encoders-prefixlm-denoising)


#### unidirectional and bidirectional {#unidirectional-and-bidirectional}

LLMs like GPT4, Sonnet and RNNs etc. are usually unidirectional, bi-directional(Eg. BERT, MPNet) is useful for understanding vs generative.

-   [nlp - Uni-directional Transformer VS Bi-directional BERT - Stack Overflow](https://stackoverflow.com/questions/55114128/uni-directional-transformer-vs-bi-directional-bert)

<!--list-separator-->

-  Unidirectional (left-to-right) example

    -   Sentence: "The cat chased the mouse."
    -   Word representation for "cat"
    -   Only considers the preceding context: "The"

<!--list-separator-->

-  Unidirectional (right-to-left) example

    -   Sentence: "The cat chased the mouse."
    -   Word representation for "cat"
    -   Only considers the following context: "chased the mouse"

<!--list-separator-->

-  Bidirectional (BERT) example

    -   Sentence: "The cat chased the mouse."
    -   Word representation for "cat"
    -   Considers the full context: "The cat chased the mouse"

<!--list-separator-->

-  Cross encoders

    {{< figure src="/ox-hugo/20231123010516-nlp_natural_language_processing-1846359407.png" >}}

    -   Both bidirectional and cross encoders work with `sentence pairs`
    -   <https://www.sbert.net/examples/applications/cross-encoder/README.html>
    -   <https://www.pinecone.io/learn/series/nlp/data-augmentation/>
    -   Usecase
        -   Cross-Encoder achieve higher performance than Bi-Encoders, however, they do not scale well for large datasets.
        -   It can make sense to combine Cross- and Bi-Encoders
        -   Eg. Information Retrieval / Semantic Search scenarios
            -   First, you use an efficient Bi-Encoder to retrieve e.g. the top-100 most similar sentences for a query.
            -   Then, you use a Cross-Encoder to re-rank these 100 hits by computing the score for every (query, hit) combination.


#### PLM (Permuted Language Model (PLM)) {#plm--permuted-language-model-plm}

Key Characteristics of PLM:

-   Considers multiple possible permutations of the input sequence during training
-   Can see all unmasked tokens regardless of their positions
-   Combines advantages of both:
    -   Masked Language Modeling (like BERT)
    -   Autoregressive Language Modeling (like GPT)

Eg.

```nil
Original Sequence: "The cat sat on the mat"

Possible Permutations:
[The] [cat] [sat] [on] [the] [mat]
[cat] [The] [on] [mat] [sat] [the]
[mat] [sat] [The] [cat] [on] [the]
... (other permutations)
```

Used by MPNet


#### Semantic Search &amp; Embeddings {#semantic-search-and-embeddings}

-   closest text or texts to a target sentence
-   For [Embeddings]({{< relref "20240916155700-embeddings.md" >}}), we could use OpenAI embeddings but we could also use sentence-transformers. We can start with the following and move to OpenAI embeddings if not work.
    -   multi-qa-dot mpnet
    -   gtr-t5-large
    -   all-mpnet-base V2
    -   paraphrase-multilingual-mpnet-base V2
-   "Your baseline for RAG apps should NOT be OpenAI embeddings. It should be ColBERT." (`single vector` vs `multi-vector`)


#### Massive Text Embedding Benchmark (MTEB) Leaderboard {#massive-text-embedding-benchmark--mteb--leaderboard}

-   The MTEB leaderboard is also very helpful if you know how to use it. The basic way to look at it is : for all the datasets mentioned there in the benchmark, which one is the closest to the type of data you're working with? Sort in order of performance of models for that dataset.
-   <https://huggingface.co/spaces/mteb/leaderboard>


### AutoEncoders (Understanding) {#autoencoders--understanding}

Usecase: semantic textual similarity (STS), Classification

Also see [Embeddings]({{< relref "20240916155700-embeddings.md" >}})


#### Base Models {#base-models}

<!--list-separator-->

-  BERT (improves upon `transformers`)

    -   Original paper follows an encoder-decoder architecture.
    -   Source (by google team)
        -   <https://www.cs.cmu.edu/~leili/course/dl23w/14-pretrained_langauge_models.pdf>
        -   <https://paperswithcode.com/method/bert>
        -   <https://huggingface.co/google-bert/bert-base-multilingual-cased>
        -   <https://pub.towardsai.net/understanding-bert-b69ce7ad03c1>
        -   Multilang: <https://github.com/google-research/bert/blob/master/multilingual.md#list-of-languages>

    <!--list-separator-->

    -  Steps (2)

        <!--list-separator-->

        -  Step1: Pre-Training

            The model learns an inner representation of the languages in the training set that can then be used to extract features useful for downstream tasks. This
            is trained on a large corpus of `unlabeled text data`.

            This has 2 objectives

            -   **MLM (Masked language model)**: taking a sentence, the model randomly masks 15% of the words in the input then run the entire masked sentence through the model and has to predict the masked words
            -   **Next sentence prediction (NSP)**: the models concatenates two masked sentences as inputs during pretraining. Sometimes they correspond to sentences that were next to each other in the original text, sometimes not. The model then has to predict if the two sentences were following each other or not.
                -   This helps the model learn the relationships between sentences, which is important for tasks like question answering and natural language inference.

        <!--list-separator-->

        -  Step2: Fine Tuning

            -   the BERT model is then fine-tuned on labeled data from specific downstream tasks. The pre-trained parameters are used as the starting point, and the model's parameters are further adjusted to perform well on the target task.
            -   For different tasks, we'll finetune separately.

    <!--list-separator-->

    -  Other notes

        -   Models like BERT have a data dependency on future time steps also, and this means you cannot Auto-Regress them.
        -   <https://www.reddit.com/r/MachineLearning/comments/e71vyr/d_why_does_the_bert_paper_say_that_standard/>
        -   BERT has a token capacity limit of 512 tokens. If you have longer than 512 you can break it up into chunks.
        -   variants
            -   <https://huggingface.co/climatebert/distilroberta-base-climate-detector>

    <!--list-separator-->

    -  Learning resources

        -   Discussion on encoder-decoder: [A BERT for laptops, from scratch | Hacker News](https://news.ycombinator.com/item?id=37425130)

<!--list-separator-->

-  SBERT (sentence transformers)

    {{< figure src="/ox-hugo/20231123010516-nlp_natural_language_processing-831256898.png" >}}

    -   Built on top of BERT or RoBERTa (Adds a pooling layer on top of BERT). i.e gives sentence level embeddings.
    -   in vanilla BERT, finding the most similar pair in a collection of 10,000 sentences requires about 50 million inference computations (~65 hours) with BERT.
    -   This improves BERT with
        -   siamese
        -   triplet network structures
        -   derive semantically meaningful sentence embeddings that can be compared using `cosine-similarity`.
    -   This reduces the effort for finding the most similar pair from 65 hours with BERT / RoBERTa to about 5 seconds with SBERT,
    -   <https://github.com/UKPLab/sentence-transformers>
    -   <https://huggingface.co/sentence-transformers>
    -   <https://www.sbert.net/docs/sentence_transformer/pretrained_models.html>
    -   [Sentence Transformers: Meanings in Disguise | Pinecone](https://www.pinecone.io/learn/series/nlp/sentence-embeddings/)

<!--list-separator-->

-  MPNet

    -   <https://paperswithcode.com/method/mpnet>
    -   <https://huggingface.co/docs/transformers/en/model_doc/mpnet>
    -   combines MLM and permuted language modeling (PLM) in one view.
    -   Has `position-aware attention` mechanism

<!--list-separator-->

-  ColBERT(Contextualized Late Interaction over BERT)

    > It is reasonable to think of ColBERT as combining the best of semantic vector search with traditional keyword search a la BM25, but without having to tune the weighting of hybrid search or dealing with corner cases where the vector and keyword sides play poorly together.

    -   Uses late interaction mechanisms
    -   Colbert generates embedding vectors for every token in a text, rather than 1 vector for the whole doc
    -   Its architecture captures cross sequence (query and doc) interaction better than a traditional bi-encoder due to the token level embeddings
    -   Also faster than a cross-encoder since the document (tokens) embeddings can be pre-computed and retrieved independent of the query.
    -   Resources
        -   <https://x.com/lateinteraction/status/1736804963760976092>
        -   <https://www.answer.ai/posts/colbert-pooling.html>
        -   <https://spyced.blogspot.com/2024/10/adding-colpali-to-colbert-live.html>
        -   <https://blog.vespa.ai/announcing-long-context-colbert-in-vespa/>

    <!--list-separator-->

    -  How it differs from other embedding models

        -   [Exploring ColBERT with RAGatouille | Simon Willison’s TILs](https://til.simonwillison.net/llms/colbert-ragatouille)
        -   In traditional models(normal BERT), we boil down the nuances of ~256 tokens (2/3rds of a page) into a single vector. This is pretty wild.
            -   Single vector retrieval models are relied upon to take passages of text and compress them to a single "concept".
        -   Instead, ColBERT's approach is to allocate a small, efficient representation to each token within the passage.

<!--list-separator-->

-  BGE-M3 models

    [BGE-M3 - The Mother of all embedding models — pyvespa documentation](https://pyvespa.readthedocs.io/en/latest/examples/mother-of-all-embedding-models-cloud.html)
    So M3 trains 3 different representations

    -   A sparse vector
    -   A dense vector
    -   A multi-vector dense (colbert)

    Usecases:

    -   Retrieve: use the dense representation
    -   re-ranking (for that little extra precision): use the sparse and multi-vectors in

<!--list-separator-->

-  SAE

    -   [An Intuitive Explanation of Sparse Autoencoders for LLM Interpretability | Adam Karvonen](https://adamkarvonen.github.io/machine_learning/2024/06/11/sae-intuitions.html)
    -   <https://x.com/enjalot/status/1859985404910510183>

<!--list-separator-->

-  ModernBERT

    -   <https://x.com/antoine_chaffin/status/1869847734930550922>
    -   [A Replacement for BERT | Hacker News](https://news.ycombinator.com/item?id=42463315)
    -   <https://x.com/jeremyphoward/status/1869786023963832509>


#### FAQ {#faq}

<!--list-separator-->

-  Differences between SBERT and MPNet

    | Aspect             | SBERT                                                                          | MPNet                                                                       |
    |--------------------|--------------------------------------------------------------------------------|-----------------------------------------------------------------------------|
    | Training Objective | Siamese network, Triplet loss, Paired-sentences, Similarity focus              | Permuted modeling, Masked prediction, Full token visibility, Position-aware |
    | Performance        | Fast inference, High similarity accuracy, Short text optimal, Production-ready | Better benchmarks, Long dependencies, Compute heavy, Long text optimal      |
    | Use Cases          | Search, Clustering, Retrieval, Paraphrasing                                    | Classification, Long text, Research                                         |

<!--list-separator-->

-  Differences between BERT and SBERT

    SBERT models do contrastive learning on top of a pretrained BERT model.

    -   BERT outputs a vector per token (????)
    -   SBERT outputs a single vector embedding. (????)

    <!--list-separator-->

    -  Usecase of "classification"

        -   To use BERT as a classifier, you need to reduce the dimension either by selecting the CLS token or using a pooling strategy. (so some cross-encoder type thing is needed)
        -   Typically you would not freeze all the layers when you train a classifier on top of BERT, because the pretraining / pooling will adapt better if they aren’t frozen.
        -   Embedding models like SBERT regularize the vector space better from their pretraining methods and are better suited toward direct classification. They may not perform better than training on an unfrozen BERT model, however.

<!--list-separator-->

-  BGE-M3 vs ModernBERT

    -   BGE-M3 is a fine-tuned embedding models. This means that they’ve taken a base language model, which was trained for just language modeling, then applied further fine-tuning to make it useful for a given application, in this case, retrieval.
    -   ModernBERT is one step back earlier in the pipeline: it’s the language model that application-specific models such as M3 build on.

<!--list-separator-->

-  What does context length have to do in an embedding/encoder model?

    {{< figure src="/ox-hugo/20231123010516-nlp_natural_language_processing-342223244.png" >}}

    -   This is based on how we plan to query: The `denser the content` the `smaller the chunk` size.
    -   So if we have dense content, smaller chunk sizes are better right, and we don't need bigger chunk sizes! hmm, but not entirely true.
    -   Bigger context sizes can be useful:
        -   We don't have to reduce a long context to a single embedding vector.
        -   We make use of multi-vectors and pooling.
        -   We compute the token embeddings of a long context and then pool those into sentence embeddings.
        -   The benefit is:
            -   Each sentence’s embedding is informed by all of the other sentences in the context.
            -   So when a sentence refers to “The company” for example, the sentence embedding will have captured which company that is based on the other sentences in the context. (This is called late chunking, coming from late interaction)

<!--list-separator-->

-  What does "pooling" mean?

    “Pooling” is just aggregation methods. It could mean taking max or average values, or more exotic methods like attention pooling. It’s meant to reduce the one-per-token dimensionality to one per passage or document.

<!--list-separator-->

-  How does "semantic chunking" relate to "late chunking"?

    See [RAG]({{< relref "20241227084628-rag.md" >}})
    You want to partition the document into chunks. Late chunking pairs really well with semantic chunking because it can use late chunking's improved sentence embeddings to find semantically more cohesive chunks. In fact, you can cast this as a binary integer programming problem and find the ‘best’ chunks this way. See RAGLite [1] for an implementation of both techniques including the formulation of semantic chunking as an optimization problem.

    Finally, you have a sequence of document chunks, each represented as a multi-vector sequence of sentence embeddings. You could choose to pool these sentence embeddings into a single embedding vector per chunk. Or, you could leave the multi-vector chunk embeddings as-is and apply a more advanced querying technique like ColBERT's MaxSim [2].

<!--list-separator-->

-  What does "late chunking" really mean? does it actually chunk?

    See [RAG]({{< relref "20241227084628-rag.md" >}})
    The name ‘late chunking’ is indeed somewhat of a misnomer in the sense that the technique does not partition documents into document chunks. What it actually does is to pool token embeddings (of a large context) into say sentence embeddings. The result is that your document is now represented as a sequence of sentence embeddings, each of which is informed by the other sentences in the document.

<!--list-separator-->

-  Finetuning in embeddings?

    See [Beating Proprietary Models with a Quick Fine-Tune | Modal Blog](https://modal.com/blog/fine-tuning-embeddings?s=35)

<!--list-separator-->

-  What is [xlang-ai/instructor-embedding](https://github.com/xlang-ai/instructor-embedding/issues/126) ?

    -   It's a way to adapt embedding models (independently of if they have multiple representations like M3) to specific domains.
    -   To use M3+instructor embedding, you then need to re-train and include the instruction prefixes of instructor into M3


### AutoRegressive (Generative) {#autoregressive--generative}

Usecase: Generation


#### LLM {#llm}

-   Language Models w &gt; 100m parameters
-   They don't have to use Transformers, but many do
-   They take text, convert it into tokens (integers), then predict which tokens should come next.
-   Pre-trained

{{< figure src="/ox-hugo/20230326092427-modern_ai_stack-1054377055.png" >}}

<!--list-separator-->

-  LLM Implementations/Architectures

    ![](/ox-hugo/20230326092427-modern_ai_stack-788841550.png)
    ![](/ox-hugo/20230326092427-modern_ai_stack-763526078.png)
    ![](/ox-hugo/20230326092427-modern_ai_stack-2012364792.png)
    ![](/ox-hugo/20230326092427-modern_ai_stack-950276543.png)
    ![](/ox-hugo/20230326092427-modern_ai_stack-1807072495.png)

<!--list-separator-->

-  LLM Training

    Generally LLMs are trained on 1 eval (epoch)

    <!--list-separator-->

    -  Gradient Accumulation

        {{< figure src="/ox-hugo/20230326092427-modern_ai_stack-1089943995.png" >}}

    <!--list-separator-->

    -  Gradient Checkpointing

        {{< figure src="/ox-hugo/20230326092427-modern_ai_stack-170687801.png" >}}

    <!--list-separator-->

    -  Mixed-Precision

        {{< figure src="/ox-hugo/20230326092427-modern_ai_stack-1850968713.png" >}}

    <!--list-separator-->

    -  Dynamic Padding &amp; Uniform-Length Batching

        {{< figure src="/ox-hugo/20230326092427-modern_ai_stack-1234901233.png" >}}

    <!--list-separator-->

    -  PEFT with Low-Rank Adaptation


#### RLHF {#rlhf}

-   This is the secret sauce in all new LLMs
-   [Reinforcement Learning]({{< relref "20240701105002-reinforcement_learning.md" >}}) from human feedback


### GPT in production {#gpt-in-production}

See [Deploying ML applications (applied ML)]({{< relref "20241130100028-deploying_ml_applications_applied_ml.md" >}})


#### Embedding search + vectorDB {#embedding-search-plus-vectordb}

<!--list-separator-->

-  Basic idea

    -   Embed internal data using the LLM tokenizer(create chunks), load it into a vectorDB
    -   Then query the vector DB for the most relevant information
    -   Add into the context window.

<!--list-separator-->

-  When documents/corpus are too big to fit into prompt. Eg. Because of token limits.

    -   Obtain relevant chunks by similarity search on query from vector DB
    -   Find top k most similar chunk embeddings.
    -   Stuff as many top k chunks as you can into the prompt and run the query

<!--list-separator-->

-  Example

    -   Imagine you have an LLM with a token limit of 8k tokens.
    -   Split the original document or corpus into 4k token chunks.
    -   Leaf nodes of a "chunk tree" are set to these 4k chunks.
        -   Run your query by summarizing these nodes, pair-wise (two at a time)
        -   Generate parent nodes of the leaf nodes.
        -   You now have a layer above the leaf nodes.
        -   Repeat until you reach a single root node.
        -   That node is the result of tree-summarizing your document using LLMs.

<!--list-separator-->

-  Tools

    -   llmaindex and langchain allow us to do this stuff.
    -   OpenAI cookbook suggests this approach, see [gpt4langchain](https://github.com/pinecone-io/examples/blob/master/generation/gpt4-retrieval-augmentation/gpt-4-langchain-docs.ipynb)
    -   [pinecode embedded search](https://github.com/openai/openai-cookbook/blob/main/examples/vector_databases/pinecone/Gen_QA.ipynb)
    -   [GPT 4: Superpower results with search - YouTube](https://www.youtube.com/watch?v=tBJ-CTKG2dM&t=787s)


#### Prompt tuning {#prompt-tuning}

-   Idea is similar to embedding search thing but here, you are allowed to insert the embeddings of the prompt into the LLM.
-   This is not currently possible with OpenAI's API
-   This claims to better perform prompt search


#### Finetune {#finetune}

![](/ox-hugo/20230326092427-modern_ai_stack-1346438305.png)
Train a model on how to respond, so you don’t have to specify that in your prompt.


#### LLMOps {#llmops}

-   The cost of LLMOps is in inference.
-   Input tokens can be processed in parallel, output is sequential
