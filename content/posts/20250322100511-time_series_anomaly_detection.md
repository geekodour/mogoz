+++
title = "Time Series / Anomaly Detection / Tabular Data"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Database]({{< relref "20221102123145-database.md" >}}), [Prometheus]({{< relref "20231230172853-prometheus.md" >}}), [Machine Learning]({{< relref "20230408190056-machine_learning.md" >}}), [Statistics]({{< relref "20231017200424-statistics.md" >}}), [Probability]({{< relref "20231126013507-probability.md" >}}), [Representing Time and Date]({{< relref "20231019125530-representing_time_and_date.md" >}})

> See TS section in [Machine Learning]({{< relref "20230408190056-machine_learning.md" >}})


## FAQ {#faq}


### What are the different methods {#what-are-the-different-methods}


#### Comparison Table {#comparison-table}

| Method                        | Category              | Desc/Features                                            | Use Cases/Strengths                              | Weaknesses                              | Introduced   |
|-------------------------------|-----------------------|----------------------------------------------------------|--------------------------------------------------|-----------------------------------------|--------------|
| **Classical/Statistical**     |                       |                                                          |                                                  |                                         |              |
|                               |                       |                                                          |                                                  |                                         |              |
| Naive/Seasonal Naive          | Statistical           | Forecast = last / last seasonal value                    | Baseline; simple; fast                           | Assumes persistence; often inaccurate   | Foundational |
| Simple Exp. Smooth (SES)      | Statistical           | Weighted avg; models level                               | Univar; no trend/season; simple                  | No trend/season handling                | ~1950s       |
| Holt's Linear Trend           | Statistical           | SES + linear trend                                       | Univar; trend; simple                            | Assumes linear trend; no season         | ~1957        |
| Holt-Winters                  | Statistical           | Holt + seasonality (add/mult)                            | Univar; trend &amp; season; good benchmark       | Assumes fixed patterns                  | ~1960        |
| ETS                           | Statistical           | State-space framework for ES; auto-selects               | General univar; robust; auto-select; prob.       | Univar only; assumes state-space        | ~2002        |
| ARIMA/SARIMA                  | Statistical           | Models autocorrelation (AR+I+MA); SARIMA=seasonal        | Univar; models autocorrelation; benchmark; prob. | Requires stationarity; param tuning     | ~1970        |
| Theta Method                  | Statistical           | Decompose + damped linear extrapolation                  | Univar; strong M3/M4 perf.; simple               | Less intuitive; mainly univar           | ~2000        |
| VAR                           | Statistical           | Multivariate AR; models linear interdep.                 | Multivar linear interactions; interp.            | Assumes linearity; needs stationarity   | ~1980        |
| TAR/SETAR/STAR                | Statistical           | Threshold AR; regime-switching; nonlinear                | Nonlinear univar w/ regimes                      | Complex thresholds; mainly univar       | ~1978        |
| INLA                          | Bayesian Stat.        | Approx. Bayesian inference; latent Gaussian              | Complex models; hierarchy; uncertainty (prob.)   | Approx. method; learning curve          | ~2009        |
| Prophet                       | Statistical/Curve Fit | Decompose trend/season/holidays; Bayesian                | Univar; strong season/holidays; robust; prob.    | Less accurate on some benchmarks        | ~2017        |
| **Machine Learning &amp; DL** |                       | (Often need more data; less interpretable)               | (Can model complex nonlinearity/interactions)    | (Compute intensive; tuning crucial)     |              |
|                               |                       |                                                          |                                                  |                                         |              |
| Tree-based (RF, XGB...)       | **ML**                | Uses lagged/derived features in trees/ensembles          | Nonlinearity/interactions; feature imp.; robust  | Needs features; no trend extrap.        | ~1984+       |
| SVR                           | **ML**                | SVM for regression; uses tolerance margin                | Robust to outliers; high-dim features            | Less intuitive; kernel/param sensitive  | ~1996        |
| Gaussian Processes (GP)       | **Bayesian ML**       | Non-parametric; models distribution over func.           | Probabilistic; complex nonlinear; flex.          | Slow (cubic); kernel tuning difficult   | ~2006        |
| MLP                           | **DL**                | Feedforward NN; needs lagged features                    | General nonlinear; covariates                    | Needs features; tuning; can overfit     | ~1980s       |
| RNN                           | **DL**                | NN w/ loops for sequence processing                      | Sequential data; time dependencies               | Vanishing gradients; often outperformed | ~1980s       |
| LSTM                          | **DL**                | RNN w/ gates for long dependencies                       | Complex seq; long dependency; multivar           | Needs data; slow; tuning; can overfit   | ~1997        |
| GRU                           | **DL**                | Simpler LSTM variant; similar perf.                      | Like LSTM; potentially faster                    | Like LSTM; needs data; tuning           | ~2014        |
| CNN (1D)                      | **DL**                | Uses convolutions for sequence feature extraction        | Feature extraction; fast pattern recog.          | Less natural for long dependencies      | ~1989/2012   |
| DeepAR/DeepVAR                | **DL**                | Autoregressive RNN outputs distribution params           | Probabilistic forecast; covariates; global       | Needs lots of data; complex; slow train | ~2017        |
| N-BEATS                       | **DL**                | Non-recurrent NN; basis expansion; interp.               | Univar; state-of-art M4/M3; interp.              | Mainly univar; compute intensive        | ~2019        |
| Transformer Variants          | **DL**                | Self-attention mechanism; parallel processing            | Long dependencies; parallel; multivar            | Data hungry; quadratic complexity       | ~2017+       |
| Samformer                     | **DL**                | Transformer variant                                      | (Specific capabilities TBD)                      | (Likely transformer limitations)        | Recent       |
| TabPFN (Time Series)          | **DL**                | Transformer for **small** tabular data; **zero-shot TS** | Small datasets; little tuning needed             | Newer; focus on specific niche          | ~2024        |


#### Additional notes {#additional-notes}

> For time-series forecasting, we can either use
>
> -   Deep learning
> -   Traditional ML/stats methods
> -   "In my projects, DL models outperform both statistical and ML methods in datasets with higher frequencies (hourly or more). I use TFT, NHITS, and a customized TSMixer. The most underrated statistical model that I often use is DynamicOptimizedTheta."

<!--list-separator-->

-  Traditional based

    -   XGBoost
    -   <https://github.com/facebook/prophet>
    -   <https://github.com/sktime/sktime>

<!--list-separator-->

-  DL based

    DL was better for probabilistic time series forecasting when trying to quantify uncertainty. But based on ppl on the internet DL is not good for time series forcasting.

    -   <https://github.com/romilbert/samformer>
    -   nixtla
        -   <https://github.com/Nixtla/neuralforecast>
        -   <https://github.com/Nixtla/statsforecast>
            -   in many cases their `statsforecast` implementation Beats `Prophet` in terms of Speed and accuracy
    -   [CARTE-AI Documentation — CARTE-AI 1.0.0 documentation](https://soda-inria.github.io/carte/)
    -   TabPFN 🌟
        -   [Show HN: TabPFN v2 – A SOTA foundation model for small tabular data | Hacker News](https://news.ycombinator.com/item?id=42647343)
        -   [GitHub - PriorLabs/tabpfn-time-series: Zero-shot Time Series Forecasting with TabPFN (work accepted at NeurIPS 2024 TRL and TSALM workshops)](https://github.com/PriorLabs/tabpfn-time-series)
        -   [GitHub - PriorLabs/tabpfn-extensions at dbc3f5da25821135602fdc4d95cc8c217afbc3b0](https://github.com/PriorLabs/tabpfn-extensions/tree/dbc3f5da25821135602fdc4d95cc8c217afbc3b0)

<!--list-separator-->

-  LLM Based

    > The fundamental challenge is that LLMs like O1 and Claude 3.5 simply aren't built for the unique structures of tabular data. When processing tables through LLMs, the inefficiencies quickly become apparent - tokenizing a 10,000 x 100 table as a sequence and numerical values as tokens creates massive inefficiencies.
    >
    > There's some interesting work on using LLMs for tabular data (TabLLM: [TabLLM: Few-shot Classification of Tabular Data with Large Language Models](https://proceedings.mlr.press/v206/hegselmann23a.html)), but this only works for datasets with tens of samples rather than the thousands of rows needed in real-world applications.
    >
    > What o1 and other LLMs typically do is wrap around existing tabular tools like XGBoost or scikit-learn. While this works, they're ultimately constrained by these tools' limitations. We're taking a fundamentally different approach - building foundation models that natively understand tabular relationships and patterns. Our approach combines the benefits of foundation models with architectures specifically designed for tabular data structures.


## Things ppl say {#things-ppl-say}

-   An aha moment for me was realizing that the way you can think of anomaly models working is that they’re effectively forecasting the next N steps, and then noticing when the actual measured values are “different enough” from the expected. This is simple to draw on a whiteboard for one signal but when it’s multi variate, pretty neat that it works.


## Links {#links}

-   <https://www.cs.ucr.edu/~eamonn/MatrixProfile.html>
-   <https://promcon.io/2019-munich/slides/improved-alerting-with-prometheus-and-alertmanager.pdf>
-   <https://gitlab-com.gitlab.io/gl-infra/tamland/>
-   <https://huggingface.co/ibm-granite/granite-timeseries-ttm-r1>
