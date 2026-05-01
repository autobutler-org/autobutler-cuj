# CUJ PR Stack

- CUJ: 1048-cirrus-folder-navigation-history
- Last Updated: 2026-05-01

Use this file to track stacked PR order for this CUJ. Keep each spec as a separate PR where possible.

## Stack Order

| Order | Spec Slug                 | Branch                               | PR            | Depends On | Review Status | Merge Status | Deploy Order | Notes                                      |
| ----- | ------------------------- | ------------------------------------ | ------------- | ---------- | ------------- | ------------ | ------------ | ------------------------------------------ |
| 1     | folder-navigation-history | feature/1048-folder-navigation-history | [#1075](https://github.com/autobutler-org/autobutler/pull/1075) | none       | merged        | merged       | 1            | Landed on `main` at `5a8b39a2a114cea84b1e454f7ef03a74123c6d6e`. |

## Rules

1. Lower order PRs are reviewed and merged first.
2. A PR must not merge until all listed dependencies are merged.
3. Deployment order can match merge order or intentionally differ; document why in Notes.
