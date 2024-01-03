+++
title = "Problems in Education"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [education]({{< relref "20220625162205-education.md" >}})


## Random {#random}


### Teaching and Learning {#teaching-and-learning}

-   Student satisfaction != Teaching Quality and Schooling != Education.
-   People think a 'modern' classroom is one that has tech. No, a modern classroom is one that treats students differently - foregrounds their agency in constructing their understanding, removes the hierarchy in learning. You can have a lot of tech and still run an outdated classroom - Subir Shukla
-   Lack of proper mentorship.
-   Not having enough teachers
-   Not having enough teachers that are trained
-   Pedagogy is not right
-   Poor learning levels
-   How to keep good teachers in rural schools
-   Teacher education currently does not raise or appreciate the curiosity of teachers. There are so many bricks but not so many houses of the right kind, there are so many teachers but not many of the right kind.
-   Current teachers lack the understanding to use modern edtech tools. Eg. Teacher telling students to upload photos of handwritten assignments to Google Classroom, of which the answer is the exact same for every student. On top of that, commercialized solutions will be trying to vendor lock in things which ppl need to be aware of.


### Policymaking and Management {#policymaking-and-management}

-   Policy makers are confused where should they prioritize
-   Very little assessment to compare one school to another
-   Not enough data to understand the disparity among schools
-   No trust in books, I was not sure if my book was teaching me the right math because there were so many mistakes.
-   Students don't trust the board. Papers get leaked, results come out without verification. Some student who didn't give exams comes out as passed!


### Schools {#schools}

-   The current education system demotivates students.
-   Learning gap between govt and private schools [see this](http://www.ncaer.org/event_details.php?EID=38), [and this](https://yourstory.com/socialstory/2019/04/andhra-pradesh-govt-schools-reducing-learning-gap)
-   Huge gap between globalization and Indian students belonging to middleclass and below middleclass families. Internet is filling the gap in an opaque manner.


### General {#general}

-   The issue here is, we have so much knowledge here and there.
-   Language problem: It might seem like that we've solved the language problem because you can translate any document/website/book using Google Translate to your own language with somewhat accuracy. Also authors who realize the potential of their books can opt in for translations to various languages. Now we can either bring all of them into one single language and have everyone understand that language. That will be loss for diversity. Different languages hinders accessibility though, eg. If an Assamese writer wrote an amazing book in Assamese and it never got translated to some other local language because there's no market for it. What if some kid would really be inspired by the content of that book, which he was denied accessbility just because he cannot read/understand that language. Licensing can solve this partly. ****More****: several parties are fluent in various languages, but none of them speak the others' native language. However they all speak a little Esperanto. While they might get by with numerous translations of other languages, each language being understood by a few participants, Esperanto is the lowest common denominator.


## Some problem statements {#some-problem-statements}


### Training Wheels for Curiosity Driven Development {#training-wheels-for-curiosity-driven-development}

-   Context, Assumptions and Scope:
    -   Consider an individual who wants to create things with the motivation to understand the inner workings of the "thing". (Eg. A text editor, A web server, A system that counts kittens in the neighborhood)
    -   While the "thing" could be software+hardware, for simplicity we scope it down to creating software(of varying complexity) only.
    -   Catch is, individual may not have created anything similar before and can also lack domain knowledge.
    -   In such a situation, usually the individual would try to "figure it out".
    -   We want to make the process of "figuring it out" more convenient for educational purposes and if possible put guard-rails against common learning pitfalls.
-   Constraints:
    -   We can assume the individual has basic understanding of programming and logic. Has sufficient google-fu, can whiteboard ideas, collaborate, take help of LLMs etc.
    -   Since the goal here is educational, we're not super concerned about things like code readability/reliability unless that's part of the understanding.
    -   Unlike traditional software development with strict requirements, we encourage individuals to explore specific topics freely.
    -   Balance exploration to avoid overwhelming them with a massive explanatory task, ensuring focus on their main goal.
-   Question:
    -   Can we build a system which would provide training wheels which can help an individual gather, navigate, validate, analyze, plan, discover, breakdown etc. Make these training wheels optional, as in they'll reach-out when needed otherwise they can be on their own. This "system" can be a human suggesting things based on some framework or can be computer system suggesting things while adapting changes from the individual.

    -   Gather: Eg. Gather initial details that the individual might have missed when formulating what they want to build
    -   Navigate: Eg. Learn more about domains, it's history and how it applies to the context of building what they're trying to build
    -   Validate: Eg. If the thing they're trying to build is possible in the model of computation they're imagining
    -   Analyze: Eg. Measuring tradeoffs of dependencies, approaches to a problem, how different components would connect etc.
    -   Plan: Eg. Draft out a dynamic syllabus for understanding of the thing they're trying to build, Breaking it down to manageable chunks
    -   Discover: Eg. Find learning opportunities when doing this project, Help see the same idea from different perspectives
-   Problems:
    -   Relevance and Perspectives
        -   How do we adjust the starting point of the suggestions, too basic/too advanced?
        -   Do we suggest to look at it from a programmer perspectives or SWE or computer scientist or something else?
        -   Which perspectives are most useful for learning when building what they're building?
        -   How do we adjust our suggestions as the individual discovers/gathers new constraints on what they want to build. i.e keeping the suggestions relevant to the scope.
    -   Striking a balance between learning and execution
        -   Sometimes we can get away with learning only little, and we can then go on finishing what we set out to build. What is the individual missing out by not spending more time learning about the topic.
        -   Do we suggest them to use solutions that are known to them, or solutions which are new to them? Can we find a path from what they know to what they don't know?
    -   Ensuring suggestion/mentoring are taken for what they're worth
        -   The person can find resources on the internet and though other mediums but there's always the possibility to be misguided. Sometimes this only can be realized in hindsight. It applies here as-well.
        -   Sometimes building certain things truly needs years of practice/experience. Such barriers should be made clearer, so that the individual can better plan on how they're going to execute/cut corners etc. instead of doubting their abilities
        -   There's a need to understand what the individual is struggling with and where exactly the help is needed. (XY problem)
        -   What kind of help do we offer? a pointer? an example? a reference? a tool for xray vision into the problem at hand?
    -   Providing Domain knowledge
        -   Challenges with an unbounded/multiple domain. This phase usually needs back and forth.
        -   Ensuring accuracy of domain information
        -   Awareness of specialized methods/notations for consolidating ideas in that domain
        -   Helping see/build the bridge between the domain and how they're going to represent in an computing environment
    -   Social and Practices
        -   Is it even a good idea to just go on build something without proper domain knowledge? We can say, it depends.
        -   This is an alternative to that tutorial which teaches you to build a search engine in 30 minutes
        -   We want the individual to have an realistic idea of what they set out to build


### Outdated syllabus {#outdated-syllabus}


### Better training wheels {#better-training-wheels}

-   How to choose better problems?
-   Intervene if spending too much time in a problem
-   How to know the unknown
-   How to look at the problem from a different angle
    -   Sometimes we're unaware of the angle
-   How to be aware of wrong mentoring
-   How to know of the missing fundamental blocks?


### Better visual mental model of problem at hand {#better-visual-mental-model-of-problem-at-hand}

-   How does history relate
-   Domain knowledge
-   User generated wisdom


### Local learning {#local-learning}

-   Faster feedback loop


### Notations for time {#notations-for-time}
