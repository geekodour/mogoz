+++
title = "Web Authentication"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Security]({{< relref "20221101184454-security.md" >}}), [Web Development]({{< relref "20221108105344-web_development.md" >}}), [Authentication]({{< relref "20230301191046-authentication.md" >}}), [JWT]({{< relref "20230301214248-jwt.md" >}}), [Identity Management]({{< relref "20230301205430-identity_management.md" >}})


## Products to look at {#products-to-look-at}


### B2C {#b2c}

-   Firebase auth
-   [SuperTokens, Open Source Authentication](https://supertokens.com/)
-   [Clerk | Authentication and User Management](https://clerk.dev/)


### B2B {#b2b}

-   [Ory - Open Source Identity Solutions For Everyone](https://www.ory.sh/)
-   [Auth. Built for Devs, by Devs - FusionAuth](https://fusionauth.io/)


## FAQ {#faq}


### Where to store auth/session token? {#where-to-store-auth-session-token}

-   See [Identity Management]({{< relref "20230301205430-identity_management.md" >}}) and [API Design]({{< relref "20230302195820-api_design.md" >}})
-   Preference is to use cookies for storing auth stuff.
-   For user preference etc. local storage is fine.
-   URL Params / URL args / POST Body : Using these is not recommended but possible for obvious reasons
-   Cookies
    -   XSS can be tightened w HTTPOnly cookie
    -   Browser will automatically send cookies so no additional handling of auth stuff required
    -   Can be set across subdomains. So you can use the same auth for `a.x.com` and `b.x.com` which is cool.
    -   Easy to clear also
-   Local storage
    -   XSS possible
    -   Only per origin
    -   Not suitable for sensitive stuff
    -   Have to send the auth token yourself
-   Session storage
    -   Similar to Local Storage but better in this regard
-   See [Cookies]({{< relref "20230615111924-cookies.md" >}})
-   See [Web Storage]({{< relref "20230615111830-web_storage.md" >}})


### What are the ways to do [Authentication]({{< relref "20230301191046-authentication.md" >}})? {#what-are-the-ways-to-do-authentication--20230301191046-authentication-dot-md}

-   Assuming we **not** dealing with [OIDC (OpenID Connect)]({{< relref "20230301191046-authentication.md#oidc--openid-connect" >}}) here.
-   We have two options, [Web Sessions]({{< relref "20231102113142-web_sessions.md" >}}) and [JWT]({{< relref "20230301214248-jwt.md" >}}). For both, [Cookies]({{< relref "20230615111924-cookies.md" >}}) are a safe storage mechanism. But not necessarily all the time. Here comes "it depends".
