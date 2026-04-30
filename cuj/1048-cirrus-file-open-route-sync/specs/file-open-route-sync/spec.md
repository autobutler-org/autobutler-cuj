---
spec_id: SPEC-004
title: Cirrus File Open Route Sync
source_cujs:
  - cuj/1048-cirrus-file-open-route-sync/cuj.md
cuj_approval_required: true
cuj_approval_status: approved
status: draft
owner: product-platform
created: 2026-04-30
updated: 2026-04-30
target_repo: git@github.com:autobutler-org/autobutler.git
target_branch: main
target_submodule_path: cuj/1048-cirrus-file-open-route-sync/specs/file-open-route-sync/target
---

# Problem

Even with deep links in place, Cirrus still breaks route fidelity if opening a file from the in-app browser does not update the URL to the file that the user actually opened. That leaves editor state unbookmarkable, breaks refresh and history expectations, and risks repeating the silent file-open cancellation bug that motivated this journey.

# Goals

1. Update the browser URL to the selected file path whenever a user opens an editor-supported file from inside Cirrus.
2. Make the resulting open-file route reliable enough for refresh, bookmarkability, and browser back/forward.
3. Preserve safe failure behavior when a route update or unsupported file type prevents editor launch.

# Non-Goals

1. Adding support for file types that do not already have an editor.
2. Redefining the folder route contract established by the preceding specs.
3. Introducing a silent fallback that hides editor-launch or route-synchronization failures.

# User Journey Mapping

1. `CUJ-004`: Define in-app file-open behavior that synchronizes the URL with the editor-supported file path without cancelling the open flow.

# Requirements

## Functional

1. When a user opens an editor-supported file from the Cirrus browser, Cirrus must transition into the correct editor and update the browser URL to that file path as part of the same user flow.
2. The route synchronization model may be interim, but it must reliably support refresh restore, bookmarkability, and browser back/forward for editor-supported file states.
3. Route updates must not cancel, interrupt, or silently roll back the editor-open action.
4. If a selected file does not have a supported editor, Cirrus must keep the user in the browser context and show explicit feedback instead of changing the route to a broken editor state.
5. If route synchronization fails during file open, Cirrus must surface a clear failure and preserve a safe browser or editor state rather than silently dropping the action.
6. The resulting file URL must be compatible with the direct file-deep-link flow defined by `file-deep-link-entry`.

## Non-Functional

1. Route updates during file open must be ordered so they cannot trigger a rebuild that cancels the editor launch.
2. The URL must never claim that a file is open when the editor failed to initialize.
3. The open-file routing contract must remain consistent between direct deep links and in-app file-open actions.

# Acceptance Criteria

1. Given a user is browsing a folder in Cirrus, when they open an editor-supported file, then Cirrus opens the editor and updates the URL to that file path without returning to the browser.
2. Given a user refreshes the page after opening an editor-supported file from Cirrus, when the app reloads, then the same file route restores through the direct file-deep-link flow.
3. Given a user opens an editor-supported file from Cirrus, when they use browser back, then the app returns to the prior folder route instead of leaving the browser history in an inconsistent state.
4. Given a user selects a file that does not have a supported editor, when Cirrus handles the action, then it keeps the user in the browser context and shows explicit feedback without changing the URL to a broken file route.
5. Given a route update would interrupt editor launch, when Cirrus performs the open-file action, then it preserves a safe final state and surfaces the failure instead of silently cancelling the open.

# UX and API Notes

The file-open route contract must match the direct file-deep-link contract so the same `/cirrus/<file path>` URL can be reached by either pasting the URL or opening the file from the browser. "Reliable enough" for the interim routing model means all three of refresh restore, bookmarkability, and browser back/forward work for editor-supported file states. Unsupported files should remain in the Cirrus browser and show explicit inline feedback rather than navigating away.

# Rollout Plan

1. Reorder the file-open flow so route synchronization cannot preempt editor launch.
2. Update browser-initiated file opens to push the canonical file route for editor-supported types.
3. Ensure refresh restore and browser history reuse the direct file-deep-link path for the resulting route.
4. Add explicit unsupported-file and route-sync failure handling that preserves a safe user state.

# Stacked PR Plan

- CUJ stack manifest: `cuj/1048-cirrus-file-open-route-sync/pr-stack.md`
- Planned PR branch: feature/1048-file-open-route-sync
- Stack position: 1
- Depends on spec(s): file-deep-link-entry
- Unblocks spec(s): none

# Implementation Gate

Implementation must not start until the linked CUJ approval is `approved`.

# Risks and Mitigations

1. Risk: Route updates fire before the editor transition is stable and recreate the silent cancellation bug.
   Mitigation: Define ordering constraints explicitly and test the editor-open flow with route synchronization enabled.
2. Risk: Unsupported files navigate into a broken route and strand the user away from the browser.
   Mitigation: Keep unsupported-file handling in Cirrus with explicit feedback and no route mutation.

# Validation Plan

1. Add tests for opening editor-supported files from Cirrus, refreshing open-file routes, browser back from an open file, unsupported-file handling, and route-sync failure handling.
2. Manually verify that a file opened from Cirrus can be bookmarked, refreshed, and revisited from browser history without cancelling the editor open.

# Implementation Tracking

The implementation repository is mounted as a submodule at:

`cuj/1048-cirrus-file-open-route-sync/specs/file-open-route-sync/target`

Expected setup command:

```bash
git submodule add -b main git@github.com:autobutler-org/autobutler.git cuj/1048-cirrus-file-open-route-sync/specs/file-open-route-sync/target
```
