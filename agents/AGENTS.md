# Global Agent Instructions

## Memory
- Get user confirmation before adding or editing persistent memories or instructions.
- Short, concise, actionable memories go inline in MEMORY.md. Create a file only when too long for one line.
- AGENTS.md has precedence over CLAUDE.md. Never load CLAUDE.md if AGENTS.md exists; if you do, tell the user.

## Writing Style
- No em dashes or unicode arrows (`->` is fine).
- Docs and reports MUST be skimmable in 30 seconds:
  - TL;DR of 1-4 lines under the H1 (what, impact, status). Write it last.
  - Headings state the finding ("Missing rescue causes 500 on cancel"), not the slot ("Root cause").
  - Active voice, sentences of 25 words or fewer, acronyms defined on first use.
  - Procedures: numbered imperative steps, one action and 20 words or fewer each.
  - MUST / SHOULD / MAY in capitals for obligations.
  - One doc = one kind of content: explanation, reference or how-to.
  - Tables for numbers and comparisons, bullets for lists, short paragraphs for reasoning.
  - At most one GitHub callout per section.

## Output Format
- No HTML artifacts or published pages unless explicitly requested. Save docs and reports as markdown files; print short answers in the console.
- Diagrams use mermaid, 9 nodes or fewer. Type by question: calls -> `sequenceDiagram`, path -> `flowchart`, states -> `stateDiagram-v2`, time -> `timeline`/`gantt`, relations -> `classDiagram`.

## Git
- Never add Co-authored-by lines when committing.
- Use conventional commits for all commit messages.
- Never push, open a PR, or post a comment or message to GitHub, Slack or any service unless explicitly asked in that session. Show the draft and ask first.
- PR descriptions: use the repo's template and keep AI notes at the bottom.

## Files
- Never delete a file without an explicit request from the user or without asking for confirmation first.

## Setup
- Dotfiles: `~/.dotfiles` (repo `kiddots`). `~/.claude/CLAUDE.md`, `settings.json` and `statusline.sh` are symlinks into it. Edit global instructions at `~/.dotfiles/agents/AGENTS.md`.
- NixOS and macOS flake config: `~/projects/dotflakes`.
- ai-market skills: edit only in `~/projects/ai-market`.
- llm-wiki-mcp: edit only in `~/projects/llm-wiki-mcp`. Recommend improvements to the user when you spot them.

## MCP and data tools
- LLM Wiki MCP: before investigating a bug, ticket or unfamiliar code, check it first. Use `find_by_id` for ticket or Sentry IDs (PAY-*, RAILS-*), `search` for keywords, `read_index` to browse, `read_page` to read.
- Skills auto-write investigations and plans. Write concepts, decisions and tool docs manually: `write_page` + `add_index_entry` + `append_log` + `add_external_ref`, and `create_adr` for decisions.
- Never reference the wiki in anything that leaves the session. Other people have no context for it.
- Databricks SQL: use ai-market `scripts/dbsql.sh` (read-only, CLI only, no MCP) with `$DATABRICKS_PROFILE` and `$DATABRICKS_CATALOG`, never hardcoded catalogs. Data lags ~24h. Expired login: `databricks auth login --profile $DATABRICKS_PROFILE`. On timeout never retry: use `WHERE id IN (...)` or bound by `created_at`.
- Stripe MCP has multiple accounts. Pick the one matching the local entity.

## CLI Tools

available CLI tools you can use when you consider it the best tool:
- `rg` grep
- `fd` find
- `eza` list files
- `sd` for simple substitutions
- `jq` for JSON parsing and transformation
- `yq` for YAML parsing and transformation
- `uv` for Python packages
- `gh` for GitHub operations
- `ast-grep` for structural code search or refactoring
- `difftastic` for semantic diffs
- `just` for running project tasks (check for a `justfile` first)
- `shellcheck` when linting shell scripts
- `hyperfine` for benchmarking commands
