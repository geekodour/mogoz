+++
title = "Mapping Ecosystem"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Geography]({{< relref "20221109130937-geography.md" >}}), [Cartography]({{< relref "20240430075801-cartography.md" >}}), [OpenStreetMap Stuff]({{< relref "20221109130921-openstreetmap_stuff.md" >}}), [Web Animation]({{< relref "20221109214315-web_animation.md" >}})


## <span class="org-todo todo TODO">TODO</span> Tooling Ecosystem {#tooling-ecosystem}


### <span class="org-todo todo TODO">TODO</span> Tooling combinations in the wild! 🐘 {#tooling-combinations-in-the-wild}


## FAQ {#faq}


### What a selfhosted map pipeline looks like? {#what-a-selfhosted-map-pipeline-looks-like}

-   [Release Notes: How to make self-hosted maps that work everywhere and cost next to nothing • MuckRock](https://www.muckrock.com/news/archives/2024/feb/13/release-notes-how-to-make-self-hosted-maps-that-work-everywhere-cost-next-to-nothing-and-might-even-work-in-airplane-mode/)
-   [How to Build a Geospatial Lakehouse, Part 2 - The Databricks Blog](https://www.databricks.com/blog/2022/03/28/building-a-geospatial-lakehouse-part-2.html) (See [Data Engineering]({{< relref "20230405003455-data_engineering.md" >}}))
-   <https://kschaul.com/post/2023/02/16/how-the-post-is-replacing-mapbox-with-open-source-solutions/>
-   [Creating Self-Hosted Tile Maps from OpenStreetMap Data | Lobsters](https://lobste.rs/s/84wg6t/creating_self_hosted_tile_maps_from)
-   [Show HN: ServerlessMaps – Host your own maps in the cloud | Hacker News](https://news.ycombinator.com/item?id=40464104)
-   Protomaps
    -   [Self-hosted vector tiles | Hacker News](https://news.ycombinator.com/item?id=34530217)
    -   [rtnf's Diary | Self-hosted vector tiles. | OpenStreetMap](https://www.openstreetmap.org/user/rtnf/diary/400836)
    -   For vector, see: [2024: The year of the OpenStreetMap vector maps | Hacker News](https://news.ycombinator.com/item?id=39339182)
    -   [Protomaps - vector tiles without the tile server - YouTube](https://www.youtube.com/watch?v=dF9UuVKOf34)
    -   [Protomaps | A serverless system for planet-scale maps](https://protomaps.com/)


### Confusion around raster and vector {#confusion-around-raster-and-vector}

> So there's two types of raster and vector.
>
> -   raster and vector data formats
> -   raster and vector tile formats

| Feature          | Data Formats                         | Tile Formats                                  |
|------------------|--------------------------------------|-----------------------------------------------|
| Primary Use      | Storage, Analysis, Editing, Exchange | Web/Mobile Delivery, Rendering                |
| Structure        | Complete dataset, complex structures | Small, standardized chunks (tiles), Z/X/Y     |
| Optimization     | Data integrity, analysis efficiency  | Network transfer speed, rendering performance |
| Styling (Vector) | N/A (Data only)                      | Applied client-side (Vector Tiles)            |
| Styling (Raster) | N/A (Pixel values)                   | Baked into the image (Raster Tiles)           |
| Size             | Can be very large                    | Individual tiles are small                    |


#### Conversion Between Formats {#conversion-between-formats}

-   **Data Format -&gt; Tile Format (Tiling)**: This is the most common conversion direction for web mapping.
    -   You take a **Vector Data Format** (e.g., `GeoPackage`, `PostGIS` data) and use tools (like `Tippecanoe`, `Planetiler`, `QGIS`, `ArcGIS`, `TileServer GL`, `PostGIS ST_AsMVT`) to generate **Vector Tiles** (`.mvt`).
    -   You take a **Vector Data Format** and use rendering tools (like `Mapnik`, often integrated into tile servers) combined with a style definition to generate **Raster Tiles** (`.png`, `.jpg`).
    -   You take a **Raster Data Format** (e.g., `GeoTIFF`) and use tools (like `GDAL gdal2tiles.py`, `QGIS`, `ArcGIS`, `MapTiler Engine`) to chop it up into **Raster Tiles** (`.png`, `.jpg`).
-   **Tile Format -&gt; Data Format**: This is less common but possible for some scenarios. For example, you could potentially stitch many raster tiles back into a larger `GeoTIFF`, or parse vector tiles to extract features back into `GeoJSON` (though often with simplification/data loss compared to the original source).
-   **Data Format -&gt; Data Format**: Conversion between different source data formats is routine using tools like `GDAL/OGR`, `QGIS`, `ArcGIS` (e.g., `Shapefile` to `GeoPackage`, `GeoJSON` to `PostGIS`).
-   **Raster Data Format -&gt; Vector Data Format (Vectorization)**: This is not simple conversion but rather feature extraction. It uses image processing algorithms to identify patterns (like roads or buildings) in raster imagery and create corresponding vector features. This is a complex process.
    -   Example: [GitHub - nypl-spacetime/map-vectorizer: An open-source map vectorizer](https://github.com/nypl-spacetime/map-vectorizer)


### Why OpenStreetMap.org Still Uses Raster Tiles (Standard Layer) {#why-openstreetmap-dot-org-still-uses-raster-tiles--standard-layer}

-   **Legacy &amp; Infrastructure:** Mature, optimized Mapnik raster stack exists. Switching is complex.
-   **Cartographic Detail:** Replicating the dense, specific OSM Carto style purely client-side is very hard performance-wise. Raster allows complex server rendering.
-   **Primary Purpose:** Fast visual feedback for mappers is key; raster provides consistent view of edits.
-   **Compute Costs &amp; Focus:** High-detail vector tile generation/updates are resource-intensive. Focus may be on providing **usable** vector data first (e.g., Shortbread schema).
-   **Good Enough:** High-quality raster meets basic map viewing needs well.


## The Ecosystem {#the-ecosystem}


### Phases {#phases}


#### Phase 1: Raw Geographic Data (The Raw Materials) {#phase-1-raw-geographic-data--the-raw-materials}

<!--list-separator-->

-  Data Sources: Where does the information about the world come from?

    -   **OpenStreetMap (OSM)**: A massive, global, community-driven database of geographic features (roads, buildings, points of interest - POIs, land use, etc.). Think of it like Wikipedia for maps. It's raw data.
    -   **Overture Maps Foundation**: A newer initiative (by Meta, Amazon, Microsoft, TomTom) aiming to create an open map dataset by combining data from multiple sources (including their own, government data, and potentially OSM). Like OSM, it provides raw data, structured into layers (e.g., Places, Buildings, Transportation, Administrative Boundaries). Its goal is often seen as providing a reliable, curated open alternative for enterprise use cases, potentially competing with proprietary sources.
    -   **Proprietary Data Providers**: Companies like Google, HERE, TomTom have their own extensive (and often expensive) datasets collected through vehicles, satellites, partnerships, etc.
    -   **Government Data**: National mapping agencies, census bureaus, local governments often provide authoritative data (boundaries, addresses, infrastructure).
    -   **Satellite/Aerial Imagery**: Companies like Maxar, Planet, Airbus, and government programs (like Sentinel, Landsat) provide raster images of the Earth's surface.

<!--list-separator-->

-  Data Formats (Storing the Raw Materials): How is this raw geographic data stored in files?

    -   See [Shapefile must die!](http://switchfromshapefile.org/)

    <!--list-separator-->

    -  Vector Formats (Points, Lines, Polygons)

        | Format         | Year | Structure             | Key Feature(s) / Use Case                                                                     | Recommendation / Status           |
        |----------------|------|-----------------------|-----------------------------------------------------------------------------------------------|-----------------------------------|
        | **Shapefile**  | 1993 | Multi-file (3+)       | Legacy ESRI format, widely used but clunky (size/name limits).                                | Avoid for new projects.           |
        | **GeoJSON**    | 2008 | Single JSON (text)    | Web standard (RFC), human-readable, excellent for web APIs/JS. Inefficient large data.        | Good for web, smaller datasets    |
        | **TopoJSON**   | 2012 | Single JSON (text)    | GeoJSON extension, preserves topology, smaller files than GeoJSON.                            | Use for topology/web size opt.    |
        | **GeoPackage** | 2014 | Single SQLite (.gpkg) | OGC Standard, versatile (vector, raster, metadata, styles), robust single file.               | Recommended Shapefile replacement |
        | **FlatGeobuf** | 2018 | Single Binary (.fgb)  | Cloud-optimized (HTTP range requests), spatial index, efficient streaming/direct web use.     | Great for cloud/web access        |
        | **GeoParquet** | 2022 | Single Columnar       | Apache Parquet + geo extensions, data science friendly, efficient large attributes/analytics. | Best for analytics/big data       |
        | **GeoArrow**   | 2023 | In-memory Columnar    | Apache Arrow based, high-performance in-memory analytics, RAM-bound.                          | High-performance computation      |

    <!--list-separator-->

    -  Raster Formats (Grids of Pixels)

        | Format                            | Year    | Structure / Key Feature                                      | Use Case / Recommendation                                         |
        |-----------------------------------|---------|--------------------------------------------------------------|-------------------------------------------------------------------|
        | **GeoTIFF**                       | 1995    | TIFF + Geo metadata, Industry Standard, robust.              | Baseline standard, local storage/processing. Not cloud-optimized. |
        | **Cloud Optimized GeoTIFF (COG)** | 2016    | Structured GeoTIFF for HTTP range requests. Cloud-optimized. | Standard for cloud storage and web distribution (WMS/WCS like).   |
        | **Zarr Geospatial**               | 2022-23 | Chunked multi-dimensional arrays. Cloud-optimized, scalable. | Modern cloud-native format, large multi-dim data, analysis-ready. |

    <!--list-separator-->

    -  Hybrid / Experimental Formats

        | Format               | Year | Description / Goal                                            | Status       |
        |----------------------|------|---------------------------------------------------------------|--------------|
        | **COG.zarr**         | 2023 | Combines COG structure with Zarr multi-dimensional capability | Emerging     |
        | **VectorTiles.zarr** | 2023 | Applies Zarr concepts (chunking, cloud) to vector tiles       | Experimental |


#### Phase 2: Data Processing &amp; Storage (The Workshop &amp; Warehouse) {#phase-2-data-processing-and-storage--the-workshop-and-warehouse}

<!--list-separator-->

-  Geospatial Databases

    > For managing, querying, and manipulating large amounts of geographic data efficiently.

    -   **PostGIS** (Extension for PostgreSQL): The Gold Standard. Adds powerful spatial data types, functions, and indexing to the robust PostgreSQL database. Industry standard for serious geospatial applications.
    -   DuckDB: spatial query support, especially with GeoParquet.
    -   **SpatiaLite** (Extension for SQLite): Adds spatial capabilities to SQLite. Good for single-file databases, mobile apps, or simpler projects where a full server isn't needed. GeoPackage is built on SQLite.
    -   OSMExpress (not a db but a way to store things)
    -   (Others: SQL Server Spatial, Oracle Spatial, etc.)

<!--list-separator-->

-  Processing Tools

    > Software to clean, transform, analyze, and prepare the data.

    | Category                    | Tool         | Description                                       |
    |-----------------------------|--------------|---------------------------------------------------|
    | **GIS Software**            | QGIS         | Full-featured desktop GIS application             |
    |                             | ArcGIS       | Industry-standard GIS platform                    |
    |                             | GRASS GIS    | Geospatial data management and analysis           |
    |                             | gvSIG        | Desktop GIS for vector and raster data            |
    | **Command-line Tools(cli)** | GDAL/ogr2ogr | Geospatial data conversion and processing library |


#### Phase 3: Tiling &amp; Serving (The Delivery Network) {#phase-3-tiling-and-serving--the-delivery-network}

> -   [Tiled web map - Wikipedia](https://en.wikipedia.org/wiki/Tiled_web_map) (Important Read)
> -   Problem: Raw geographic data (even processed) is often too large to send directly to a web browser efficiently, especially for a whole country or the world.
> -   Solution: Tiling. At different zoom-levels, break the map down into:
>     -   small square images (Raster Tiles)
>     -   data chunks (Vector Tiles)

<!--list-separator-->

-  Raster vs Vector tiles

    <!--list-separator-->

    -  What?

        > (combining both) is very common and powerful. using layers.

        <!--list-separator-->

        -  Raster Tiles

            -   **What:** Grid of pre-rendered static image files (PNG, JPG).
            -   **How:** Server renders map features + style into pixels. Client displays image mosaic.
            -   **Analogy:** Pre-printed map cut into squares.

        <!--list-separator-->

        -  Vector Tiles (MVT - Mapbox Vector Tiles standard)

            -   **What:** Grid of files with geographic data (points, lines, polygons) + attributes. **No** style info. Compact format (protobuf).
            -   **How:** Server sends raw data tiles. Client uses library (MapLibre GL JS, etc.) + separate **style file** (JSON) to render dynamically (often GPU accelerated).
            -   **Analogy:** Blueprints + instructions (style file) to draw the map on the spot.

    <!--list-separator-->

    -  Detailed Analysis

        <!--list-separator-->

        -  Rendering &amp; Visuals

            -   **Raster:**
                -   **Pros:** Consistent (WYSIWYG), handles complex server-side cartography, good for imagery/hillshade.
                -   **Cons:** Pixelated when overzoomed, static labels/symbols (no smooth scale/rotate), distorted on tilt.
            -   **Vector (MVT):**
                -   **Pros:** Sharp at any zoom ("infinite zoom"), smooth scaling/rotation/tilt with dynamic labels.
                -   **Cons:** Client hardware/library dependent, complex client-side cartography is challenging, potential minor rendering variations.

        <!--list-separator-->

        -  Styling &amp; Customization

            -   **Raster:**
                -   **Styling:** Server-side only, baked into images.
                -   **Flexibility:** Very limited client-side (opacity, basic filters). Style change requires server re-render.
            -   **Vector (MVT):**
                -   **Styling:** Separate **style file** (e.g., Mapbox Style Spec JSON), applied **client-side**.
                -   **Flexibility:** Extremely high. Dynamic style changes (dark mode, filtering), data-driven styling possible without refetching tiles.

        <!--list-separator-->

        -  Data &amp; Interactivity

            -   **Raster:**
                -   **Data:** Only pixels. No underlying feature data.
                -   **Interactivity:** Limited. Requires separate API calls for feature info.
            -   **Vector (MVT):**
                -   **Data:** Contains geographic features + attributes.
                -   **Interactivity:** High. Client-side query/interaction (click/hover), feature highlighting, layer toggling.

        <!--list-separator-->

        -  Performance &amp; Efficiency

            -   **Raster:**
                -   **Client Load:** Low (displaying images). Good for low-power devices.
                -   **Server Load (Rendering):** Potentially very high (image generation).
                -   **Bandwidth/Storage:** Can be large, especially with multiple styles/updates.
            -   **Vector (MVT):**
                -   **Client Load:** Higher (rendering). Needs decent JS/GPU.
                -   **Server Load (Generation):** Often less than raster rendering; shifts load to client.
                -   **Bandwidth/Storage:** Often smaller tiles (esp. sparse areas). Styles are small. **BUT** overly detailed tiles can be large/slow.

        <!--list-separator-->

        -  Workflows

            -   **Raster Tile Workflow:**
                -   Data Prep -&gt; Server-Side Styling (Mapnik, etc.) -&gt; Tile Generation (renderd, MapProxy) -&gt; Serve Images (Web Server)
            -   **Vector Tile (MVT) Workflow:**
                -   Data Prep -&gt; Tile Generation (Tippecanoe, PostGIS ST_AsMVT, etc.) -&gt; Serve Tiles (.pbf) -&gt; Create Style File (JSON) -&gt; Client Library Renders (MapLibre GL JS)

    <!--list-separator-->

    -  Combining Raster and Vector Tiles

        -   **How:** Easily layered using client libraries (Leaflet, MapLibre, OpenLayers).
        -   **Why:** Get the best of both worlds.
        -   **Common Examples:**
            -   Satellite/Aerial (Raster) + Labels/Roads (Vector)
            -   Vector Basemap + Hillshade (Raster)
            -   Vector Basemap + Weather Radar (Raster)

    <!--list-separator-->

    -  Key Considerations

        -   **Detail vs. Performance (Vector):** Too much detail -&gt; large tiles, slow client rendering. Generalization is key.
        -   **Client-Side Complexity (Vector):** Needs capable devices; involves understanding style specs &amp; rendering libs.
        -   **Styling Effort (Vector):** Creating rich styles takes effort; pre-existing styles are common.
        -   **Tooling:** Different ecosystems for raster vs. vector generation/styling.
        -   **Cost:** Generation, storage, bandwidth trade-offs. Vector **serving** often cheaper.
        -   **Offline Use:** Vector often more efficient for offline storage.

    <!--list-separator-->

    -  Styling concerns w Vector tiles

        <!--list-separator-->

        -  Issue: Sophisticated Labeling &amp; Cartography (Non-Marker Text)

            -   **Concern:** Client-side rendering still struggles with complex placement and avoidance rules for **linear features** (street names, river names) and **area labels** (neighborhoods, parks) compared to server-side raster rendering, especially in dense areas.
            -   **Impact of Client-Side Markers:** This issue remains largely unchanged, as it pertains to labels intrinsically linked to lines and polygons within the base map data, not separate point markers added on top.
            -   **Example:** On the dense street network of central Tokyo, a server-rendered raster tile (like OSM.org's standard layer) can use advanced algorithms to elegantly curve street names and place district labels clearly. A client-side vector renderer might show fewer street names or place area labels less optimally to maintain performance, affecting readability. Client-side **markers** for POIs don't solve this **base map labeling challenge**.

        <!--list-separator-->

        -  Issue: Client Performance Burden (Base Map + Markers)

            -   **Concern:** Rendering a **detailed vector base map** (complex buildings, land use, road networks) **plus** potentially hundreds or thousands of **dynamic client-side markers** can still heavily load the user's device.
            -   **Impact of Client-Side Markers:** While styling POIs **within** the vector tile adds load, rendering them as client-side markers also consumes resources (`DOM` manipulation or `canvas` drawing, potential clustering logic). The combined load of rendering a detailed vector base **and** many markers can exceed that of rendering a simple raster base **and** the same markers.
            -   **Example:** Imagine a vector map showing detailed building footprints and intricate road casings, **plus** displaying 100 client-side markers for nearby restaurants fetched from an API. The client needs `GPU/CPU` power for both the vector base and the marker layer. A simpler pre-rendered raster base map showing only roads and landuse **plus** the same 100 markers might offer smoother performance on lower-end devices because the base map rendering is trivial.

        <!--list-separator-->

        -  Issue: Data Density &amp; Filtering Needs (Attributes in Tiles)

            -   **Concern:** If the vector tiles themselves need to contain rich attribute data **to enable client-side filtering or complex base map styling** (beyond just placing markers), the tiles can become large and slow to process, even if final POI display uses markers.
            -   **Impact of Client-Side Markers:** If you only need POI locations fetched from a separate API for markers, this isn't an issue **for the vector tile size**. But if you want to, say, style **roads** differently based on 10 surface types or filter **buildings** by age directly from vector tile attributes, you need that data **in the tiles**, increasing their size.
            -   **Example:** A style needs to color different **land use polygons** (residential, commercial, industrial, retail, meadow, forest - 6 types) directly from the vector tile data. The `landuse` attribute must be in the polygon features within the tile. If you **also** fetch POIs separately for markers, that's fine, but the base map tile size is still affected by the attributes **it** needs for its own styling. A raster tile pre-renders the colors, requiring no `landuse` attribute transfer to the client.

        <!--list-separator-->

        -  Issue: Complex/Custom Visual Effects (Non-Marker Styling)

            -   **Concern:** Achieving specific visual styles for **lines** (e.g., patterned railways) or **areas** (e.g., textured fills for parks, specific water patterns) remains easier or higher fidelity with server-side raster rendering.
            -   **Impact of Client-Side Markers:** How POI markers are displayed doesn't affect the difficulty of applying complex patterns or textures to lines and polygons defined within the vector tile style specification.
            -   **Example:** Creating a vintage map style requires rendering water bodies with subtle, wavy line patterns. A server-side raster engine can do this easily. Achieving the exact same artistic effect using only standard vector tile styling properties for polygons might be difficult or look less refined.

        <!--list-separator-->

        -  Issue: Guaranteed Visual Consistency (Base Map Rendering)

            -   **Concern:** The rendering of the **base map features** (roads, buildings, landuse polygons, non-marker labels) styled from vector tiles might have minor variations across platforms, while raster base tiles are identical everywhere.
            -   **Impact of Client-Side Markers:** While the **markers themselves** might be rendered consistently (e.g., if they are simple `<img>` tags), their appearance **relative** to a potentially slightly differently rendered vector base map could vary. A raster base map provides an absolutely consistent background.
            -   **Example:** A design requires road casings to perfectly align with underlying land use color boundaries. Slight variations in vector rendering might cause tiny gaps or overlaps on some devices. Pre-rendered raster tiles ensure the alignment is pixel-perfect and identical for all users, providing a completely consistent canvas for any client-side markers placed on top.

<!--list-separator-->

-  Tile Formats

    > -   See: Tile formats: <https://maptilesexplorer.geekodour.org/> 🌟
    > -   See: [mapbox/awesome-vector-tiles](https://github.com/mapbox/awesome-vector-tiles)
    > -   See: [You Might Not Want PMTiles - Protomaps Blog](https://protomaps.com/blog/you-might-not-want-pmtiles/)
    > -   See: [Serving a custom vector web map using PMTiles and maplibre-gl | Simon Willison’s TILs](https://til.simonwillison.net/gis/pmtiles)

    -   **Raster Tiles**: Pre-rendered images (PNG, JPG). Simple, universally compatible, but styling is fixed, and they can be large.
    -   **Vector Tiles** (`.mvt`, `.pbf`): Contain geometric data (points, lines, polygons) and attributes, compressed into protocol buffers. Rendered client-side by the browser/app. This allows for dynamic styling, smooth zooming, smaller file sizes, and interaction with features. Mapbox Vector Tile (MVT) is the de facto standard.
    -   **PMTiles** (`.pmtiles`): A clever container format for Vector Tiles. It packages potentially millions of tiles into a single file that can be hosted on simple storage (like AWS S3, GitHub Pages). It uses HTTP range requests so the client only downloads the necessary parts of the single file, behaving like a tile server without needing an active server process. Great for serverless/static hosting. Protomaps developed this format.

<!--list-separator-->

-  Tile Generation (Creating the Tiles)

    > -   Tile generation is the crucial step of converting detailed source data into web-optimized chunks. The process differs significantly depending on whether you need pre-styled images (raster tiles) or raw data for client-side styling (vector tiles)
    > -   To take large, complex geographic datasets and systematically slice them into a pyramid of square tiles, typically following the Slippy Map Tilenames convention (`Zoom/X/Y`). Each tile covers a specific geographic area at a specific level of detail (zoom level).

    <!--list-separator-->

    -  General Steps Involved (Common to Both Raster and Vector)

        -   **Input Data**: Specify the source dataset(s).
            -   Usually processed data from Phase 2 (e.g., a `GeoPackage` file, data in a `PostGIS` database, a large `GeoTIFF`).
        -   **Configuration**: Define the parameters for the tiling process:
            -   **Zoom Levels**: Specify the range of zoom levels to generate (e.g., min zoom 0 to max zoom 14). Lower zooms show less detail over large areas; higher zooms show more detail over smaller areas.
            -   **Output Format**: Choose **Raster** (`PNG`, `JPG`) or **Vector** (`MVT`).
            -   **Output Structure**: Decide whether to output tiles as individual files in a `Z/X/Y` directory structure or package them into a container format like `MBTiles` (SQLite database) or `PMTiles` (single static file).
            -   **Bounding Box (Optional)**: Limit tile generation to a specific geographic region.
            -   **Tool-Specific Options**: Each tool will have many options controlling simplification, attribute handling, parallel processing, etc.
        -   **Processing (Iteration)**: The tool iterates through each specified zoom level (`Z`).
            -   For each zoom level, it calculates the grid of `X` and `Y` tile coordinates covering the target area.
            -   For each `Z/X/Y` combination, it performs the core generation step (detailed below for raster/vector).
            -   This is often computationally intensive and can be parallelized.
        -   **Output**: The generated tiles (image files or data blobs) are saved to the specified output structure (directories or container file).

    <!--list-separator-->

    -  Differences in the Core Generation Step: Raster vs. Vector

        <!--list-separator-->

        -  Raster Tile Generation

            -   **Goal**: To create pre-rendered image tiles where the visual style is baked in.
            -   **Input**: Can be either:
                -   Source Raster Data (e.g., `GeoTIFF` satellite image, elevation model).
                -   Source Vector Data plus a Style Definition (e.g., rules defining road colors, label fonts).
            -   **Core Process (per tile)**:
                -   **Identify Source Data**: Determine which part of the source raster or which vector features fall within the current tile's geographic boundary.
                -   **Apply Styling (if input is vector)**: Use a rendering engine (like `Mapnik` or the engine within `QGIS/ArcGIS`) to apply the defined style rules (colors, line widths, label placement) to the vector data for that tile's extent and zoom level.
                -   **Render Pixels**: Create an image (typically 256x256 or 512x512 pixels) representing the styled vector data or the corresponding portion of the source raster data. This might involve resampling/rescaling source raster pixels.
                -   **Encode Image**: Save the rendered pixels as a `PNG`, `JPG`, or `WebP` file.
            -   **Key Characteristic**: The styling decisions and rendering happen **during** the tile generation process on the server/machine doing the generation. The output is just pixels.

        <!--list-separator-->

        -  Vector Tile Generation

            -   **Goal**: To create lightweight tiles containing the geometric data and attributes needed for **client-side** rendering.
            -   **Input**: Source Vector Data (e.g., `GeoPackage`, `PostGIS`, `OSM PBF`). Style definitions are **not** used at this stage.
            -   **Core Process (per tile)**:
                -   **Select Features**: Query the source data to find all vector features (points, lines, polygons) that intersect the current tile's geographic boundary (often including a small buffer).
                -   **Clip Geometries**: Precisely clip the geometries of selected features to the tile boundary (plus buffer).
                -   **Simplify Geometries**: Reduce the number of vertices in lines and polygons based on the current zoom level. More simplification is applied at lower zooms (less detail needed) to reduce tile size and improve rendering speed. This is a critical step.
                -   **Select Attributes**: Include only the necessary attributes (tags/properties) needed for styling and interaction on the client. Dropping unneeded attributes significantly reduces tile size.
                -   **Encode Tile**: Package the clipped, simplified geometries and selected attributes into the standardized vector tile format (usually Mapbox Vector Tiles - `MVT`, using Protocol Buffers for efficiency). Tiles can contain multiple layers (e.g., a 'roads' layer, a 'buildings' layer).
            -   **Key Characteristic**: No visual styling is applied during generation. The process focuses on selecting, simplifying, and efficiently packaging the data. Styling happens later in the client browser/app using a separate style file.

    <!--list-separator-->

    -  Available Tools (Expanding on the list)

        <!--list-separator-->

        -  Primarily/Often Used for Raster Tile Generation

            -   **GDAL (`gdal2tiles.py`)**: Standard command-line tool, especially good for Raster Source -&gt; Raster Tiles. Reliable but can be slow for very large datasets compared to newer tools.
            -   **QGIS/ArcGIS**: Desktop GIS software. Offer GUI tools to generate raster tiles ("Generate XYZ tiles (Directory/MBTiles)") from either raster layers or styled vector layers. Good for smaller areas or visual setup.
            -   **MapTiler Engine**: Commercial software (with a free version for smaller use). User-friendly GUI, efficiently generates raster tiles from raster or vector sources into various structures (`Z/X/Y`, `MBTiles`, `PMTiles`).
            -   **Mapnik (with a tile server/script)**: A powerful rendering library. You configure it with XML or `CartoCSS` (older) styles and use scripts or servers (like `TileStache`, `TileServer GL` in raster mode) to drive the tile generation from vector data. More complex setup.
            -   **MapServer/GeoServer**: Full map servers. Can be configured to serve `WMTS` (Web Map Tile Service) endpoints, effectively generating raster tiles on demand or caching them based on `SLD` or other styling definitions.

        <!--list-separator-->

        -  Primarily/Often Used for Vector Tile Generation (Outputting MVT)

            -   **Tippecanoe**: (originally Mapbox, now Felt) Command-line tool, highly optimized for performance and smart feature generalization/simplification. Excellent for converting large `GeoJSON` or `CSV` files into `MVT` (usually within `MBTiles` or `PMTiles`).
            -   **Planetiler**: Java command-line tool, extremely fast for converting OpenStreetMap data (`PBF` format) into `MVT` (often `PMTiles`). Uses configurable profiles (Java code) to define layer content. Great for whole countries/continents.
            -   **OpenMapTiles Tools**: A comprehensive Docker-based toolchain using PostgreSQL/PostGIS internally. Generates vector tiles following the detailed OpenMapTiles schema from OSM and other sources. Powerful but involves a significant database setup.
            -   **Tilemaker**: Simpler command-line tool converting OSM `PBF` into `MVT`. Uses `Lua` scripts for configuration. Good alternative if OpenMapTiles is too complex or Planetiler profiles seem daunting.
            -   **PostGIS (`ST_AsMVT`, `ST_AsMVTGeom`)**: SQL functions built directly into PostGIS. Allows you to construct vector tiles directly using SQL queries. This is the core method used by many dynamic vector tile servers (like `Martin`, `Tegola`) that generate tiles on-the-fly from the database. Can also be used in scripts for pre-generation.
            -   **ogr2ogr (GDAL)**: The vector counterpart in GDAL. Can convert various vector data formats into `MVT` tiles, often packaged within an `MBTiles` container. May offer less sophisticated simplification/attribute handling than Tippecanoe.
            -   **QGIS/ArcGIS**: Can export vector layers to vector tiles, but potentially less optimized for web delivery speed and size compared to dedicated tools like Tippecanoe or Planetiler for very large datasets.

<!--list-separator-->

-  Tile Serving (Delivering the Tiles)

    > -   This is the crucial step where the generated map tiles (raster images like `/z/x/y.png` or vector data chunks like `/z/x/y.mvt`) are made available over the internet (or a local network) to be requested by the client-side mapping library (like **Leaflet** or **MapLibre GL JS**).
    > -   **Tile servers** deliver raw map data using open standards for developers to build custom mapping applications with complete control over styling, data, and functionality. Not all tile servers, but a raw tile server may be missing info such as search or geocoding, route calculation, navigation or directions, static image generation, raster tile hosting, satellite image hosting, elevation lookup etc.
    > -   **Full map service providers** such as Google Maps is an all-in-one proprietary platform combining pre-rendered maps, search, routing, and business data with less customization but more out-of-the-box features.
    > -   This highlights that choosing a "tile server" approach (self-hosted or direct static) often means you'll need to source other components like geocoding or routing separately, whereas "hosted tile services" may bundle them, and "full map service providers" (like Google/Apple Maps via their specific SDKs) provide a tightly integrated but less customizable package.

    <!--list-separator-->

    -  Comparison of Tile Serving Approaches

        | Feature                | Hosted Tile Services                   | Self-Hosted Server (Dynamic)     | Self-Hosted Server (Static)                                                     | Direct Static Hosting (Serverless)     |
        |------------------------|----------------------------------------|----------------------------------|---------------------------------------------------------------------------------|----------------------------------------|
        | **Who Manages Infra**  | Vendor (Mapbox, MapTiler)              | You                              | You                                                                             | You (Static Storage like S3, Pages)    |
        | **Control Over Infra** | Low                                    | High                             | High                                                                            | Medium (Storage config)                |
        | **Control Over Data**  | Often uses Vendor's data, upload       | High                             | High                                                                            | High (You generate the files)          |
        | **Control Over Style** | Via Vendor tools/APIs; Full vector     | Full                             | Full (for vector style defs)                                                    | Full (for vector style defs)           |
        | **Scalability**        | Managed by Vendor (usually high)       | Depends on your server setup     | Depends on your server setup                                                    | Very High (Leverages CDN/Object Store) |
        | **Cost Model**         | Usage-based (loads, tiles), Tiers      | Server costs (CPU, RAM, BW)      | Server costs (Disk I/O, BW)                                                     | Storage + Bandwidth (often cheap)      |
        | **Maintenance Effort** | Low (Vendor handles updates)           | High (OS, DB, server, scaling)   | Medium (OS, server updates)                                                     | Very Low (Update static files)         |
        | **Data Generation**    | Often by Vendor; Upload possible       | On-the-fly from DB (PostGIS)     | Pre-generated tiles                                                             | Pre-generated tiles (PMTiles/FGB)      |
        | **Output Flexibility** | Vector/Raster as offered               | Primarily Vector (MVT via SQL)   | Vector/Raster (Reads MBTiles/Files)                                             | Vector (PMTiles/FGB)                   |
        | **Example**            | Mapbox, MapTiler Cloud, Stadia         | Martin, Tegola, PostGIS          | TileServer GL, [Baremaps](https://news.ycombinator.com/item?id=36106695), Nginx | Protomaps (PMTiles), FlatGeobuf, S3    |
        |                        | AWS Location, Azure Maps, ProtomapsAPI | (ST_AsMVT), GeoServer, MapServer | /Caddy serving ZXY files                                                        | GCS, R2, GitHub Pages                  |

    <!--list-separator-->

    -  Detailed Breakdown of Serving Approaches

        <!--list-separator-->

        -  Hosted Tile Services

            -   **Description:** Commercial or freemium platforms that handle tile generation (often from their curated datasets like OSM, but allowing uploads) and provide globally distributed, scalable infrastructure to serve tiles via APIs. They often bundle other services like Geocoding, Routing, and sophisticated styling tools.
            -   **Pros:** Easy to get started, high availability, scalable, low maintenance, often includes curated data and styles.
            -   **Cons:** Can become expensive at scale, less control over data processing and infrastructure, potential vendor lock-in, usage limits on free tiers.
            -   **Examples:**
                -   **Mapbox:** Pioneer, extensive features, commercial focus.
                -   **MapTiler Cloud:** Strong OSM focus, open-standards friendly, vector &amp; raster, free tier available.
                -   **Stadia Maps:** Privacy-focused, OSM-based tiles and APIs.
                -   **AWS Location Service / Azure Maps:** Cloud provider integrations, usage-based pricing.
                -   (Others: **HERE Platform**, **Esri ArcGIS Platform**, etc.)

        <!--list-separator-->

        -  Self-Hosted Tile Servers

            -   **Description:** You run specific server software on your own infrastructure (your server, cloud VM, container) which responds to tile requests. This gives you maximum control. Two main sub-types:

            <!--list-separator-->

            -  a) Dynamic Generation Servers:

                -   **Description:** These connect to a geospatial database (usually **PostGIS**) and generate vector tiles (`MVT`) on-the-fly using SQL queries (like `ST_AsMVT`) when a request comes in. They often cache results for performance.
                -   **Pros:** Data updates in the DB are reflected immediately (after cache expiry), no need to pre-generate all tiles.
                -   **Cons:** Requires a powerful database, can be CPU/RAM intensive, higher maintenance (DB + Server).
                -   **Examples:** **Martin** (Rust), **Tegola** (Go), Custom app using PostGIS `ST_AsMVT`. **GeoServer\*/\*MapServer** can also serve vector tiles dynamically.
                    -   [Serving Vector Tiles, Fast | Hacker News](https://news.ycombinator.com/item?id=43598600) (dynamic tiles)

            <!--list-separator-->

            -  b) Static File Servers:

                -   **Description:** These serve pre-generated tiles that are stored as individual files (`Z/X/Y` directories) or within container formats like `MBTiles` (**SQLite**). The server's job is simpler: find the correct file/database record and send it.
                -   **Pros:** Less CPU/RAM intensive than dynamic servers, simpler setup if tiles are pre-generated.
                -   **Cons:** Requires pre-generating all tiles (can take time/disk space), data updates require regenerating and replacing tiles.
                -   **Examples:** **TileServer GL** (by MapTiler, serves from `MBTiles~/directories, includes style editor), *Apache Baremaps* (can serve tiles it generates), basic web servers like *Nginx*/*Caddy*/*Apache* configured to serve files from ~Z/X/Y` directories. **Headway** appears to bundle a tile server component.

        <!--list-separator-->

        -  Direct Static Hosting (Serverless Approach)

            -   **Description:** This modern approach avoids running an active tile server process. Instead, you pre-generate tiles into a single, cleverly structured file (like `PMTiles`) or directly consumable format (like `FlatGeobuf`). This file is hosted on simple, cheap static web storage (**AWS S3**, **Cloudflare R2**, **GitHub Pages**, **Netlify**). A specialized client-side library then fetches only the required byte ranges from that single file using **HTTP Range Requests**, effectively behaving like a tile server without the server.
            -   **Pros:** Extremely scalable, very low cost (static hosting is cheap), minimal maintenance (just upload the file), fits well with serverless architectures.
            -   **Cons:** Requires pre-generating the entire ~.pmtiles~/.fgb file, less suitable for data that changes very frequently (requires regeneration/re-upload).
            -   **Examples:**
                -   **Protomaps (PMTiles):** The primary driver of this approach. Provides tools to create `.pmtiles` files and client libraries (or integration with MapLibre/Leaflet) to read them. See: [Protomaps Website](https://protomaps.com/)
                -   **FlatGeobuf:** While primarily a data format, its spatial indexing allows efficient fetching over HTTP Range Requests, enabling direct use in clients like OpenLayers.
                -   **ServerlessMaps:** Appears to be a framework/tool for deploying maps using this static/serverless cloud approach.

        <!--list-separator-->

        -  Hybrid / Community Provided Tiles

            -   **Description:** Projects or organizations that leverage combinations of the above techniques (often self-hosted servers or static hosting) to provide free or community-supported tile access, typically based on OpenStreetMap data.
            -   **Example:**
                -   **OpenFreeMap:** Aims to provide free, production-quality vector tiles hosted using existing tools (**Planetiler**, **Cloudflare R2** for hosting `PMTiles`), demonstrating the power of the Direct Static Hosting approach for open data.
                -   <https://github.com/headwaymaps/headway>

    <!--list-separator-->

    -  Alternative Rendering (Not Tile Serving)

        **SVG from PostGIS:** Techniques exist to generate Scalable Vector Graphics (`SVG`) images directly from database queries (like shown in the [CrunchyData blog post](https://www.crunchydata.com/blog/svg-images-from-postgis)). This is useful for generating specific, potentially complex vector map images server-side, but it's **not** a tiled approach suitable for interactive slippy maps.


#### Phase 4: Frontend Rendering &amp; Interaction (The User Interface) {#phase-4-frontend-rendering-and-interaction--the-user-interface}

<!--list-separator-->

-  Basemaps

    <!--list-separator-->

    -  Definition &amp; Key Characteristics

        -   Foundational visual layer providing geographic context (land, water, roads, labels).
        -   Purpose: Orient user, provide background without distraction.
        -   Delivery: Almost always served as Tiles (Raster or Vector).
        -   Content: Fundamental geographic features (variable detail).
        -   Styling: Defines the visual appearance (colors, fonts, density).

    <!--list-separator-->

    -  Why Many Basemaps? (Purpose-Driven)

        -   Different tasks need different context:
        -   **Navigation:** Clear roads, POIs (e.g., Mapbox Streets).
        -   **Data Visualization:** Muted, simple styles (e.g., Carto Positron, Stamen Toner).
        -   **Outdoor/Terrain:** Contour lines, trails (e.g., Mapbox Outdoors).
        -   **Satellite/Imagery:** Real-world visual texture (e.g., Mapbox Satellite).
        -   **Minimalist:** Essential features only.

    <!--list-separator-->

    -  Common Basemap Providers &amp; Examples

        | Provider                                     | Example Styles                      | Data Sources (Typical)       | Tile Types    | Notes                                            | Updates (Typical Street) |
        |----------------------------------------------|-------------------------------------|------------------------------|---------------|--------------------------------------------------|--------------------------|
        | Mapbox                                       | Streets, Outdoors, Light, Dark, Sat | Mapbox Curated (OSM derived) | Vector,Raster | Polished, Dev-focused, Commercial                | Weekly/Monthly           |
        | MapTiler                                     | Streets, Topo, Satellite, Dataviz   | OSM, Proprietary             | Vector,Raster | OSM focus, Open standards, Free tier             | Weekly/Monthly           |
        | Stadia Maps                                  | Stamen Styles, Alidade, Outdoors    | OSM                          | Vector,Raster | Privacy-focused, Clean styles                    | Monthly/Quarterly        |
        | Esri (ArcGIS)                                | Streets, Topo, Imagery, Gray Canvas | HERE, OSM, Gov, Imagery      | Vector,Raster | Enterprise GIS focus, High-quality cartography   | Monthly/Quarterly        |
        | Google Maps                                  | Roadmap, Satellite, Terrain         | Google Proprietary           | Vector,Raster | Consumer focus, POIs, API Costs                  | Continuous               |
        | Apple Maps                                   | Standard, Hybrid, Satellite         | Apple Proprietary            | Vector,Raster | Apple ecosystem focus (MapKit JS)                | Continuous               |
        | Carto                                        | Positron, Dark Matter, Voyager      | OSM                          | Vector,Raster | Data viz focus, Minimalist styles                | Quarterly/Yearly?        |
        | OSM (Default)                                | Standard                            | OSM                          | Raster Only   | Reference tile layer, **Not for production use** | Weekly                   |
        | Thunderforest                                | OpenCycleMap, Transport             | OSM                          | Raster        | Niche OSM raster styles (cycling, etc.)          | Monthly?                 |
        | Protomaps                                    | **N/A - Toolkit**                   | OSM (typically)              | Vector        | Tools/System to **create** your own static tiles | **User Controlled**      |
        | [OpenTopoMap](https://opentopomap.org/about) |                                     |                              |               |                                                  |                          |
        | [Tracestrack Maps](https://tracestrack.com/) |                                     |                              |               |                                                  |                          |

        -   **Protomaps:** A **system/toolkit** to create and self-host your own OSM-based vector tile basemaps (PMTiles).
        -   **Overture Maps:** A **data source** (like OSM), not a basemap itself. Needs processing/styling/tiling to become one.
        -   **Satellite Data:** Yes, commonly used as a **raster tile** basemap, often with vector label overlays (Hybrid).

    <!--list-separator-->

    -  Choosing a Basemap (Key Factors)

        -   Purpose Alignment (Navigation, Data Viz, etc.)
        -   Aesthetics &amp; Branding
        -   Data Interference (Does it clash with overlays?)
        -   Detail Level &amp; Data Freshness/Coverage
        -   Tile Type (Vector for styling flexibility vs. Raster)
        -   Cost &amp; Usage Limits
        -   Licensing &amp; Attribution
        -   Performance

    <!--list-separator-->

    -  Style part of basemap?

        <!--list-separator-->

        -  Is styling part of basemap?

            -   **Yes**, styling is essential and defining.
            -   Raw data (e.g., OSM PBF) lacks visual style (colors, widths).
            -   Applying a **style** transforms raw data into a visually coherent basemap (e.g., street map, satellite, dark).

        <!--list-separator-->

        -  Is the datasource the basemap?

            -   **No**, the datasource (OSM, Overture, imagery) is the **raw ingredient**.
            -   It's geographic facts, not yet a functional, viewable map.

        <!--list-separator-->

        -  At what stage do we have a basemap?

            -   When the **styled, tiled representation** is ready for client rendering.
            -   **Raster Tiles:** After data is processed, styled, and rendered into image tiles (e.g., PNG Z/X/Y). The basemap **is** these images.
            -   **Vector Tiles:** Requires **both**:
                1.  The generated **vector tiles** (MVT/PMTiles: geometry + attributes, **no** style).
                2.  An associated **style definition file** (e.g., Mapbox Style JSON) telling the client how to draw the tiles.
                    -   The functional basemap is the **combination** of vector tiles + style definition.

<!--list-separator-->

-  Frontend Mapping Libraries (JavaScript Libraries)

    > Tools used in the web browser to display the map, fetch tiles, handle user interactions (zoom, pan, click), render data, and apply styles.

    <!--list-separator-->

    -  Rendering vs Styling

        > For vector tiles, we apply the style when rendering client side. But for raster the style is already pre-applied. On top when rendering we can always use markers, layers etc to make more manupulations on top of the rendered raster/vector tile ofc.

        -   **Vector Styling is Rich**: Languages/specs like the `Mapbox GL Style Spec` allow fine-grained control over vector features based on their attributes and the zoom level.
        -   **Raster Styling is Limited (Client-Side)**: On the client-side, you cannot style the content of raster tiles (like changing road colors). You can only apply overall effects like opacity or `CSS` filters to the entire layer. Raster styling primarily happens server-side before the tiles are generated.
        -   **Library vs. Style**: `MapLibre GL JS` is the library that renders the map; the `Mapbox GL Style Spec` is the `JSON` file that tells MapLibre how to render the vector data. `Leaflet` can display raster tiles directly or use plugins (and potentially separate style information, depending on the plugin) to render vector data.
        -   **KML**: It's a data format that includes basic styling information within the file itself. Rendering libraries like `OpenLayers` or `Google Maps` can parse and display `KML`, applying the embedded styles.

    <!--list-separator-->

    -  Client-Side Map Rendering Libraries/SDKs

        > These are the JavaScript libraries used in the browser or application to display interactive maps, handle user input (pan, zoom), fetch map tiles or data, and render visuals.
        >
        > See [Display an interactive map — Maps for HTML reference examples](https://maps4html.org/HTML-Map-Element-UseCases-Requirements/examples/create-map.html)

        | Library/SDK Name              | Approx. Year | Primary Tile Type(s) Supported                                      | Rendering Engine     | Key Characteristics &amp; Notes                                                                                                          |
        |-------------------------------|--------------|---------------------------------------------------------------------|----------------------|------------------------------------------------------------------------------------------------------------------------------------------|
        | Leaflet                       | 2010         | Raster primarily, Vector (`GeoJSON`, Plugins for `MVT` / `PMTiles`) | Canvas / DOM         | Lightweight, mobile-friendly, huge plugin ecosystem. Simple `API`. Raster is core, vector often via plugins.                             |
        | OpenLayers                    | 2006         | Raster &amp; Vector (`MVT`, `GeoJSON`, `KML`, etc.)                 | Canvas / WebGL       | Very powerful, feature-rich, handles many formats and projections well. Steeper learning curve than Leaflet.                             |
        | MapLibre GL JS                | 2020 (Fork)  | Vector (`MVT`) primarily, Raster                                    | WebGL                | High-performance, focuses on vector tiles using Mapbox Style Spec. Open-source fork of Mapbox GL JS v1.                                  |
        | Mapbox GL JS                  | ~2014        | Vector (`MVT`) primarily, Raster                                    | WebGL                | High-performance, vector tile focus, uses Mapbox Style Spec. Commercial (v2+ requires Mapbox token).                                     |
        | Google Maps Platform API (JS) | ~2005        | Raster &amp; Vector (Proprietary)                                   | DOM / Canvas / WebGL | Part of Google's ecosystem, rich POI data, well-documented. Requires `API` key, usage costs apply. Style via `API~/~JSON`.               |
        | MapKit JS (Apple Maps API)    | ~2018        | Raster &amp; Vector (Proprietary)                                   | Native (via WebKit)  | Integrates with Apple Maps data/services. Best for Apple ecosystem. Limited outside. Requires Apple Developer credentials.               |
        | Bing Maps Control API (JS)    | ~2005        | Raster &amp; Vector (Proprietary)                                   | Native (via browser) | Microsoft's mapping platform, integrates with Bing services. Requires `API` key.                                                         |
        | TomTom Maps SDK for Web       | ?            | Vector (Proprietary)                                                | WebGL                | Commercial SDK focused on TomTom's data and services (routing, traffic, etc.).                                                           |
        | D3.js (Geographies)           | 2011         | Vector (`GeoJSON`, `TopoJSON`)                                      | SVG / Canvas         | Powerful data visualization library, not primarily for tiled maps. Used for custom, often non-geographic projections/choropleths.        |
        | protomaps-leaflet (Plugin)    | 2021         | Vector (`PMTiles` only)                                             | Canvas (via Leaflet) | Leaflet plugin specifically for reading/rendering the `PMTiles` vector tile format. Uses Leaflet's engine.                               |
        | (Other Platform SDKs)         | various      | Various                                                             | Various              | E.g., HERE, Esri ArcGIS API for JavaScript provide similar platform-specific rendering capabilities.                                     |
        | (iframe embeds)               | N/A          | N/A                                                                 | `HTML`               | Not a styling method itself. Embeds a pre-rendered, often pre-styled map from another service. Styling controlled by the source service. |

    <!--list-separator-->

    -  Map Styling Languages / Specifications / Techniques

        > These define how map features should look (colors, sizes, labels, visibility). They are distinct from the rendering library itself, though tightly coupled, especially for vector data.

        | Name / Technique               | Primary Use Context         | Applies Primarily To    | Format / Type               | Status &amp; Key Characteristics                                                                                                                         |
        |--------------------------------|-----------------------------|-------------------------|-----------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|
        | Mapbox GL Style Specification  | Client-side                 | Vector (Limited Raster) | `JSON`                      | The standard for MapLibre/Mapbox GL JS. Allows dynamic, data-driven styling based on feature attributes. Rich feature set. Defines sources and layers.   |
        | SLD (Styled Layer Descriptor)  | Server-side                 | Vector &amp; Raster     | `XML`                       | OGC standard, often used for styling WMS/WFS services generated by servers like GeoServer/MapServer. Verbose.                                            |
        | CartoCSS                       | Server-side (Legacy Client) | Vector                  | `CSS`-like Syntax           | Used by Mapnik renderer. Was used by TileMill/older Mapbox Studio. Still actively used by OpenStreetMap Carto style. Less common for modern client-side. |
        | KML Styling                    | Client/Server               | Vector (Basic)          | `XML` (within `KML`)        | Basic styling (icons, colors, labels) embedded directly within `KML` files. Widely supported but limited expressiveness compared to Mapbox GL Style.     |
        | CSS Filters (on Raster Layers) | Client-side                 | Raster Only             | `CSS` (Browser Feature)     | Technique, not a map spec. Apply `CSS` filter properties (grayscale, sepia, opacity, hue-rotate) to the entire raster tile layer in the browser.         |
        | Platform-Specific Styling APIs | Client/Server               | Vector &amp; Raster     | `API` Calls / `JSON` Config | Specific to platforms like Google Maps `API`, MapKit JS. Styles configured via JavaScript objects or `JSON` passed to the library's `API` methods.       |


#### Phase 5: Value-Added Services (The Utilities &amp; Appliances) {#phase-5-value-added-services--the-utilities-and-appliances}

> These are often separate APIs or components that work alongside the map display:

-   Geocoder: Converts human-readable addresses or place names into geographic coordinates (latitude/longitude) (Forward Geocoding) and vice-versa (Reverse Geocoding).
    -   Examples: OpenCage (aggregator), Nominatim (OSM-based), Pelias (OSM-based), Mapbox Search API, Google Geocoding API, HERE Geocoding.
-   Routing: Calculates directions (routes) between two or more points, considering factors like road networks, travel mode (car, bike, walk), traffic, etc.
    -   Examples: OSRM (open-source), Valhalla (open-source), GraphHopper (open-source), Mapbox Directions API, Google Directions API, HERE Routing.
-   **Places/POI Search**: Finding specific businesses or points of interest near a location.
-   **Elevation Data**: Finding the altitude at a specific point.
-   **Static Maps API**: Generating non-interactive map images.
-   **Map Matching**: Snapping GPS traces to the road network.
-   **Isochrones**: Calculating areas reachable within a certain time or distance.


#### How they fit together (Example Pipeline): {#how-they-fit-together--example-pipeline}

> -   **Data vs. Service**: OSM and Overture provide data. Mapbox, Google Maps, MapTiler provide services (which often include curated data, tile hosting, APIs, styling tools).
> -   **Tiles are Key**: Tiling (vector or raster) is the standard way to deliver map data efficiently for the web.
> -   **Vector Tiles are Flexible**: They allow client-side styling and interaction. PMTiles makes them easy to host statically.
> -   **Components are Modular**: You often mix and match tools: OSM data + Planetiler + PMTiles + MapLibre + OpenCage geocoder.
> -   **Self-hosted vs. Hosted**: You can run your own tile servers, geocoders, routing engines (more control, potentially cheaper at scale, more work) or use managed cloud services (easier setup, pay-as-you-go).
> -   **Basemap is Foundational**: It's the background map, usually tiled, on which you overlay specific data.

-   **Data**: Download OSM data for your region (`.pbf` format).
-   **Processing**: Use Planetiler to convert the OSM `.pbf` into vector tiles (`.mvt`).
-   **Option A (Server)**: Serve these `.mvt` tiles using Martin running on your server.
-   **Option B (Serverless)**: Use tippecanoe or another tool to package the `.mvt` files into a single `yourmap.pmtiles` file. Host `yourmap.pmtiles` on AWS S3.
-   **Frontend**: Use MapLibre GL JS in your web app.
    -   Point it to your tile server (Option A) or your `.pmtiles` file URL (Option B).
    -   Create a style JSON file to tell MapLibre how to draw the roads, buildings, etc., from the vector tiles.
-   **Add Feature**: Add a search box that uses the OpenCage Geocoding API to find locations.
-   **Add Feature**: When a user clicks two points, send the coordinates to your self-hosted OSRM routing engine API to get directions and draw the route line on the map using MapLibre.


### Service Types (Canonical) {#service-types--canonical}

| Format | Year  | Description                                                                     |
|--------|-------|---------------------------------------------------------------------------------|
| WMS    | 2000  | Web Map Service for delivering georeferenced map images                         |
| WTMS   | 2010  | Web Tile Map Service for delivering pre-rendered tiled maps                     |
| STAC   | ~2018 | SpatioTemporal Asset Catalogs for standardizing earth observation data metadata |


### Mapping services/platforms {#mapping-services-platforms}

See [Comparison of web map services - Wikipedia](https://en.wikipedia.org/wiki/Comparison_of_web_map_services)

| Platform                              | Description                                                        | Good to Know                                  |
|---------------------------------------|--------------------------------------------------------------------|-----------------------------------------------|
| **Google Maps**                       | Industry leader in digital mapping                                 | Most extensive POI database                   |
|                                       |                                                                    | Higher costs for commercial use               |
|                                       |                                                                    | Detailed usage limits and quotas              |
|                                       |                                                                    | Must be used via its Javascript SDK           |
| **OpenStreetMap**                     | Open-source, community-driven mapping project                      | Raw data requires technical knowledge to use  |
|                                       |                                                                    | Quality varies by region                      |
|                                       |                                                                    | Suitable for custom applications              |
|                                       |                                                                    |                                               |
| **Apple Maps**                        | Apple's mapping service integrated into Apple devices              | Improved significantly since launch           |
|                                       |                                                                    | Best integration with Apple devices           |
|                                       |                                                                    | Limited use outside Apple ecosystem           |
|                                       |                                                                    |                                               |
| **Overture Maps**                     | Open map data foundation created by industry leaders               | Newer entrant (launched 2022)                 |
|                                       |                                                                    | Aimed at reducing dependency on Google        |
|                                       |                                                                    | Compatible with other open mapping frameworks |
|                                       |                                                                    |                                               |
| Mapbox                                | Developer platform for custom maps.                                | Popular with developers                       |
|                                       |                                                                    | Used by Snapchat, Instacart, Strava           |
|                                       |                                                                    | Strong visualization tools                    |
| [MapTiler](https://www.maptiler.com/) | Map hosting and tile generation service focusing on open standards |                                               |
| **Bing Maps**                         | Microsoft's mapping service                                        | Integrated with Microsoft products            |
|                                       |                                                                    | Good API documentation                        |
|                                       |                                                                    | Less popular than Google Maps                 |
| [peermaps](https://peermaps.org/)     | This one is p2p stuff. So it's probably incomplete.                | Obsolete                                      |
| Protomaps                             |                                                                    |                                               |


#### More on `Overture Maps` {#more-on-overture-maps}

-   Source of data: Unlike OSM, it doesn't rely on a community of mappers who manually update maps. Instead, it aggregates data from a variety of sources such as: sensors, satellites, aerial images, government sources, as well as data provided from its members (e.g. Amazon, Meta, Microsoft, and TomTom).
-   Focusing on enterprise customers, but it's cheaper than google maps as it's open
-   See
    -   [ ] [The Overture Maps Foundation: Marc Prioleau - MBM#43 - YouTube](https://www.youtube.com/watch?v=OSK4DlFePzk)
    -   [ ] [Overture Maps Foundation releases open map dataset | Hacker News](https://news.ycombinator.com/item?id=36879461)
    -   [ ] [Overture Maps Foundation Releases Beta of Its First Open Map Dataset | Hacker News](https://news.ycombinator.com/item?id=40057322)
    -   [ ] [Overture's Global Geospatial Datasets](https://tech.marksblogg.com/overture-gis-data.html)


## Other tooling {#other-tooling}


### Analysis {#analysis}

-   <https://turfjs.org/> : Geo analysis in nodejs
-   <https://www.whosonfirst.org/browse/>
-   <https://www.mapzen.com/projects/>


### GPS {#gps}

-   [Calculating Position from Raw GPS Data | Telesens](https://www.telesens.co/2017/07/17/calculating-position-from-raw-gps-data/)
-   [Using GPS in the Year 1565 | Hacker News](https://news.ycombinator.com/item?id=42181529)
-   [GPS Tracking Software - Free and Open Source System - Traccar](https://www.traccar.org/)


### Drone {#drone}

-   [Drone Mapping Software - OpenDroneMap](https://www.opendronemap.org/)


### Routing {#routing}

-   <https://github.com/valhalla>


### Geocoding {#geocoding}

-   <https://opencagedata.com/?ocs=10>
-   <https://www.pelias.io/>


### Visualization {#visualization}

-   <https://kepler.gl/>
-   <https://vis.gl/>
-   [Tiny World Map | Hacker News](https://news.ycombinator.com/item?id=40104774)


### Urban planning {#urban-planning}

-   [a-b-street/abstreet](https://github.com/a-b-street/abstreet): Transportation planning and traffic simulation software for creating cities friendlier to walking, biking, and public transit.


### Editors {#editors}

-   <https://github.com/placemark/placemark>


## Terms I keep hearing {#terms-i-keep-hearing}

-   ARCO: Analysis-Ready, Cloud-Optimized approach, Umbrella term for modern geospatial data practices optimized for cloud environments
-   basemap, geocoder and routing engine
-   [Web Mercator projection - Wikipedia](https://en.wikipedia.org/wiki/Web_Mercator_projection)


## Random links {#random-links}

-   <https://docs.opentripplanner.org/en/dev-2.x/Basic-Tutorial/>
