---
spec_id: SPEC-002
title: Cirrus Folder Deep-Link Entry
source_cujs:
  - cuj/1048-cirrus-folder-deep-link-entry/cuj.md
cuj_approval_required: true
cuj_approval_status: approved
status: draft
owner: product-platform
created: 2026-04-30
updated: 2026-04-30
target_repo: git@github.com:autobutler-org/autobutler.git
target_branch: main
target_submodule_path: cuj/1048-cirrus-folder-deep-link-entry/specs/folder-deep-link-entry/target
---

# Problem

Even if folder navigation updates the route, users still cannot share or bookmark a non-root Cirrus folder unless the application can resolve a folder path directly on first load. Without direct folder entry, pasted links and bookmarks still break the user journey and the route contract remains incomplete for real-world sharing and recovery flows.

# Goals

1. Open a valid non-root Cirrus folder directly from the browser URL on first render.
2. Provide a lightweight loading experience while the target folder is resolved.
3. Fail invalid or unauthorized folder links with a dedicated not-found state instead of redirecting elsewhere.

# Non-Goals

1. Directly opening file URLs; that is covered by `file-deep-link-entry`.
2. Changing folder browsing behavior after the target folder has already loaded; that is covered by `folder-navigation-history`.
3. Defining final error-copy wording beyond the required recovery actions and state transitions.

# User Journey Mapping

1. `CUJ-002`: Define initial-load routing that resolves a shared folder URL into the matching Cirrus folder view with safe fallback behavior.

# Requirements

## Functional

1. On initial load of `/cirrus/<folder path>`, Cirrus must parse the requested folder path before default browser content is rendered.
2. While the target folder is being resolved, Cirrus must show a lightweight loading shell instead of dropping the user at root or showing a full-page blocking spinner.
3. If the target folder exists and the user has access, Cirrus must render that folder as the initial browser state.
4. If the target folder is missing, stale, or malformed, Cirrus must show a dedicated not-found state instead of silently redirecting to another folder.
5. If the user lacks access to the requested folder, Cirrus must deny access without exposing the folder contents.
6. The not-found state must provide recovery actions to retry, go to the parent folder when derivable, and return to `/cirrus`.

## Non-Functional

1. Initial route resolution must not flash unrelated folder contents before the target folder or error state is known.
2. Unauthorized folder deep links must not reveal folder names or contents beyond what is already present in the route itself.
3. The folder-deep-link flow must reuse the canonical route contract established by `folder-navigation-history`.

# Acceptance Criteria

1. Given a user opens `/cirrus/Documents/Projects`, when Cirrus finishes initial route resolution, then the `Documents/Projects` folder listing is the first interactive state shown to the user.
2. Given a user opens a valid folder deep link, when the target folder is still loading, then Cirrus shows a lightweight loading shell rather than root content or a full-page blocking spinner.
3. Given a user opens a missing or malformed folder deep link, when Cirrus resolves the route, then it shows a dedicated not-found state with recovery actions and does not redirect to another folder automatically.
4. Given a user opens a folder route they are not authorized to access, when Cirrus resolves the route, then it denies access without rendering folder contents.

# UX and API Notes

The folder deep-link contract reuses `/cirrus/<folder path>`. The loading shell should display enough location context for the user to confirm which path is being resolved. The not-found state should preserve the requested route in the address bar until the user explicitly chooses a recovery action.

# Rollout Plan

1. Reuse the folder-route parser to resolve nested folder paths on first render.
2. Add the lightweight loading shell for folder resolution on startup.
3. Introduce dedicated not-found and unauthorized-folder states with explicit recovery actions.
4. Validate first-load folder deep links across valid, missing, and unauthorized paths.

# Stacked PR Plan

- CUJ stack manifest: `cuj/1048-cirrus-folder-deep-link-entry/pr-stack.md`
- Planned PR branch: feature/1048-folder-deep-link-entry
- Stack position: 1
- Depends on spec(s): folder-navigation-history
- Unblocks spec(s): file-deep-link-entry

# Implementation Gate

Implementation must not start until the linked CUJ approval is `approved`.

# Risks and Mitigations

1. Risk: Startup routing briefly renders root content before the target folder is resolved.
   Mitigation: Gate the first interactive folder render behind explicit route resolution and the lightweight loading shell.
2. Risk: Missing-folder handling conflates unauthorized and not-found states.
   Mitigation: Separate authorization failure from not-found behavior and validate both paths explicitly.

# Validation Plan

1. Add first-load routing tests for valid folder links, missing-folder links, and unauthorized-folder links.
2. Manually verify that bookmarked folder URLs resolve to the requested folder and that not-found states preserve the route until the user picks a recovery action.

# Implementation Tracking

The implementation repository is mounted as a submodule at:

`cuj/1048-cirrus-folder-deep-link-entry/specs/folder-deep-link-entry/target`

Expected setup command:

```bash
git submodule add -b main git@github.com:autobutler-org/autobutler.git cuj/1048-cirrus-folder-deep-link-entry/specs/folder-deep-link-entry/target
```
