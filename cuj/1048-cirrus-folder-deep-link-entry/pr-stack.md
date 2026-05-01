# CUJ PR Stack

- CUJ: 1048-cirrus-folder-deep-link-entry
- Last Updated: 2026-05-01

Use this file to track stacked PR order for this CUJ. Keep each spec as a separate PR where possible.

## Stack Order

| Order | Spec Slug           | Branch                             | PR            | Depends On                | Review Status | Merge Status | Deploy Order | Notes                                                |
| ----- | ------------------- | ---------------------------------- | ------------- | ------------------------- | ------------- | ------------ | ------------ | ---------------------------------------------------- |
| 1     | folder-deep-link-entry | feature/1048-folder-deep-link-entry | [#1076](https://github.com/autobutler-org/autobutler/pull/1076) | folder-navigation-history | merged        | merged       | 1            | Landed on `main` at `b7771abc87564bdf6b3dae2311cec9377e78bfd5`. |

## Rules

1. Lower order PRs are reviewed and merged first.
2. A PR must not merge until all listed dependencies are merged.
3. Deployment order can match merge order or intentionally differ; document why in Notes.
