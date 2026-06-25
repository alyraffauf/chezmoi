---
name: literate-code
description: Pragmatic coding standards focused on literate, readable code that newcomers can understand without prior codebase knowledge. Use when writing or editing any source code, reviewing code, or discussing implementation approaches.
---

# Literate Code: Readable & Scalable Standards

> **Readability first.** Code is read far more often than it is written. Write for the human who opens this file six months from now, or six minutes from now, with no context.

---

## Core Principles

| Principle | Rule |
|-----------|------|
| **Clarity** | Prefer the obvious over the clever. |
| **Literacy** | Code should read like prose where possible. |
| **SRP** | Each function and class does ONE thing, named precisely. |
| **DRY** | Extract duplication; reuse meaningfully. |
| **KISS** | The simplest solution that fully solves the problem. |
| **YAGNI** | Do not build features or abstractions you do not need today. |
| **Boy Scout** | Leave the code cleaner than you found it. |

---

## Naming

> **Names are the primary interface for understanding code.**

### General Rules

- **Reveal intent.** A name should answer *why* it exists and *how* it is used.
- **Avoid abbreviations.** `customerAddress` not `custAddr`.
- **Avoid single-letter names** unless they are the **universal idiomatic convention** for that language (e.g., `i`/`j` for loop indices in C-style languages, `e` for error in Go, `T` for type parameters in generics). When in doubt, spell it out.
- **No leetcode-style shortcuts.** `currentNode` not `curr`; `previousValue` not `prev`; `result` not `res`; `answer` not `ans`.
- **Pronounceable names.** `generationTimestamp` not `gen_ts`.

### By Type

| Element | Convention |
|---------|-----------|
| **Variables** | Noun phrase describing the value: `activeUserCount`, `processedLines` |
| **Functions** | Verb + noun describing the action: `findUserByEmail()`, `calculateTotalPrice()` |
| **Booleans** | Question form: `isActive`, `hasPermission`, `canEdit`, `shouldRetry` |
| **Constants** | SCREAMING_SNAKE_CASE describing the concept: `MAX_RETRY_COUNT`, `DEFAULT_TIMEOUT_MS` |
| **Collections** | Plural noun: `users`, `pendingOrders` |
| **Predicates / Filters** | Past participle or adjective: `enabledFeatures`, `matchedRecords` |

> **Rule:** If you need a comment to explain a name, rename it.

---

## Functions

| Rule | Description |
|------|-------------|
| **Small** | Prefer under 40 lines. Smaller functions are better, but do not artificially split a single clear responsibility just to hit a line count. |
| **One thing** | The name should describe the entire body. If you can extract a meaningful chunk, do so. |
| **One level of abstraction** | Do not mix high-level orchestration with low-level bit-twiddling in the same function. |
| **Few arguments** | 0–2 is ideal. 3 is acceptable. More than 3 requires a struct/object parameter with named fields. |
| **No hidden side effects** | A function called `checkUserStatus` should not also update the database. |
| **Return early** | Use guard clauses to handle edge cases and errors at the top. |

---

## Code Structure

| Pattern | Guideline |
|---------|-----------|
| **Guard clauses** | Return early for nulls, errors, and edge cases. |
| **Flat over nested** | Prefer early returns over deep `if` nesting. Maximum visual nesting: 2 levels. |
| **Step-down rule** | Read from top to bottom: high-level functions first, helpers below. |
| **Colocation** | Keep related code close. Avoid scattering a single concept across many files. |
| **Whitespace as punctuation** | Use blank lines to separate logical paragraphs within a function. |

---

## Scale & Flexibility

> **Solve today's problem with tomorrow's load in mind.**

- **Do not over-engineer speculative features.** YAGNI still applies. Do not build abstractions for requirements that do not exist yet.
- **Do engineer boundaries that scale.** Design interfaces, data models, and failure modes that can grow without rewrites.
- **Prefer configuration over hardcoding** for values likely to change: timeouts, limits, feature flags, URLs, thresholds.
- **Consider the blast radius.** A change in one module should not cascade through the entire system. Prefer loose coupling.
- **Handle errors explicitly.** Silent failures and swallowed exceptions become catastrophic at scale. Fail loudly, recover cleanly.
- **Design for observability.** Logs, metrics, and tracing should be easy to add later. Do not block them with rigid structures.
- **Avoid tight coupling to external services or libraries.** Wrap them so they can be replaced or mocked.

---

## Comments & Didacticism

> **The code is the explanation. Comments are the apology.**

- **Do not state the obvious.**
  ```
  ❌  // increment counter by 1
      counter += 1;

  ✅  counter += 1;
  ```
- **Do not write tutorials in comments.** Assume the reader knows the language. Explain *why* a non-obvious choice was made, not *what* the syntax does.
- **Do not leave commented-out code.** Delete it. Git remembers.

- **Use simple, direct clauses in comments.** Prefer imperative style. Write `Retry on timeout` not `This will retry the operation if a timeout occurs`. Comments should be brief and to the point.
- **Do document surprises.** If the code must diverge from an obvious approach for a subtle reason, a brief comment is warranted.

---

## Anti-Patterns

| ❌ Don't | ✅ Do |
|----------|-------|
| Single-letter variables (`x`, `n`, `a`) unless idiomatic | `itemIndex`, `nodeCount`, `inputBuffer` |
| Leetcode abbreviations (`curr`, `prev`, `res`, `ans`, `tmp`) | `currentNode`, `previousValue`, `result`, `answer`, `temporaryBuffer` |
| Comment every line or block | Let names and structure speak |
| Helper for a one-liner used once | Inline it |
| Deep nesting | Guard clauses and early returns |
| Magic numbers | Named constants |
| God functions / classes | Split by responsibility |
| Clever one-liners that require deciphering | Explicit, multi-step logic |

---

## Before Editing Any File

**Stop and think.**

| Question | Why it matters |
|----------|----------------|
| What imports this file? | Signatures changes may break callers. |
| What does this file import? | Changing an interface may require downstream updates. |
| What tests cover this? | Tests will fail if behavior changes. |
| Is this shared code? | A change here affects many places. |

> **Rule:** Edit the file AND all dependent files in the same task. Never leave broken imports, missing updates, or orphaned references.

---

## AI Coding Style

| Situation | Action |
|-----------|--------|
| User asks for a feature | Write it directly and clearly. Consider how it fits the existing architecture. |
| User reports a bug | Fix it. Do not explain the fix unless asked. Check if the root cause affects other areas. |
| No clear requirement | Ask, do not assume. |
| Multiple valid approaches | Choose the most readable and the one that respects existing boundaries, not the most impressive. |
| User asks about architecture or design | Explain tradeoffs concisely. Recommend the approach that minimizes future maintenance burden and cognitive load, not the most novel. |
| Encountering messy existing code | Follow the Boy Scout rule: leave it cleaner. But do not refactor unrelated code without permission. |
| Performance vs. readability tension | Default to readability. Optimize only when there is measurable evidence of a bottleneck, not on speculation. |

---

## Self-Check Before Completing

Before reporting a task complete, verify:

- [ ] **Goal met?** Did I do exactly what the user asked?
- [ ] **All files edited?** Did I modify every necessary file, including dependents?
- [ ] **Code works?** Did I verify the change compiles / runs / passes tests?
- [ ] **Readable?** Would a new teammate understand this without explanation?
- [ ] **No obvious comments?** Is the code self-documenting via names and structure?
- [ ] **No single-letter shortcuts?** Are names literate and intention-revealing?
- [ ] **Scale respected?** Did I avoid tunnel vision? Does this change hold up if usage grows 10x?
- [ ] **Nothing forgotten?** Edge cases, error paths, cleanup handled?

> **Rule:** If any check fails, fix it before completing.

---

## Summary

| Do | Don't |
|----|-------|
| Write code like prose | Write puzzles |
| Name things fully and clearly | Abbreviate or obfuscate |
| Let structure and names document logic | Add comments that repeat the code |
| Fix bugs immediately | Explain the fix first |
| Keep functions small and single-purpose | Build monolithic blocks |
| Ask when requirements are unclear | Assume and over-engineer |

> **Remember:** The reader may be unfamiliar with the codebase, the domain, or even programming. Write code that welcomes them in.
