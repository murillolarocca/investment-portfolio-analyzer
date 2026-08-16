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

  # Build a fresh git repo from scratch — avoids detached HEAD issues
  # that occur when the CI checkout is a PR merge ref without a real branch.
  WORK_DIR="$(mktemp -d)"
  git init "$WORK_DIR" --quiet
  git -C "$WORK_DIR" config user.email "ci@test.local"
  git -C "$WORK_DIR" config user.name "CI"

  # Populate with the files sync.sh needs
  cp "$REPO_ROOT/sync.sh" "$WORK_DIR/sync.sh"
  cp -r "$REPO_ROOT/skill" "$WORK_DIR/skill"
  git -C "$WORK_DIR" add -A
  git -C "$WORK_DIR" commit -m "init" --quiet

  # Create a bare remote so sync.sh can push successfully
  BARE_DIR="$(mktemp -d)"
  git init --bare "$BARE_DIR" --quiet
  git -C "$WORK_DIR" remote add origin "$BARE_DIR"
  BRANCH="$(git -C "$WORK_DIR" rev-parse --abbrev-ref HEAD)"
  git -C "$WORK_DIR" push -u origin "$BRANCH" --quiet

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
  git -C "$WORK_DIR" log --oneline -1 | grep -q "test: custom message"
}
