+++
title = "Mapping Ecosystem"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Geography]({{< relref "20221109130937-geography.md" >}}), [Cartography]({{< relref "20240430075801-cartography.md" >}})


## FAQ {#faq}


### What a selfhosted map pipeline looks like? {#what-a-selfhosted-map-pipeline-looks-like}

-   [Release Notes: How to make self-hosted maps that work everywhere and cost next to nothing • MuckRock](https://www.muckrock.com/news/archives/2024/feb/13/release-notes-how-to-make-self-hosted-maps-that-work-everywhere-cost-next-to-nothing-and-might-even-work-in-airplane-mode/)
-   [How to Build a Geospatial Lakehouse, Part 2 - The Databricks Blog](https://www.databricks.com/blog/2022/03/28/building-a-geospatial-lakehouse-part-2.html) (See [Data Engineering]({{< relref "20230405003455-data_engineering.md" >}}))


### What are the different providers? {#what-are-the-different-providers}

-   Map database
-   Geocoder
    -   Why do we need this?
    -   Example: [OpenCage](https://opencagedata.com/)


## Mapping databases {#mapping-databases}


### Players for map Dataset {#players-for-map-dataset}


#### Google Map {#google-map}


#### [OpenStreetMap Stuff]({{< relref "20221109130921-openstreetmap_stuff.md" >}}) {#openstreetmap-stuff--20221109130921-openstreetmap-stuff-dot-md}


#### Apple Maps {#apple-maps}


#### Overture Maps {#overture-maps}

-   Source of data: Unlike OSM, it doesn't rely on a community of mappers who manually update maps. Instead, it aggregates data from a variety of sources such as: sensors, satellites, aerial images, government sources, as well as data provided from its members (e.g. Amazon, Meta, Microsoft, and TomTom).
-   USP: Focussing on enterprise customers
-   But it's cheaper than google maps as it's open
-   See
    -   [ ] [The Overture Maps Foundation: Marc Prioleau - MBM#43 - YouTube](https://www.youtube.com/watch?v=OSK4DlFePzk)
    -   [ ] [Overture Maps Foundation releases open map dataset | Hacker News](https://news.ycombinator.com/item?id=36879461)
    -   [ ] [Overture Maps Foundation Releases Beta of Its First Open Map Dataset | Hacker News](https://news.ycombinator.com/item?id=40057322)
    -   [ ] [Overture's Global Geospatial Datasets](https://tech.marksblogg.com/overture-gis-data.html)


### What do these dataset contain? {#what-do-these-dataset-contain}

These different dataset providers(Google, Apple, OSM, Overture etc.). Non exhaustive.

-   Layers
    -   See [this explanation](https://news.ycombinator.com/item?id=37636551) on OSM layer names
-   Places
-   What else?
