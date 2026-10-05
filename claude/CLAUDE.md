# Global Claude Instructions

## Memory
- Always get confirmation from the user before adding or editing memories.
- Short memories go directly as inline entries in MEMORY.md, not as separate files. Only create a file when the content is too long to fit on one line.

## Writing Style
- Never use em dashes or unicode arrow characters. Use a comma, colon, or restructure the sentence instead. `->` is fine as an arrow.
- Docs, reports and long explanations MUST be readable by a skimmer in 30 seconds:
  - Answer first (BLUF): put a 1-4 line TL;DR right under the H1 covering what it is, the impact, and the status or decision. Write it last and only restate what the body proves.
  - Plain language (ISO 24495-1): use active voice, keep sentences to 25 words or fewer, and define acronyms the first time they appear.
  - Procedures (ASD-STE100): use numbered steps in imperative mood, one action per step, 20 words or fewer per step.
  - Obligations (RFC 2119): write MUST / SHOULD / MAY in capitals in plans, decisions and acceptance criteria.
  - One doc = one kind of content (Diátaxis): explanation, reference or how-to. Don't mix them.
  - Headings state the finding ("Missing rescue causes 500 on cancel"), not the slot ("Root cause"). Fixed template sections can keep their generic names.
  - Use tables for numbers, comparisons, options and before/after. Use bullets for lists. Use short paragraphs for reasoning, never a chain of "because" bullets.
  - Use GitHub callouts sparingly, at most one per section: `[!NOTE]` for the TL;DR, `[!WARNING]` for risks or root causes, `[!TIP]` for the recommended action, `[!IMPORTANT]` for open questions.

## Output Format
- Never create HTML artifacts or published pages unless explicitly requested. For documents, reports, and summaries that need saving: write as markdown files. For short responses that don't need saving: print markdown in the console.
- Always use mermaid syntax for diagrams in markdown or any output.
- Mermaid diagrams: 9 nodes or fewer (split bigger flows). Pick the type by the question: what calls what -> `sequenceDiagram`, which path is taken -> `flowchart`, what states exist -> `stateDiagram-v2`, when -> `timeline`/`gantt`, how objects relate -> `classDiagram`.

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
