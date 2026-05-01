# CUJ PR Stack

- CUJ: 1048-cirrus-file-open-route-sync
- Last Updated: 2026-05-01

Use this file to track stacked PR order for this CUJ. Keep each spec as a separate PR where possible.

## Stack Order

| Order | Spec Slug            | Branch                            | PR            | Depends On           | Review Status | Merge Status | Deploy Order | Notes                                                          |
| ----- | -------------------- | --------------------------------- | ------------- | -------------------- | ------------- | ------------ | ------------ | -------------------------------------------------------------- |
| 1     | file-open-route-sync | feature/1048-file-open-route-sync | [#1078](https://github.com/autobutler-org/autobutler/pull/1078) | file-deep-link-entry | merged        | merged       | 1            | Landed on `main` at `ea9225b530781325f6456160b32adb076ae9c8c4`. |

## Rules

1. Lower order PRs are reviewed and merged first.
2. A PR must not merge until all listed dependencies are merged.
3. Deployment order can match merge order or intentionally differ; document why in Notes.
