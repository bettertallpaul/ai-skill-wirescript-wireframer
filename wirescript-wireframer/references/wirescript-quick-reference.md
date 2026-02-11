# WireScript Quick Reference

Use this reference while authoring `.wire` files.

## Core Syntax

- `title: "..."` set the wireframe title
- `define Name { ... }` declare reusable components
- `container { ... }` compose layout blocks
- `use Name` place a defined component

## Common Elements

Use these element primitives as building blocks:

- `header`
- `paragraph`
- `input`
- `button`
- `checkbox`
- `radio`
- `select`
- `dropdown`
- `image`
- `line-chart`
- `bar-chart`
- `pie-chart`
- `date-picker`
- `calendar`
- `table`

## Useful Properties

- `label`
- `placeholder`
- `text`
- `src`
- `options`
- `rows`
- `columns`
- `checked`
- `selected`
- `value`

## Example Pattern

```wire
title: "Admin Dashboard"

define TopNav {
  container {
    header "Operations Dashboard"
    input { placeholder: "Search users" }
    button "Create report"
  }
}

define KPISection {
  container {
    line-chart { data: [120, 160, 180, 210, 260] }
    bar-chart { data: [34, 28, 50, 41] }
  }
}

container {
  use TopNav
  container {
    use KPISection
    table {
      columns: ["User", "Plan", "Status"]
      rows: [
        ["A. Rivera", "Pro", "Active"],
        ["D. Kim", "Starter", "Trial"]
      ]
    }
  }
}
```

## Rendering Commands

Choose one execution path:

- Validate: `wirescript verify app.wire`
- HTML: `wirescript render app.wire > output.html`
- PNG: `wirescript render app.wire -f png -o screenshot.png`
- Static docs: `wirescript build app.wire -o ./dist`
- Format: `wirescript format app.wire`

## Bundled Example Templates

The skill includes upstream examples in `assets/examples/`:
- `landing-page.wire`
- `dashboard.wire`
- `analytics-dashboard.wire`
- `admin-panel.wire`
- `e-commerce.wire`
- `task-manager.wire`
- `project-management.wire`
- `crm-system.wire`
- `messaging-app.wire`
- `social-app.wire`
- `settings-page.wire`
- `login-form.wire`
- `design-system.wire`

Prefer copying the closest template and modifying it.

Use `scripts/render_wirescript.sh` for an environment-aware wrapper.
