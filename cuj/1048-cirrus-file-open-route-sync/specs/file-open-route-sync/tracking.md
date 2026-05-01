# Tracking

- Spec ID: SPEC-004
- Status: merged
- Last Updated: 2026-05-01

## Linked Artifacts

- CUJ: `cuj/1048-cirrus-file-open-route-sync/cuj.md`
- Spec: `cuj/1048-cirrus-file-open-route-sync/specs/file-open-route-sync/spec.md`
- Target Submodule: `cuj/1048-cirrus-file-open-route-sync/specs/file-open-route-sync/target`

## Target Repository

- Repo URL: git@github.com:autobutler-org/autobutler.git
- Branch: feature/1048-file-open-route-sync
- Current Submodule Commit: ea9225b530781325f6456160b32adb076ae9c8c4
- Landed Main Commit: ea9225b530781325f6456160b32adb076ae9c8c4

## PR Stack Tracking

- CUJ PR Stack: `cuj/1048-cirrus-file-open-route-sync/pr-stack.md`
- Stack Position: 1
- Depends On: file-deep-link-entry
- PR URL: https://github.com/autobutler-org/autobutler/pull/1078
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

1. 2026-04-30 - Bootstrapped the file-open-route-sync spec scaffold and pinned the AutoButler target submodule at `bc011096da71cc01c09445e9619e06592afd8de9`.
2. 2026-04-30 - Replaced template content with route-sync ordering, restore guarantees, and unsupported-file handling requirements for CUJ-004.
3. 2026-04-30 - Implemented go_router-owned file-open route sync and stacked it on `feature/1048-file-deep-link-entry`, then opened draft PR #1078.
4. 2026-04-30 - Fixed editor close navigation on `feature/1048-file-open-route-sync` so abdoc and absheet restores return to the prior Cirrus route instead of leaving the file route behind.
5. 2026-04-30 - Moved route-leave handling into the document and spreadsheet editors so browser back/forward closes the overlay even after the Cirrus page rebuilds under the file route.
6. 2026-04-30 - Deferred editor pop and route-restore by one frame so the overlay closes before the `/cirrus` restore runs when back navigation removes the file route.
7. 2026-04-30 - Added `didUpdateWidget` route syncing in `FileBrowserPage` so nested `/cirrus/<folder>/<child>` deep links refresh `_currentPath` instead of reusing the first matched segment.
8. 2026-05-01 - PR #1078 merged to `main` at `ea9225b530781325f6456160b32adb076ae9c8c4`, and the target submodule was repinned to that landed commit.

## Decision Log

1. Define interim routing reliability as refresh restore, bookmarkability, and browser back/forward - Makes the route-sync bar measurable instead of subjective.
2. Keep unsupported-file behavior inside Cirrus with explicit feedback - Avoids routing users into a broken editor state for unsupported files.

## Next Actions

1. Target submodule is pinned to the landed `main` commit for PR #1078.
