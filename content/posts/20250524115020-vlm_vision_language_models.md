+++
title = "VLM(Vision Language Models)"
author = ["Hrishikesh Barman"]
draft = false
+++

VLM (Vision Language Model) is a broad term for any model that processes information from both visual and linguistic modalities.

-   See [Vision Language Models (Better, faster, stronger)](https://huggingface.co/blog/vlms-2025)
-   See [jingyi0000/VLM_survey](https://github.com/jingyi0000/VLM_survey)


## FAQ {#faq}


### Are CLIP and Moondream/LLaVA both Vision Language Models? {#are-clip-and-moondream-llava-both-vision-language-models}

-   Yes, just different types.
-   VLM (Vision Language Model) is a broad term for any model that processes information from both visual and linguistic modalities.


### People say for captioning use CLIP, is it true? {#people-say-for-captioning-use-clip-is-it-true}

-   CLIP can’t generate text
-   If you were generating caption you are probably using something different.
-   One popular library for this was: <https://github.com/pharmapsychotic/clip-interrogator>


## Types {#types}

> What language these vision models support depend on the underlying text encoder/decoder used. Eg. someone wanted to try ColPali + VLM pipeline or Turkish language, the issue was ColPali PaliGemma) isn't trained on it so recommended ColQwen &amp; Qwen2VL and it worked. Eg. `voyage-multimodal-3` is also multilingual but how much support obviously differs etc.


### Pre-training with Contrastive Objective(image-text) (Eg. CLIP) {#pre-training-with-contrastive-objective--image-text----eg-dot-clip}

{{< figure src="/ox-hugo/20240629114811-object_detection-2059429889.png" >}}

> -   Main purpose/training objective: Comparison, (putting things in the same latent space)
> -   <https://github.com/mlfoundations/open_clip> (maintains both CLIP and SigLIP)
> -   <https://github.com/jina-ai/clip-as-service>


#### Training CLIP {#training-clip}

1.  Feature encoder: Fuse text and image into one using self attention mechanism
    ![](/ox-hugo/20240629114811-object_detection-2076247559.png)
2.  Enhance encoding: Combines text and image
    ![](/ox-hugo/20240629114811-object_detection-1751393539.png)
3.  Language guided selection (Dont understand)
    ![](/ox-hugo/20240629114811-object_detection-1202662291.png)
4.  Cross-Modality Decoder (Dont understand)
    ![](/ox-hugo/20240629114811-object_detection-1603844632.png)
    ![](/ox-hugo/20240629114811-object_detection-690406912.png)
5.  Calculate loss
    ![](/ox-hugo/20240629114811-object_detection-1472729532.png)
    -   Contrastive loss: Compare text and visual features
    -   DETR loss: Bounding box, detect object of interest

<!--listend-->

-   More stuff
    -   [natural language processing - Why does CLIP use a decoder-only transformer for encoding text?](https://ai.stackexchange.com/questions/39073/why-does-clip-use-a-decoder-only-transformer-for-encoding-text)


#### CLIP {#clip}

-   `dual-encoder VLM` (image is encoded, text is encoded)
-   focused on learning joint image-text embeddings.
-   2 parts/components:
    -   `text encoder`: Some ViT
    -   `image encoder`
-   Use: <https://github.com/rom1504/clip-retrieval>


#### SigLIP {#siglip}

> Also, as mentioned in the original comment I think using Siglip might be just better than CLIP as laion2b is a pretty messy dataset and to my knowledge Google did a really good job with Siglip. A lot of multimodal models use Siglip as the encoder. Probably just a straightforward improvement in some regards.

[SigLIP](https://huggingface.co/docs/transformers/en/model_doc/siglip)


#### Other CLIP variations {#other-clip-variations}

-   [Jina CLIP v2: Multilingual Multimodal Embeddings for Text and Images](https://jina.ai/news/jina-clip-v2-multilingual-multimodal-embeddings-for-text-and-images/)
-   open clip with the Laion2B dataset <https://github.com/mlfoundations/open_clip>
-   long clip (bigger token lengths during training) <https://github.com/beichenzbc/Long-CLIP>
-   meta-clip <https://github.com/facebookresearch/metaclip>
-   google siglip <https://huggingface.co/docs/transformers/main/en/model_doc/siglip> different loss function
-   apple dfn <https://huggingface.co/apple/DFN5B-CLIP-ViT-H-14> if I recall the 5b uses a higher image resolution, amongst a number of other innovations (378 ×378 resolution)
-   Blip 1 &amp; 2 by salesforce I have worked with also <https://huggingface.co/docs/transformers/en/model_doc/blip>


### Pre-training with Contrastive Objective (image-only) (Eg. DINO) {#pre-training-with-contrastive-objective--image-only----eg-dot-dino}

> -   If you just want to do image [Clustering / Classification]({{< relref "20241227082910-clustering.md" >}}), this is probably better than the other VLM techniques
> -   Also see [Image replacement in Canva designs using reverse image search - Canva Engineering Blog](https://www.canva.dev/blog/engineering/image-replacement-in-canva-designs-using-reverse-image-search/)


#### DINO {#dino}

-   If you don’t need image-text pairs you might even try experimenting with self supervised models like Dinov2.
-   In my testing for retrieval of similar off-road driving images, Dino works better than CLIP thanks to visual pre training and CLIP suffers due to language grounding(it gets images which might have been captioned similarly, but have different colors)


#### DreamSim {#dreamsim}

-   [DreamSim: Learning New Dimensions of Human Visual Similarity using Synthetic Data](https://dreamsim-nights.github.io/)
-   It stacks dino and clip embeddings but also finetune's these models to be a perceptual metric.
-   It's much better at finding similar images rather than images with similar content that look quite different.


### Pre-training with Contrastive Objective + Interleaving (image-text) (Eg. ColPali) {#pre-training-with-contrastive-objective-plus-interleaving--image-text----eg-dot-colpali}

> Leaderboard: <https://huggingface.co/spaces/vidore/vidore-leaderboard>


#### META: Understanding Interleaving and Modality Gap {#meta-understanding-interleaving-and-modality-gap}

<!--list-separator-->

-  Interleaving (missing info)

    > This is not a CLIP problem but more of a document processing problem, if you had a document with text &amp; image, you'd parse the text (eg. pdf to markdown) and then embed the images in the document and then also embed the text using CLIP. There's missing spatial info now. That's what we call interleaving.

    This allows mixing of different types of data (modalities) within a single input sequence or document. This is also sometimes called "interleaving". Imagine a tutorial page: a paragraph of text, then an image illustrating a step, then more text explaining the image, then another image. This is interleaved data.

<!--list-separator-->

-  Modality Gap (skewed representation)

    > All CLIP-like models perform poorly on mixed-modality search due to a phenomenon known as the modality gap. As illustrated in the figure below, the closest vector to the snippet “I address you, members of the Seventy-Seventh Congress…” is not its screenshot, but other texts. This leads to search results that are skewed towards items of the same modality; in other words, text vectors will be closer to irrelevant texts than relevant images in the embedding space.

    ![](/ox-hugo/SCR-20250524-oyav.png)
    See [this blogpost for more details.](https://blog.voyageai.com/2024/11/12/voyage-multimodal-3/) and also [this thread](https://news.ycombinator.com/item?id=42162622)


#### ColBERT-like models (ColPali, ColQwen2, ColSmolVLM, ColiVara) {#colbert-like-models--colpali-colqwen2-colsmolvlm-colivara}

{{< figure src="/ox-hugo/20231106113255-ocr-939834503.png" >}}

-   See ColBERT in [NLP (Natural Language Processing)]({{< relref "20231123010516-nlp_natural_language_processing.md" >}})
-   Used for [PDF]({{< relref "20231114174804-pdf.md" >}}) extraction, also works for images
-   ColPali is enabled by the latest advances in Vision Language Models &amp; LLMs
    -   `Col`: Leverages multi-vector retrieval through late interaction mechanisms as proposed in ColBERT by Omar Khattab(author of DSPy).
    -   `Pali`: The PaliGemma model from the Google Zürich team (See [Computer Vision]({{< relref "20240629114811-object_detection.md" >}}))

<!--list-separator-->

-  More info

    -   It’s not an extraction(ocr) replacement (I wondered the same thing). It’s retrieval that can bypass extraction.
    -   I'd misunderstood it as a vision LLM that could extract information from PDFs, it looks like it's more of an embedding model that can represent a page from a PDF as a set of vectors, which means "will it just refuse to run" isn't actually a concern (unlike Claude 3 Vision etc)
    -   In essence; ColPali is just an adapter on PaliGemma for retrieval task, while PaliGemma itself can be used for many others tasks. As the authors point out, you can remove or not use the adapter and also have it use the general capabilities to read the page.

    <!--listend-->

    -   During indexing, the complex PDF parsing steps are replaced by using "screenshots" of the PDF pages directly.
    -   These screenshots are then embedded with the VLM. At inference time, the query is embedded and matched with a late interaction mechanism to retrieve the most similar document pages.

<!--list-separator-->

-  Resources

    -   [pdf retrieval with ColQwen2 vlm Vespa cloud - Vespa python API](https://vespa-engine.github.io/pyvespa/examples/pdf-retrieval-with-ColQwen2-vlm_Vespa-cloud.html)
    -   <https://www.analyticsvidhya.com/blog/2024/10/multimodal-retrieval-with-colqwen-vespa/>  🌟
    -   <https://huggingface.co/blog/manu/colpali>
    -   <https://blog.vespa.ai/retrieval-with-vision-language-models-colpali/> 🌟
    -   [Your connected workspace for wiki, docs &amp; projects | Notion](https://antaripasaha.notion.site/ColPali-Document-Retrieval-with-Vision-Language-Models-10f5314a5639803d94d0d7ac191bb5b1)
    -   <https://github.com/merveenoyan/smol-vision/blob/main/ColPali_%2B_Qwen2_VL.ipynb>


#### Voyage-Multimodal-3 {#voyage-multimodal-3}

-   This is like the hosted version of ColPali
-   In contrast to CLIP, this uses a `unified encoder` (uses the same encoder for text&amp;image)
-   The architecture is similar to how LLaVa works(post projection), but in usecase/objective of comparision.


#### Document Screenshot Embedding (DSE, MCDSE) {#document-screenshot-embedding--dse-mcdse}

See [[2406.11251] Unifying Multimodal Retrieval via Document Screenshot Embedding](https://arxiv.org/abs/2406.11251)


### Pre-training with Generative Objective (Eg. Moondream/LLaVa/Gemini/OAI Multimodal) {#pre-training-with-generative-objective--eg-dot-moondream-llava-gemini-oai-multimodal}

> -   Turns an existing LLM into a vision assistant
> -   <https://github.com/jiayev/GPT4V-Image-Captioner>


#### LLaVA/Moondream {#llava-moondream}

{{< figure src="/ox-hugo/20240629114811-object_detection-1241859690.png" >}}

-   `encoder-decoder VLM` (where the vision &amp; text encoders feeds into an LLM decoder).
-   visual instruction-following model
-   eg. moondream depends on Phi1.5(LLM) and SigLIP(visual encoder like CLIP) etc.
-   4 parts/components:
    -   `image encoder`: ViT (usually from CLIP, SigLIP etc, skipping the )
    -   `projection layer`:
        -   The projection layer in VLMs like LLaVA acts as a learned translator, adapting visual features from a vision encoder into a format (dimensionally compatible embeddings) that a Large Language Model (LLM) can understand.
        -   It's trained, often with the LLM frozen initially, to map these visual features into the LLM's input space using image-text datasets.
        -   This enables the LLM to process and reason over both visual and textual information for tasks like visual Q&amp;A.
    -   `text encoder`: LLM embedding
    -   `text decoder`: LLM


#### Understanding how LLaVA/Mooderam etc. is different from CLIP/ColPali {#understanding-how-llava-mooderam-etc-dot-is-different-from-clip-colpali}

> "Because LLMs such as Gemini -- and other causal language models more broadly -- are trained on next token prediction, the vectors that you get from pooling the output token embeddings aren't that useful for RAG or semantic search compared to what you get from actual embedding models."

<!--quoteend-->

> -   `llm( projector(ViT(image.png)) + embed(text prompt) ) = text output`
> -   Here both of the arguments sent to llm are in dimensionally compatible embedding after `projection`.

-   Imagine the `projection layer`'s output (visual pseudo-tokens) as a report about the image written in a very specific technical shorthand that the "Committee Pre-processor" understands.
-   Imagine the LLM's initial text embeddings for your prompt as your question, also translated into that same technical shorthand by the "Committee Pre-processor."
-   Usecase
    -   `Generative` (GOOD)
        -   You just send these 2 embeddings into the LLM and you should get a nice text output
    -   `Comparison/Similarity` (BAD/DONT DO)
        -   See [Embeddings]({{< relref "20240916155700-embeddings.md" >}}) FAQ for understanding that `embedding != similarity`
        -   Here we're trying to use a something which it models like LLaVA are not built for.
        -   We CAN probably take the embedding generated by `projection layer` and the embedding of the `text prompt` and try running cosine similarity in it right as the embedding dimensionality match? That'll be same as CLIP right?
        -   Well, NO.
        -   This most probably won't work as expected, because there's no direct training pressure in LLaVA to make these two specific sets of initial embeddings (projected visual vs. prompt text) align in a way that globally maximizes their cosine similarity for matching pairs.
        -   Coming back to our example, these shorthand reports are just the starting point for the main Committee (LLM layers). The Committee's job is to take both, discuss them deeply, cross-reference, infer, and then produce a final considered statement.
            -   i.e for any further understanding of this embedding pari(image&amp;text), we must pass it though the LLM. This is unlike CLIP, where the embedding themselves carry intrinsic meaning about where it belongs in a space.


### Pre-training with Unified Understanding Objective (Eg. BLIP) {#pre-training-with-unified-understanding-objective--eg-dot-blip}

> This does both embedding and captioning. Sort of like a middle child.

-   Example: BLIP, BLIP-2
-   [[2205.01917] CoCa: Contrastive Captioners are Image-Text Foundation Models](https://arxiv.org/abs/2205.01917)


### Pre-training with No text, only Visual Thinking {#pre-training-with-no-text-only-visual-thinking}

-   This is very new(May'25)
-   See: [[2505.11409] Visual Planning: Let's Think Only with Images](https://www.arxiv.org/abs/2505.11409)


### Video Embeddings? {#video-embeddings}

-   <https://github.com/OpenGVLab/VideoMAEv2>
-   <https://github.com/xuyang-liu16/VidCom2/tree/main>


## <span class="org-todo todo TODO">TODO</span> Finetuning and Augumenting VLMs {#finetuning-and-augumenting-vlms}

> Finetuning diffusion model(Image generation models) is different, see [StableDiffusion]({{< relref "20230719120753-stablediffusion.md" >}}) for that.

-   [Vision Language Models Explained](https://huggingface.co/blog/vlms) 🌟
-   [Paper page - mmE5: Improving Multimodal Multilingual Embeddings via High-quality Synthetic Data](https://huggingface.co/papers/2502.08468)
-   [Google Colab](https://colab.research.google.com/github/NielsRogge/Transformers-Tutorials/blob/master/SigLIP/Fine_tuning_SigLIP_and_friends_for_multi_label_image_classification.ipynb)
-   [FastVLM: Dramatically Faster Vision Language Model from Apple | Hacker News](https://news.ycombinator.com/item?id=43968897)
-   [Trying out QvQ – Qwen's new visual reasoning model | Hacker News](https://news.ycombinator.com/item?id=42505038)
-   [PaliGemma 2: Powerful Vision-Language Models, Simple Fine-Tuning | Hacker News](https://news.ycombinator.com/item?id=42330491)
    -   [How to Fine-tune PaliGemma 2](https://blog.roboflow.com/fine-tune-paligemma-2/)
-   Fine-tune SmolVLM on Visual Question Answering using Consumer GPU with QLoRA
    -   <https://github.com/huggingface/smollm/blob/main/finetuning%2FSmol_VLM_FT.ipynb>
