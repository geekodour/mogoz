+++
title = "Personal AI Workflow"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Doing Research]({{< relref "20230419134645-doing_research.md" >}}), [Open Source LLMs (Transformers)]({{< relref "20230719050449-open_source_llms.md" >}}), [Deploying ML applications (applied ML)]({{< relref "20241130100028-deploying_ml_applications_applied_ml.md" >}})


## Usecases {#usecases}


### Manual management {#manual-management}

-   Have all the usermanuals of the different devices in one notebook and search through them. (Using NotebookLM)


### <span class="org-todo todo TODO">TODO</span> Reading book/Paper {#reading-book-paper}


### PM'ing with AI {#pm-ing-with-ai}

Want to dramatically speed up your product development cycle? This guide shows you exactly how to use AI tools in each phase of product management to work up to 40 times faster, based on insights from Sahil Lavingia of Gumroad.


#### Phase 1: Idea Generation &amp; Initial Spec Creation {#phase-1-idea-generation-and-initial-spec-creation}

1.  ****Input your initial idea or customer request**** into an AI tool
2.  ****Ask AI to clarify the core problem**** and desired outcome
3.  ****Prompt AI to brainstorm different user scenarios**** and edge cases
4.  ****Request an initial spec draft**** in your preferred format
5.  ****Use AI with web search to analyze competitors****

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


## Prompts {#prompts}


### Summary {#summary}

You summarize the pasted in text
Start with a overall summary in a single paragraph
Then show a bullet pointed list of the most interesting illustrative quotes from the piece
Then a bullet point list of the most unusual ideas
Finally provide a longer summary that covers points not included already


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
