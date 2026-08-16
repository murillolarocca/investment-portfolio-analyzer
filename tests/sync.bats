#!/usr/bin/env bats

setup() {
  REPO_ROOT="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
  SYNC_SH="$REPO_ROOT/sync.sh"
  FAKE_HOME="$(mktemp -d)"
  export HOME="$FAKE_HOME"

  # Set up a fake installed skill directory
  SKILL_SRC="$FAKE_HOME/.claude/skills/investment-portfolio-analyzer"
  mkdir -p "$SKILL_SRC/references"
  cp "$REPO_ROOT/skill/SKILL.md" "$SKILL_SRC/SKILL.md"
  cp "$REPO_ROOT/skill/references/"*.md "$SKILL_SRC/references/"

  # Clone from REPO_ROOT into a working copy
  WORK_DIR="$(mktemp -d)"
  git clone "$REPO_ROOT" "$WORK_DIR" --quiet 2>/dev/null || true
  git -C "$WORK_DIR" config user.email "ci@test.local"
  git -C "$WORK_DIR" config user.name "CI"

  # Ensure we are on a real branch (CI checks out a detached HEAD)
  git -C "$WORK_DIR" checkout -B main 2>/dev/null || true

  # Create a bare repo and push to it so sync.sh can push successfully
  BARE_DIR="$(mktemp -d)"
  git init --bare "$BARE_DIR" --quiet
  git -C "$WORK_DIR" remote set-url origin "$BARE_DIR"
  git -C "$WORK_DIR" push -u origin main --quiet 2>/dev/null || true

  WORK_SYNC="$WORK_DIR/sync.sh"
}

teardown() {
  rm -rf "$FAKE_HOME" "$WORK_DIR" "$BARE_DIR"
}

@test "sync.sh exists and is executable" {
  [ -f "$SYNC_SH" ]
  [ -x "$SYNC_SH" ]
}

@test "sync.sh copies SKILL.md back to repo clone" {
  # Modify the installed copy so we can verify it was synced
  echo "# extra line" >> "$SKILL_SRC/SKILL.md"

  run bash "$WORK_SYNC"
  grep -q "extra line" "$WORK_DIR/skill/SKILL.md"
}

@test "sync.sh copies reference files back to repo clone" {
  echo "# extra" >> "$SKILL_SRC/references/tax-brazil.md"

  run bash "$WORK_SYNC"
  grep -q "extra" "$WORK_DIR/skill/references/tax-brazil.md"
}

@test "sync.sh warns and exits 0 when skill directory is missing" {
  rm -rf "$SKILL_SRC"
  run bash "$WORK_SYNC"
  [ "$status" -eq 0 ]
  echo "$output" | grep -qi "not found\|skipping"
}

@test "sync.sh accepts a custom commit message argument" {
  echo "# bump" >> "$SKILL_SRC/SKILL.md"
  run bash "$WORK_SYNC" "test: custom message"
  [ "$status" -eq 0 ]
  # verify the custom message appears in git log of the working copy
  git -C "$WORK_DIR" log --oneline -1 | grep -q "test: custom message"
}
