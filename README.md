# WireScript Wireframer Skill

Generate low-fidelity UI wireframes from natural language using [WireScript](https://github.com/ruiyangke/wirescript), then render output as HTML and/or PNG.

## What This Skill Does

- turns a product/screen description into a `.wire` file
- validates output with `wirescript verify`
- renders wireframes with `wirescript render`
- provides reusable starter templates from upstream WireScript examples

## Repository Layout

This repository currently stores the skill under:

- `wirescript-wireframer/`

Skill files:

- `wirescript-wireframer/SKILL.md`
- `wirescript-wireframer/agents/openai.yaml`
- `wirescript-wireframer/scripts/render_wirescript.sh`
- `wirescript-wireframer/references/wirescript-quick-reference.md`
- `wirescript-wireframer/assets/examples/*.wire`

## Install In Codex

Copy or clone this repo, then place the skill folder under your Codex skills directory:

- `~/.codex/skills/wirescript-wireframer`

After that, type `/`, then pick `WireScript Wireframer` from the Skills section. You can also invoke it with `wirescript-wireframer` in prompt text.

## Usage

Example request:

`Create a SaaS analytics dashboard wireframe with KPI cards, trend chart, filters, and activity table.`

Typical output:

- a `.wire` source file (for example `wireframes/analytics-dashboard.wire`)
- rendered HTML/PNG artifacts

## Render Helper

Use the bundled script:

```bash
./wirescript-wireframer/scripts/render_wirescript.sh wireframes/home.wire wireframes --both
```

Modes:

- `--png`
- `--html`
- `--both`

## Upstream References

- WireScript project: `https://github.com/ruiyangke/wirescript`
- Included examples synced from upstream `examples/` directory

## Optional Cleanup

If you want this to be a single-folder skill repo, move contents of `wirescript-wireframer/` to repository root so `SKILL.md` lives at root.
