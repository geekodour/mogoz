+++
title = "Information Retrieval"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Information Theory]({{< relref "20221101222235-information_theory.md" >}}), [NLP (Natural Language Processing)]({{< relref "20231123010516-nlp_natural_language_processing.md" >}}), [Machine Learning]({{< relref "20230408190056-machine_learning.md" >}})


See [GitHub - kuutsav/information-retrieval: Neural information retrieval / semantic-search / Bi-Encoders](https://github.com/kuutsav/information-retrieval)


## Forward Index {#forward-index}

-   Eg. Doc123 =&gt; "the","apple","in","tree"
-   Keywords can be marked more or less relevant etc
-   Problems: capitalization, phases, alternate spellings, other stuff.
-   Inverted index can be generated out of it


## Ranking {#ranking}


### TF-IDF (Term Freq. and Inverse Doc. Freq) {#tf-idf--term-freq-dot-and-inverse-doc-dot-freq}

-   Not used too much these days but old OG


#### Formula {#formula}

-   Term Freq: How often word appears in doc
-   Doc Freq: How often word occurs in ALL set of documents. (Tells us that "is" is pretty common)
-   Relevancy =  \\(\frac{Term Freq}{Document Freq}\\)
    -   i.e Term Freq \* 1/Doc Freq
    -   i.e Term Freq \* Inverse Doc Freq
    -   i.e TF-IDF


### Page Rank {#page-rank}

-   Again not used a lot anymore but the algorithm was similar to TF-IDF but includes backlinks and a damping factor into the eqn.


## Search Engines {#search-engines}

You can decompose a "search engine" into multiple big components

-   Gather
    -   Web crawler/spiders
    -   See [Scraping]({{< relref "20230115032823-scraping.md" >}}) and [Archival]({{< relref "20230115032923-archival.md" >}})
-   Search Index
    -   Database cache of web content
    -   aka building the "search index"
    -   See [Database]({{< relref "20221102123145-database.md" >}}), [NLP (Natural Language Processing)]({{< relref "20231123010516-nlp_natural_language_processing.md" >}})
-   Ranking
    -   Algorithm of scoring/weighing/ranking of pages
-   Query engine
    -   Translating user inputs into returning the most "relevant" pages
    -   See [Query Engines]({{< relref "20231113151855-query_engines.md" >}})
