---
spec_id: SPEC-001
title: Cirrus Folder Navigation History
source_cujs:
  - cuj/1048-cirrus-folder-navigation-history/cuj.md
cuj_approval_required: true
cuj_approval_status: approved
status: draft
owner: product-platform
created: 2026-04-30
updated: 2026-04-30
target_repo: git@github.com:autobutler-org/autobutler.git
target_branch: main
target_submodule_path: cuj/1048-cirrus-folder-navigation-history/specs/folder-navigation-history/target
---

# Problem

Cirrus currently treats folder navigation as local UI state instead of route state, so the address bar, refresh behavior, and browser history drift away from the folder the user is actually viewing. That breaks basic web expectations for navigation, makes folders impossible to bookmark or share reliably, and forces follow-on routing work to rebuild core folder state from scratch.

# Goals

1. Keep the visible Cirrus folder, browser URL, and browser history aligned for every folder navigation action.
2. Restore the folder represented by the current URL on initial load, refresh, and browser back/forward.
3. Define consistent invalid-folder behavior without silently redirecting users to a different location.

# Non-Goals

1. Opening files directly from a pasted URL; that is covered by `file-deep-link-entry`.
2. Updating the URL when a user opens a file from within Cirrus; that is covered by `file-open-route-sync`.
3. Preserving transient UI state such as scroll position or selection across history navigation.

# User Journey Mapping

1. `CUJ-001`: Define route-driven folder browsing so navigation, refresh, and browser history all restore the same Cirrus folder state.

# Requirements

## Functional

1. Cirrus must treat `/cirrus` as the root folder route and `/cirrus/<folder path>` as the canonical route for a nested folder.
2. On page mount, refresh, and browser history navigation, Cirrus must load the folder represented by the current route instead of defaulting to root.
3. When a user opens a child folder, navigates home, or otherwise changes folders from the UI, Cirrus must update the browser URL to the canonical folder path.
4. Browser back and forward must restore the folder listing for the previous or next folder route without requiring a manual reload.
5. When folder state is restored from browser history, transient UI state such as scroll position and file selection must reset for the restored folder view.
6. If the requested folder path is missing or inaccessible, Cirrus must render an explicit error state and must not silently redirect to root or another folder.

## Non-Functional

1. Route changes for folder navigation must complete without a full-page reload and must not leave the file browser in a mismatched route/UI state.
2. Invalid or unauthorized folder routes must not expose contents from any other folder while the error state is displayed.
3. The folder-routing contract must be stable enough to support later deep-link and file-open routing work without redefining the folder route shape.

# Acceptance Criteria

1. Given a user is at `/cirrus`, when they open a child folder named `Documents`, then the URL becomes `/cirrus/Documents` and the file browser shows the `Documents` listing.
2. Given a user is at `/cirrus/Documents/Projects`, when they refresh the page, then Cirrus reloads `Documents/Projects` instead of returning to `/cirrus`.
3. Given a user has navigated from `/cirrus` to `/cirrus/Documents`, when they press browser back, then Cirrus returns to the root listing and resets folder-local selection and scroll state.
4. Given the browser route points to a missing or inaccessible folder, when Cirrus loads that route, then it shows an explicit error state and does not silently redirect to another folder.

# UX and API Notes

The canonical folder route contract is `/cirrus/<folder path>` with `/cirrus` reserved for the root. Error UX should expose recovery actions for retry, go to parent when one exists, and go to root. Home navigation should always return the route to `/cirrus` and reset transient folder UI state even if the user was already at root.

# Rollout Plan

1. Land route parsing and folder-route generation for root and nested folder paths.
2. Wire folder navigation actions and browser history events to the route contract.
3. Add the explicit invalid-folder error state and recovery actions.
4. Verify manual and automated coverage for refresh, back/forward, and invalid-folder routes.

# Stacked PR Plan

- CUJ stack manifest: `cuj/1048-cirrus-folder-navigation-history/pr-stack.md`
- Planned PR branch: feature/1048-folder-navigation-history
- Stack position: 1
- Depends on spec(s): none
- Unblocks spec(s): folder-deep-link-entry, file-deep-link-entry, file-open-route-sync

# Implementation Gate

Implementation must not start until the linked CUJ approval is `approved`.

# Risks and Mitigations

1. Risk: Browser history restores a route before the folder store is ready, causing stale or blank listings.
   Mitigation: Make route-derived folder loading the single source of truth and cover back/forward and refresh in the validation plan.
2. Risk: Invalid-folder handling silently falls back to root and hides routing bugs.
   Mitigation: Require an explicit error state with deterministic recovery actions and test it with missing and unauthorized folders.

# Validation Plan

1. Add route-aware tests for root navigation, nested folder navigation, refresh restore, browser back/forward, and invalid-folder error rendering.
2. Manually verify that the visible folder and address bar stay aligned across root, nested folders, home navigation, and browser history transitions.

# Implementation Tracking

The implementation repository is mounted as a submodule at:

`cuj/1048-cirrus-folder-navigation-history/specs/folder-navigation-history/target`

Expected setup command:

```bash
git submodule add -b main git@github.com:autobutler-org/autobutler.git cuj/1048-cirrus-folder-navigation-history/specs/folder-navigation-history/target
```
