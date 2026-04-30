# CUJ PR Stack

- CUJ: 1048-cirrus-file-deep-link-entry
- Last Updated: 2026-04-30

Use this file to track stacked PR order for this CUJ. Keep each spec as a separate PR where possible.

## Stack Order

| Order | Spec Slug            | Branch                           | PR            | Depends On             | Review Status | Merge Status | Deploy Order | Notes                                                  |
| ----- | -------------------- | -------------------------------- | ------------- | ---------------------- | ------------- | ------------ | ------------ | ------------------------------------------------------ |
| 1     | file-deep-link-entry | feature/1048-file-deep-link-entry | pending       | folder-deep-link-entry | planned       | not-merged   | 1            | Extends route resolution from folders into file paths. |

## Rules

1. Lower order PRs are reviewed and merged first.
2. A PR must not merge until all listed dependencies are merged.
3. Deployment order can match merge order or intentionally differ; document why in Notes.
