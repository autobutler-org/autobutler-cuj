# Tracking

- Spec ID: SPEC-003
- Status: draft
- Last Updated: 2026-04-30

## Linked Artifacts

- CUJ: `cuj/1048-cirrus-file-deep-link-entry/cuj.md`
- Spec: `cuj/1048-cirrus-file-deep-link-entry/specs/file-deep-link-entry/spec.md`
- Target Submodule: `cuj/1048-cirrus-file-deep-link-entry/specs/file-deep-link-entry/target`

## Target Repository

- Repo URL: git@github.com:autobutler-org/autobutler.git
- Branch: main
- Current Submodule Commit: bc011096da71cc01c09445e9619e06592afd8de9

## PR Stack Tracking

- CUJ PR Stack: `cuj/1048-cirrus-file-deep-link-entry/pr-stack.md`
- Stack Position: 1
- Depends On: folder-deep-link-entry
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

1. 2026-04-30 - Bootstrapped the file-deep-link-entry spec scaffold and pinned the AutoButler target submodule at `bc011096da71cc01c09445e9619e06592afd8de9`.
2. 2026-04-30 - Replaced template content with path-classification, editor-open, and file-error-state requirements for CUJ-003.

## Decision Log

1. Limit direct file open to editor-supported file types - Matches the approved CUJ scope and avoids inventing new viewer behavior.
2. Use a dedicated file error state with explicit unsupported-file messaging - Separates capability gaps from missing or unauthorized file failures.

## Next Actions

1. Implement shared route classification for folder-versus-file deep-link resolution.
2. Add tests for supported, unsupported, missing, and unauthorized file deep-link cases.
