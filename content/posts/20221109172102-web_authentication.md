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


### Setting up auth for golang webapp {#setting-up-auth-for-golang-webapp}

-   See [Identity Management]({{< relref "20230301205430-identity_management.md" >}})
-   My current pref. is Ory Katros, Supabase(with HTTPOnlyCookies to store the [JWT]({{< relref "20230301214248-jwt.md" >}})), Pocketbase based on convinience and featuers needed
    -   Supabase and pocketbase gives me the nice UI which is super nice for prototyping
        -   Supabase when using [PostgreSQL]({{< relref "20221102123302-postgresql.md" >}}), Pocketbase when using [sqlite]({{< relref "20230702184501-sqlite.md" >}})
    -   Ory doesn't have the UI offering in the open source version but seems like the one to go with if we need anything more than supabase/pocketbase
    -   We can roll our custom one but since I don't want to do much backend stuff esp things other ppl have done better, better to avoid it as i really most of the time need the whole suite of things, eg. password reset, confirmation email all of which becomes real complicated if done manually
-   For API auth, things can be different the following comment has decent suggetion
    ![](/ox-hugo/20221109172102-web_authentication-784196282.png)
-   There's also something called the phantom token approach which i dont think i need really
    -   [Securing APIs with The Phantom Token Approach | Curity](https://curity.io/resources/learn/phantom-token-pattern/)


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
