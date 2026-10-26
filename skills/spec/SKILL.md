---
name: spec
description: Find every `@spec` comment the user has planted in the codebase and carry out its request by default. List only when the user explicitly asks to list. A `@spec` comment is an in-place request — a spec, requirement, or change the user wants made at that exact spot (`// @spec retry with backoff here`), or a question about the code there (`// @spec? why is this clone needed`). Use when the user says "/spec", "do my specs", "pick up my @spec comments", "what specs have I left", "work through the spec tags", or similar.
---

# @spec — in-place requests

The user leaves requests in comments where the work should happen, then invokes
this skill to carry them out. The comment's location is part of the request: "here"
means the code around the tag. Invoking the skill without a mode executes the
requests; do not require `do` or confirmation merely because the mode was omitted.

## Tag syntax

Any line comment or block comment, in any language:

```
// @spec <request>              do this here
// @spec(<group>) <request>     same, tagged with a group (e.g. billing, auth)
// @spec? <question>            answer this; do not change code
# @spec ...   -- @spec ...   /* @spec ... */   <!-- @spec ... -->
```

- A colon after the tag is optional: `// @spec: ...`.
- **Continuation:** comment lines directly below the tag, with no blank line
  and no new tag in between, are part of the same request.
- `@spec` outside a comment (e.g. an Elixir typespec) is not a tag.

## Arguments

- No mode *(default)*: carry out the specs.
- `list`: show the open specs and stop, only when explicitly requested.
- `do`: optional alias for the default behavior; never required.
- `keep`: carry out the specs, but leave every `@spec` comment in place
  instead of removing it.
- `<group>`: only specs tagged `@spec(<group>)`.
- `<path>`: only search under this path.

Arguments may appear in any order. If a word isn't `list`/`do`/`keep` and isn't an
existing path, treat it as a group.

## Step 1 — Find the tags

Run from the repo root, narrowing to `<path>` if one was given:

```bash
rg -n --no-heading --hidden -g '!.git' -g '!node_modules' -g '!target' \
  -e '(//|#|--|/\*|\*|<!--|;)\s*@spec(\([A-Za-z0-9_-]+\))?\??(:|\s|$)' <path-or-.>
```

For each hit, read the surrounding code (enough for the enclosing function or
block) and any continuation lines. Record for each spec:

- `file:line`
- kind: **do** (`@spec`) or **ask** (`@spec?`)
- group, if any
- the request text
- the enclosing symbol (function, type, or module) it applies to

If a group filter was given, drop the specs that don't match it. If nothing is
found, say so and stop.

## Step 2 — List

Group the specs by file and print them like this:

```
src/services/billing/handler.rs
  L42  do   (billing)  round to pence before persisting      — in `apply_tariff`
  L88  ask             why is this clone needed              — in `build_invoice`
```

After the list, flag any spec that is ambiguous or that conflicts with another
spec. Stop here only when the user explicitly requested `list` mode or a list
of open specs. Otherwise, proceed directly to Step 3 in the same turn without
waiting for confirmation or another invocation.

## Step 3 — Do

1. **Plan before editing.** Sort the specs into an order that makes sense:
   related ones together, dependencies first. When several specs touch the same
   function, handle them in one pass.
2. **Skip what you'd have to guess at.** If a spec is ambiguous, contradicts
   another spec, or needs a design decision the text doesn't settle, leave its
   comment in place and list it under "Needs you" in the report. Never invent
   intent.
3. **Carry out each `do` spec.** Follow the repo's conventions (CLAUDE.md,
   AGENTS.md, style guides). Keep each change scoped to its request: no drive-by
   refactors.
4. **Remove the tag once the spec is done.** Delete the `@spec` comment and its
   continuation lines; the code is now the record. If part of the comment is
   still worth keeping as documentation, rewrite it as a normal comment without
   the tag. In `keep` mode, skip this step: leave the `@spec` comment and its
   continuation lines exactly as written.
5. **Answer `ask` specs in the chat**, citing `file:line`. Leave those comments
   in place and offer to delete them. Make no code changes for them.
6. **Verify.** Run the build, lint, and tests that cover the files you touched.
   Report any failures plainly.
7. **Don't commit** unless the user asks.

## Report

End with three short sections:

- **Done:** `file:line`, with one line per spec on what changed.
- **Answered:** `file:line`, with the answer for each `@spec?`.
- **Needs you:** `file:line`, with why each spec was skipped and what decision
  is needed.
