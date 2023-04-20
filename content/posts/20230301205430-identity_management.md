+++
title = "Identity Management"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Security]({{< relref "20221101184454-security.md" >}}), [Authentication]({{< relref "20230301191046-authentication.md" >}})


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

| Name          | Remark | Released |
|---------------|--------|----------|
| Keycloak      |        | 2014     |
| Authentik     |        |          |
| Authelia      |        |          |
| Ory           |        | 2016     |
| Okta          |        |          |
| AWS Cognito   |        |          |
| Auth0         |        |          |
| Clerk         |        |          |
| Firebase Auth |        |          |
| Supabase Auth |        |          |
| Supertokens   |        | 2019     |


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

-   Has both selfhosted and SaaS based(Ory Network)
-   Not [super mature](https://www.ory.sh/docs/ecosystem/versioning)


#### Ory Kratos {#ory-kratos}

-   Released 2018
-   Headless
-   User registration, login, password reset, social sign in(Client side OAuth2), profile management, 2FA, and more


#### Ory Hydra {#ory-hydra}

-   OAuth/OIDC provider
-   Have multiple apps that need a common sign-in method (SSO)
-   3rd parties to access your users data safely etc.


#### Oathkeeper {#oathkeeper}

-   2017
-   Access control for API endpoints


#### Keto {#keto}

-   Authorization, define advanced permission rules (“Access Control Policies”)
-   Permission management, roles, who is allowed to do what


### Supertokens {#supertokens}

-   Ory has criticized these guys of using incorrect terms and specs etc.


### Authentik {#authentik}

-   Authentik is a full LDAP container reimplementation with many bell and whistles.


### Authelia {#authelia}

-   Authelia needs a LDAP or file backend with user credentials
