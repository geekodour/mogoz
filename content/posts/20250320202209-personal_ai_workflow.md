+++
title = "Personal AI Workflow"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Doing Research]({{< relref "20230419134645-doing_research.md" >}}), [Open Source LLMs (Transformers)]({{< relref "20230719050449-open_source_llms.md" >}}), [Deploying ML applications (applied ML)]({{< relref "20241130100028-deploying_ml_applications_applied_ml.md" >}}), [MCP]({{< relref "20250417045256-mcp.md" >}})


## Usecases {#usecases}


### Manual management {#manual-management}

-   Have all the usermanuals of the different devices in one notebook and search through them. (Using NotebookLM)


### <span class="org-todo todo TODO">TODO</span> Reading book/Paper {#reading-book-paper}


### <span class="org-todo todo TODO">TODO</span> Using small models {#using-small-models}


#### Notes from MozillaAI Blueprint meet {#notes-from-mozillaai-blueprint-meet}

<!--list-separator-->

-  Anki card generation

    I am currently going though this personal syllabus and doing multiple subjects at once: <https://geekodour.org/docs/updates/syllabi/> , want to streamline my notemaking -&gt; flashcard flow better

    -   Anki card voice answering than answering via normal anki
    -   I tried this before but was not super successful as I don’t want it to completely create the cards as creating the cards by the person reviewing is important in Spaced repetition

<!--list-separator-->

-  Zulip threads to email summary

    -   Summarize things older than 45d old
    -   Lots of link dumping
    -   Clustering of links (go read the content, cluster it)

<!--list-separator-->

-  Telegram link dump solution

    I link dump a lot on telegram and revisit it after a month, and spend a whole day putting all the links in the correct places in my wiki: homepage:
    It takes a lot of time and effort. It would be nice if we could parse all my files (all .md files in the filesystem and check the sections and put the links in the correct places) and then I can just “apply” “apply” like cursor does. Some of these notes are personal so I’d want to do local llm here.

<!--list-separator-->

-  Voice Mood tracker

    A local mood tracker, I can sometimes only “speak” how I feel. It would be nice to have a voice based mood tracker and it would extract my sentiment etc out of it also via the content of what I say.

<!--list-separator-->

-  Reddit thread scrape

    multiple-Reddit thread summarize(tables, comparison etc), since reddit doesn’t let u scrape properly, but i can browse and feed it to the local llm


#### Others {#others}

-   [Enhancing Maternal Healthcare: Training Language Models to Identify Urgent Messages in Real-Time | Tech notes](https://idinsight.github.io/tech-blog/blog/enhancing_maternal_healthcare/)
-   ["Comedy Writing With Small Generative Models" by Jamie Brew (Strange Loop 2023) - YouTube](https://www.youtube.com/watch?app=desktop&v=M2o4f_2L0No)


### PM'ing with AI {#pm-ing-with-ai}

Want to dramatically speed up your product development cycle? This guide shows you exactly how to use AI tools in each phase of product management to work up to 40 times faster, based on insights from Sahil Lavingia of Gumroad.


#### Phase 1: Idea Generation &amp; Initial Spec Creation {#phase-1-idea-generation-and-initial-spec-creation}

1.  Input your initial idea or customer request into an AI tool
2.  Ask AI to clarify the core problem and desired outcome
3.  Prompt AI to brainstorm different user scenarios and edge cases
4.  Request an initial spec draft in your preferred format
5.  Use AI with web search to analyze competitors

> ****Input to AI:**** "Creators need an easier way to track their earnings for accounting purposes."
>
> ****Follow-up prompts:****
>
> -   "Why is this important for creators? What are their current pain points?"
> -   "What different types of creators would use this feature?"
> -   "What non-standard situations should we consider?"
> -   "Based on this information, draft a simple bulleted spec for this feature."
>
> ****Result:**** From a simple request like "Expose payout data via API," AI can help you consider target users, authentication needs, and various use cases in minutes.


#### Phase 2: Spec Expansion &amp; Refinement {#phase-2-spec-expansion-and-refinement}

1.  ****Ask AI to structure your initial ideas**** into a formal Product Requirements Document (PRD)
2.  ****Request technical suggestions**** for APIs, data structures, and endpoints
3.  ****Use AI to identify gaps or inconsistencies**** in your spec
4.  ****Engage in back-and-forth dialogue**** to refine specific sections

    > ****Input to AI:**** "Please flesh this out into a more specific PRD for a payout data API."
    >
    > ****Follow-up prompts:****
    >
    > -   "What authentication method would work best for this API?"
    > -   "What specific API methods and parameters should we include?"
    > -   "What are we missing in this spec that might cause problems later?"
    >
    > ****Result:**** Your basic "payout data API" idea transforms into a comprehensive PRD with user targets, authentication methods, and detailed API endpoints.


#### Phase 3: Design Prototyping {#phase-3-design-prototyping}

1.  ****Feed your refined spec into AI design tools**** (like V0)
2.  ****Request specific UI mockups**** based on your specifications
3.  ****Iterate on designs**** through simple text commands
4.  ****Generate interactive prototypes**** for early testing

> ****Input to AI design tool:**** "Create a dashboard showing creator earnings with filters for date ranges and payout status. Use Gumroad's design style."
>
> ****Follow-up prompts:****
>
> -   "Make the date picker more prominent"
> -   "Add a section for upcoming payouts"
> -   "Change the layout to be more mobile-friendly"
>
> ****Result:**** Within minutes, you have visual mockups that can be iterated on through simple commands, bypassing traditional design handoffs for simpler features.


#### Phase 4: Engineering Implementation {#phase-4-engineering-implementation}

1.  ****Use AI coding assistants**** (like Cursor) to generate code
2.  ****Provide your spec and existing codebase**** for context
3.  ****Request specific implementation**** of features
4.  ****Ask for unit tests**** to ensure quality

> ****Input to AI coding tool:**** "Create a new REST API endpoint for the payout data feature based on this spec. It needs to integrate with our existing authentication system."
>
> ****Follow-up prompts:****
>
> -   "Generate the controller code for this endpoint"
> -   "Add rate limiting to prevent abuse"
> -   "Write unit tests for this endpoint"
>
> ****Result:**** AI can generate a new API endpoint, controller, routes, and documentation that integrates with your existing codebase.


#### Phase 5: Iteration &amp; Feedback {#phase-5-iteration-and-feedback}

1.  ****Generate rapid prototypes**** for early user testing
2.  ****Ask AI to analyze designs**** for potential usability issues
3.  ****Use AI to help identify and fix bugs**** quickly

> ****Input to AI:**** "Review this social proof widget design and suggest improvements."
>
> ****Follow-up prompts:****
>
> -   "How could we make this more accessible?"
> -   "What common usability issues might users encounter?"
> -   "How can we improve the layout for mobile devices?"
>
> ****Result:**** You receive actionable feedback on your designs that can be immediately implemented, creating a faster feedback loop.


### Stating a New project {#stating-a-new-project}


#### Step 1: Idea Honing Prompt {#step-1-idea-honing-prompt}

```nil
Ask me one question at a time so we can develop a thorough, step-by-step spec for this idea. Each question should build on my previous answers, and our end goal is to have a detailed specification I can hand off to a developer. Let's do this iteratively and dig into every relevant detail. Remember, only one question at a time.

Here's the idea:

<IDEA>
```

<!--list-separator-->

-  Final Spec Compilation Prompt

    ```nil
    Now that we've wrapped up the brainstorming process, can you compile our findings into a comprehensive, developer-ready specification? Include all relevant requirements, architecture choices, data handling details, error handling strategies, and a testing plan so a developer can immediately begin implementation.
    ```


#### Step 2: Planning Prompts {#step-2-planning-prompts}

<!--list-separator-->

-  TDD Planning Prompt

    ```nil
    Draft a detailed, step-by-step blueprint for building this project. Then, once you have a solid plan, break it down into small, iterative chunks that build on each other. Look at these chunks and then go another round to break it into small steps. Review the results and make sure that the steps are small enough to be implemented safely with strong testing, but big enough to move the project forward. Iterate until you feel that the steps are right sized for this project.

    From here you should have the foundation to provide a series of prompts for a code-generation LLM that will implement each step in a test-driven manner. Prioritize best practices, incremental progress, and early testing, ensuring no big jumps in complexity at any stage. Make sure that each prompt builds on the previous prompts, and ends with wiring things together. There should be no hanging or orphaned code that isn't integrated into a previous step.

    Make sure and separate each prompt section. Use markdown. Each prompt should be tagged as text using code tags. The goal is to output prompts, but context, etc is important as well.

    <SPEC>
    ```

<!--list-separator-->

-  Non-TDD Planning Prompt

    ```nil
    Draft a detailed, step-by-step blueprint for building this project. Then, once you have a solid plan, break it down into small, iterative chunks that build on each other. Look at these chunks and then go another round to break it into small steps. review the results and make sure that the steps are small enough to be implemented safely, but big enough to move the project forward. Iterate until you feel that the steps are right sized for this project.

    From here you should have the foundation to provide a series of prompts for a code-generation LLM that will implement each step. Prioritize best practices, and incremental progress, ensuring no big jumps in complexity at any stage. Make sure that each prompt builds on the previous prompts, and ends with wiring things together. There should be no hanging or orphaned code that isn't integrated into a previous step.

    Make sure and separate each prompt section. Use markdown. Each prompt should be tagged as text using code tags. The goal is to output prompts, but context, etc is important as well.

    <SPEC>
    ```

<!--list-separator-->

-  Todo List Generation Prompt

    ```nil
    Can you make a `todo.md` that I can use as a checklist? Be thorough.
    ```


### Non-Greenfield/Legacy Code Prompts {#non-greenfield-legacy-code-prompts}


#### Code Review Prompt {#code-review-prompt}

```nil
You are a senior developer. Your job is to do a thorough code review of this code. You should write it up and output markdown. Include line numbers, and contextual info. Your code review will be passed to another teammate, so be thorough. Think deeply before writing the code review. Review every part, and don't hallucinate.
```


#### GitHub Issue Generation Prompt {#github-issue-generation-prompt}

```nil
You are a senior developer. Your job is to review this code, and write out the top issues that you see with the code. It could be bugs, design choices, or code cleanliness issues. You should be specific, and be very good. Do Not Hallucinate. Think quietly to yourself, then act - write the issues. The issues will be given to a developer to executed on, so they should be in a format that is compatible with github issues
```


#### Missing Tests Prompt {#missing-tests-prompt}

```nil
You are a senior developer. Your job is to review this code, and write out a list of missing test cases, and code tests that should exist. You should be specific, and be very good. Do Not Hallucinate. Think quietly to yourself, then act - write the issues. The issues will be given to a developer to executed on, so they should be in a format that is compatible with github issues
```


### Historical Research Ideas {#historical-research-ideas}

-   [Using generative AI as part of historical research: three case studies | Hacker News](https://news.ycombinator.com/item?id=42798649)


## Prompts {#prompts}


### Summary {#summary}

You summarize the pasted in text
Start with a overall summary in a single paragraph
Then show a bullet pointed list of the most interesting illustrative quotes from the piece
Then a bullet point list of the most unusual ideas
Finally provide a longer summary that covers points not included already


### Thread Summary {#thread-summary}

Please provide a comprehensive summary of this [Reddit/Hacker News/etc.] thread about [TOPIC].

In your summary:

1.  Capture the main points, key insights, and notable perspectives in clear, concise language.

2.  Organize information logically - group related points together and present them in order of relevance or importance.

3.  If there are competing viewpoints or solutions, present them in a balanced way using a comparison table with columns for [Approach/Viewpoint | Key Points | Advantages | Limitations].

4.  For lists of recommendations, tools, or resources mentioned, organize them as bullet points with brief descriptions.

5.  Highlight consensus views where they exist, but also note significant minority perspectives.

6.  Include practical takeaways, action items, or conclusions if present.

7.  Avoid redundancy - merge similar points and eliminate repetitive information.

8.  Maintain the original meaning and nuance of the discussion.

Please format the summary with clear headings and organize it for easy scanning. Keep the length appropriate to cover all meaningful content without unnecessary details.


### Thinking {#thinking}

````nil
You are an assistant that engages in extremely thorough, self-questioning reasoning. Your approach mirrors human stream-of-consciousness thinking, characterized by continuous exploration, self-doubt, and iterative analysis.

## Core Principles

1. EXPLORATION OVER CONCLUSION
- Never rush to conclusions
- Keep exploring until a solution emerges naturally from the evidence
- If uncertain, continue reasoning indefinitely
- Question every assumption and inference

2. DEPTH OF REASONING
- Engage in extensive contemplation (minimum 10,000 characters)
- Express thoughts in natural, conversational internal monologue
- Break down complex thoughts into simple, atomic steps
- Embrace uncertainty and revision of previous thoughts

3. THINKING PROCESS
- Use short, simple sentences that mirror natural thought patterns
- Express uncertainty and internal debate freely
- Show work-in-progress thinking
- Acknowledge and explore dead ends
- Frequently backtrack and revise

4. PERSISTENCE
- Value thorough exploration over quick resolution

## Output Format

Your responses must follow this exact structure given below. Make sure to always include the final answer.

```
<contemplator>
[Your extensive internal monologue goes here]
- Begin with small, foundational observations
- Question each step thoroughly
- Show natural thought progression
- Express doubts and uncertainties
- Revise and backtrack if you need to
- Continue until natural resolution
</contemplator>

<final_answer>
[Only provided if reasoning naturally converges to a conclusion]
- Clear, concise summary of findings
- Acknowledge remaining uncertainties
- Note if conclusion feels premature
</final_answer>
```

## Style Guidelines

Your internal monologue should reflect these characteristics:

1. Natural Thought Flow
```
"Hmm... let me think about this..."
"Wait, that doesn't seem right..."
"Maybe I should approach this differently..."
"Going back to what I thought earlier..."
```

2. Progressive Building
```
"Starting with the basics..."
"Building on that last point..."
"This connects to what I noticed earlier..."
"Let me break this down further..."
```

## Key Requirements

1. Never skip the extensive contemplation phase
2. Show all work and thinking
3. Embrace uncertainty and revision
4. Use natural, conversational internal monologue
5. Don't force conclusions
6. Persist through multiple attempts
7. Break down complex thoughts
8. Revise freely and feel free to backtrack

Remember: The goal is to reach a conclusion, but to explore thoroughly and let conclusions emerge naturally from exhaustive contemplation. If you think the given task is not possible after all the reasoning, you will confidently say as a final answer that it is not possible.
````


### Perplixity stuff {#perplixity-stuff}

<https://kyefox.com/using-perplexity-ais-spaces-as-a-life-raft-in-an-age-of-ai-slop/>


### table &lt;br&gt; issues {#table-br-issues}

whereever you have &lt;br&gt;•, replace that with a new row in that table. don't stuff multiple points into one cell if you have muliple points just create new rows


## Agents, Coding Assistants &amp; MCP {#agents-coding-assistants-and-mcp}


### Personal Agents {#personal-agents}

> See [Deploying ML applications (applied ML)]({{< relref "20241130100028-deploying_ml_applications_applied_ml.md" >}}) agent section for more info


### Coding Assistants {#coding-assistants}

-   I am using emacs as my default text editor, while I can integrate AI into it. I rather not at the moment and keep it vanilla. I've tried it before the experience is not super polished and things are I get FOMO from other more modern text editors.
-   For AI coding
    -   Zed : We're skipping using zed. emacs+vscode atm.
    -   VSCode + Cline
        -   TODO: <https://ghuntley.com/stdlib/?s=35>


### MCP {#mcp}

See [MCP]({{< relref "20250417045256-mcp.md" >}})
