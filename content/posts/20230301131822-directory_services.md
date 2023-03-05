+++
title = "Directory Services"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Security]({{< relref "20221101184454-security.md" >}}), [Linux]({{< relref "20221101150211-linux.md" >}})

There are two parts to this:

-   Directory servers for application
-   System authentication/authorization


## Clients {#clients}

-   Linux/FreeBSD/Solaris uses [PAM]({{< relref "20230228014608-pam.md" >}})


## LDAP {#ldap}


### The Protocol {#the-protocol}

-   LDAP is an Internet alternative to the X.500 Directory Access Protocol (`X.511 DAP`).
-   Workloads LDAP is used for most often are things RDBMSs suck at.
-   Built on X.500 directory specification
-   ~~LDAP is a directory service.~~
-   LDAP is just a protocol to access a directory; there can be different data storage backends.
-   Authentication by default uses plaintext
    -   can use TLS or instead use Kerberos for auth
-   LDAP can be used for authentication and authorization.
-   Can be used with Kerberos, there are pros and cons
-   You should be able to put any modern Authenticator on top of your existing LDAP forest.


### LDAP Servers {#ldap-servers}


#### 389 {#389}

-   Red Hat's LDAP
-   389 is afaik full-featured enterprise LDAP server


#### OpenLDAP {#openldap}

-   Pain to setup


#### LLDAP {#lldap}

-   LLDAP instead provides a minimalistic LDAP server that supports the subset of LDAP needed for user management and authentication, with almost no configuration required, and a nice UI/API in front of it.
-   you just want some simple to set up user management (just users and groups) for common services like Nextcloud or Authelia, LLDAP is for you
-   <https://github.com/nitnelave/lldap>


#### glauth {#glauth}

-   <https://github.com/glauth/glauth>


### LDAP Servers + Framework {#ldap-servers-plus-framework}

<div class="warning small-text">

> **DNS SRV records**
>
> Entries in your DNS server so systems to can perform service lookups, which server should I look for when doing and LDAP query, stuff like that.
</div>


#### FreeIPA {#freeipa}

-   Much more featurefull than plain LDAP
-   Manages Linux hosts, allows users to log in/SSH into the hosts, Kerberos security policies, Apache frontend, a DNS server, DogTag CA, 389 LDAP server, SSSD, and so on.
-   Depends on `DNS SRV` records to work correctly
-   It can also setup a trust to AD, but AD and FreeIPA should never share the same IP space.


#### Active Directory(AD) {#active-directory--ad}

-   AD is LDAP+krb5, and as part of making krb5 work easily, it also handled DNS+ddns+NTP
-   The pain of running Windows Server is outweighed by the excellence, stability, effortless scalability, and programmability of AD.
-   Connecting FreeIPA (IPA) to Active Directory allows people to authenticate to Linux servers using their Windows Active Directory accounts.


### LDAP alternatives {#ldap-alternatives}

-   There is no proper alternative to LDAP. You could go crazy with creating a database schema with user information specific to your needs.
-   Azure Active Directory and "Directory-as-a-Service" options like JumpCloud, Okta LDAP etc.


## Auth backends {#auth-backends}

-   OpenID Connect
-   SAML
-   [Kerberos]({{< relref "20230301183027-kerberos.md" >}})
    -   Released in 1988
    -   Kerberos is an authentication protocol which is used to establish identity of users, hosts or service.
    -   Keycloak has User Federation feature, where you can use Kerberos for getting LDAP users.
-   See [Authentication]({{< relref "20230301191046-authentication.md" >}})


## Actually setting it up {#actually-setting-it-up}

This is just one scenario

-   Configure [nsswitch]({{< relref "20230228000520-nsswitch.md" >}}) to use the `OpenLDAP` server as a source for the `passwd`, `shadow` and other configuration databases
-   Configure [PAM]({{< relref "20230228014608-pam.md" >}}) to use these sources to authenticate its users.


## Resources {#resources}

-   [Open Source Guide - LDAP for Rocket Scientists - Contents](https://www.zytrax.com/books/ldap/)
-   <https://www.reddit.com/r/linuxadmin/comments/3xj6q3/central_authentication_directory_servers_primer/>
