+++
title = "Tactical Knowledge"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Notetaking]({{< relref "20221102000904-notetaking.md" >}}), [Learning How to learn]({{< relref "20220625142317-learning_how_to_learn.md" >}}), [General Programming]({{< relref "20230122140847-general_programming.md" >}})


## Web stuff {#web-stuff}


### Custom domain for a website {#custom-domain-for-a-website}

-   This is a issue that's bugging me for years now
-   [The ultimate guide to custom domains for your SaaS app](https://saascustomdomains.com/blog/posts/the-ultimate-guide-to-custom-domains-for-your-saas-app)
-   It basically boils down to
    -   They CNAME their domain to your subdomain(CNAME)
    -   In your application you need to handle based on domain/host field
    -   Maintain a db of custom domain and user to serve correct content.
-   TLS management is a problem, caddy probably helps(ondemandtls) w it but cloudflare has a sass solution, more info
    -   [SaaS custom domain application : devops](https://www.reddit.com/r/devops/comments/p5gtuv/saas_custom_domain_application/)
-   Relevant discussions
    -   It's called multi tenant apps: <https://demo.vercel.pub/platforms-starter-kit>
    -   <https://github.com/orgs/vercel/discussions/31>
    -   [Has anyone ever implemented custom domains for their customers? : SaaS](https://www.reddit.com/r/SaaS/comments/12x9oqe/has_anyone_ever_implemented_custom_domains_for/)
    -   [Custom domain on a multi-tenant SAAS app : laravel](https://www.reddit.com/r/laravel/comments/pk7pq8/custom_domain_on_a_multitenant_saas_app/)
    -   [dns - How do I enable custom domains for my users? - Stack Overflow](https://stackoverflow.com/questions/35092287/how-do-i-enable-custom-domains-for-my-users)
    -   [How do you allow users to add a custom domain?](https://www.indiehackers.com/post/how-do-you-allow-users-to-add-a-custom-domain-ba3fbcc35a)
