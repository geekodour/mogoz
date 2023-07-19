+++
title = "Data Engineering"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Distributed Systems]({{< relref "20221102130004-distributed_systems.md" >}}), [Database]({{< relref "20221102123145-database.md" >}}), [Caches]({{< relref "20221101214226-caches.md" >}})

{{< figure src="/ox-hugo/data_eng_landscape.jpg" >}}


## Jargons {#jargons}


### Data Lake {#data-lake}

-   Throw data into files like json, csv, parquet into a storage system like s3
-   Used for unstructured data/big data


## Technologies {#technologies}


### Apache Spark {#apache-spark}

{{< figure src="/ox-hugo/20230405003455-data_engineering-993265666.png" >}}

-   An alternative to MapReduce but better


## Information retrieval {#information-retrieval}

-   See [GitHub - kuutsav/information-retrieval: Neural information retrieval / semantic-search / Bi-Encoders](https://github.com/kuutsav/information-retrieval)


### Forward Index {#forward-index}

-   Eg. Doc123 =&gt; "the","apple","in","tree"
-   Keywords can be marked more or less relevant etc
-   Problems: capitalization, phases, alternate spellings, other stuff.
-   Inverted index can be generated out of it


### Ranking {#ranking}


#### TF-IDF (Term Freq. and Inverse Doc. Freq) {#tf-idf--term-freq-dot-and-inverse-doc-dot-freq}

-   Not used too much these days but old OG

<!--list-separator-->

-  Formula

    -   Term Freq: How often word appears in doc
    -   Doc Freq: How often word occurs in ALL set of documents. (Tells us that "is" is pretty common)
    -   Relevancy =  \\(\frac{Term Freq}{Document Freq}\\)
        -   i.e Term Freq \* 1/Doc Freq
        -   i.e Term Freq \* Inverse Doc Freq
        -   i.e TF-IDF


#### Page Rank {#page-rank}

-   Again not used a lot anymore but the algorithm was similar to TF-IDF but includes backlinks and a damping factor into the eqn.


## Caching related problems {#caching-related-problems}


### Hotspots {#hotspots}

-   Horizontally scaled but shit going to the same node. UUID instead of incremental primary key would be a saver.


### Cold start {#cold-start}

-   If cache crashes, all high traffic goes to db and db can crash again, so we need some way to warm up the cache beforehand


## Processing Types {#processing-types}


### Batch processing {#batch-processing}


### Stream processing {#stream-processing}

-   This can mean different things for different people, eg. for some ingestion pipeline, streaming might just means anything ingesting more often than every ten minutes.


## Links {#links}

-   [Wide Column Store NoSQL vs SQL Data Modeling - YouTube](https://www.youtube.com/watch?v=bTEfRmdBq7I&t=457s)
-   [Scalable Efficient Big Data Pipeline Architecture – Machine Learning for Developers](https://www.ml4devs.com/articles/scalable-efficient-big-data-analytics-machine-learning-pipeline-architecture-on-cloud/)
