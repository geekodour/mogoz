+++
title = "Personal AI Workflow"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Doing Research]({{< relref "20230419134645-doing_research.md" >}}), [Open Source LLMs (Transformers)]({{< relref "20230719050449-open_source_llms.md" >}}), [Deploying ML applications (applied ML)]({{< relref "20241130100028-deploying_ml_applications_applied_ml.md" >}}), [MCP]({{< relref "20250417045256-mcp.md" >}}), [AI Agents]({{< relref "20250417184115-ai_agents.md" >}})


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


### Coding {#coding}

see beflow


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


## Coding Assistants {#coding-assistants}

> -   I am using emacs as my default text editor, while I can integrate AI into it. I rather not at the moment and keep it vanilla. I've tried it before the experience is not super polished and things are I get FOMO from other more modern text editors.
> -   For AI coding
>     -   Zed : We're skipping using zed. emacs+vscode atm.
>     -   VSCode + Cline


### Meta ideas {#meta-ideas}


#### System prompt {#system-prompt}

-   <https://github.com/cline/cline/blob/main/src/core/prompts/system.ts>


#### Contexts (Persistent) {#contexts--persistent}

-   `NEEDED` to maintain understanding ****across**** sessions.
-   These are for AI, not for human

<!--list-separator-->

-  Types

    1.  `Context about context`
        -   Info about where AI should find "contexts"(for AI) in the first place.
        -   General place to look for documentation: Eg. "All API documentation is available in our internal Notion workspace under 'Engineering &gt; API Reference'. For component usage examples, refer to our Storybook instance at <https://storybook.internal.company.com>"
    2.  `Evergreen/Project Specific`
        1.  Living set of document(s) describing overall architecture, approach etc.
        2.  Useful for long running projects. (Eg. `techContext.md` and `systemPatterns.md`)
    3.  `Task Specific`
        -   Created for specific implementation tasks(requirements, constraints, decisions)
    4.  `Knowledge Transfer`
        -   When working with AI assistant it can probably do a lot of things
        -   Often useful to have the AI write/document all of what it did in markdown
        -   Once it is in markdown we can refer back to it in downstream tasks etc.
        -   Eg. "Cline, summarize what we did in the last user dashboard task. I want to capture the main features and outstanding issues. Save this to cline_docs/user-dashboard-summary.md."
    5.  `Project convention & tool usage`
        -   "All components must include Jest tests with at least 85% coverage. Run tests using npm run test:coverage before submitting any pull request."
        -   "Use React Query for data fetching and state management. Avoid Redux unless specifically required for complex global state. For styling, use Tailwind CSS with our custom theme configuration found in src/styles/theme.js."
        -   "For database operations, use the Postgres MCP server with credentials stored in 1Password under 'Development &gt; Database'. For deployments, use the AWS MCP server which requires the deployment role from IAM. Refer to docs/mcp-setup.md for configuration instructions."
        -   "Name all React components using PascalCase and all helper functions using camelCase. Place components in the src/components directory organized by feature, not by type. Always use TypeScript interfaces for prop definitions."
    6.  `Rules`
        -   These are sort of all over the place in all the previously mentioned types of contexts
        -   But this is clearly marked as "rule" and something that ought to be followed.
        -   These are to be created everytime you want to intervene the AI in some way, best part, Let the AI create these rules. Eg. [huntley](https://ghuntley.com/stdlib/) mentions how he let the AI create a cursor rule that mentions not to create bazel stuff again.

<!--list-separator-->

-  Convention &amp; Maintenance

    > -   Basic: Keep them updated, keep them versioned, removed outdated context.
    > -   Different tools have different conventions, I am focusing on cline and aider. mostly cline.

    <!--list-separator-->

    -  geekodour's convention

        -   Just like I always have an `.infra` repo, i'll have a `/docs/for_ai` repo
        -   Anything I want which is sort of docs and I want to pullup to llm context remains here. (eg. llmtxt, project specific instructions etc)
        -   I can "pull these into context" by
            -   `@` (referencing)
            -   Inform the purpose of these files via another file in `.clinerules` (how I use memory bank)
            -   Copying the files directly into `.clinerules` on case-by-case basis (eg. I want to work only on frontend and have only frontend related things in context while working on a monorepo)

    <!--list-separator-->

    -  Project Specific

        -   `.clinerules` is a file but now they support it as a directory aswell. Whatever is inside that directory automatically gets injected after the system prompt.
            -   Use `@` to reference files or folders.
        -   Maintain a `ai-rules-bank`, copy things over to `.cursorules` when we want to **activate** them.
            -   This can be useful in a mono-repo setup, suppose you want to only focus things on frontend, or only focus on backend etc.
            -   This also allows you to gitignore `.cursorules` directory and version control the bank instead.
        -   Use `.clineignore` to let it ignore certain files/directories completely. Better than telling this in prompts. Also helps with security.
        -   `cline memory bank`

    <!--list-separator-->

    -  Memory

        > "Its effectiveness depends entirely on maintaining clear, accurate documentation and confirming context preservation in every interaction."

        -   Cline has something called "memory-bank": [Cline Memory Bank | Cline](https://docs.cline.bot/improving-your-prompting-skills/cline-memory-bank)
        -   It's a set of files with certain structure. We can improve the structure ofcourse but it's better if it's automatically being updated by the AI.
            -   It's not necessary to include these files in `.clinerules` but rather we should have something in `.clinerules` that tells cline to use the memory bank the way it supposed to be used.
        -   Update the Memory Bank after significant milestones or changes in direction. Cline will sometimes automatically update the memory bank aswell.
        -   MAIN COMMANDS:
            -   `"follow your custom instructions"` / `"refresh your memory"` : tells Cline to read the Memory Bank files and continue where you left off (use this at the start of tasks)
            -   `"initialize memory bank"` - Use when starting a new project
            -   `"update memory bank"` - Triggers a full documentation review and update during a task

    <!--list-separator-->

    -  User specific

        -   Client has "custom prompt" that gets injected to the system prompt

    <!--list-separator-->

    -  Prompting tips

        -   <https://github.com/nickbaumann98/cline_docs/tree/main/prompting/custom%20instructions%20library>
        -   <https://docs.cline.bot/improving-your-prompting-skills/prompting>
        -   [Building Advanced Software with Cline: A Structured Approach - Cline Blog](https://cline.bot/blog/building-advanced-software-with-cline-a-structured-approach)


### Workflow: Stating a New project/feature {#workflow-stating-a-new-project-feature}

> -   A lengthy discussion about requirements and listing the requirements out in numbered bullet points so that I can cite the specific requirement when something needs changing or if something goes wrong.
> -   Asking cursor to write the requirements to a file, that I can reinject back in to the context window if required.
> -   Attaching the @file and @file-test into the context. Specifically instructing Cursor to "inspect and describe the file"
> -   Asking the agent to
>     -   implement the "XYZ" requirement
>     -   author tests
>     -   Add documentation.
> -   Run builds and tests after each change.
> -   Perform a git commit (via a configured rule) if everything went alright.


### Workflow: Non-Greenfield/Legacy Code feature {#workflow-non-greenfield-legacy-code-feature}


#### Code Review Prompt {#code-review-prompt}

````nil
You are a senior developer. Your job is to do a thorough code review of this code. You should write it up and output markdown. Include line numbers, and contextual info. Your code review will be passed to another teammate, so be thorough. Think deeply before writing the code review. Review every part, and don't hallucinate.
````


#### GitHub Issue Generation Prompt {#github-issue-generation-prompt}

````nil
You are a senior developer. Your job is to review this code, and write out the top issues that you see with the code. It could be bugs, design choices, or code cleanliness issues. You should be specific, and be very good. Do Not Hallucinate. Think quietly to yourself, then act - write the issues. The issues will be given to a developer to executed on, so they should be in a format that is compatible with github issues
````


#### Missing Tests Prompt {#missing-tests-prompt}

````nil
You are a senior developer. Your job is to review this code, and write out a list of missing test cases, and code tests that should exist. You should be specific, and be very good. Do Not Hallucinate. Think quietly to yourself, then act - write the issues. The issues will be given to a developer to executed on, so they should be in a format that is compatible with github issues
````


### Resources {#resources}

-   [From Design doc to code: the Groundhog AI coding assistant (and new Cursor vibecoding meta)](https://ghuntley.com/specs/)
-   [You are using Cursor AI incorrectly...](https://ghuntley.com/stdlib/)


## Agents, Coding Assistants &amp; MCP {#agents-coding-assistants-and-mcp}


### Personal Agents {#personal-agents}

> See [Deploying ML applications (applied ML)]({{< relref "20241130100028-deploying_ml_applications_applied_ml.md" >}}) agent section for more info


### MCP {#mcp}

See [MCP]({{< relref "20250417045256-mcp.md" >}})
