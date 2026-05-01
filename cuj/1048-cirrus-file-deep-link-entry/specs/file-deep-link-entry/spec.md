---
spec_id: SPEC-003
title: Cirrus File Deep-Link Entry
source_cujs:
  - cuj/1048-cirrus-file-deep-link-entry/cuj.md
cuj_approval_required: true
cuj_approval_status: approved
status: draft
owner: product-platform
created: 2026-04-30
updated: 2026-04-30
target_repo: git@github.com:autobutler-org/autobutler.git
target_branch: main
target_submodule_path: cuj/1048-cirrus-file-deep-link-entry/specs/file-deep-link-entry/target
---

# Problem

Users cannot reliably share or bookmark a file in Cirrus unless the routing layer can resolve a file path directly into the correct editor state on first load. Without file deep links, file-centric workflows still require manual folder navigation, and broken file URLs can fail ambiguously instead of giving users a safe, explicit recovery path.

# Goals

1. Open a valid file deep link directly into the correct editor for editor-supported file types.
2. Distinguish file deep links from folder deep links during initial route resolution.
3. Fail invalid, unauthorized, or unsupported file deep links with a dedicated file error state.

# Non-Goals

1. Updating the browser URL when a user opens a file from inside Cirrus; that is covered by `file-open-route-sync`.
2. Adding editors for file types that the app does not already support.
3. Defining the full file-viewer contract for non-editor experiences outside the approved editor-supported scope.

# User Journey Mapping

1. `CUJ-003`: Define initial-load routing that resolves a file path into an editor-supported file open or a dedicated file error state.

# Requirements

## Functional

1. On initial load of `/cirrus/<path>`, Cirrus must determine whether the requested path resolves to a folder or a file before entering the final UI state.
2. If the requested path resolves to an editor-supported file type, Cirrus must open the correct editor directly from the route without requiring manual folder navigation first.
3. If the requested file is missing, malformed, or unauthorized, Cirrus must render a dedicated file error state and must not silently redirect to another route.
4. If the requested file type is not supported by an editor, Cirrus must render the same dedicated file error state with copy that explicitly says no supported editor is available.
5. The dedicated file error state must provide actions to retry, open the containing folder when derivable, and return to `/cirrus`.
6. File-deep-link resolution must coexist with folder deep-link resolution so `/cirrus/<path>` can correctly choose between folder and file behaviors.

## Non-Functional

1. Initial file route resolution must not briefly render the wrong folder or editor before the file type is known.
2. Unauthorized file deep links must not expose file contents or editor state.
3. The route resolution path for file deep links must be deterministic enough to support later in-app file-open URL sync work.

# Acceptance Criteria

1. Given a user opens a valid editor-supported file URL such as `/cirrus/Documents/report.abdoc`, when Cirrus resolves the route, then it opens the correct editor directly on first load.
2. Given a user opens a route that resolves to a folder instead of a file, when Cirrus resolves the path, then it follows the folder deep-link flow instead of opening an editor.
3. Given a user opens a missing, unauthorized, or malformed file deep link, when Cirrus resolves the route, then it shows a dedicated file error state and does not silently redirect elsewhere.
4. Given a user opens a file type that does not have a supported editor, when Cirrus resolves the route, then it shows a dedicated file error state that explains no supported editor is available.

# UX and API Notes

The shared route contract remains `/cirrus/<path>`, with resolution deciding whether the final state is a folder or an editor-supported file. The dedicated file error state should preserve the requested route until the user chooses a recovery action. Unsupported-file messaging should explicitly distinguish "no editor available" from missing or unauthorized files.

# Rollout Plan

1. Extend route resolution to classify `/cirrus/<path>` as folder or file before the final UI state is committed.
2. Wire editor selection for supported file types during initial route handling.
3. Add the dedicated file error state, including unsupported-file messaging and recovery actions.
4. Validate editor-supported, unsupported, missing, and unauthorized file deep-link cases.

# Stacked PR Plan

- CUJ stack manifest: `cuj/1048-cirrus-file-deep-link-entry/pr-stack.md`
- Planned PR branch: feature/1048-file-deep-link-entry
- Stack position: 1
- Depends on spec(s): folder-deep-link-entry
- Unblocks spec(s): file-open-route-sync

# Implementation Gate

Implementation must not start until the linked CUJ approval is `approved`.

# Risks and Mitigations

1. Risk: File-path resolution misclassifies a route and opens the wrong end state.
   Mitigation: Centralize path classification and test folder-versus-file resolution with representative paths.
2. Risk: Unsupported files fail with the same behavior as missing files, confusing users and obscuring capability gaps.
   Mitigation: Use explicit unsupported-file messaging within the dedicated file error state.

# Validation Plan

1. Add route-resolution tests for valid editor-supported files, unsupported file types, folders, missing files, and unauthorized files.
2. Manually verify that shared file links open directly in the correct editor and that failures preserve the route until the user selects a recovery action.

# Implementation Tracking

The implementation repository is mounted as a submodule at:

`cuj/1048-cirrus-file-deep-link-entry/specs/file-deep-link-entry/target`

Expected setup command:

```bash
git submodule add -b main git@github.com:autobutler-org/autobutler.git cuj/1048-cirrus-file-deep-link-entry/specs/file-deep-link-entry/target
```
