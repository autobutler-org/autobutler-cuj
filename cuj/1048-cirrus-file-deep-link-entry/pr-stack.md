# CUJ PR Stack

- CUJ: 1048-cirrus-file-deep-link-entry
- Last Updated: 2026-05-01

Use this file to track stacked PR order for this CUJ. Keep each spec as a separate PR where possible.

## Stack Order

| Order | Spec Slug            | Branch                           | PR            | Depends On             | Review Status | Merge Status | Deploy Order | Notes                                                  |
| ----- | -------------------- | -------------------------------- | ------------- | ---------------------- | ------------- | ------------ | ------------ | ------------------------------------------------------ |
| 1     | file-deep-link-entry | feature/1048-file-deep-link-entry | [#1077](https://github.com/autobutler-org/autobutler/pull/1077) | folder-deep-link-entry | merged        | merged       | 1            | Landed on `main` at `a0a2a833b01d2e4cc50cd809ebced8815976dbe6`. |

## Rules

1. Lower order PRs are reviewed and merged first.
2. A PR must not merge until all listed dependencies are merged.
3. Deployment order can match merge order or intentionally differ; document why in Notes.
