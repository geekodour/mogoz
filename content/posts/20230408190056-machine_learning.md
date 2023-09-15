+++
title = "Machine Learning"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Algorithms]({{< relref "20230205172402-algorithms.md" >}}), [Data Engineering]({{< relref "20230405003455-data_engineering.md" >}}), [GPGPU]({{< relref "20230408051445-gpgpu.md" >}})


## FAQ {#faq}


### Keras vs Pytorch vs TF {#keras-vs-pytorch-vs-tf}

-   Keras is high level framework and has less boilerplate so easy to understand etc. It earlier only largely supported TF but [now supports pytorch](https://keras.io/keras_core/announcement/)
-   Pytorch is good for training and dev but is hard to put to prod.
-   TF is pytorch alternative.


### Classical ML vs DL {#classical-ml-vs-dl}

-   See [Why Tree-Based Models Beat Deep Learning on Tabular Data](https://medium.com/geekculture/why-tree-based-models-beat-deep-learning-on-tabular-data-fcad692b1456)
-   The combination can be very useful sometimes, for example for transfer learning for working with low resource datasets/problems. Use a deep neural network to go from high dimensionality data to a compact fixed length vector. Basically doing feature extraction. This network is increasingly trained on large amounts of unlabeled data, using self-supervision. Then use simple classical model like a linear model, Random Forest or k-nearest-neighbors to make model for specialized task of interest, using a much smaller labeled dataset. This is relevant for many task around sound, image, multi-variate timeseries. Probably also NLP (not my field).


## What are the steps {#what-are-the-steps}

{{< figure src="/ox-hugo/20230408190056-machine_learning-98191752.png" >}}

-   <https://github.com/florist-notes/linux_d/blob/main/sysdesign/MLOPS.MD>


### Feature transformation {#feature-transformation}

-   Transform the inputs to fit your model.
-   For LLMs training requires more like 100 x A100 and a cluster to train on
-   [DeepSpeed - Wikipedia](https://en.wikipedia.org/wiki/DeepSpeed)
-   To do backprop you have to accumulate a loss gradient for every model parameter and trace it back to the input. I haven't calculated it precisely but a reasonable rule of thumb is to reserve VRAM equal to the model size + input size. That is, if you load your model and a single batch onto the GPU and it takes up 12 GB, you will want to reserve another 12 GB or so.


### Weight training {#weight-training}

-   Aim for High throughput
-   If you're going to do quantization, you'll do quantization aware training if needed
-   The real point of using GPUs is often to form minibatches during training.
-   training is doing forward + backward + applying gradients,


#### Traininig steps {#traininig-steps}

-   Split data into train and validation sets or something.


#### Training laws {#training-laws}

-   [Chinchilla data-optimal scaling laws: In plain English](https://lifearchitect.ai/chinchilla/)
-   [chinchilla reddit discussion](https://www.reddit.com/r/singularity/comments/wcsa8g/chinchillas_wild_implications_scaling_laws/)
-   Multiple epochs can give us better results, but this helps us know if we even need to do another eval.
-   `training data : model parameter count` ratio for a certain budget
-   How much training data should I ideally use for a model of X size?
-   Ratio: `20:1` , Eg. `20bn training tokens:1bn parameter` parameters, on `1 epoch`


### Serialize the weights {#serialize-the-weights}


#### Model and Weights {#model-and-weights}

-   Not necessary to save the model and weights separately.
-   Many serialization formats and frameworks provide options to save the model and its weights together in a single file.
-   We can save separately if needed.
-   In pytorch, state_dict contains all this stuff


#### Serialization Formats {#serialization-formats}

-   JSON, HDF5(Keras), SavedModel(TF, uses [Protocol Buffers]({{< relref "20230522131118-protocol_buffers.md" >}}))  ONNX, pth(Pytorch objects as pickle), safetensors, ckpt(TF), ggml etc.
-   Some [formats are more dangerous than others](https://www.reddit.com/r/LocalLLaMA/comments/13t2b67/security_psa_huggingface_models_are_code_not_just/). safetensors and ggml nice.
-   Most of the time these can be converted into one another etc.
-   ckpt, pth, pickle can contain malicious code
-   `pth, pt` are same, usually not recommended to use `pth` cuz [pth falls in sys.](https://docs.python.org/3.8/library/site.html) so use `pt`.
-   pytorch has `torch.jit.save()` and `torch.save()`, the first one saved in a way that the model can be loaded by c++ for inference etc. while the later saves in [Python]({{< relref "20221231140207-python.md" >}}) pickle, which is useful for prototyping, researching, and training.


#### ONNX vs safetensors {#onnx-vs-safetensors}

-   These are for different usecases. Inference and Storage.
-   There's some [compatibility issues](https://github.com/onnx/onnx/issues/5406) with ONNX ecosystem and safetensors

<!--list-separator-->

-  ONNX (framework interoperability, inference)

    -   ONNX is designed to allow framework interoperability. This is a [protobuf]({{< relref "20230522131118-protocol_buffers.md" >}}) file.
    -   ONNX consumes a .onnx file, which is a definition of the network and weights.
    -   GGML instead just consumes the weights, and defines the network in code. GGML less bloated than onnx.

<!--list-separator-->

-  safetensors

    -   Format for storing tensors safely (as opposed to pickle) and that is still fast (zero-copy).


#### Components of sharing a model {#components-of-sharing-a-model}

-   Model (checkpoints) : The main deal
-   Weights: This sometimes comes w the model file, sometimes separately
-   Tokenizer : The algorithm to use for tokenization that the model will understand


### Optimize weights {#optimize-weights}


#### ONNX {#onnx}

-   ONNX is a format where on how we can store pretrained model but it also provides a runtime which can run quantized model.
-   See [Convert Transformers to ONNX with Hugging Face Optimum](https://huggingface.co/blog/convert-transformers-to-onnx)
-   There is also TFLite runtime which support ONNX models.


#### Quantization {#quantization}

-   Model quantization is a method of reducing the size of a trained model while maintaining accuracy.
-   You can quantize for performance/power consumption/size weight sizes etc., [all of many](https://pytorch.org/blog/quantization-in-practice/) by decreasing precision of weights.
-   There are various quantization schemes, some may use more memory etc. Eg. llma.cpp has different quantization methods like q4_2, q4_3, q5_0, q5_1 etc. Then there's also [GPTQ for 4bit quantization.](https://github.com/qwopqwop200/GPTQ-for-LLaMa)
-   [OpenVino](https://github.com/openvinotoolkit/openvino_notebooks) is a [nice tool](https://docs.openvino.ai/latest/home.html) to do quantization for Intel CPUs

<!--list-separator-->

-  Resources

    -   [8-bit Methods for Efficient Deep Learning -- Tim Dettmers (University of Washington) - YouTube](https://www.youtube.com/watch?v=2ETNONas068) 🌟
    -   [Basic math related to computation and memory usage for transformers](https://news.ycombinator.com/item?id=35631546)  🌟
    -   [What Is int8 Quantization and Why Is It Popular for Deep Neural Networks?](https://www.mathworks.com/company/newsletters/articles/what-is-int8-quantization-and-why-is-it-popular-for-deep-neural-networks.html)
    -   [Quantization | Papers With Code](https://paperswithcode.com/paper/quantization-and-training-of-neural-networks)
    -   <https://inst.eecs.berkeley.edu/~ee290-2/sp20/assets/labs/lab1.pdf>
    -   [TensorFlow model optimization  |  TensorFlow Model Optimization](https://www.tensorflow.org/model_optimization/guide)
    -   [Post-training quantization  |  TensorFlow Lite](https://www.tensorflow.org/lite/performance/post_training_quantization)
    -   [8-bit Matrix Multiplication for transformers at scale using transformers, accelerate and bitsandbytes](https://huggingface.co/blog/hf-bitsandbytes-integration)
    -   [Quantization](https://huggingface.co/docs/optimum/concept_guides/quantization)
    -   [Quantization for Neural Networks - Lei Mao's Log Book](https://leimao.github.io/article/Neural-Networks-Quantization/)


#### Other stuff {#other-stuff}

-   Pruning
-   [distillation](https://en.wikipedia.org/wiki/Knowledge_distillation) (Eg. Alpaca(small model) is distillation of gpt3.5(big model))


### Ship the weights {#ship-the-weights}


### Inference {#inference}

There are several inference engines to choose from.
![](/ox-hugo/20230408190056-machine_learning-1005953129.png)

-   There are also cloud providers which offer GPU for inference. Eg. GenesisCloud, Paperspace, Big ones like AWS Inferentia.
-   CPU is often faster for inference except on very huge models like CNNs or I guess big Transformers.
-   inference is only doing forward pass
-   Sometimes inference may require GPU
-   a GPU is good if you have a lot of compute intensity  for inference
-   Now you are calling your model to do the inference on those inputs. If the model is running on CPU, then data goes directly from RAM to CPU, eval happens on the cpu, and output is saved back to the RAM and sent as response.
    -   If you are running your model on GPU, then the inputs are first copied from the RAM to the GPU memory, and then passed from the GPU memory to the GPU compute unit for processing, the output is saved to GPU memory, and then copied back the the RAM to be sent as response, So you have two extra copy steps
-   Aim for low latency
-   Can be a web service.
-   "inference endpoint" which is basically an HTTP API that you can send requests to and get back responses.
-   or just use it in some way
-   Most trained ML models that ship today can generate predictions on a raspberry pi or a cell phone. LLMs still require more hardware for inference, but you’d be surprised how little they need compared to what’s needed for training.
-   People usually train of GPU and inference on CPU. Saves a lot of money.
-   Really depends on the mode.
-   For big models(60B+), interference is possible w Threadripper builds with &gt; 256GB RAM + some assortment of 2x-4x GPUs. **BUT it'll be stupid slow**, probably MINUTES per token.
-   GLM-130B runs on 4x 3090, uses INT4.


### Deploying {#deploying}

-   tensorflow serving (with ONNX, you can train with pytorch and infer w TF)
-   Nvidia Titron (There's also openAI titron that's different)


#### Web based {#web-based}

-   [WebAssembly]({{< relref "20230510200213-webassembly.md" >}}) GGML: [whisper example](https://github.com/ggerganov/whisper.cpp/tree/master/examples/talk.wasm), doesn't use webgpu. wasm+cpu
-   WebGPT
    -   POC, uses vanilla JS to make use of WebGPU to run a basic [GPT](https://github.com/0hq/WebGPT)
    -   [[2112.09332] WebGPT: Browser-assisted question-answering with human feedback](https://arxiv.org/abs/2112.09332)
-   TVM based
    -   [TVM](https://tvm.apache.org/) is used to compile the GPU-side code to WebGPU
    -   Emscripten is used to compile the CPU-side code to WebAssembly.
    -   Examples
        -   <https://github.com/mlc-ai/web-llm>
        -   <https://github.com/mlc-ai/mlc-llm>
        -   <https://github.com/mlc-ai/web-stable-diffusion>


### Continuous learning {#continuous-learning}

-   You can update a model with new data at any time. Production models are often updated at intervals with monitoring. It is generally possible but not always practical.
-   [Federated learning - Wikipedia](https://en.m.wikipedia.org/wiki/Federated_learning)


#### RL {#rl}

It’s common to set agents to set some fraction of their time exploring and some other exploiting the environment.


#### NN {#nn}

whole “online learning” field that addresses just that


## Hardware {#hardware}


### Chips {#chips}

generated by chatgpt


#### CPU {#cpu}

Central Processing Units (CPUs) are the main processing units in a computer. They are designed to handle a wide range of tasks, including running the operating system and applications. However, CPUs are not optimized for parallel computing, which is a key aspect of machine learning.


#### GPU {#gpu}

Graphics Processing Units (GPUs) were originally designed for rendering graphics, but their parallel architecture makes them well-suited for machine learning tasks that require large-scale parallel processing, such as training deep neural networks. GPUs are particularly useful for matrix operations, which are common in machine learning.


#### APU {#apu}

Accelerated Processing Units (APUs) are a combination of CPU and GPU on a single chip. They are designed to provide high-performance computing for a variety of tasks, including machine learning. APUs are well-suited for tasks that require both serial and parallel processing.


#### TPU {#tpu}

Tensor Processing Units (TPUs) are Google's custom-designed chips for machine learning. TPUs are optimized for matrix multiplication, which is a key operation in deep neural networks. TPUs are particularly useful for large-scale machine learning tasks, such as training complex models on massive datasets.


#### FPGA {#fpga}

Field-Programmable Gate Arrays (FPGAs) are chips that can be reprogrammed after manufacturing. FPGAs are highly customizable and can be optimized for specific machine learning tasks. They are particularly useful for tasks that require low latency and high throughput, such as real-time image recognition.


#### ASIC {#asic}

Application-Specific Integrated Circuits (ASICs) are custom-designed chips that are optimized for specific tasks. ASICs are highly specialized and can be designed to perform a particular machine learning task very efficiently. ASICs are particularly useful for tasks that require high throughput and low power consumption, such as inference in deep neural networks.


## Models {#models}

-   GPT-J
-   gpt-turbo and FLAN-T5-XXL
-   Roberta
-   LLAMA or Standford Alpaca


## Terms I keep hearing {#terms-i-keep-hearing}

-   dropout regularization in a deep neural network
-   activations
-   weights


## Training LLMs {#training-llms}

{{< figure src="/ox-hugo/20230408190056-machine_learning-488154042.png" >}}


## Resources {#resources}

-   [GPT-2 Neural Network Poetry · Gwern.net](https://gwern.net/gpt-2#fn3)


### Explainable AI {#explainable-ai}

-   <https://github.com/slundberg/shap>
-   <https://github.com/marcotcr/lime>
-   <https://github.com/interpretml/interpret/>
-   <https://github.com/slundberg/shap>
-   <https://github.com/MAIF/shapash>
-   <https://github.com/pytorch/captum>
-   <https://github.com/Trusted-AI/AIX360>
