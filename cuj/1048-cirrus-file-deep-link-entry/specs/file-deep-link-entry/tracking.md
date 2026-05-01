# Tracking

- Spec ID: SPEC-003
- Status: merged
- Last Updated: 2026-05-01

## Linked Artifacts

- CUJ: `cuj/1048-cirrus-file-deep-link-entry/cuj.md`
- Spec: `cuj/1048-cirrus-file-deep-link-entry/specs/file-deep-link-entry/spec.md`
- Target Submodule: `cuj/1048-cirrus-file-deep-link-entry/specs/file-deep-link-entry/target`

## Target Repository

- Repo URL: git@github.com:autobutler-org/autobutler.git
- Branch: feature/1048-file-deep-link-entry
- Current Submodule Commit: a0a2a833b01d2e4cc50cd809ebced8815976dbe6
- Landed Main Commit: a0a2a833b01d2e4cc50cd809ebced8815976dbe6

## PR Stack Tracking

- CUJ PR Stack: `cuj/1048-cirrus-file-deep-link-entry/pr-stack.md`
- Stack Position: 1
- Depends On: folder-deep-link-entry
- PR URL: https://github.com/autobutler-org/autobutler/pull/1077
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

1. 2026-04-30 - Bootstrapped the file-deep-link-entry spec scaffold and pinned the AutoButler target submodule at `bc011096da71cc01c09445e9619e06592afd8de9`.
2. 2026-04-30 - Replaced template content with path-classification, editor-open, and file-error-state requirements for CUJ-003.
3. 2026-04-30 - Implemented file-vs-folder route resolution and dedicated file deep-link states in `feature/1048-file-deep-link-entry`, then opened draft PR #1077.
4. 2026-05-01 - PR #1077 merged to `main` at `a0a2a833b01d2e4cc50cd809ebced8815976dbe6`, and the target submodule was repinned to that landed commit.

## Decision Log

1. Limit direct file open to editor-supported file types - Matches the approved CUJ scope and avoids inventing new viewer behavior.
2. Use a dedicated file error state with explicit unsupported-file messaging - Separates capability gaps from missing or unauthorized file failures.

## Next Actions

1. Target submodule is pinned to the landed `main` commit for PR #1077.
