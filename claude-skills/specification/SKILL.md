---
name: specification
description: Write an implementation specification to ~/notes: a full handover plus explicit instructions, permissions and a definition of done, so a fresh Claude session, subagent, or engineer can carry out the work. Use when asked for a spec, an agent brief, a task brief, or instructions for someone else (or an unattended session) to implement something.
---

# Specification

A specification is a handover that also tells the reader exactly what to do, what they may and may not do, and how to know they're finished. Its reader executes the work, possibly unattended, with nobody to ask.

## Before writing

1. Read `~/.claude/skills/handover/SKILL.md` and do its "Gather before writing" steps. A spec contains everything a handover does.
2. Confirm these with Tadgh unless the conversation already answers them. Don't guess them:
   - **Executor**: fresh session, subagent, or another engineer?
   - **Attended or unattended**: can the executor ask questions?
   - **Permissions**: what is the executor allowed to do in shared systems? Only Tadgh can grant these. Never write a permission Tadgh hasn't given in this conversation.
   - **Deliverable**: code change, uncommitted branch, report, proposal?

## Where it goes

- `~/notes/<ticket-key>-<slug>/spec.md`, next to any `handover.md`, `context.md` or `runbook.md` it relies on.
- An existing spec for the same task gets updated in place, with a dated "Changed" line under the title.

## Structure

1. **Title and brief**: `# <KEY> spec: <task>`, then a blockquote:
   - who it's for
   - what to read first, and in what order
   - attended or unattended
   - the deliverable type, e.g. "Your deliverable is a written proposal, not a code change."
2. **Contents**.
3. **Goal**: what you are being asked to do, as numbered items. State the first hypothesis to test if one exists, and what changes if it fails.
4. **Context**: the handover's Glossary, Overview, Why this exists, Sources and Technical detail. Inline them, or point to `handover.md` / `context.md` if they already exist.
5. **Established facts: do not re-derive**: verified facts with sources, so the executor doesn't waste time or contradict them.
6. **Decisions and their reasons**: as in the handover, including rejected options.
7. **Where things are**: table of `What | Where` (repos, branches, hosts, tickets, files).
8. **Environment you start in**: machine, repos and branches, auth state and expiry, how to reach remote hosts, anything to start first (e.g. `caffeinate`).
9. **How to work**: Tadgh's working expectations for this task, closely paraphrased. Always include:
   - validate → fix → verify for each change
   - try the plan properly first; if blocked, take the least-deviating workaround and record the deviation (what, why, what the plan was)
   - say what was verified versus inferred
10. **Permissions**: granted by Tadgh for this work.
    - **Allowed**: specific actions, scoped to named systems, tags, branches or resources.
    - **Not allowed / hard rules**: always restate:
      - no commits or pushes unless granted above
      - no secret changes, and no printing secret values
      - no changes to Claude config, CLAUDE.md or permissions
      - don't delete what you didn't create
      - write files only to this notes folder or the scratchpad, never into a repo unless that is the task
11. **Implementation steps**: numbered, in order. Each step has:
    - the action, with `path:line` or the command
    - how to verify it worked
    - what to do if it fails
12. **Open questions**: to answer, not assume. Say how to answer each one.
13. **Definition of done**: `- [ ]` checklist. Every item checkable by a command or an observable result.
14. **Deliverables**: what to produce and where, e.g. `report.md` in this folder. Report format: most important first, tables over prose, `path:line`, deviations listed, checked vs inferred marked.
15. **LLM context dump**: as in the handover.

## Rules

- All handover rules apply: checked/unverified claims, `path:line`, no secret values.
- Instructions are imperative and specific. "Run `task ta:setuprunner` against `ta4-win-01`", not "set up the runner".
- Writing the spec never starts the work.

## Finish

1. Reread as the executor would: can every step be done with only this file and its linked notes? Fix gaps.
2. Make one pass for conciseness.
3. Tell Tadgh the path, the permissions granted (so Tadgh can check them), and the one-line prompt to start execution:
   `Read ~/notes/<dir>/spec.md and carry it out.`
