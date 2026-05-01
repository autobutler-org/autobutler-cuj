# Tracking

- Spec ID: SPEC-001
- Status: merged
- Last Updated: 2026-05-01

## Linked Artifacts

- CUJ: `cuj/1048-cirrus-folder-navigation-history/cuj.md`
- Spec: `cuj/1048-cirrus-folder-navigation-history/specs/folder-navigation-history/spec.md`
- Target Submodule: `cuj/1048-cirrus-folder-navigation-history/specs/folder-navigation-history/target`

## Target Repository

- Repo URL: git@github.com:autobutler-org/autobutler.git
- Branch: feature/1048-folder-navigation-history
- Current Submodule Commit: 5a8b39a2a114cea84b1e454f7ef03a74123c6d6e
- Landed Main Commit: 5a8b39a2a114cea84b1e454f7ef03a74123c6d6e

## PR Stack Tracking

- CUJ PR Stack: `cuj/1048-cirrus-folder-navigation-history/pr-stack.md`
- Stack Position: 1
- Depends On: none
- PR URL: https://github.com/autobutler-org/autobutler/pull/1075
- Review Status: merged
- Merge Sequence: 1
- Deployment Sequence: 1

## Hard Gates

- Gate 1 (Spec Creation): CUJ approval required (`approval_status: approved`).
- Gate 2 (Implementation Start): Do not open implementation PRs or code changes until CUJ approval is verified.
- CUJ Approval Verified: yes
- Verified By: jamesaorson
- Verified On: 2026-04-30

## Work Log

1. 2026-04-30 - Bootstrapped the folder-navigation-history spec scaffold and pinned the AutoButler target submodule at `bc011096da71cc01c09445e9619e06592afd8de9`.
2. 2026-04-30 - Replaced template content with route-state requirements, error-state behavior, and validation criteria for CUJ-001.
3. 2026-04-30 - Implemented router-owned folder navigation and invalid-folder 404 handling in `feature/1048-folder-navigation-history`, then opened draft PR #1075.
4. 2026-05-01 - PR #1075 merged to `main` at `5a8b39a2a114cea84b1e454f7ef03a74123c6d6e`, and the target submodule was repinned to that landed commit.

## Decision Log

1. Reset transient folder UI state on history restore - Keeps route restoration predictable and matches the approved CUJ decision.
2. Use an explicit invalid-folder error state instead of redirecting - Preserves truthfulness of the route and exposes routing problems clearly.

## Next Actions

1. Target submodule is pinned to the landed `main` commit for PR #1075.
