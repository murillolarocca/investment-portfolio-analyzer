#!/usr/bin/env bash
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
SKILL_SRC="$HOME/.claude/skills/investment-advisor"
MSG="${1:-"sync: $(date '+%Y-%m-%d %H:%M')"}"

echo "Syncing skill files from $SKILL_SRC..."
if [[ -d "$SKILL_SRC" ]]; then
  cp "$SKILL_SRC/SKILL.md" "$REPO/skill/SKILL.md"
  cp "$SKILL_SRC/references/"*.md "$REPO/skill/references/"
  echo "  ✓ Skill files updated"
else
  echo "  ⚠ Skill directory not found at $SKILL_SRC — skipping skill file sync"
fi

cd "$REPO"

if git diff --quiet && git diff --cached --quiet; then
  echo "  Nothing to commit — working tree is clean."
  exit 0
fi

git add -A
git commit -m "$MSG"
git push

echo "✓ Pushed to GitHub."
