# CUJ PR Stack

- CUJ: 1048-cirrus-file-open-route-sync
- Last Updated: 2026-04-30

Use this file to track stacked PR order for this CUJ. Keep each spec as a separate PR where possible.

## Stack Order

| Order | Spec Slug            | Branch                            | PR            | Depends On           | Review Status | Merge Status | Deploy Order | Notes                                                          |
| ----- | -------------------- | --------------------------------- | ------------- | -------------------- | ------------- | ------------ | ------------ | -------------------------------------------------------------- |
| 1     | file-open-route-sync | feature/1048-file-open-route-sync | pending       | file-deep-link-entry | planned       | not-merged   | 1            | Synchronizes in-app file open with the direct deep-link route. |

## Rules

1. Lower order PRs are reviewed and merged first.
2. A PR must not merge until all listed dependencies are merged.
3. Deployment order can match merge order or intentionally differ; document why in Notes.
