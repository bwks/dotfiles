---
name: gh-push
description: Stage, commit, and push changes to GitHub. Use when the user wants to push their work, save progress to remote, or publish changes. Uses Claude as the committer.
argument-hint: [commit-message]
allowed-tools: Bash
---

Stage, commit, and push all current changes to GitHub.

- **Commit message**: `$ARGUMENTS` (optional — if not provided, generate one from the changes)

## Git identity

Always set Claude as the committer for this commit:

```
git -c user.name="Claude" -c user.email="noreply@anthropic.com" commit ...
```

Do NOT modify the global or local git config. Pass identity via `-c` flags on the commit command only.

## Authentication

Use the `GH_TOKEN` environment variable for authentication. Set it on all `git push` and `gh` commands:

```
GH_TOKEN="$GH_TOKEN" git push ...
GH_TOKEN="$GH_TOKEN" gh browse ...
```

If `GH_TOKEN` is not set, inform the user and stop. Do NOT fall back to interactive auth.

## Steps

1. **Check authentication**: Verify `GH_TOKEN` is set. If not, inform the user to export it and stop.

2. **Verify state**: Run `git status` to check for changes. If there are no changes, inform the user and stop.

2. **Review changes**: Run `git diff` and `git diff --cached` to understand what will be committed.

3. **Stage changes**: Stage all modified and new files:
   ```
   git add -A
   ```

4. **Generate commit message** (if none provided): Based on the diff, write a concise commit message:
   - First line: imperative mood summary, under 72 characters
   - Blank line, then bullet points for details if the change is non-trivial
   - End with: `Co-Authored-By: Claude <noreply@anthropic.com>`

5. **Commit**:
   ```
   git -c user.name="Claude" -c user.email="noreply@anthropic.com" commit -m "<message>"
   ```
   Always pass the message via a HEREDOC for proper formatting:
   ```
   git -c user.name="Claude" -c user.email="noreply@anthropic.com" commit -m "$(cat <<'EOF'
   <commit message>

   Co-Authored-By: Claude <noreply@anthropic.com>
   EOF
   )"
   ```

6. **Push**: Push the current branch to origin:
   ```
   git push origin HEAD
   ```
   If the branch has no upstream, use:
   ```
   git push -u origin HEAD
   ```

7. **Confirm**: Print the branch name, commit hash, and a link to the commit on GitHub using:
   ```
   gh browse -n -c
   ```

## Error handling

- If push is rejected (behind remote), inform the user and suggest pulling first. Do NOT force push.
- If there are merge conflicts, stop and explain the situation.
- If `GH_TOKEN` is not set or invalid, inform the user to set it via `export GH_TOKEN=<token>`.
