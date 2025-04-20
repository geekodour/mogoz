+++
title = "Machine Learning"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Algorithms]({{< relref "20230205172402-algorithms.md" >}}), [Data Engineering]({{< relref "20230405003455-data_engineering.md" >}}), [GPGPU]({{< relref "20230408051445-gpgpu.md" >}}), [Computer vision]({{< relref "20240629114811-object_detection.md" >}}), [Modern AI Stack]({{< relref "20230326092427-modern_ai_stack.md" >}}), [Deep Learning]({{< relref "20250407014803-deep_learning.md" >}}), [Modern AI Stack]({{< relref "20230326092427-modern_ai_stack.md" >}}), [Deploying ML applications (applied ML)]({{< relref "20241130100028-deploying_ml_applications_applied_ml.md" >}})


## FAQ {#faq}


### What really matters? {#what-really-matters}

-   Traditional Neural Networks
    -   Good results comes from composing multiple layers (depth) rather than optimizing single layers
    -   Key components: convolutional layers, recurrent layers, linear layers, dropouts, activation functions. Finding the right thing is useful, but picking the right depth and composition is more important
    -   Power lies in modularity and depth of composition
-   Language Model Evolution
    -   See [Open Source LLMs (Transformers)]({{< relref "20230719050449-open_source_llms.md" >}})
    -   Moving beyond just using/fine-tuning existing models like GPT
    -   Focus shifting to building task-specific architectures
    -   Architecture design becoming more important than training techniques (like RLHF)


### Keras vs Pytorch vs TF {#keras-vs-pytorch-vs-tf}

-   Keras is high level framework and has less boilerplate so easy to understand etc. It earlier only largely supported TF but [now supports pytorch](https://keras.io/keras_core/announcement/)
-   Pytorch is good for training and dev but is hard to put to prod.
-   TF is pytorch alternative.


### Classical ML vs DL {#classical-ml-vs-dl}

-   See [Why Tree-Based Models Beat Deep Learning on Tabular Data](https://medium.com/geekculture/why-tree-based-models-beat-deep-learning-on-tabular-data-fcad692b1456)
-   The combination can be very useful sometimes, for example for transfer learning for working with low resource datasets/problems. Use a deep neural network to go from high dimensionality data to a compact fixed length vector. Basically doing feature extraction. This network is increasingly trained on large amounts of unlabeled data, using self-supervision. Then use simple classical model like a linear model, Random Forest or k-nearest-neighbors to make model for specialized task of interest, using a much smaller labeled dataset. This is relevant for many task around sound, image, multi-variate timeseries. Probably also NLP (not my field).


## Categories {#categories}

> -   Text
>     -   Text classification
>     -   Test generation
>     -   Summarization
> -   Audio
>     -   Audio classification
>     -   Automatic speech recognition
> -   Vision
>     -   Object detection
>     -   Image classification
>     -   Image segmentation
> -   Multi Modal
>     -   Visual QA
>     -   Document QA
>     -   Image captioning


### Generative AI {#generative-ai}

-   [Embeddings]({{< relref "20240916155700-embeddings.md" >}})
-   [Personal AI Workflow]({{< relref "20250320202209-personal_ai_workflow.md" >}})
-   [Deploying ML applications (applied ML)]({{< relref "20241130100028-deploying_ml_applications_applied_ml.md" >}})
-   [RAG]({{< relref "20241227084628-rag.md" >}})


#### Diffusion models {#diffusion-models}

> These are different from transformers in arch, training process, how they infer, usecase etc.

-   See
    -   [⭐ Diffusion Models](https://andrewkchan.dev/posts/diffusion.html)
    -   [What are Diffusion Models? | Lil'Log](https://lilianweng.github.io/posts/2021-07-11-diffusion-models/)
    -   [Diffusion models are autoencoders – Sander Dieleman](https://sander.ai/2022/01/31/diffusion.html)

<!--list-separator-->

-  Finetuning diffusion models (Stable Difussion)

    <!--list-separator-->

    -  Dreambooth

        {{< figure src="/ox-hugo/20230326092427-modern_ai_stack-494918082.png" >}}

    <!--list-separator-->

    -  Textual Inversion

        {{< figure src="/ox-hugo/20230326092427-modern_ai_stack-1116443791.png" >}}

    <!--list-separator-->

    -  LoRA

        {{< figure src="/ox-hugo/20230326092427-modern_ai_stack-743950201.png" >}}

    <!--list-separator-->

    -  Depth-2-Img

        {{< figure src="/ox-hugo/20230326092427-modern_ai_stack-318853441.png" >}}

    <!--list-separator-->

    -  ControlNet

        -   It's a training strategy, a way of doing fine tuning
        -   It's different from Dreambooth and LoRA in ways that they don't freeze the original model.

        ![](/ox-hugo/20230326092427-modern_ai_stack-1701974168.png)
        ![](/ox-hugo/20230326092427-modern_ai_stack-1033145681.png)
        ![](/ox-hugo/20230326092427-modern_ai_stack-1213872828.png)
        ![](/ox-hugo/20230326092427-modern_ai_stack-1557053891.png)
        ![](/ox-hugo/20230326092427-modern_ai_stack-361886987.png)

        -   The complimentary external model can be distributed independently or can be baked into one model.
        -   The complimentary model is specific to freezed main model so it'll only work with that version so we need to care about compatibility


#### Transformers {#transformers}

-   [Open Source LLMs (Transformers)]({{< relref "20230719050449-open_source_llms.md" >}})


### Deep Learning {#deep-learning}

[Deep Learning]({{< relref "20250407014803-deep_learning.md" >}})


### NLP {#nlp}

-   [NLP (Natural Language Processing)]({{< relref "20231123010516-nlp_natural_language_processing.md" >}})


### Time Series Forecasting / Tabular Data {#time-series-forecasting-tabular-data}

See [Time Series / Anomaly Detection]({{< relref "20250322100511-time_series_anomaly_detection.md" >}})


### Retrieval {#retrieval}

-   [NLP (Natural Language Processing)]({{< relref "20231123010516-nlp_natural_language_processing.md" >}})
-   [RAG]({{< relref "20241227084628-rag.md" >}})
-   [Information Retrieval]({{< relref "20231123014416-information_retrieval.md" >}})
-   [Information Theory/Knowledge]({{< relref "20221101222235-information_theory.md" >}})


### Clustering {#clustering}

-   [Clustering]({{< relref "20241227082910-clustering.md" >}})


### Vision {#vision}

-   [Computer Vision]({{< relref "20240629114811-object_detection.md" >}})
-   [OCR]({{< relref "20231106113255-ocr.md" >}})


### Voice/Audio {#voice-audio}

> <https://voiceaiandvoiceagents.com/>


#### TTS {#tts}

<!--list-separator-->

-  Bark

    -   <https://github.com/suno-ai/bark>
    -   <https://github.com/coqui-ai/TTS>
    -   <https://github.com/serp-ai/bark-with-voice-clone>

<!--list-separator-->

-  tortoise

    -   <https://github.com/neonbjb/tortoise-tts>
    -   <https://git.ecker.tech/mrq/ai-voice-cloning>
    -   <https://github.com/facebookresearch/fairseq/tree/main/examples/mms>

<!--list-separator-->

-  Piper

    -   <https://github.com/rhasspy/piper>

<!--list-separator-->

-  StyleTTS

    -   [StyleTTS2 – open-source Eleven-Labs-quality Text To Speech | Hacker News](https://news.ycombinator.com/item?id=38335255)

<!--list-separator-->

-  HF

    <https://github.com/huggingface/parler-tts>

<!--list-separator-->

-  Others

    -   [Generate audiobooks from E-books with Kokoro-82M | Hacker News](https://news.ycombinator.com/item?id=42708773)


#### STT {#stt}

<!--list-separator-->

-  Whisper

    -   <https://github.com/guillaumekln/faster-whisper>
    -   [Singlish-Whisper: Finetuning ASR for Singapore's Unique English | Jensen Low](https://www.jensenlwt.com/blog/singlish-whisper-finetuning-asr-for-singapore-unique-english) (Custom language fine tuning)


### Scientific Computing {#scientific-computing}

-   [How to solve computational science problems with AI: PINNs | Hacker News](https://news.ycombinator.com/item?id=42769623) (People not a fan)


## Learning Roadmap {#learning-roadmap}


#### Mathematics and Calculus {#mathematics-and-calculus}

<!--list-separator-->

-  1. Linear Algebra

    This is what essentially provides the mathematical framework for understanding and manipulating vectors and matrices, which are the building blocks of almost any ML algorithm. A full grasp of these concepts is **essential**. As always, [Khan Academy](https://www.khanacademy.org) is a great resource. Below are a list of the essentials, along with the appropriate Khan Academy course materials. You can always choose your own course if you wish to.

    1.  [Vectors and Spaces](https://www.khanacademy.org/math/linear-algebra/vectors-and-spaces)
    2.  [Matrices](https://www.khanacademy.org/math/precalculus/x9e81a4f98389efdf:matrices) and [Matrix Transformations](https://www.khanacademy.org/math/linear-algebra/matrix-transformations)

<!--list-separator-->

-  2. Calculus

    Calculus, and particularly derivatives and gradients, play a key role in optimization algorithms used in ML. You will rely on Calculus for optimization techniques such as [gradient descent](https://en.wikipedia.org/wiki/Gradient_descent), and key components of DL such as [Backpropagation](https://en.wikipedia.org/wiki/Backpropagation) - which heavily relies on the chain rule of calculus. Studying integrals and derivatives are fundamental for understanding the rate of change in functions and how they behave, which is crucial for interpreting and modeling real-world use-cases.

    1.  [Integrals](https://www.khanacademy.org/math/integral-calculus/ic-integration)
    2.  [Differential Equations](https://www.khanacademy.org/math/integral-calculus/ic-diff-eq)
    3.  [Application of Integrals](https://www.khanacademy.org/math/integral-calculus/ic-int-app)
    4.  [Parametric equations, polar coordinates, and vector-valued functions](https://www.khanacademy.org/math/integral-calculus/ic-adv-funcs)
    5.  [Series](https://www.khanacademy.org/math/integral-calculus/ic-series)
    6.  [Gradients](https://www.khanacademy.org/math/multivariable-calculus/multivariable-derivatives)

<!--list-separator-->

-  3. Probability and Statistics

    Another essential building-block. Probability theory provides a math framework for quantifying _uncertainty_. In ML, models often need to make predictions or decisions based on incomplete or noisy data. With probability, we can easily express that uncertainty and reason about it. There's myriad other reasons for learning probability, of course; just keep in mind that Language Models generate text by taking your input and calculating the probability distribution of the next sequence of words that would follow it, and pick the most likely output to complete your input text.

    1.  [The Entire Khan Academy Statistics and Probability course](https://www.khanacademy.org/math/statistics-probability)

    > You can take only the lessons you think might be important and then take the Course Challenge.

    1.  Discrete and continuous probability distributions: [binomial](https://www.khanacademy.org/math/math3/x5549cc1686316ba5:binomial-prob) and [normal (Gaussian)](https://www.khanacademy.org/math/math3/x5549cc1686316ba5:normal-dist).
    2.  [Bayesian Statistics](https://dataorigami.net/Probabilistic-Programming-and-Bayesian-Methods-for-Hackers/)

    That should probably be enough for Math. I might've missed a few essential things, but I will add more as I come across them.


#### Programming {#programming}

The current programming language dominating the ML community is **Python**. Not surprising, since the ease of use allows you to focus on writing efficient code without needing to spend too much time learning the intricacies of the language's syntax. There's a good chance you already know Python, but we'll go over the basic steps anyway.

<!--list-separator-->

-  Learn Python Basics

    The `roadmap.sh` [Python Developer roadmap](https://roadmap.sh/python) is an incredibly useful resource for this. What it essentially boils down to, however, is:

    1.  Learn the Basic Syntax and Data Types

    You'll need to familiarize yourself with Python's syntax, variables, data types (integers, floats, strings, lists, dicts), and basic operations (arithmetic, string manipulation, indexing, slicing).

    1.  Control Flow

    Understand conditional statements (`if`, `elif`, `else`), loops (`for`, `while`), and logical operators (`and`, `or`, `not`). Very important for implementing decision-making and repetition in your code.

    1.  Functions and modules

    Learn how to define and use functions to encapsulate reusable blocks of code. Also, you'll need to understand how to import and utilize modules (libs).

    1.  Data Structures and Manipulation

    Get yourself acquainted with fundamental data structures like lists, tuples, sets, and dictionaries. Learn how to manipulate and transform data.

    1.  NumPy

    A fundamental library for scientific computing in Python. You will need to gain proficiency in using NumPy arrays for efficient numerical computations.

    1.  Pandas

    You will often need Pandas DataFrames to clean, transform, filter, aggregate, and analyze your datasets.

    1.  Plotting and Data Visualization

    Become familiar with libraries such as [Matplotlib](https://matplotlib.org/) and [Seaborn](https://seaborn.pydata.org/) for creating plots, charts, and visualization. Not strictly necessary, but recommended.

<!--list-separator-->

-  Learn Advanced Python

    At this stage, you'll be sufficiently familiar with Python and ready to tackle the ML aspects of Python. Very exciting.

    1.  Machine Learning Libraries

    Explore the popular ML libraries, such as [PyTorch](https://www.youtube.com/watch?v=V_xro1bcAuA&), [TensorFlow](https://www.tensorflow.org/resources/learn-ml), or [scikit-learn](https://scikit-learn.org/). It's recommended to focus on only one, and as of now, PyTorch is the most popular.

    1.  Object-Oriented Programming (OOP)

    Get yourself comfortable with the principles of OOP, including classes, objects, inheritance, and encapsulation. Allows for modular and organized code design.


#### Machine Learning Concepts {#machine-learning-concepts}

At this point, you can follow whatever ML course you're comfortable with. A popular recommendation is [fastai](https://course.fast.ai). It's a great resource for almost everything you'll need to learn about ML. Otherwise, pick any of the concepts below that interest you and get to learning.

<!--list-separator-->

-  **Supervised Learning**

    This [Coursera](https://www.coursera.org/learn/machine-learning) curriculum on Supervised ML will be useful. As of writing this guide, the course is completely free. The main points to learn are:

    -   Classification: Predicting discrete class labels.
    -   Regression: Predicting continuous values.

<!--list-separator-->

-  **Unsupervised Learning**

    This [course](https://www.udacity.com/course/machine-learning-unsupervised-learning--ud741) should provide the adequate amount of knowledge on Unsupervised Learning. The main points to learn are:

    -   Clustering: Grouping similar data points together.
    -   Dimensionality Reduction: Reducing the number of input features while preserving important information.
    -   Anomaly Detection: Identifying rare of abnormal instances in the data.

<!--list-separator-->

-  **Reinforcement Learning**

    Coursera provides this [course](https://www.coursera.org/specializations/reinforcement-learning) on Reinforcement Learning, which should be a good starting point.

<!--list-separator-->

-  **Linear Regression**

    This [resource](https://machinelearningmastery.com/linear-regression-for-machine-learning/) should be a useful starting point. The main outtakes are:

    -   Understanding linear regression models and assumptions.
    -   Cost functions, including mean squared error.
    -   Gradient descent for parameter optimization.
    -   Evaluation metrics for regression models.

<!--list-separator-->

-  **Logistic Regression**

    Read through [this resource](https://machinelearningmastery.com/logistic-regression-for-machine-learning/) as a starting point. Main outtakes will be:

    -   Modeling binary classification problems with logistic regression.
    -   Sigmoid function and interpretation of probabilities.
    -   Maximum likelihood estimation and logistic loss.
    -   Regularization techniques for logistic regression.

<!--list-separator-->

-  **Decision Trees and Random Forests**

    This incredible resource by [Jake VanderPlas](https://jakevdp.github.io/PythonDataScienceHandbook/05.08-random-forests.html) should be extremely useful. Main outtake are:

    -   Basics of decision tree learning.
    -   Splitting criteria and handling categorical variables.
    -   Ensemble learning with random forests.
    -   Feature importance and tree visualization.

<!--list-separator-->

-  **Support Vector Machines (SVM)**

    Read through [this resource](https://towardsdatascience.com/support-vector-machine-introduction-to-machine-learning-algorithms-934a444fca47). The main outtakes are:

    -   Formulation of SVMs for binary classification.
    -   Kernel trick and non-linear decision boundaries.
    -   Soft margin and regularization in SVMs.
    -   SVMs for multi-class classification.

<!--list-separator-->

-  **Clustering**

    Read through this excellent [Google for Developers](https://developers.google.com/machine-learning/clustering) course on Clustering. The main outtakes are:

    -   Overview of unsupervised learning and clustering.
    -   K-means clustering algorithm and initialization methods.
    -   Hierarchical clustering and density-based clustering.
    -   Evaluating clustering performance.

<!--list-separator-->

-  **Neural Networks and Deep Learning**

    See [Deep Learning]({{< relref "20250407014803-deep_learning.md" >}})
    The heart of the matter. Read through the papers for each:

    -   [Deep Learning in Neural Networks: an Overview](https://arxiv.org/abs/1404.7828)
    -   [An Introduction to Convolutional Neural Networks](https://arxiv.org/abs/1511.08458)
    -   [Recurrent Neural Networks (RNNs): A gentle Introduction and Overview](https://arxiv.org/abs/1912.05911)
    -   [Three Mechanisms of Weight Decay Regularization](https://arxiv.org/abs/1810.12281)
    -   [Layer Normalization](https://arxiv.org/abs/1607.06450)
    -   [Attention Is All You Need](https://arxiv.org/abs/1706.03762)

<!--list-separator-->

-  **Evaluation and Validation**

    Read the following papers:

    -   [Using J-K fold Cross Validation to Reduce Variance When Tuning NLP Models](https://arxiv.org/abs/1806.07139)
    -   [Leave-One-Out Cross-Validation for Bayesian Model Comparison in Large Data](https://arxiv.org/abs/2001.00980)

    And [this HuggingFace guide](https://huggingface.co/docs/evaluate/types_of_evaluations) on Evaluating ML models.

<!--list-separator-->

-  **Feature Engineering and Dimensionality Reduction**

    Take a look at [this article](https://towardsdatascience.com/feature-selection-and-dimensionality-reduction-f488d1a035de) for a general oveeview.
    Also read these papers:

    -   [Beyond One-hot Encoding: lower dimensional target embedding](https://arxiv.org/abs/1806.10805)
    -   [A Tutorial on Principal Component Analysis](https://arxiv.org/abs/1404.1100)

<!--list-separator-->

-  **Model Selection and Hyperparameter Tuning**

    This is where you're finally dabbling in model training. Good job! You will need to learn:

    -   Grid search, random search, and Bayesian optimization for hyperparameter tuning.
    -   Model selection techniques, including nested cross-validation.
    -   Overfitting, underfitting, and bias-variance tradeoff.
    -   Performance comparison of different models.


## Random Resources {#random-resources}

-   [GPT-2 Neural Network Poetry · Gwern.net](https://gwern.net/gpt-2#fn3)
-   <https://teachablemachine.withgoogle.com/?s=35>


### Explainable AI {#explainable-ai}

-   <https://github.com/slundberg/shap>
-   <https://github.com/marcotcr/lime>
-   <https://github.com/interpretml/interpret/>
-   <https://github.com/slundberg/shap>
-   <https://github.com/MAIF/shapash>
-   <https://github.com/pytorch/captum>
-   <https://github.com/Trusted-AI/AIX360>
