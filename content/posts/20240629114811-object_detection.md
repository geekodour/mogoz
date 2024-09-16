+++
title = "Computer Vision"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Machine Learning]({{< relref "20230408190056-machine_learning.md" >}}), [NLP (Natural Language Processing)]({{< relref "20231123010516-nlp_natural_language_processing.md" >}})


## Vision tasks {#vision-tasks}

| Task                                | Variations                                                   |
|-------------------------------------|--------------------------------------------------------------|
| Object detection                    | Real time, non-realtime, rotated, captioning, classification |
| Object tracking(video)              | Similar to object detection but with some additional checks  |
| Segmentation                        |                                                              |
| Contrastive Learning                |                                                              |
| Distillation                        |                                                              |
| VDU (Visual Document Understanding) | OCR, OCR-free                                                |
| VQA (Visual QA)                     |                                                              |
| Pose estimation                     |                                                              |


### Image generation {#image-generation}

-   See [Modern AI Stack]({{< relref "20230326092427-modern_ai_stack.md" >}})
-   [GLIGEN:Open-Set Grounded Text-to-Image Generation.](https://gligen.github.io/)


### Object Detection {#object-detection}

| Architecture | Type    | Name                                               | Use                                                                                    | Other notes                              |
|--------------|---------|----------------------------------------------------|----------------------------------------------------------------------------------------|------------------------------------------|
| Transformer  | VLM     | [LLaVA](https://llava-vl.github.io/)               | Visual Q/A, alternative to GPT-4V                                                      |                                          |
|              | VLM     | [moondream](https://moondream.ai/)                 | same as LLaVa                                                                          | can't do ocr probably                    |
|              | VLM     | CogVLM                                             | same as LLaVa                                                                          | Better than LLaVa in captioning          |
|              | ViT     | CLIP                                               | txt-guided imagen, classification, caption                                             |                                          |
|              | ViT     | BLIP                                               | Same as CLIP, better than CLIP at captioning                                           | Considered faster than CLIP?             |
|              | ViT     | [DETIC](https://github.com/facebookresearch/Detic) |                                                                                        |                                          |
|              | ViT     | GDINO                                              | [Better at detection](https://docs.autodistill.com/what-model-should-i-use/) than CLIP | similar to YOLO but slower               |
| CNN          | 1 stage | YOLO                                               | Realtime object identification                                                         | No involvement of anything NLP like VLMs |
|              | 2 stage | Detectron-2                                        |                                                                                        | Apache license, Fast-RCNN                |
|              |         | EfficientNetV2                                     | classification                                                                         |                                          |


#### Theory {#theory}

-   [What are some foundational papers in CV that every newcomer should read? : computervision](https://www.reddit.com/r/computervision/comments/1azewu3/what_are_some_foundational_papers_in_cv_that/)
-   [Object Detection | Papers With Code](https://paperswithcode.com/task/object-detection)
-   [A Dive into Vision-Language Models](https://huggingface.co/blog/vision_language_pretraining#3-multi-modal-fusing-with-cross-attention)
-   Closed-set: Detect from trained stuff. Eg. Find all dogs in the image
-   Open-set: Detects un-trained stuff. Eg. Find the right-most dog, is a person holding a dog? (Transformer based work nicely here)
    -   In other words, allows to do `zero-shot` object detection


#### CNN based {#cnn-based}

> -   CNN uses pixel arrays

{{< figure src="/ox-hugo/20240629114811-object_detection-1337584625.png" >}}

<!--list-separator-->

-  YOLO! (?)

    -   <https://roboflow.github.io/model-leaderboard/>

    > Lot of crazy politics. anyone is coming up with anything. The newer version doesn't mean the newer version of the same thing. superr confusing. Original author left the chat long back cuz ethical reasons
    >
    > "The YOLOv5, YOLOv6, and YOLOv7 teams all say their versions are faster and more accurate than the rest, and for what it's worth, the teams for v4 and v7 overlap, and the implementation for v7 is based on v5. At the end of the day, the only benchmarks that really matter to us are ones using our data and hardware"

    -   YOLO algorithm treats object detection as a regression problem, utilizing a single convolutional neural network to spatially separate bounding boxes and associate probabilities with detected objects.
    -   YOLO is a family of detection algorithms made by, at times, totally different groups of people.
    -   See [Programming Comments - Darknet FAQ](https://www.ccoderun.ca/programming/yolo_faq/#optimal_network_size)
    -   See [[2304.00501] A Comprehensive Review of YOLO Architectures in Computer Vision: From YOLOv1 to YOLOv8 and YOLO-NAS](https://arxiv.org/abs/2304.00501)

    | Year | Name         | Description                                                                                                                                                                                 |
    |------|--------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    |      | Darknet/YOLO | Someone says it's [faster than the newer](https://www.reddit.com/r/computervision/comments/1d8a93h/compare_yolov3_yolov4_and_yolov10/) version, idk tf they talking about. Goes upto YOLOv7 |
    | 2015 | YOLOv1       | Improved on R-CNN/ Fast R-CNN by doing 1 CNN archtecture, made things real fast                                                                                                             |
    | 2016 | YOLOv2       | Improved on v1 (Darknet-19), anchor boxes                                                                                                                                                   |
    | 2018 | YOLOv3       | Improved on v2 (Darknet-53), NMS was added                                                                                                                                                  |
    |      | YOLOv4       | Added CSPNet, k-means, GHM loss etc.                                                                                                                                                        |
    |      | YOLOv5       |                                                                                                                                                                                             |
    |      | YOLOv6       |                                                                                                                                                                                             |
    |      | YOLOv7       |                                                                                                                                                                                             |
    |      | YOLOv8       |                                                                                                                                                                                             |
    |      | YOLOv8-n     |                                                                                                                                                                                             |
    |      | YOLOv8-s     |                                                                                                                                                                                             |
    |      | YOLOv8-m     |                                                                                                                                                                                             |
    |      | YOLOv10      |                                                                                                                                                                                             |
    |      | YOLO-X       | Based on YOLOv3 but adds features as anchor free and other things.                                                                                                                          |
    |      | YOLO NAS     | for detecting small objects, suitable for edge devices                                                                                                                                      |
    |      | YOLO-World   |                                                                                                                                                                                             |

    {{< figure src="/ox-hugo/20240629114811-object_detection-1955448504.png" >}}

    <!--list-separator-->

    -  YOLO vs older CNN based models

        > From a reddit comment
        >
        > -   the R-CNN family:
        >     -   Find the interesting regions
        >     -   For every interesting region: What object is in the region?
        >     -   Remove overlapping and low score detections
        > -   YOLO/SSD:
        >     -   Come up with a fixed grid of regions
        >     -   Predict N objects in every region all at once
        >     -   same as above

<!--list-separator-->

-  MMLabs 🌟

    -   [mmdetection](https://github.com/open-mmlab/mmdetection)(MMLabs)
    -   More like a framework for vision models.
    -   Good choice if you're just experimenting with a model right now. The SOTA model can be trained via config alone.
        -   Has both CNN and Transformer based stuff
    -   It also has YOLO model variants: <https://github.com/open-mmlab/mmyolo>

<!--list-separator-->

-  Doubts

    -   ResNet?


#### Transformer {#transformer}

> -   ViT splits the input images into visual tokens
>     -   divides an image into fixed-size patches
>     -   correctly embeds each of them
>     -   includes positional embedding as an input to the transformer encoder

<!--list-separator-->

-  Vision Encoder (Transformer)

    {{< figure src="/ox-hugo/20240629114811-object_detection-1041645406.png" >}}

    -   The OG here is [ViT](https://huggingface.co/docs/transformers/en/model_doc/vit)(Google Brain team)
        -   Downstream variants include: BEiT, DeiT, Swin, CSWIn(better than Swin), MAE, DINO(Improved DETR)
        -   Prior work before ViT was [DETR](https://huggingface.co/docs/transformers/en/model_doc/detr)
    -   Has outperformed CNN models in certain cases
        -   ViT models outperform the current SOTA CNNs by almost x4 in terms of computational efficiency and accuracy.
    -   What we can do
        -   Ask what a image is about i.e `Input(Image) = Output(Text)`
        -   Return us a set of images given a text. i.e `Input(Text) = Output(Image(s))`
    -   Examples of implementation: CLIP, GDINO
        -   ViT is what CLIP uses. In other words, CLIP is possible because of ViT.
        -   [GroundingDINO(GDINO)](https://github.com/IDEA-Research/GroundingDINO) uses [DINO](https://github.com/IDEA-Research/DINO)
            -   [Eyes Wide Shut? Exploring the Visual Shortcomings of Multimodal LLMs - YouTube](https://www.youtube.com/watch?v=Iy9xClK65Bs&t=277s) (combining DINO+CLIP for better results)

    <!--list-separator-->

    -  Architecture of ViT

        -   [this blogpost](https://viso.ai/deep-learning/vision-transformer-vit/) has simple explanation of the architecture

    <!--list-separator-->

    -  Architecture of CLIP/GDINO

        {{< figure src="/ox-hugo/20240629114811-object_detection-2059429889.png" >}}

        -   Components
            -   `Text backbone`: Eg. BERT/ OpenAI Embeddings
            -   `Image backbone`: SWIN/ViT etc.
        -   Steps
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
        -   More stuff
            -   [natural language processing - Why does CLIP use a decoder-only transformer for encoding text?](https://ai.stackexchange.com/questions/39073/why-does-clip-use-a-decoder-only-transformer-for-encoding-text)

    <!--list-separator-->

    -  Similarity search

        -   With such models we can look for similarity between the text and the image embedding
            -   Because the inner product is a similarity metric
        -   Process
            -   Create a bunch of prompts out of your classes (e.g. “A photo of a Dog”) and run them through the text encoder to get an embedding.
            -   Create the image embedding with the image encoder
            -   Multiply it with each text embedding to get the similarity of the texts and the images.
            -   The one with the highest similarity is your predicted class.

<!--list-separator-->

-  VLM(Vision Language Model)

    -   MOONDREAM EXAMPLE PROMPT ENG: <https://gist.github.com/geekodour/e9bb4c0c35957cabdb2dc3618be1f4e1>
    -   These are technically a special usecase of using vision encoder with [LLMs]({{< relref "20230719050449-open_source_llms.md" >}})
    -   Capabilities keep [improving/differ](https://blog.roboflow.com/gpt-4-vision-alternatives/)
        ![](/ox-hugo/20240629114811-object_detection-1241859690.png)
    -   Examples: LLaVa, moondream2 etc.
    -   Example project using LVM to do captioning: [jiayev/GPT4V-Image-Captioner](https://github.com/jiayev/GPT4V-Image-Captioner)
    -   See <https://github.com/BradyFU/Awesome-Multimodal-Large-Language-Models/tree/Evaluation>

    <!--list-separator-->

    -  Architecture of VLM

        -   Components
            -   `visual encoder`
                -   VLMs need a visual encoder such as CLIP(ViT), this can be used in
                -   Plugging ViT into task-specific fine-tuning
                -   Combining ViT with V&amp;L pre-training and transferring to downstream tasks
                -   So the visual understanding of VLM will only be as good as the ViT.
                -   In other words, when you attach a "decoder only LLM" to a `vision encoder` such as CLIP, you get a VLM.
            -   `LLM`
                -   Then VLM also depend on some LLM
        -   Example
            -   eg. moondream depends on Phi1.5(LLM) and SigLIP(visual encoder like CLIP) etc.

    <!--list-separator-->

    -  Fine turning VLM

        -   Eg. moondream does not support OCR ootb, but we can finetune it to support OCR. But results also depends on the LLM used. Eg. From a reddit comment: "However would not recommend moondream for ocr due to it’s PHI tokenizer not splitting digits into separate tokens. It struggles to pick up sequential digits reliably. For example: 222 is likely to become 22 due to this issue."
        -   <https://github.com/BradyFU/Woodpecker> (correction)


#### Combining Transformer based + CNN based {#combining-transformer-based-plus-cnn-based}

> This is only useful if you need super fast inference, low on compute inference etc. Otherwise for most cases GDINO/CLIP etc goto.

-   Now CNN based inference is faster than transformer based. So something like YOLO is still more preferable for realtime stuff.
-   But we can use GDINO to generate label for our training dataset and then we can use this to train our YOLO models which will be fast.
    -   Essentially, use Transformer based detection for labeling &amp; training the CNN model
    -   Use the CNN model to do fast inference in production
-   Basically using foundation models to train fine-tuned models. The foundation model acts as an automatic labeling tool, then you can use that model to get your dataset.
-   <https://github.com/autodistill/autodistill> allows to do exactly this.
-   see <https://www.youtube.com/@Roboflow/videos>


### Segmentation {#segmentation}

| Name                                                                                                                | Description |
|---------------------------------------------------------------------------------------------------------------------|-------------|
| [SEEM](https://www.reddit.com/r/MachineLearning/comments/12lf2l3/r_seem_segment_everything_everywhere_all_at_once/) |             |
| [SAM](https://segment-anything.com/)                                                                                |             |

-   To improve segmentation we can tune the params, else we can also use some kind of object detection(eg. yolo etc) to draw bounding boxes before we apply segmentation to it. See [this thread](https://www.reddit.com/r/computervision/comments/1bqwcun/segment_anything_sam_segments_literally/) for more info.


### Visual Document Understanding (VDU) {#visual-document-understanding--vdu}

-   OCR
    -   2-stage pipeline: Usually when trying to understand a document, we'd do OCR and then run though another process for the understanding.
    -   Issue: Mostly with OCR, the result might not be what you want. Eg. No spatial understanding ( even different line etc). Using a OCR free approach might help.
    -   See [OCR]({{< relref "20231106113255-ocr.md" >}})
-   OCR-free
    -   1 stage pipeline: OCR and understanding in one
    -   Eg. [Donut](https://arxiv.org/abs/2111.15664), (Document understanding transformer), [LayoutLM](https://huggingface.co/docs/transformers/en/model_doc/layoutlm) (reciept understanding)
        -   Some of the VLMs can do this as-well.


## Meta {#meta}


### Datasets {#datasets}

-   ImageNet
-   COCO


## OpenCV {#opencv}

-   <https://archive.ph/2024.07.23-031436/https://scottsexton.co/post/opencv_wild_kingdom/>


## Resources {#resources}

-   <https://x.com/simonw/status/1828113518610047386>
