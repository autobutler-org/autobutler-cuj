# Tracking

- Spec ID: SPEC-002
- Status: draft
- Last Updated: 2026-04-30

## Linked Artifacts

- CUJ: `cuj/1048-cirrus-folder-deep-link-entry/cuj.md`
- Spec: `cuj/1048-cirrus-folder-deep-link-entry/specs/folder-deep-link-entry/spec.md`
- Target Submodule: `cuj/1048-cirrus-folder-deep-link-entry/specs/folder-deep-link-entry/target`

## Target Repository

- Repo URL: git@github.com:autobutler-org/autobutler.git
- Branch: main
- Current Submodule Commit: bc011096da71cc01c09445e9619e06592afd8de9

## PR Stack Tracking

- CUJ PR Stack: `cuj/1048-cirrus-folder-deep-link-entry/pr-stack.md`
- Stack Position: 1
- Depends On: folder-navigation-history
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

1. 2026-04-30 - Bootstrapped the folder-deep-link-entry spec scaffold and pinned the AutoButler target submodule at `bc011096da71cc01c09445e9619e06592afd8de9`.
2. 2026-04-30 - Replaced template content with startup route-resolution requirements, lightweight-loading behavior, and dedicated not-found handling for CUJ-002.

## Decision Log

1. Show a lightweight loading shell during initial folder resolution - Avoids rendering unrelated content while still feeling responsive.
2. Use a dedicated not-found state for invalid folder deep links - Preserves the requested route and avoids masking routing failures behind redirects.

## Next Actions

1. Implement first-load folder route resolution on top of the canonical Cirrus folder route.
2. Add tests for valid, missing, and unauthorized folder deep-link startup paths.
