+++
title = "Image Compression"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [System Design]({{< relref "20230113141133-system_design.md" >}}), [Compression]({{< relref "20230406044437-compression.md" >}}), [Web Animation]({{< relref "20221109214315-web_animation.md" >}}), [Web Development]({{< relref "20221108105344-web_development.md" >}}), [Codec]({{< relref "20230221191655-codec.md" >}}), [Custom Protocols]({{< relref "20230221012237-custom_protocols.md" >}})


## FAQ {#faq}

{{< figure src="/ox-hugo/20230113141102-image_compression-655873941.png" >}}


### Raster what? {#raster-what}

-   Taking a vector graphics format (shapes) and converting it into a raster image (a series of pixels, dots or lines, which, when displayed together, create the image which was represented via shapes) usually a bitmap.
-   Raster formats are for 2D images.


### Can a bitmap file be lossless/lossy? {#can-a-bitmap-file-be-lossless-lossy}

-   No. Bitmap is a image format type. Not a image format.
-   lossless/lossy are attribute of certain image formats.
-   Any image format is its plain form is uncompressed, and has certain properties of its own. It can decide to support compression which can lossy/lossless or sometimes both.


## Image format types {#image-format-types}

![](/ox-hugo/20230113141102-image_compression-2048388375.png)
Individual image formats can fit into multiple types, depending on their features and capabilities.


### Bitmaps {#bitmaps}

-   It's a pixel grid w a predefined w and h.
-   Eg. BMP, JPG, PNG, GIFs.


### Vector {#vector}

-   Eg. SVG, Postscript


### Metafile Formats {#metafile-formats}

These are image formats that can contain both vector and bitmap data. Examples include Enhanced Metafile (EMF), Windows Metafile (WMF), and Portable Document Format (PDF).


### 3D Formats {#3d-formats}

These are image formats that store 3D models or scenes, which can be rendered into 2D images. Examples include OBJ, FBX, and STL.


### RAW Formats {#raw-formats}

These are image formats that store unprocessed image data straight from the camera's sensor. Examples include CR2 (Canon RAW), NEF (Nikon RAW), and ARW (Sony RAW).


### Animated Formats {#animated-formats}

These are image formats that can display a sequence of images as an animation. Examples include GIF, APNG, and WEBP.


### DICOM Formats {#dicom-formats}

These are image formats used in medical imaging to store and transmit medical images such as X-rays and MRI scans.


## Details on certain image formats {#details-on-certain-image-formats}

> -   Lossless and Lossy is explained in [Compression]({{< relref "20230406044437-compression.md" >}})
>     -   Lossless: Does not throw away stuff.
>     -   Lossy: Throws away stuff.

{{< figure src="/ox-hugo/image_codecs.png" >}}


### BMP {#bmp}

-   Type: Bitmap
-   Supported compression: Some variant support 8-bit RLE or Huffman 1D algorithm.
-   The most basic one. It contains basically a list telling what color each pixel is in a predefined succession. It needs little processing to go from the device's memory to the display
-   It's generally uncompressed (or weakly compressed w/o loss)
-   The file size is quite high


### GIF {#gif}

-   Type: Bitmap/Animated
-   Supported compression: Lossless
-   Can dance but doesn't have to.
-   Has a low max number of colors (transparency is supported)


### PNG {#png}

-   Type: Bitmap
-   Supported compression: Lossless
-   Supports more colors than GIF (transparency is supported)


### JPG {#jpg}

-   Type: Bitmap
-   Supported compression: Lossy (Image Quality will degrade as you compress more)


### SVG {#svg}

-   Type: Vector
-   Supported compression: Lossless (Deflate based on Huffman and LZ77)
-   On the web, they can be styled with CSS and controlled w JS
-   [Pocket Guide to Writing SVG](https://svgpocketguide.com/)


### WebP {#webp}

-   Supported compression: Both lossless and lossy


### TIFF {#tiff}

-   Type: Meta?
-   Complex format that can contain multiple images, sometimes layers, different coding algorithms etc etc.
-   CMYK support
-   Newer alternative is EPS?


## Resources {#resources}


### Blogposts {#blogposts}

-   [Making Photos Smaller Without Quality Loss](https://engineeringblog.yelp.com/2017/06/making-photos-smaller.html)
-   [How Discord Resizes 150 Million Images Every Day with Go and C++](https://discord.com/blog/how-discord-resizes-150-million-images-every-day-with-go-and-c)


### When writing my own alias for resizing {#when-writing-my-own-alias-for-resizing}

-   [Memory problems with MozJPEG and Pillow - A Virtual Home - All about Python, Django, and infrastructure](https://blog.avirtualhome.com/memory-problems-with-jpg-files-and-pillow/)
-   [Python libraries to compress &amp; resize images fast — Uploadcare Blog](https://uploadcare.com/blog/image-optimization-python/)
-   [sharp - npm](https://www.npmjs.com/package/sharp)
-   [cwebp  |  WebP  |  Google Developers](https://developers.google.com/speed/webp/docs/cwebp)
-   <https://github.com/shssoichiro/oxipng>
-   <https://github.com/toy/image_optim>
-   <https://github.com/jarun/imgp>
-   <https://github.com/wanadev/pyguetzli>


### Image diff comparison tools {#image-diff-comparison-tools}

-   [Comparing -- ImageMagick Examples](https://www.imagemagick.org/Usage/compare/) : og, also creates diff animations?
-   [simonw/image-diff: CLI tool for comparing images](https://github.com/simonw/image-diff) : python
-   [dmtrKovalenko/odiff](https://github.com/dmtrKovalenko/odiff): The fastest pixel-by-pixel image visual diff
-   [nicolashahn/diffimg](https://github.com/nicolashahn/diffimg) : python
-   [jhnc/findimagedupes](https://github.com/jhnc/findimagedupes) : perl
-   [rivo/duplo](https://github.com/rivo/duplo) : Go
-   [murooka/go-diff-image](https://github.com/murooka/go-diff-image) : Also see [bokuweb/lcs-image-diff-rs](https://github.com/bokuweb/lcs-image-diff-rs)
-   [idealo/imagededup](https://github.com/idealo/imagededup) : Python (Maybe good for learning)
    -   Also see [Reverse image search using perceptual hashes](https://www.aadhav.me/posts/reverse-image-search)
-   [google/butteraugli](https://github.com/google/butteraugli) : More to do quality comparison. (More of a research tool)


### GIF {#gif}

-   <https://github.com/discord/lilliput>
-   <https://github.com/LucaCappelletti94/pygifsicle>
