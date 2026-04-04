---
name: git-branch
description: Create a new git branch from the current or specified base branch. Use when the user wants to start a new branch, begin work on a feature/fix, or check out a fresh branch.
argument-hint: <branch-name> [base-branch]
allowed-tools: Bash
---

Create a new git branch.

- **Branch name**: `$ARGUMENTS[0]` (required)
- **Base branch**: `$ARGUMENTS[1]` (optional — defaults to the repository's default branch)

## Steps

1. Verify this is a git repository by running `git rev-parse --is-inside-work-tree`.
2. If no base branch was provided, detect the default branch:
   ```
   git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@'
   ```
   If that fails, fall back to checking for `main` then `master`.
3. Fetch the latest from the remote for the base branch:
   ```
   git fetch origin <base-branch>
   ```
4. Create and switch to the new branch from the base:
   ```
   git checkout -b <branch-name> origin/<base-branch>
   ```
5. Confirm success by printing the current branch name and its tracking status.

## Branch naming

If the user provides a descriptive name rather than a formatted branch name, convert it to a conventional format:
- Lowercase, words separated by hyphens
- Prefix with `feature/`, `fix/`, `chore/`, `docs/`, etc. if the intent is clear and no prefix was given
- Strip special characters

For example: "Add user authentication" → `feature/add-user-authentication`

## Error handling

- If the branch already exists, inform the user and ask if they want to switch to it.
- If there are uncommitted changes, warn the user and suggest stashing or committing first.
- If there is no remote, skip the fetch and create the branch from the local base.
