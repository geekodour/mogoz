+++
title = "Information Retrieval"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Information Theory]({{< relref "20221101222235-information_theory.md" >}}), [NLP (Natural Language Processing)]({{< relref "20231123010516-nlp_natural_language_processing.md" >}}), [Machine Learning]({{< relref "20230408190056-machine_learning.md" >}})


See [GitHub - kuutsav/information-retrieval: Neural information retrieval / semantic-search / Bi-Encoders](https://github.com/kuutsav/information-retrieval)


## Theory {#theory}


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


## Search Engines {#search-engines}

You can decompose a "search engine" into multiple big components: `Gather, Search Index, Ranking, Query`


### Gather {#gather}

-   Web crawler/spiders
-   See [Scraping]({{< relref "20230115032823-scraping.md" >}}) and [Archival]({{< relref "20230115032923-archival.md" >}})


### Search Index {#search-index}

-   Database cache of web content
-   aka building the "search index"
-   See [Database]({{< relref "20221102123145-database.md" >}}), [NLP (Natural Language Processing)]({{< relref "20231123010516-nlp_natural_language_processing.md" >}})


### Ranking {#ranking}

-   Algorithm of scoring/weighing/ranking of pages


### Query engine {#query-engine}

-   Translating user inputs into returning the most "relevant" pages
-   See [Query Engines]({{< relref "20231113151855-query_engines.md" >}})


## Semantic Search Resources {#semantic-search-resources}

-   [Spotify-Inspired: Elevating Meilisearch with Hybrid Search and Rust](https://blog.kerollmops.com/spotify-inspired-elevating-meilisearch-with-hybrid-search-and-rust)
-   <https://github.com/josephrmartinez/recipe-dataset/blob/main/tutorial.md>


## <span class="org-todo todo TODO">TODO</span> Full Text Search (FTS) {#full-text-search--fts}

-   Think Wordebut issue has more links
-   [Structure of FTS5 Index in SQLite | Lobsters](https://lobste.rs/s/b3d1ba/structure_fts5_index_sqlite)
-   [Why Full Text Search is Hard](https://transactional.blog/blog/2023-why-full-text-search-is-hard)


## Resources {#resources}

-   [Build a search engine, not a vector DB | Hacker News](https://news.ycombinator.com/item?id=38703943)
