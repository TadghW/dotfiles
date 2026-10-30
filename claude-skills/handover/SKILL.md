---
name: handover
description: Write a handover note to ~/notes so a fresh Claude session (or Tadgh) can resume work exactly where it stopped. Use when asked for a handover, to pause or park work, to "write up where we are", or before starting a new session on the same task. Suggest it (don't run it unasked) when a session is long, multi-day, or close to compacting.
---

# Handover

A handover captures the state of a piece of work so it can be resumed from a fresh session with no loss. Its readers are a future Claude session and Tadgh.

## Where it goes

- `~/notes/<ticket-key>-<slug>/handover.md`, e.g. `~/notes/bat-1044-symbol-retention/handover.md`. No ticket: `~/notes/<slug>/handover.md`.
- If a handover already exists there, update it in place and change the "Written" date. Don't create a second one.
- Raw material (TSVs, logs, scripts) goes in the same folder, never in a repo.

## Gather before writing

Collect facts; don't write from memory alone.

1. Every repo touched: `git status`, branch, `git log origin/<branch>..HEAD` (unpushed commits), uncommitted changes.
2. Every ticket, MR, pipeline and Slack thread involved, with links.
3. Anything changed in shared state this session: commits, pushes, Jira edits, runner changes, messages sent.
4. Ticket drift: does the ticket still describe what we're actually building? If not, say so under "Open questions".
5. Auth that will expire or needed manual login (Vault, az, glab, VPN).

## Structure

Use these sections, in this order. Drop a section only if it would be empty.

1. **Title**: `# <KEY> handover: <topic>`, then one line: what this covers, ticket link, "Written <YYYY-MM-DD> for a future Claude session and for Tadgh."
2. **Contents**: linked table of contents.
3. **Glossary**: table of terms a tech manager wouldn't know, including our internal names.
4. **Overview**: the problem and the plan, in a few sentences.
5. **Why this exists**: why the work matters, for a reader with no context.
6. **Resume here**: the most important section.
   - **Status** line: what has been changed, committed, pushed, or run against shared systems. Say "nothing" explicitly when true.
   - **Next steps, in order**, numbered, each concrete enough to start without re-reading the session (`path:line`, commands, which section to continue from).
7. **Sources**: tickets, MRs, Slack threads, files, docs, people, each with a link or `path:line`.
8. **Technical detail**: numbered subsections of what was learned. Explain in phases for pipelines and control flow.
9. **Decisions and their reasons**: table of `Decision | Why | Who`. Include rejected options so they aren't re-proposed.
10. **Open questions and blockers**: table of `Item | State | Unblock by`. Use ⛔ for blockers, ⚠ for side issues.
11. **LLM context dump**: everything else a future session needs:
    - people and their roles in this work
    - hosts, mounts, paths, resource names
    - corrections made to Tadgh's mental model
    - corrections Claude made to itself, so they aren't repeated
    - things that look wrong but aren't
    - don't restate CLAUDE.md preferences; they load anyway

## Rules

- Mark every factual claim about our systems as checked (with its source) or unverified.
- Reference code as `path:line`. Link tickets and MRs.
- Never include secret values. Name where a secret lives (Vault path, env var), not its value.
- Writing the handover never commits, pushes, or edits tickets. If ticket drift needs fixing, list it as a next step.

## Finish

1. Reread once for conciseness; cut anything a resuming reader doesn't need.
2. Tell Tadgh the path and give the one-line prompt to resume from a new session:
   `Read ~/notes/<dir>/handover.md and continue from "Resume here".`
