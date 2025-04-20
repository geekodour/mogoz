+++
title = "Notifications & Reminders (Backend)"
author = ["Hrishikesh Barman"]
draft = false
+++

## Push Notifications {#push-notifications}

-   Listen for notifications
    -   <https://gotify.net/>
-   Receive Notifications
    -   <https://pushover.net/pricing>
    -   <https://ntfy.sh/>
-   Unified push
    -   <https://f-droid.org/2022/12/18/unifiedpush.html>
    -   <https://firebase.google.com/docs/cloud-messaging>
-   Send notifications
    -   <https://github.com/nikoksr/notify>
    -   <https://github.com/caronc/apprise> (send to multiple channels)


### ntfy vs gotify {#ntfy-vs-gotify}

ntfy
    Pro: No need to create communication channels ahead of time. Sending and subscribing Just Work.
    Pro: Anyone can send or subscribe on a given channel. For my purposes this makes things a lot simpler.
    Con: Fragile when self-hosted. I spent hours trying to get the configuration just right for messages to be delivered to my phone. It works, though the website still never reports any messages being posted.
gotify
    Pro: Self-hosted installation was trivial. Created the docker-compose config, started it up, it was immediately available via phone app and web.
    Con: User separation. A user can create "apps" (channels), and will receive messages posted there. Users will not receive messages posted to apps they didn't create. I haven't yet found a way to create shared apps, or allow multiple clients to receive notifications for a given message, and I don't want to share client logins.
