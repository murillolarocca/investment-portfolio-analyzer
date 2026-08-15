#!/usr/bin/env bash
set -euo pipefail

SKILL_SRC="$(cd "$(dirname "$0")/skill" && pwd)"
SKILL_DST="$HOME/.claude/skills/investment-portfolio-analyzer"

echo "Installing Investment Portfolio Analyzer (IPA)..."
mkdir -p "$SKILL_DST/references"
cp "$SKILL_SRC/SKILL.md" "$SKILL_DST/SKILL.md"
cp "$SKILL_SRC/references/"*.md "$SKILL_DST/references/"

echo "✓ IPA installed at $SKILL_DST"
echo "  Restart Claude Code (or reload skills) to activate."
