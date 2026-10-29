---
name: write-documentation
description: Structure for writing documentation that serves both humans and LLMs. Use when writing or restructuring a README, runbook, design doc, specification, or any docs/*.md file, or when asked to "document" a tool, system, or codebase.
---

# Good documentation

Good documentation is structured for both humans and LLMs, it allows for both skimming and deep reading. It achieves this with a system of layers:

1. A good, descriptive filename.
2. A slightly more descriptive header.
3. A glossary that explains any words that may not be familiar to a tech manager.
4. Top-level overview that declares the intent of the tool or system being documented.
5. A short section explaining why it exists; targeted at a manager or first-week new hire.
6. A section of concise instructions for interacting with the tool, system, or codebase including code snippets or commands (targeted at junior or mid-level engineers).
7. A longer technical justification that carries a full architecture, lists and explains design decisions, highlights gotchas and important technical details (targeted at experienced or senior engineers).
8. A section designed for LLMs that contains every piece of information you have absorbed in the process of working with the system.

## Editing passes

Once you've finished writing out those layers, you must take the time to reread the whole document and make three edit passes for conciseness, cutting out excess or misleading language.

Then, a final pass should be made taking care to create and easily scannable visual hierarchy with a table of contents where appropriate. Make sure that each distinct paragraph within the documentation is surrounded by sufficient whitespace when rendered in GitHub or GitLab.
