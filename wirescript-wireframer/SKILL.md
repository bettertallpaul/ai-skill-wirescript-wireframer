---
name: wirescript-wireframer
description: Generate low-fidelity UI wireframes with WireScript and render them to visual output files. Use when the user asks to design screens, dashboards, forms, flows, app/page layouts, or quick UI mockups and wants both a `.wire` source file and rendered output (PNG and/or HTML).
---

# Wirescript Wireframer

## Overview

Translate product requirements into WireScript definitions and renderable wireframes. Produce a `.wire` file, run validation and rendering, and return artifact paths with assumptions and next edits.

## Workflow

1. Understand the target UI before writing code.
2. Generate a complete `.wire` file from the intent.
3. Render the `.wire` file into artifacts.
4. Report outputs, assumptions, and fast follow-up edits.

## Step 1: Capture Intent

Extract or confirm:
- product/page purpose
- primary user actions
- key screens or states
- required components (forms, nav, tables, cards, modals, etc.)
- layout constraints (desktop/mobile, columns, hierarchy)

When requirements are underspecified, ask up to 4 focused questions, then proceed with explicit assumptions.

## Step 2: Author the WireScript File

Write the wireframe at `wireframes/<slug>.wire` unless the user asks for another path.

Use this structure:
- one `title` block naming the wireframe
- one `define` block per reusable component
- one root `container` section to compose the page/screen
- nested `container` blocks for regions and sections

Use only WireScript-supported elements and properties. Read `references/wirescript-quick-reference.md` when you need syntax, composition rules, or available elements.

Prefer:
- meaningful names in `define` blocks (`Header`, `PrimaryCTA`, `FilterPanel`)
- predictable visual hierarchy (top-level frame -> major regions -> leaf components)
- concise labels and placeholder text that reflect user intent

Use `assets/examples/*.wire` as starter templates when the request matches a known pattern. Copy the closest template to `wireframes/<slug>.wire`, then adapt labels, sections, and components instead of starting from a blank file.

## Step 3: Render

Use the bundled renderer helper:

```bash
./scripts/render_wirescript.sh wireframes/<slug>.wire wireframes --both
```

Flags:
- `--png` render PNG output only
- `--html` render HTML output only
- `--both` render both

The script auto-selects one execution path:
- local `wirescript` CLI
- `docker compose run --rm wirescript ...` when `docker-compose.yml` exists
- `npx wirescript ...` fallback

If rendering fails, return the exact command and error, then provide the smallest fix.

## Step 4: Return Results

Always include:
- path to generated `.wire` file
- render command executed
- output directory
- assumptions made

Then offer 2-4 targeted follow-up edits (for example: responsive variant, denser table layout, alternate dashboard navigation).

## Quality Checklist

- file parses as valid WireScript syntax
- all major user requirements are represented visually
- component reuse via `define` is used where appropriate
- no unsupported elements/properties are introduced
- render command is executed (or failure is clearly reported with remediation)
