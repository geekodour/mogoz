+++
title = "State Management Libraries"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Web Development]({{< relref "20221108105344-web_development.md" >}})

I was sort of collecting resources for my study on react and friends because of few projects I'll be building with react. Turns out it's a circus. Too many of them.


## Meta {#meta}


### Too many schemas! {#too-many-schemas}

{{< figure src="/ox-hugo/20221108105322-state_management_libraries-17312374.png" >}}

With this approach, if you eg. have to update a new field in the frontend you'll need to change schema at multiple levels.


#### With [Local First Software (LoFi)]({{< relref "20230915141853-local_first_software.md" >}}) this can change {#with-local-first-software--lofi----20230915141853-local-first-software-dot-md--this-can-change}

{{< figure src="/ox-hugo/20221108105322-state_management_libraries-1462671061.png" >}}


## Understanding state management for react {#understanding-state-management-for-react}


### Client state management {#client-state-management}

React has some state management baked in with things like contexts, hooks and state, `useState`, `useContext`, `useReducer`, `useEffect` etc. Now it's really usecase specific which approach to go with.

The approaches taken by current state management libraries can be split into these three:


#### Flux {#flux}

Flux approach is characterized by the fact that all changes to the app state are caused by actions, and components are subscribing to the parts of the state using selectors.

-   State is in the store outside React.
-   State is one object (i.e. top-down).
-   Support for Redux dev tools
-   External world to the React world via `useSyncExternalStore` hook.
-   Example: [Redux](https://redux.js.org/)/RTK, [Zustand](https://zustand-demo.pmnd.rs/)


#### Atomic {#atomic}

The atomic state is much closer to the React state and stored inside the React tree

-   State is within react component tree.
-   State consists of atoms (i.e. bottom-up)
-   Could be a replacement for `useState+useContext` (React Context)
-   Example: [Jotai](https://jotai.org/), [Recoil](https://recoiljs.org/)


#### Proxy {#proxy}

proxy approach gives you access to the whole state and will automatically detect which parts of the state are used in the component and subscribe to just updates in that part.

-   State is in the store outside React.
-   Example: [Valtio](https://valtio.pmnd.rs/), [MobX](https://mobx.js.org/), [Overmind](https://overmindjs.org/)


### Server side state management {#server-side-state-management}

-   SWR
-   React-Query
-   RTK Query
    -   A purpose-built data fetching and caching solution for Redux apps
    -   UI-agnostic core, with additional React-specific functionality on top
    -   If RTKQ doesn't fully fit for some reason, use createAsyncThunk from RTK
    -   Works with REST APIs, GraphQL, and any async function


## Some rules {#some-rules}

These rules are just opinions of internet strangers. They are not actually rules but ideas that I can think about.


### Client state {#client-state}

-   `useState/useReducer` for local state, Zustand for shared.
-   If you have a global state that doesn't update often, use can use `react context`.
-   If I have a global state that updates often, then migrate to `RTK`.


### Server state {#server-state}

-   use `React Query` if you're just using `React`, use `RTK Query` if you're using `Redux` at all


## List of libraries {#list-of-libraries}

This list was created on 8th Nov'22

-   [XState](https://xstate.js.org/)
-   [Redux](https://redux.js.org/)/RTK
-   [Zustand](https://zustand-demo.pmnd.rs/)
    -   Primitive APIs for easy learning, and unopinionated.
-   [Recoil](https://recoiljs.org/) (by facebook)
    -   Full featured for big apps with complex requirements.
-   [Valtio](https://valtio.pmnd.rs/) (by Poimandres)
-   [MobX](https://mobx.js.org/)
-   [Jotai](https://jotai.org/) (by Poimandres)
    -   Primitive APIs for easy learning, and unopinionated.
-   [MobX](https://mobx.js.org/)
-   [Overmind](https://overmindjs.org/)


## Some notes on individual libraries {#some-notes-on-individual-libraries}


### Redux {#redux}

-   A state container where `events` (called `actions`) are sent to a `reducer` which update `state`
-   `action` -&gt; `middleware(3rd part ext)` -&gt; `reducer`
-   `middleware`: special kind of addon which lets us customize the `store's dispatch function`. They can be chained.


#### Middleware {#middleware}

-   Centralized application-wide behavior, like logging, crash reporting, and talking to an external API.
-   Enabling user-defined asynchronous behavior, without hardcoding a specific async pattern into Redux itself.
-   Can inspect actions and state, modify actions, dispatch other actions, stop actions from reaching the reducers, and much more.
-   Good place for managing persistent server connections via websockets, and other similar behavior.

<!--list-separator-->

-  Popular middlewares

    -   Thunks
        -   Can be used to write complex sync logic and moderate async logic.
        -   Implements promise pattern
        -   While `Redux` only allows you to dispatch plain action objects, `Thunk` also allows you to dispatch functions which can contain any logic.
        -   Can't respond to dispatched actions; imperative; can't be cancelled.
    -   Sagas
        -   Can be used to write highly complex async workflows.
        -   Generator functions called "sagas" that return descriptions of effects, like "call this function with these arguments".
        -   An alternative side effect model for Redux apps.
        -   Not good for data fetching
        -   Not recommended
    -   Epics/Observables
        -   Can be used to write highly complex async workflows.
        -   Declarative pipelines called "epics" using RxJS operators to define processing steps.
        -   Not good for data fetching


### Xstate {#xstate}

-   State container but has definition of states such as finite, infinite and context
-   Experimental POC of it working with Redux: <https://github.com/mattpocock/redux-xstate-poc>


#### Some Resources {#some-resources}

-   [There are so many fundamental misunderstandings about XState](https://medium.com/@DavidKPiano/there-are-so-many-fundamental-misunderstandings-about-xstate-and-state-machines-in-general-in-13aec57d2f85)
-   [No, disabling a button is not app logic.](https://dev.to/davidkpiano/no-disabling-a-button-is-not-app-logic-598i)
-   [Welcome to the world of Statecharts - Statecharts](https://statecharts.dev/)
-   [My love letter to XState and statecharts](https://timdeschryver.dev/blog/my-love-letter-to-xstate-and-statecharts#thoughts-on-the-demo-project)


### RTK {#rtk}

The official docs says Redux is RTK at this point but I wanted to have a dedicated section for RTK. RTK has built in support for `thunks` and recommends it.


## Resources {#resources}

-   [tnfe/awesome-state: collection of state management lib](https://github.com/tnfe/awesome-state)
-   [javascript - What is an actual difference between redux and a state machine](https://stackoverflow.com/questions/54482695/what-is-an-actual-difference-between-redux-and-a-state-machine-e-g-xstate/54521035#54521035)
-   [Reactathon 2022: The Evolution of Redux Async Logic · Mark's Dev Blog](https://blog.isquaredsoftware.com/2022/05/presentations-evolution-redux-async-logic/)
-   [Jotai vs. Recoil: What are the differences? - LogRocket Blog](https://blog.logrocket.com/jotai-vs-recoil-what-are-the-differences/)
