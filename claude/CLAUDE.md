# Global Claude Instructions

## Memory
- Always get confirmation from the user before adding or editing memories.
- Short memories go directly as inline entries in MEMORY.md, not as separate files. Only create a file when the content is too long to fit on one line.

## Writing Style
- Never use em dashes or unicode arrow characters. Use a comma, colon, or restructure the sentence instead. `->` is fine as an arrow.

## Output Format
- Never create HTML artifacts or published pages unless explicitly requested. For documents, reports, and summaries that need saving: write as markdown files. For short responses that don't need saving: print markdown in the console.
- Always use mermaid syntax for diagrams in markdown or any output.

## Git
- Never add Co-authored-by lines when committing.

## Files
- Never delete a file without an explicit request from the user or without asking for confirmation first.

## CLI Tools
Prefer these over standard alternatives when available:

- `rg` instead of `grep`
- `fd` instead of `find`
- `eza` instead of `ls`
- `sd` instead of `sed` for simple substitutions
- `jq` for JSON parsing and transformation
- `yq` for YAML parsing and transformation
- `uv` instead of `pip` or `python -m venv` for Python packages
- `gh` for GitHub operations

Use these when the task calls for it:
- `ast-grep` for structural code search or refactoring
- `difftastic` for semantic diffs
- `just` for running project tasks (check for a `justfile` first)
- `shellcheck` when linting shell scripts
- `hyperfine` for benchmarking commands
