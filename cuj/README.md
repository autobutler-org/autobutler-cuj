# CUJ Catalog

Store AutoButler critical user journeys as folders:

`cuj/<cuj-slug>/cuj.md`

Each CUJ folder should also include:

- `pr-stack.md` for stacked PR review, merge, and deploy order
- `specs/<spec-slug>/` for one or more specs linked to the CUJ

Approval requirement:

- Set `approval_status: approved` in `cuj/<cuj-slug>/cuj.md` before creating specs.
- Do not begin implementation until CUJ approval is present.

Use `templates/cuj-template.md` for every new journey.
Use `templates/pr-stack-template.md` for CUJ-level PR stack tracking.

## Index

| CUJ ID  | Slug                            | Title                                              | Status | Approval | Source |
| ------- | ------------------------------- | -------------------------------------------------- | ------ | -------- | ------ |
| CUJ-001 | `1048-cirrus-folder-navigation-history` | Navigate Cirrus folders with URL and browser history | approved | approved | `autobutler-org/autobutler#1048` |
| CUJ-002 | `1048-cirrus-folder-deep-link-entry` | Open Cirrus directly to a shared folder URL        | approved | approved | `autobutler-org/autobutler#1048` |
| CUJ-003 | `1048-cirrus-file-deep-link-entry`   | Open a Cirrus file directly from a deep link       | approved | approved | `autobutler-org/autobutler#1048` |
| CUJ-004 | `1048-cirrus-file-open-route-sync`   | Open a Cirrus file from the browser and keep the URL in sync | approved | approved | `autobutler-org/autobutler#1048` |

Keep this table updated whenever a CUJ is added, renamed, approved, or retired.
