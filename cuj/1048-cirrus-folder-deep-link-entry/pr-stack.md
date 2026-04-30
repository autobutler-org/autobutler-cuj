# CUJ PR Stack

- CUJ: 1048-cirrus-folder-deep-link-entry
- Last Updated: 2026-04-30

Use this file to track stacked PR order for this CUJ. Keep each spec as a separate PR where possible.

## Stack Order

| Order | Spec Slug           | Branch                             | PR            | Depends On                | Review Status | Merge Status | Deploy Order | Notes                                                |
| ----- | ------------------- | ---------------------------------- | ------------- | ------------------------- | ------------- | ------------ | ------------ | ---------------------------------------------------- |
| 1     | folder-deep-link-entry | feature/1048-folder-deep-link-entry | pending       | folder-navigation-history | planned       | not-merged   | 1            | Builds on the canonical folder route from CUJ-001. |

## Rules

1. Lower order PRs are reviewed and merged first.
2. A PR must not merge until all listed dependencies are merged.
3. Deployment order can match merge order or intentionally differ; document why in Notes.
