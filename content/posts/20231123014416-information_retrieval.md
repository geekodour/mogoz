+++
title = "Information Retrieval"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Information Theory]({{< relref "20221101222235-information_theory.md" >}}), [NLP (Natural Language Processing)]({{< relref "20231123010516-nlp_natural_language_processing.md" >}}), [Machine Learning]({{< relref "20230408190056-machine_learning.md" >}}), [Embeddings]({{< relref "20240916155700-embeddings.md" >}})


See [GitHub - kuutsav/information-retrieval: Neural information retrieval / semantic-search / Bi-Encoders](https://github.com/kuutsav/information-retrieval)


## Theory {#theory}


### General idea {#general-idea}

-   IR is about scale, you have a huge data you should be able to get things out.
-   There have been traditional methods used but more recently people have also use BERT, [Embeddings]({{< relref "20240916155700-embeddings.md" >}}), even LLMs to do IR tasks.
-   The use of IR can be task specific
    -   For search, you might just want a limited retrival where you return n ranked reponses
    -   For something like fact checking, you'd want it to get everything, run analysis and get back with the result


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


## Recommendation Engines {#recommendation-engines}

-   [GitHub - bytedance/monolith: A Lightweight Recommendation System](https://github.com/bytedance/monolith)


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

-   See [Embeddings]({{< relref "20240916155700-embeddings.md" >}})
-   [Spotify-Inspired: Elevating Meilisearch with Hybrid Search and Rust](https://blog.kerollmops.com/spotify-inspired-elevating-meilisearch-with-hybrid-search-and-rust)
-   <https://github.com/josephrmartinez/recipe-dataset/blob/main/tutorial.md>


## <span class="org-todo todo TODO">TODO</span> Full Text Search (FTS) {#full-text-search--fts}

-   [ParadeDB](https://www.paradedb.com/blog/block_storage_part_one)
-   [Understanding the BM25 full text search algorithm | Evan Schwartz](https://emschwartz.me/understanding-the-bm25-full-text-search-algorithm/)
-   [Structure of FTS5 Index in SQLite | Lobsters](https://lobste.rs/s/b3d1ba/structure_fts5_index_sqlite)
-   [Why Full Text Search is Hard](https://transactional.blog/blog/2023-why-full-text-search-is-hard)
-   [Full text search over Postgres: Elasticsearch vs. alternatives | Hacker News](https://news.ycombinator.com/item?id=41173288)
-   [Meilisearch is too slow](https://blog.kerollmops.com/meilisearch-is-too-slow)
-   [Postgres as a search engine](https://anyblockers.com/posts/postgres-as-a-search-engine)
-   [Hybrid full-text search and vector search with SQLite | Alex Garcia's Blog](https://alexgarcia.xyz/blog/2024/sqlite-vec-hybrid-search/index.html)


### Postgres {#postgres}

-   You would have to build two different indexes, one with pg_trgm and one with tsvector. Alternatively you could use the partial match feature of FTS, with :\*, but that doesn't play well with stemming or with synonyms.


### Meilisearch {#meilisearch}


#### Debugging {#debugging}

Ideally when run in development env, we should have the meilisearch UI
running at MEILI_HTTP_ADDR but I am not sure why it's not exposed. As a
workaround for manual debugging/checks etc. We can use this:
<https://github.com/riccox/meilisearch-ui>


## Resources {#resources}

-   [Build a search engine, not a vector DB | Hacker News](https://news.ycombinator.com/item?id=38703943)
-   [Meilisearch Expands Search Power with Arroy's Filtered Disk ANN](https://blog.kerollmops.com/meilisearch-expands-search-power-with-arroy-s-filtered-disk-ann)
-   [Supercharge vector search with ColBERT rerank in PostgreSQL | Hacker News](https://news.ycombinator.com/item?id=42809990)
    -   [An experiment of adding recommendation engine to your app using pgvector search | Hacker News](https://news.ycombinator.com/item?id=42804406)
-   [How do we evaluate vector-based code retrieval? – Voyage AI](https://blog.voyageai.com/2024/12/04/code-retrieval-eval/) 🌟
