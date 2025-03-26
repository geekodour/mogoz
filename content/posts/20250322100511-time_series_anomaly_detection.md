+++
title = "Time Series / Anomaly Detection / Tabular Data"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Database]({{< relref "20221102123145-database.md" >}}), [Prometheus]({{< relref "20231230172853-prometheus.md" >}}), [Machine Learning]({{< relref "20230408190056-machine_learning.md" >}}), [Statistics]({{< relref "20231017200424-statistics.md" >}}), [Probability]({{< relref "20231126013507-probability.md" >}}), [Representing Time and Date]({{< relref "20231019125530-representing_time_and_date.md" >}})

> See TS section in [Machine Learning]({{< relref "20230408190056-machine_learning.md" >}})


## Things ppl say {#things-ppl-say}

-   An aha moment for me was realizing that the way you can think of anomaly models working is that they’re effectively forecasting the next N steps, and then noticing when the actual measured values are “different enough” from the expected. This is simple to draw on a whiteboard for one signal but when it’s multi variate, pretty neat that it works.


## Links {#links}

-   <https://www.cs.ucr.edu/~eamonn/MatrixProfile.html>
-   <https://promcon.io/2019-munich/slides/improved-alerting-with-prometheus-and-alertmanager.pdf>
-   <https://gitlab-com.gitlab.io/gl-infra/tamland/>
-   <https://huggingface.co/ibm-granite/granite-timeseries-ttm-r1>
