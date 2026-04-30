# Tracking

- Spec ID: SPEC-004
- Status: draft
- Last Updated: 2026-04-30

## Linked Artifacts

- CUJ: `cuj/1048-cirrus-file-open-route-sync/cuj.md`
- Spec: `cuj/1048-cirrus-file-open-route-sync/specs/file-open-route-sync/spec.md`
- Target Submodule: `cuj/1048-cirrus-file-open-route-sync/specs/file-open-route-sync/target`

## Target Repository

- Repo URL: git@github.com:autobutler-org/autobutler.git
- Branch: main
- Current Submodule Commit: bc011096da71cc01c09445e9619e06592afd8de9

## PR Stack Tracking

- CUJ PR Stack: `cuj/1048-cirrus-file-open-route-sync/pr-stack.md`
- Stack Position: 1
- Depends On: file-deep-link-entry
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

1. 2026-04-30 - Bootstrapped the file-open-route-sync spec scaffold and pinned the AutoButler target submodule at `bc011096da71cc01c09445e9619e06592afd8de9`.
2. 2026-04-30 - Replaced template content with route-sync ordering, restore guarantees, and unsupported-file handling requirements for CUJ-004.

## Decision Log

1. Define interim routing reliability as refresh restore, bookmarkability, and browser back/forward - Makes the route-sync bar measurable instead of subjective.
2. Keep unsupported-file behavior inside Cirrus with explicit feedback - Avoids routing users into a broken editor state for unsupported files.

## Next Actions

1. Implement route-update ordering that cannot cancel editor launch.
2. Add end-to-end coverage for in-app file open, refresh restore, browser back, and unsupported-file handling.
