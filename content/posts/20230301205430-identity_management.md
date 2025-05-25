+++
title = "Identity Management"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Security]({{< relref "20221101184454-security.md" >}}), [Authentication]({{< relref "20230301191046-authentication.md" >}}), [Authorization]({{< relref "20230301205620-authorization.md" >}})


## Two parts {#two-parts}

-   [Authentication]({{< relref "20230301191046-authentication.md" >}}) (are you actually the person you say you are)
-   [Authorization]({{< relref "20230301205620-authorization.md" >}}) (are you allowed to do what you are trying to do.)


## SSO {#sso}


### Covering all bases for SSO {#covering-all-bases-for-sso}

To cover all your bases, you need 2 identity providers. Any modern identity provider worth itself will also be able to sync back to an LDAP server to keep the two consistent.

-   An LDAP server that's preferably not exposed to the web
-   An SSO identity provider that is exposed to the web.


## Products {#products}

There are opensource and prioperty Products

| Name          | Type               | Remark                                                                                                   | Released/Founded |
|---------------|--------------------|----------------------------------------------------------------------------------------------------------|------------------|
| Keycloak      | Open Source        | Mature open-source IAM solution, Java-based, highly customizable.                                        | 2014             |
| Authentik     | Open Source        | Modern open-source Identity Provider (IdP), focuses on flexibility and integrations.                     | ~2020            |
| Authelia      | Open Source        | Open-source authentication and authorization server, often paired with reverse proxies for SSO.          | ~2019            |
| Ory Kratos    | Open Source        | API-first, headless identity &amp; user management system, part of the Ory ecosystem.                    | 2016             |
| Casdoor       | Open Source        | UI-first open-source IAM/SSO platform supporting various protocols.                                      | ~2020/2021       |
| Supertokens   | Open Source / SaaS | Open-source authentication, often noted for session management, offers a hosted service too.             | 2019             |
| Zitadel       | Open Source / SaaS | Cloud-native open-source identity platform built in Go, focuses on multi-tenancy and B2B.                | ~2019/2020       |
| Okta          | SaaS (IDaaS)       | Major enterprise-grade cloud Identity and Access Management (IAM) service.                               | 2009 (Founded)   |
| Auth0         | SaaS (IDaaS)       | Developer-focused identity platform, known for ease of implementation, acquired by Okta.                 | 2013 (Founded)   |
| Clerk         | SaaS (IDaaS)       | Developer-focused authentication &amp; user management, strong frontend component library (React, etc.). | ~2021            |
| Firebase Auth | BaaS Feature       | Part of Google's Firebase platform, provides backend authentication services for apps.                   | ~2016            |
| Supabase Auth | BaaS Feature       | Authentication component of Supabase (open-source Firebase alternative), built on PostgreSQL.            | ~2020            |
| AWS Cognito   | Cloud Service      | AWS identity service for web/mobile apps, offering user pools and federated identities.                  | 2014             |


### Keycloak {#keycloak}

-   Open-source identity and access management by RedHat
-   Managing users, roles, and permissions, as well as for implementing multi-factor authentication and social login.
-   Supports authentication mechanisms such as OpenID Connect, OAuth 2.0, and SAML
-   You also need to use their template and plugin system (so Java for Keycloak)
-   Can't use a different OAuth2 provider because well - you use Keycloak
-   Needs to be selfhosted
-   [Keycloak with PostgreSQL on Kubernetes | Hacker News](https://news.ycombinator.com/item?id=35515873)


### Auth0 {#auth0}

-   Dedicated to providing its solution in the SaaS model.
-   Owned by Okta now


### Okta {#okta}

-   Identity SaaS product


### Ory {#ory}

{{< figure src="/ox-hugo/SCR-20250426-ntlh.png" >}}

-   Has both selfhosted and SaaS based(Ory Network)
-   Not [super mature](https://www.ory.sh/docs/ecosystem/versioning)


#### Ory Kratos {#ory-kratos}

-   Released 2018
-   Headless
-   User registration, login, password reset, social sign in(Client side OAuth2), profile management, 2FA, and more
-   [Ory Kratos: Headless Authentication, Identity and User Management - Developer Friendly Blog](https://developer-friendly.blog/2024/05/20/ory-kratos-headless-authentication-identity-and-user-management/#identity-schema)


#### Ory Hydra {#ory-hydra}

-   OAuth/OIDC provider
-   Have multiple apps that need a common sign-in method (SSO)
-   3rd parties to access your users data safely etc.


#### Oathkeeper {#oathkeeper}

-   2017 : Access control for API endpoints

<!--list-separator-->

-  Can be run in 2 modes

    <!--list-separator-->

    -  Reverse Proxy Mode

        -   Acts as a gatekeeper, intercepting client traffic before upstream services.
        -   Applies access rules (authentication, authorization, mutation).
        -   Forwards allowed requests upstream.
        -   Rejects denied requests with an error.
        -   Functions as the Policy Enforcement Point (PEP).

    <!--list-separator-->

    -  Decision API Mode (Policy Decision Point)

        -   Exposes a decision API (e.g., `/decisions`) queried by an external proxy/gateway.
        -   External proxy sends request details to Oathkeeper for evaluation.
        -   Oathkeeper evaluates rules and returns an allow/deny decision.
        -   External proxy enforces the decision (forwards or blocks).
        -   Oathkeeper acts as the Policy Decision Point (PDP).
        -   Allows integration with existing infrastructure (which acts as the PEP).
        -   Reverse Proxy: Caddy like usecase but does the auth for you
        -   Decision API:


#### Keto {#keto}

-   Authorization, define advanced permission rules (“Access Control Policies”)
-   Permission management, roles, who is allowed to do what


### Supertokens {#supertokens}

-   Ory has criticized these guys of using incorrect terms and specs etc.


### Authentik {#authentik}

-   Authentik is a full LDAP container reimplementation with many bell and whistles.


### Authelia {#authelia}

-   Authelia needs a LDAP or file backend with user credentials


## Others {#others}

-   <https://github.com/go-pkgz/auth>
-   <https://github.com/Permify/permify>
