+++
title = "Browser Extensions"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Web Development]({{< relref "20221108105344-web_development.md" >}}), [Javascript Runtime and Browser]({{< relref "20221127082259-javascript_runtime.md" >}}), [Javascript]({{< relref "20221126085225-javascript.md" >}})


## Basics {#basics}


### Example Usage {#example-usage}

-   Ad and Tracking Blockers
-   PW Managers
-   Smart Writing Management Tools
-   Accessibility Tools
-   Content and Link Aggregators
-   Tab mgmt
-   Screen Rec
-   Devtools


### Extension Model (Where it places) {#extension-model--where-it-places}

{{< figure src="/ox-hugo/20230819201918-browser_extensions-1533550882.png" >}}

-   From the perspective of the web page, browser extensions can be thought of as an invisible supplemental entity.
-   Own
    -   Own runtime
    -   Render pages in their own sandboxed contexts
    -   Own APIs
-   `content scripts` are exceptions.
    -   Web page and extension can access DOM &amp; Share resources
    -   Extension specific sandboxing


#### What extension can offer {#what-extension-can-offer}

<!--list-separator-->

-  UI

    Each of the following pages are rendered as any normal webpage with events, own Runtime and DOM etc.

    -   Popup page
    -   Options page
    -   Devtools page

<!--list-separator-->

-  Non-UI

    These don't have UI but have their own [Javascript Runtime]({{< relref "20221127082259-javascript_runtime.md" >}})

    -   Background script
    -   Content script


#### Lifecycle {#lifecycle}

-   Not restricted to single source. (Given enough permission, it'll be able to access all tabs)
-   Can exist without any webpage open at all. (Exception: `content scripts`, `devtool page` etc)


### Components {#components}

The most basic extension will need a `ext manifest` and `background script` at min.


#### Extension Manifest {#extension-manifest}

<!--list-separator-->

-  v2

    -   Background script had the option of being either
        -   Persistent: Background script is initialized exactly once and lives in memory until the browser is closed
        -   Non-Persistent: Background script exists as an `event page` that is initialized on demand whenever a relevant browser event occurs.

<!--list-separator-->

-  v3

    -   `background script` exist as service worker (See [Web Performance]({{< relref "20230503160302-web_performance.md" >}})), similar to `v2-non-persistent`


#### Background Script {#background-script}

-   Function: Handle browser events
    -   Extension lifecycle events: Eg. install or uninstall
    -   Browser events: Eg. navigating to a web page or adding a new bookmark
-   Abilities
    -   Access the WebExtensions APIs
    -   Performing actions such as exchanging messages with other parts of the same extension
    -   Exchanging messages with other extensions
    -   Programmatically injecting `content scripts` into a page


#### Pages {#pages}

<!--list-separator-->

-  Popup Page

    -   Concerns
        -   Cannot be opened programatically
    -   Abilities
        -   Access the WebExtensions APIs

<!--list-separator-->

-  Options page

    Display a custom user interface. The options page behaves as a standalone web page that opens when the user clicks “Options” in the extension toolbar context menu.

    -   Abilities
        -   Access the WebExtensions APIs


#### Injecting {#injecting}

Can inject JS/CSS or both

<!--list-separator-->

-  content script

    -   Sandboxed runtime: can't read JS properties from web page runtime
    -   Shares access to the same DOM as the web page itself, so can manipulate the DOM of the webpage.
    -   Ability
        -   **Limited** access to the WebExtensions APIs (Indirect access via messages)
        -   Can exchanges messages with other extension elements like background scripts.

<!--list-separator-->

-  declaratively via manifest

<!--list-separator-->

-  programatically via ext. page

<!--list-separator-->

-  programatically via background script using WebExtAPI


## FAQ {#faq}


### [WebAssembly]({{< relref "20230510200213-webassembly.md" >}}) and ManifestV3 {#webassembly--20230510200213-webassembly-dot-md--and-manifestv3}

-   See [Sample: Using WASM in Manifest V3 · Issue #775 · GoogleChrome/chrome-extensions-samples · GitHub](https://github.com/GoogleChrome/chrome-extensions-samples/issues/775#issuecomment-1492023661)


## Links {#links}

-   [Prepare your Firefox desktop extension for the upcoming Android release | Mozilla Add-ons Community Blog](https://blog.mozilla.org/addons/2023/08/10/prepare-your-firefox-desktop-extension-for-the-upcoming-android-release/)
-   [GitHub - fregante/webext-content-scripts: Utility functions to inject content scripts from a WebExtension](https://github.com/fregante/webext-content-scripts)
