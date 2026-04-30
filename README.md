# AutoButler CUJ Repository

This repository stores Critical User Journeys (CUJs) and CUJ-derived OpenSpec documents for the AutoButler product.

Implementation code lives in the target repository:

- Repository: `git@github.com:autobutler-org/autobutler.git`
- Default branch: `main`
- GitHub URL: <https://github.com/autobutler-org/autobutler>

Use this repository to capture user-centric flows first, then break those flows into implementation-ready specs that track stacked PR order and the exact implementation checkout used for delivery.

## What This Repo Stores

1. Product CUJ definitions in markdown.
2. Mermaid `journey` diagrams for each CUJ.
3. OpenSpec specs derived from approved CUJs.
4. Git submodules per spec that point to the AutoButler implementation repository and branch.
5. CUJ-level stacked PR manifests that track code review, merge, and deployment order.

## Directory Layout

```text
cuj/
  <cuj-slug>/
    cuj.md
    pr-stack.md
    specs/
      <spec-slug>/
        spec.md
        tracking.md
        target/   # git submodule to autobutler-org/autobutler
scripts/
  new-spec.sh
specs/
  README.md      # compatibility placeholder
templates/
  cuj-template.md
  pr-stack-template.md
  spec-template.md
  tracking-template.md
```

## Workflow

1. Create a CUJ folder under `cuj/<cuj-slug>/` and add `cuj.md` from `templates/cuj-template.md`.
2. Review and approve the CUJ by setting `approval_status: approved` in `cuj.md`.
3. Create or update `pr-stack.md` from `templates/pr-stack-template.md`.
4. Create a spec folder under `cuj/<cuj-slug>/specs/<spec-slug>/`.
5. Copy `templates/spec-template.md` to `spec.md`.
6. Copy `templates/tracking-template.md` to `tracking.md`.
7. Add the AutoButler implementation repository as a submodule under the spec's `target/`.
8. Update `pr-stack.md` with review, merge, and deploy ordering.

## Hard Gates

1. Specs cannot be created until the linked CUJ is approved.
2. Implementation cannot begin until the linked CUJ is approved.

## Bootstrap a New Spec

Use the helper script after the CUJ has been approved:

```bash
chmod +x scripts/new-spec.sh

scripts/new-spec.sh \
  --cuj <cuj-slug> \
  --spec <spec-slug> \
  --spec-id <SPEC-NNN> \
  --title "<Feature Spec Title>" \
  --owner "<team-or-person>" \
  --repo git@github.com:autobutler-org/autobutler.git \
  --branch <branch-name>
```

The script validates CUJ approval, pre-fills spec and tracking metadata, creates `pr-stack.md` when needed, and adds the target repository as a submodule at `cuj/<cuj-slug>/specs/<spec-slug>/target`.
