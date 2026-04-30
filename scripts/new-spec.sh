#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  scripts/new-spec.sh \
    --cuj <cuj-slug> \
    --spec <spec-slug> \
    --spec-id <SPEC-NNN> \
    --title "<Feature Spec Title>" \
    --owner "<team-or-person>" \
    --repo <git-url> \
    --branch <branch-name>

Example:
  scripts/new-spec.sh \
    --cuj device-onboarding \
    --spec device-onboarding-bootstrap \
    --spec-id SPEC-001 \
    --title "Device Onboarding Bootstrap" \
    --owner "product-platform" \
    --repo git@github.com:autobutler-org/autobutler.git \
    --branch feature/device-onboarding-bootstrap
EOF
}

CUJ_SLUG=""
SPEC_SLUG=""
SPEC_ID=""
SPEC_TITLE=""
OWNER=""
TARGET_REPO=""
TARGET_BRANCH=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --cuj)
      CUJ_SLUG="$2"
      shift 2
      ;;
    --spec)
      SPEC_SLUG="$2"
      shift 2
      ;;
    --spec-id)
      SPEC_ID="$2"
      shift 2
      ;;
    --title)
      SPEC_TITLE="$2"
      shift 2
      ;;
    --owner)
      OWNER="$2"
      shift 2
      ;;
    --repo)
      TARGET_REPO="$2"
      shift 2
      ;;
    --branch)
      TARGET_BRANCH="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if [[ -z "$CUJ_SLUG" || -z "$SPEC_SLUG" || -z "$SPEC_ID" || -z "$SPEC_TITLE" || -z "$OWNER" || -z "$TARGET_REPO" || -z "$TARGET_BRANCH" ]]; then
  echo "Error: Missing one or more required arguments." >&2
  usage
  exit 1
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CUJ_DIR="$ROOT_DIR/cuj/$CUJ_SLUG"
CUJ_DOC="$CUJ_DIR/cuj.md"
SPEC_DIR="$CUJ_DIR/specs/$SPEC_SLUG"
TARGET_SUBMODULE_PATH="cuj/$CUJ_SLUG/specs/$SPEC_SLUG/target"
TARGET_SUBMODULE_ABS="$ROOT_DIR/$TARGET_SUBMODULE_PATH"
PR_STACK_TEMPLATE="$ROOT_DIR/templates/pr-stack-template.md"
PR_STACK_DOC="$CUJ_DIR/pr-stack.md"
SPEC_TEMPLATE="$ROOT_DIR/templates/spec-template.md"
TRACKING_TEMPLATE="$ROOT_DIR/templates/tracking-template.md"

replace_placeholder() {
  local placeholder="$1"
  local value="$2"
  local file="$3"
  PLACEHOLDER="$placeholder" VALUE="$value" perl -0pi -e 's/\Q$ENV{PLACEHOLDER}\E/$ENV{VALUE}/g' "$file"
}

if [[ ! -f "$PR_STACK_TEMPLATE" || ! -f "$SPEC_TEMPLATE" || ! -f "$TRACKING_TEMPLATE" ]]; then
  echo "Error: Missing template files under templates/." >&2
  exit 1
fi

if [[ ! -f "$CUJ_DOC" ]]; then
  echo "Error: Missing CUJ document: cuj/$CUJ_SLUG/cuj.md" >&2
  echo "Create and approve the CUJ first (set approval_status: approved), then create specs." >&2
  exit 1
fi

CUJ_APPROVAL_STATUS="$(awk -F': ' '/^approval_status:/ { print $2; exit }' "$CUJ_DOC" | tr -d '\r' | xargs)"
if [[ "$CUJ_APPROVAL_STATUS" != "approved" ]]; then
  echo "Error: CUJ is not approved (approval_status: ${CUJ_APPROVAL_STATUS:-missing})." >&2
  echo "Set approval_status: approved in cuj/$CUJ_SLUG/cuj.md before creating specs." >&2
  exit 1
fi

if [[ -d "$SPEC_DIR" ]]; then
  echo "Error: Spec directory already exists: $SPEC_DIR" >&2
  exit 1
fi

if [[ -e "$TARGET_SUBMODULE_ABS" ]]; then
  echo "Error: Target submodule path already exists: $TARGET_SUBMODULE_PATH" >&2
  exit 1
fi

mkdir -p "$CUJ_DIR"
if [[ ! -f "$PR_STACK_DOC" ]]; then
  cp "$PR_STACK_TEMPLATE" "$PR_STACK_DOC"
fi

mkdir -p "$SPEC_DIR"
cp "$SPEC_TEMPLATE" "$SPEC_DIR/spec.md"
cp "$TRACKING_TEMPLATE" "$SPEC_DIR/tracking.md"

TODAY="$(date +%F)"
STACK_ORDER=""

replace_placeholder "<NNN>" "${SPEC_ID#SPEC-}" "$SPEC_DIR/spec.md"
replace_placeholder "SPEC-<NNN>" "$SPEC_ID" "$SPEC_DIR/spec.md"
replace_placeholder "<Feature Spec Title>" "$SPEC_TITLE" "$SPEC_DIR/spec.md"
replace_placeholder "<cuj-slug>" "$CUJ_SLUG" "$SPEC_DIR/spec.md"
replace_placeholder "<spec-slug>" "$SPEC_SLUG" "$SPEC_DIR/spec.md"
replace_placeholder "<team-or-person>" "$OWNER" "$SPEC_DIR/spec.md"
replace_placeholder "<YYYY-MM-DD>" "$TODAY" "$SPEC_DIR/spec.md"
replace_placeholder "<git-url>" "$TARGET_REPO" "$SPEC_DIR/spec.md"
replace_placeholder "<branch-name>" "$TARGET_BRANCH" "$SPEC_DIR/spec.md"
replace_placeholder "<target_repo>" "$TARGET_REPO" "$SPEC_DIR/spec.md"
replace_placeholder "<target_branch>" "$TARGET_BRANCH" "$SPEC_DIR/spec.md"
replace_placeholder "<target_submodule_path>" "$TARGET_SUBMODULE_PATH" "$SPEC_DIR/spec.md"

replace_placeholder "SPEC-<NNN>" "$SPEC_ID" "$SPEC_DIR/tracking.md"
replace_placeholder "<YYYY-MM-DD>" "$TODAY" "$SPEC_DIR/tracking.md"
replace_placeholder "<cuj-slug>" "$CUJ_SLUG" "$SPEC_DIR/tracking.md"
replace_placeholder "<spec-slug>" "$SPEC_SLUG" "$SPEC_DIR/tracking.md"
replace_placeholder "<git-url>" "$TARGET_REPO" "$SPEC_DIR/tracking.md"
replace_placeholder "<branch-name>" "$TARGET_BRANCH" "$SPEC_DIR/tracking.md"

if grep -q "<cuj-slug>" "$PR_STACK_DOC"; then
  replace_placeholder "<cuj-slug>" "$CUJ_SLUG" "$PR_STACK_DOC"
fi
if grep -q "<YYYY-MM-DD>" "$PR_STACK_DOC"; then
  replace_placeholder "<YYYY-MM-DD>" "$TODAY" "$PR_STACK_DOC"
fi

if grep -q "<spec-slug>" "$PR_STACK_DOC"; then
  STACK_ORDER="1"
  awk -v spec="$SPEC_SLUG" -v branch="$TARGET_BRANCH" '
    {
      if ($0 ~ /\|[[:space:]]*1[[:space:]]*\|[[:space:]]*<spec-slug>[[:space:]]*\|/) {
        print "| 1 | " spec " | " branch " | <https://...> | none | planned | not-merged | 1 | created by bootstrap |"
      } else {
        print $0
      }
    }
  ' "$PR_STACK_DOC" > "$PR_STACK_DOC.tmp"
  mv "$PR_STACK_DOC.tmp" "$PR_STACK_DOC"
elif ! grep -q "| $SPEC_SLUG |" "$PR_STACK_DOC"; then
  STACK_ORDER="$(awk -F'|' '
    BEGIN { max = 0 }
    /^[|][[:space:]]*[0-9]+[[:space:]]*[|]/ {
      gsub(/ /, "", $2)
      if ($2 + 0 > max) max = $2 + 0
    }
    END { print max + 1 }
  ' "$PR_STACK_DOC")"
  printf '| %s | %s | %s | <https://...> | none | planned | not-merged | %s | created by bootstrap |\n' "$STACK_ORDER" "$SPEC_SLUG" "$TARGET_BRANCH" "$STACK_ORDER" >> "$PR_STACK_DOC"
else
  STACK_ORDER="$(awk -F'|' -v spec="$SPEC_SLUG" '
    /^[|]/ {
      order = $2
      slug = $3
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", order)
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", slug)
      if (slug == spec) {
        print order
        exit
      }
    }
  ' "$PR_STACK_DOC")"
fi

git -C "$ROOT_DIR" submodule add -b "$TARGET_BRANCH" "$TARGET_REPO" "$TARGET_SUBMODULE_PATH"
CURRENT_SUBMODULE_COMMIT="$(git -C "$TARGET_SUBMODULE_ABS" rev-parse HEAD)"

replace_placeholder "<1-based-order>" "$STACK_ORDER" "$SPEC_DIR/spec.md"
replace_placeholder "${SPEC_SLUG}[, ${SPEC_SLUG}]" "none" "$SPEC_DIR/spec.md"

replace_placeholder "draft | in-progress | blocked | done" "draft" "$SPEC_DIR/tracking.md"
replace_placeholder "<sha>" "$CURRENT_SUBMODULE_COMMIT" "$SPEC_DIR/tracking.md"
replace_placeholder "<1-based-order>" "$STACK_ORDER" "$SPEC_DIR/tracking.md"
replace_placeholder "<none or comma-separated spec-slugs>" "none" "$SPEC_DIR/tracking.md"
replace_placeholder "<https://...>" "pending" "$SPEC_DIR/tracking.md"
replace_placeholder "planned | open | approved | changes-requested | merged" "planned" "$SPEC_DIR/tracking.md"
replace_placeholder "<order value>" "$STACK_ORDER" "$SPEC_DIR/tracking.md"
replace_placeholder "yes | no" "yes" "$SPEC_DIR/tracking.md"
replace_placeholder "<name-or-role>" "bootstrap script" "$SPEC_DIR/tracking.md"
replace_placeholder "1. $TODAY - <change summary>" "1. $TODAY - Bootstrapped spec scaffold and added target submodule." "$SPEC_DIR/tracking.md"
replace_placeholder "2. $TODAY - <change summary>" "2. $TODAY - Verified CUJ approval gate and recorded initial stack metadata." "$SPEC_DIR/tracking.md"

cat <<EOF
Created:
  - cuj/$CUJ_SLUG/pr-stack.md
  - $TARGET_SUBMODULE_PATH
  - cuj/$CUJ_SLUG/specs/$SPEC_SLUG/spec.md
  - cuj/$CUJ_SLUG/specs/$SPEC_SLUG/tracking.md

Next steps:
  1) Review and refine spec content.
  2) Commit the new files and .gitmodules.
EOF
