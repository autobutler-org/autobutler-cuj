# Tracking

- Spec ID: SPEC-001
- Status: draft
- Last Updated: 2026-04-30

## Linked Artifacts

- CUJ: `cuj/1048-cirrus-folder-navigation-history/cuj.md`
- Spec: `cuj/1048-cirrus-folder-navigation-history/specs/folder-navigation-history/spec.md`
- Target Submodule: `cuj/1048-cirrus-folder-navigation-history/specs/folder-navigation-history/target`

## Target Repository

- Repo URL: git@github.com:autobutler-org/autobutler.git
- Branch: main
- Current Submodule Commit: bc011096da71cc01c09445e9619e06592afd8de9

## PR Stack Tracking

- CUJ PR Stack: `cuj/1048-cirrus-folder-navigation-history/pr-stack.md`
- Stack Position: 1
- Depends On: none
- PR URL: pending
- Review Status: planned
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

## Decision Log

1. Reset transient folder UI state on history restore - Keeps route restoration predictable and matches the approved CUJ decision.
2. Use an explicit invalid-folder error state instead of redirecting - Preserves truthfulness of the route and exposes routing problems clearly.

## Next Actions

1. Implement the canonical `/cirrus/<folder path>` route contract in the AutoButler app.
2. Add automated coverage for refresh, browser back/forward, and invalid-folder routing behavior.
