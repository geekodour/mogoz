+++
title = "Same Origin Policy (SOP)"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [CORS]({{< relref "20230302210256-cors.md" >}}), [XSS]({{< relref "20230616121539-xss.md" >}}), [Web Authentication]({{< relref "20221109172102-web_authentication.md" >}}), [CSRF]({{< relref "20230616090755-csrf.md" >}}), [Cookies]({{< relref "20230615111924-cookies.md" >}}), [Security]({{< relref "20221101184454-security.md" >}}), [Javascript]({{< relref "20221126085225-javascript.md" >}})


## Origin {#origin}

{{< figure src="/ox-hugo/20230302210256-cors-1621407877.png" >}}

-   Origin: `Scheme + Hostname + Port`
-   Can also be an IP address


## Site {#site}

{{< figure src="/ox-hugo/20230302210256-cors-427498965.png" >}}

-   Site: `Scheme + eTLD+1`
-   There's also schemeless site, in which change of change of scheme means same site. (This is the current standard)


## X-origin and X-site jargon {#x-origin-and-x-site-jargon}


### same-origin {#same-origin}

![](/ox-hugo/20230302210256-cors-1955340988.png)
![](/ox-hugo/20230302210256-cors-776151307.png)


### cross-origin {#cross-origin}

-   When it's not same-origin, it's cross origin
-   subdomains will be cross-origin
-   different port will be cross-origin


### same-site {#same-site}

{{< figure src="/ox-hugo/20230302210256-cors-427459679.png" >}}

-   subdomains will be same-site
-   different port will be same-site


### cross-site {#cross-site}

-   When it's not same-site, it's cross-site
-   different scheme will be cross-site


## Same Origin Policy {#same-origin-policy}

-   SOP is good, [CORS]({{< relref "20230302210256-cors.md" >}}) allows us to bypass SOP when needed
-   Browsers by default follow SOP
-   No request to other origins


### Scope of "Same origin" {#scope-of-same-origin}

-   This is not limited to API calls
-   Not limited to [Cookies]({{< relref "20230615111924-cookies.md" >}}) not having access to cookies of other origin
-   Not limited to access of parent-child in iframe
-   It's a meta thing


### Why SOP needed in the first place? {#why-sop-needed-in-the-first-place}

<div class="warning small-text">

> Confusion is like:
>
> If we have to do CORS anyway, why do browsers enforce SOP? Non-browser clients can anyway make the request to the API endpoint, why not allow the browser to do so?
>
> Spoiler: We don't always need [CORS]({{< relref "20230302210256-cors.md" >}}) and it's better to avoid CORS when you can by design.
</div>

-   Now, neither SOP nor CORS are for protecting the API endpoint.
-   It exists so as to reduce possibility of attacks that can be done when you open a webpage in the browser.
-   Its a policy, there's no specific implementation so the idea of SOP is implemented by the browser at different levels
-   Eg. [Cookies]({{< relref "20230615111924-cookies.md" >}}) will be disallowed from accessing cookies of other origins. Script running on `evil.com` can't access `X.com` cookies.
-   Eg. You're not allowed to just randomly fetch data from any random website. A script in `evil.com` should not be able to hit `localhost:8000` and relay the data to the attacker.
-   Eg. `file://` is also another origin, you don't want random websites to have access to `file://` origin for sure.


### SOP does allow cross-origin! {#sop-does-allow-cross-origin}

-   SOP is nuanced, even without [CORS]({{< relref "20230302210256-cors.md" >}}) it does allow limited cross-origin requests.
-   Whenever things are denied by SOP, browser will attempt to do [CORS]({{< relref "20230302210256-cors.md" >}}) by using a preflight request. If the preflight fails, you really won't be able to access the resource.


#### Write: Allowed {#write-allowed}

-   You're allowed to send request, server will receive it and respond as expected, but browser will not let you read the response
-   You can send `GET`, `POST` (certain content-type), `HEAD`, others will need preflight w `OPTIONS`.


#### Embed: Allowed {#embed-allowed}

-   `<script>`, `<link>`, `<video>`, `<audio>`, `<iframe>`, `<img>` tags etc.


#### Read: Denied {#read-denied}

-   Any response coming from cross-origin will be blocked by the browser by default. You'll need to configure [CORS]({{< relref "20230302210256-cors.md" >}}) to bypass this.


#### Harden CORS on SOP {#harden-cors-on-sop}

-   Since SOP does allow some [CORS]({{< relref "20230302210256-cors.md" >}}), by default we can tighten it even further. See MDN docs on SOP for this.
-   Eg. For [iframe]({{< relref "20230617111853-iframe.md" >}}) with `X-Frame-Options: DENY` you can make sure your page cannot be embedded even if by default SOP it allows.
