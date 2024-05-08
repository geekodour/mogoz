+++
title = "Two Phase Locking (2PL) & Two Phase Commit (2PC)"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Distributed Systems]({{< relref "20221102130004-distributed_systems.md" >}}), [Database Locks]({{< relref "20231114211916-database_locks.md" >}}), [Database Transactions]({{< relref "20231113145513-database_transactions.md" >}}), [Concurrency Consistency Models]({{< relref "20231113121413-concurrency_consistency_models.md" >}})


## FAQ {#faq}


### 2PC vs 2PL {#2pc-vs-2pl}

-   `2PL`
    -   Solves for Isolation
    -   Locking mechanism implemented within a single database instance to achieve `Strict Serializability`
-   `2PC`
    -   Solves for atomicity
    -   2 phase commit is an algorithm for implementing distributed transaction([Database Transactions]({{< relref "20231113145513-database_transactions.md" >}})) across multiple database instances to ensure all nodes either commit or abort the transaction.


### Paxos/Raft/Consensus/Replication Protocols vs 2PC {#paxos-raft-consensus-replication-protocols-vs-2pc}

-   Raft (Availability)
    -   Getting high availability by replicating data on multiple participants
    -   Keep being operational even if **some** of the participants have crashed
    -   All the participants are doing the **same** thing ([Data Replication]({{< relref "20231021151742-data_replication.md" >}}))
-   2PC (Atomicity)
    -   All the participants are doing the **different** thing specific to the participant
    -   There's no notion of **some**, all the participants must be involved
    -   It has pretty low availability, any participant crashing will lead to the whole thing not working.


#### Combing both {#combing-both}

![](/ox-hugo/20231116010456-two_phase_locking_2pl-440905626.png)
![](/ox-hugo/20231116010456-two_phase_locking_2pl-275226558.png)
By combing Raft + 2PC, we get both `Availability+Atomicity`

-   [How Paxos and Two-Phase Commit Differ](https://predr.ag/blog/paxos-vs-2pc/)
-   [database - Paxos vs two phase commit - Stack Overflow](https://stackoverflow.com/questions/27304887/paxos-vs-two-phase-commit)


### Eventual Consistency vs 2PC {#eventual-consistency-vs-2pc}

-   See [Eventual Consistency]({{< relref "20231117135755-eventual_consistency.md" >}})


### Sagas vs 2PC {#sagas-vs-2pc}

-   [cloud - 2PC vs Sagas (distributed transactions) - Stack Overflow](https://stackoverflow.com/questions/48906817/2pc-vs-sagas-distributed-transactions)
-   [SAGA vs 2PC: An Exhaustive Exploration of Distributed Transaction Protocols |...](https://blog.stackademic.com/saga-vs-2pc-an-exhaustive-exploration-of-distributed-transaction-protocols-995e4d780d27)


### [crdt]({{< relref "20230607045339-crdt.md" >}}) vs 2PC {#crdt--20230607045339-crdt-dot-md--vs-2pc}


## 2PL (Isolation) {#2pl--isolation}

-   It's a lock
-   See [Database Locks]({{< relref "20231114211916-database_locks.md" >}})
-   2PL protocol defines a lock management strategy for ensuring `Strict Serializability`
-   It's similar to RWMutex but more used in [Database Transactions]({{< relref "20231113145513-database_transactions.md" >}}) context
-   With 2PL
    -   `Read`: requires a shared lock acquisition (others can read but not write)
    -   `Write`: operation requires taking an exclusive lock. (others cannot read, cannot write)


### Phases {#phases}

Following two phases for each [transaction]({{< relref "20231113145513-database_transactions.md" >}})


#### Lock / Expand / Grow {#lock-expand-grow}

-   Each query, Wants to `write` : Acquire a write/exclusive lock.
-   Each query, Wants to `read` : Acquire a read/shared lock.
-   Don't release lock immediately after each query
-   Hold the lock till the end of the transaction(commit or abort)
-   While the transaction executes, no. of locks held by the transaction expand/grow.


#### Unlock / Shrink {#unlock-shrink}

-   Once the transaction is complete
-   Release all locks (shrink)
-   No more locks can be acquired in this phase, only release


### Issues {#issues}

-   Very easy to end up in a deadlock because locks won't be released until transaction end (but these are detected by the DBMS usually)


## 2PC (Atomicity) {#2pc--atomicity}

-   It is a `Atomic commit protocol` (See [Database Transactions]({{< relref "20231113145513-database_transactions.md" >}}))
-   2 phase commit is an algorithm for implementing distributed transaction across multiple database instances to ensure all nodes either commit or abort the transaction.
-   It works by having coordinator(could be a separate service or library within the application initiating the transaction) issue two requests - PREPARE to all nodes in phase 1 and COMMIT(if all nodes returned OK in PREPARE phase) or ABORT(if any node returned NOT OK in PREPARE PHASE) to all nodes in phase 2.
-   [PostgreSQL]({{< relref "20221102123302-postgresql.md" >}}) allows allows multiple distributed systems to work together in a transactional manner using `prepared transactions`


### Components {#components}

-   `Transaction Coordinator/Manager`
    -   Assume one computer that's actually running one transaction
    -   Sends messages to other computers/paricipants that are involved in the transaction
    -   There can me multiple transaction coordinators; There can be multiple transaction from one transaction coordinator
-   `Participants`
    -   Does not make any\* decision (Really depends on the situation)
    -   Just waits on instructions from the TC. Will Block if it doesn't receive instructions from TC.


### Phases {#phases}


#### Prepare {#prepare}

-   TC: sends `prepare` messages to all `participants` with a `txid`
-   Participants: (each)
    -   Will decide whether it can do the transaction/commit or not (YES/NO)
    -   Log the `decision:txid` persistently (so that can be used in recovery)
    -   Hold a lock for for `txid:resource_record`
    -   Respond with (YES/NO) to the TC


#### Commit {#commit}

-   TC: If all participant respond `YES` for `prepare`, send `commit` to each `participant`
-   Participants: (each)
    -   Log the `commitoccured:txid` persistently (so that can be used in recovery)
    -   Send `acknowledgment` back to TC
    -   Participants should be ready to handle duplicated `commit` messages and respond maintaining idempotency
-   TC: If any `participant` didn't acknowledge, `abort` transaction


### Failure modes {#failure-modes}

-   Messages might get dropped
    -   Need to think what to do here
-   Participant crashes before saying `YES`
    -   TC never sends `commit`
    -   If TC ever sends `commit` without the participant saying `YES`, the participant will simply not do the `commit`
-   Participant crashes after saying `YES`
    -   TC sends `commit`
    -   But the participant recovers about saying `YES` to that `txid` from the recovery log
    -   Things go on as expected
-   Participant crashes after processing the `commit` but before sending `acknowledgment`
    -   Again when participant comes back up, it'll recover that it did commit
    -   And if there's another ask from the `TC` about whether it was committed, it can simply send back the transaction without doing any processing
-   Participant got a `prepare`, sent a `YES`, holding a lock, but not getting a `commit`
    -   In this case the `commit` message from TC must have dropped
    -   Or the TC for some reason could not send the `commit` message
    -   **Participant MUST BLOCK**
        -   i.e participant must keep waiting infinitely.
        -   Because TC might have sent `commit` to other participants and they might have already processed things.
        -   Participant can't/shouldn't decide to `abort` or `commit` on its own after it has sent `YES` and have not received a `commit` message.
    -   2PC implementation usually try to make this failure mode real fast so that the block is not long.
-   TC crashes before sending `commit`
    -   Not a problem
-   TC crashes after sending `commit`
    -   TC needs to log that it is going to send a `commit`
    -   TC needs to log that it sent the `commit`
        -   Depends on implementation whether we do it after sending all participants or after each participant
    -   After the crash, once the TC comes back up, it'll replay the log and re-send the `commit`
    -   And wait for the `acks` from `participant`
-   **QUESTION:** Participant has no log for a `txid`, we get a `txid`
    -   `txid` might have been committed, aborted or never even sent for a prepare
    -   Do we do then?


### 2PC Optimizations {#2pc-optimizations}

-   Issues with 2PC
    -   2PC is slow because it has so many messages going in and around
    -   Lot of disk io (writing to logs)
    -   Locks are held by participants on `record:txid` after `prepare`, which can be an issue in busy system
    -   Because of its limitations, in practice 2PC is not used to do distributed transactions where `participants` are geographical isolated etc. Might be used in small systems etc. Esp because of the blocking/locking issue.


#### <span class="org-todo todo TODO">TODO</span> CHATGPT {#chatgpt}

Making it fast, Relazing rules, Specializing usecase etc.

-   Single-Phase Commit (Optimized 2PC): This is a simplified version of 2PC used when there's only a single resource manager or when it's known in advance that the transaction will likely succeed. The prepare phase is skipped, and the transaction is directly committed, reducing the protocol to a single phase in these cases.
-   Presumed Abort and Presumed Commit: These are optimizations of the 2PC protocol. In Presumed Abort, it's assumed that transactions will abort by default. This reduces the logging overhead in the case of aborts. Conversely, in Presumed Commit, it's assumed that transactions will commit, optimizing for scenarios where commits are more common.
-   Coordinator Log Avoidance: An optimization where the coordinator does not write a log record during the prepare phase if all participants voted "Yes". This reduces disk I/O, improving performance but at the cost of some increase in recovery complexity.
-   Read-Only Optimization: If a participant in the transaction has only read data and not made any changes, it can inform the coordinator during the prepare phase. This allows the coordinator to exclude the participant from the commit or abort phases, reducing overhead.
-   Early Prepare: This variation allows participants to send their vote (commit or abort) as soon as they are ready, rather than waiting for the coordinator to request votes from all participants. This can improve the performance of the protocol in some cases.
-   Distributed 2PC: In a distributed environment, the 2PC protocol can be extended to support transactions across multiple distributed resource managers. This requires additional coordination and can introduce more complexity, especially in handling failures and network partitions.
-   Hierarchical 2PC: This is a variant where participants are arranged in a hierarchical structure. The top-level coordinator communicates with lower-level coordinators, who in turn manage their respective participants. This can improve scalability and manageability in large distributed systems.
-   Timeout-based 2PC: To handle the problem of blocking in case of failures, timeouts can be introduced. If the coordinator or a participant does not receive expected messages within a timeout period, it can unilaterally decide to abort or commit (based on the protocol's assumption).


#### 3PC (Three Phase Commit) {#3pc--three-phase-commit}

-   An extension of 2PC, 3PC introduces an additional phase to reduce the chances of blocking. The new "PreCommit" phase comes between the voting and commit phases, allowing nodes to agree on the outcome even if the coordinator fails. However, 3PC is more complex and can still be vulnerable to certain network partition scenarios.


## Resources {#resources}

-   [50 years later, is two-phase locking the best we can do? | Hacker News](https://news.ycombinator.com/item?id=37706893)
-   [Two-Phase Commit Three Ways](https://justinjaffray.com/two-phase-commit-three-ways/)
-   [It’s Time to Move on from Two Phase Commit | Hacker News](https://news.ycombinator.com/item?id=18999520)
-   [Two Phase Commit](https://martinfowler.com/articles/patterns-of-distributed-systems/two-phase-commit.html#solution)
