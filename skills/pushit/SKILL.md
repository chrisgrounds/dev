---
name: pushit
description: Commit the current changes on a branch with a one-line message, push, and raise a PR with a very short description. Use when asked to "pushit", "/pushit", "commit and raise a PR", "ship this", or similar.
argument-hint: [<branch-name>]
---

# Pushit

Commit the current changes, push them on a branch, and open a pull request. Keep every message as short as possible.

## Steps

1. Run `git status` and `git diff`. Identify only the files that belong to this change. Do not stage unrelated files. Do not use `git add -A` or `git commit -a`.
2. If the current branch is the default branch (`develop`), create a new branch with a short kebab-case name that describes the change. Use the argument as the branch name if the user gave one. If already on a feature branch, stay on it.
3. Stage the files by path.
4. Commit with a **one-line** message: imperative mood, no body, no trailers, no co-authors. Run the commit inside the nix shell so the pre-commit hook can run:
   `nix develop --command git commit -m "<one line>"`
5. Check what the hook added to the commit (`git show --stat HEAD`). A version bump in `package.json` is normal. Tell the user about anything else.
6. Push: `git push -u origin <branch>`.
7. Open the PR against `develop`:
   `gh pr create --base develop --title "<the commit line>" --body "<description>"`

## The PR description

- At most **one paragraph**. Shorter is better: one sentence is ideal.
- Say what changed, and why if it is not obvious. Nothing else.
- No headings, no bullet lists, no test plan, no "Generated with" footer, no attribution to Claude.

## Report

Give the user the PR link and the commit line. Nothing more.
