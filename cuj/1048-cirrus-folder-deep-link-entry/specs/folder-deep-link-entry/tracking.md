# Tracking

- Spec ID: SPEC-002
- Status: merged
- Last Updated: 2026-05-01

## Linked Artifacts

- CUJ: `cuj/1048-cirrus-folder-deep-link-entry/cuj.md`
- Spec: `cuj/1048-cirrus-folder-deep-link-entry/specs/folder-deep-link-entry/spec.md`
- Target Submodule: `cuj/1048-cirrus-folder-deep-link-entry/specs/folder-deep-link-entry/target`

## Target Repository

- Repo URL: git@github.com:autobutler-org/autobutler.git
- Branch: feature/1048-folder-deep-link-entry
- Current Submodule Commit: b7771abc87564bdf6b3dae2311cec9377e78bfd5
- Landed Main Commit: b7771abc87564bdf6b3dae2311cec9377e78bfd5

## PR Stack Tracking

- CUJ PR Stack: `cuj/1048-cirrus-folder-deep-link-entry/pr-stack.md`
- Stack Position: 1
- Depends On: folder-navigation-history
- PR URL: https://github.com/autobutler-org/autobutler/pull/1076
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

1. 2026-04-30 - Bootstrapped the folder-deep-link-entry spec scaffold and pinned the AutoButler target submodule at `bc011096da71cc01c09445e9619e06592afd8de9`.
2. 2026-04-30 - Replaced template content with startup route-resolution requirements, lightweight-loading behavior, and dedicated not-found handling for CUJ-002.
3. 2026-04-30 - Implemented startup folder deep-link loading and dedicated folder error states in `feature/1048-folder-deep-link-entry`, then opened draft PR #1076.
4. 2026-05-01 - PR #1076 merged to `main` at `b7771abc87564bdf6b3dae2311cec9377e78bfd5`, and the target submodule was repinned to that landed commit.

## Decision Log

1. Show a lightweight loading shell during initial folder resolution - Avoids rendering unrelated content while still feeling responsive.
2. Use a dedicated not-found state for invalid folder deep links - Preserves the requested route and avoids masking routing failures behind redirects.

## Next Actions

1. Target submodule is pinned to the landed `main` commit for PR #1076.
