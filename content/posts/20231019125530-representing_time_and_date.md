+++
title = "Representing Time and Date"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Human Computer Interaction ( HCI )]({{< relref "20230806231355-human_computer_interaction_hci.md" >}}), [Database]({{< relref "20221102123145-database.md" >}}), [Clocks]({{< relref "20231119003900-clocks.md" >}})


This is interesting to me, notations and ways to represent date and time

There's something called metric time


## Resources {#resources}


## Different ways to show {#different-ways-to-show}


### Calendar {#calendar}

-   [We Need to Talk About the State of Calendar Software on Desktop | Lobsters](https://lobste.rs/s/fex5ji/we_need_talk_about_state_calendar)
-   [This is what the year actually looks like (2018) | Hacker News](https://news.ycombinator.com/item?id=37926239)
-   [Deciyear Calendar | Hacker News](https://news.ycombinator.com/item?id=38639415)
-   [the human calendar®: about](https://humancalendar.com/about)
-   [Show HN: KittyCal – minimalist PWA calendar app for couples | Hacker News](https://news.ycombinator.com/item?id=41153712)
-   WhenFS
-   [The Calendar of Sound of Hermeto Pascoal (2020) [pdf] | Hacker News](https://news.ycombinator.com/item?id=41338159)
-   [Holocene calendar - Wikipedia](https://en.wikipedia.org/wiki/Holocene_calendar)


### Clock {#clock}

-   [Author Clock: a novel way to tell time | Hacker News](https://news.ycombinator.com/item?id=40644960)
-   [Linear Clock | John Whittington's Blog](https://engineer.john-whittington.co.uk/electronics/fabrication/mechanical/clock/2021/06/16/linear-clock.html)
-   [Lenticular Clock | Hacker News](https://news.ycombinator.com/item?id=41293929)
-   <https://www.humanclock.com/>


## Date, Time and Timezone {#date-time-and-timezone}


### Meta {#meta}

-   `data` : Doesn't have a time component but what actual point-in-time it is really is determined by the reader of the data(where they live)
-   `date/time` : Same as date. The correct time is determined by what timezone your location is assigned to.
    -   `date/time` by itself doesn't seem


#### What to go with? {#what-to-go-with}

|                  | point-in-time data        | interop btwn systems | different systems ops | sortable |
|------------------|---------------------------|----------------------|-----------------------|----------|
| unix timestamp   | YES                       | YES                  | YES                   | YES      |
| date time w tz   | YES + tz origin data      | No, needs logic      | YES                   | YES      |
| date time w/o tz | No, represent social time |                      |                       |          |


#### Which timezone to pick? (If you picked `date time w tz`) {#which-timezone-to-pick--if-you-picked-date-time-w-tz}

-   If you just want `date` and don't want time component, UTC+000 seems like a way to go.
-   If you need to know the original timezone of the event, then store it with the original timezone.
-   Unless you have a reason to store something in a local timezone, UTC is the right choice, but no choice is perfect.
-   If using pg, use:
    -   `date`
    -   `time`
    -   `timestamp {without|with} time zone`
        -   `timestamp without time zone` essentially [falls into UTC](https://stackoverflow.com/questions/5876218/difference-between-timestamps-with-without-time-zone-in-postgresql)
    -   AVOID `time with timezone`
        -   See <https://gist.github.com/henryivesjones/ebd653acbf61cb408380a49659e2be97>


#### More on unix timestamp (from some article) {#more-on-unix-timestamp--from-some-article}

-   Common misconception is that Unix time can’t be used to represent dates before January 1st, 1970.
    -   It is timezone agnostoc works across timezones
-   Unlike Unix timestamp, there is no such thing as a universal DateTime format. Each programming language or tool relies on its own internal logic and implementation details for this data type. For the purpose of this article, we’ll categorize DateTime as an embedded calendar-aware and timezone-aware module, capable of handling the complexity of modern time-keeping systems.


### Resources {#resources}

-   [ ] [ISO 8601: the better date format | Blog | Kirby Kevinson](https://kirby.kevinson.org/blog/iso-8601-the-better-date-format/)
-   [ ] [Timezone-naive datetimes are one of the most dangerous objects in Python | Hacker News](https://news.ycombinator.com/item?id=40977293)
-   [ ] [Designing a REST API: Unix time vs ISO-8601](https://nickb.dev/blog/designing-a-rest-api-unix-time-vs-iso-8601/)
-   [ ] [Time on Unix](https://venam.nixers.net/blog/unix/2020/05/02/time-on-unix.html)
-   [ ] [Time is an illusion, Unix time doubly so](https://www.netmeister.org/blog/epoch.html)
-   [ ] [Ian Mallett - Reference: Time Standards Page](https://geometrian.com/programming/reference/timestds/index.php)
-   [ ] [Falsehoods programmers believe about time zones](https://www.zainrizvi.io/blog/falsehoods-programmers-believe-about-time-zones/)
-   [-] [Wesley Aptekar-Cassels | Timezone Bullshit](https://blog.wesleyac.com/posts/timezone-bullshit)
-   [-] [Storing UTC is not a silver bullet (2019) | Lobsters](https://lobste.rs/s/5suewc/storing_utc_is_not_silver_bullet_2019)
-   [X] [You might as well timestamp it |&gt; Changelog](https://changelog.com/posts/you-might-as-well-timestamp-it)
-   [X] [You (probably) don't need DateTime · Scorpil](https://scorpil.com/post/you-dont-need-datetime/)
