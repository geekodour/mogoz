+++
title = "Machine Learning"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Algorithms]({{< relref "20230205172402-algorithms.md" >}}), [Data Engineering]({{< relref "20230405003455-data_engineering.md" >}})


## What are the steps {#what-are-the-steps}

{{< figure src="/ox-hugo/20230408190056-machine_learning-98191752.png" >}}


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


### Serialize the weights {#serialize-the-weights}

-   Can be JSON, Pickle, Protobuf etc.


### Optimize weights {#optimize-weights}


#### Quantization {#quantization}

-   You can quantize for performance/power consumption/size, [all of many](https://pytorch.org/blog/quantization-in-practice/) by decreasing precision of weights.
-   OpenVino is a [nice tool](https://docs.openvino.ai/latest/home.html) to do quantization for Intel CPUs
-   [Knowledge distillation](https://en.wikipedia.org/wiki/Knowledge_distillation)

<!--list-separator-->

-  Resources

    -   [What Is int8 Quantization and Why Is It Popular for Deep Neural Networks?](https://www.mathworks.com/company/newsletters/articles/what-is-int8-quantization-and-why-is-it-popular-for-deep-neural-networks.html)
    -   [Quantization | Papers With Code](https://paperswithcode.com/paper/quantization-and-training-of-neural-networks)
    -   <https://inst.eecs.berkeley.edu/~ee290-2/sp20/assets/labs/lab1.pdf>
    -   [TensorFlow model optimization  |  TensorFlow Model Optimization](https://www.tensorflow.org/model_optimization/guide)
    -   [Post-training quantization  |  TensorFlow Lite](https://www.tensorflow.org/lite/performance/post_training_quantization)
    -   [8-bit Matrix Multiplication for transformers at scale using transformers, accelerate and bitsandbytes](https://huggingface.co/blog/hf-bitsandbytes-integration)
    -   [Quantization](https://huggingface.co/docs/optimum/concept_guides/quantization)
    -   [Quantization for Neural Networks - Lei Mao's Log Book](https://leimao.github.io/article/Neural-Networks-Quantization/)


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

-   tensorflow serving


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
-   <https://github.com/openvinotoolkit/openvino_notebooks>


## Resources {#resources}

-   [GPT-2 Neural Network Poetry · Gwern.net](https://gwern.net/gpt-2#fn3)


## Terms I keep hearing {#terms-i-keep-hearing}

-   dropout regularization in a deep neural network
-   activations
-   weights
