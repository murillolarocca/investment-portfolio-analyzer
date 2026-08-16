#!/usr/bin/env bats

setup() {
  REPO_ROOT="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
  INSTALL_SH="$REPO_ROOT/install.sh"
  FAKE_HOME="$(mktemp -d)"
  export HOME="$FAKE_HOME"
}

teardown() {
  rm -rf "$FAKE_HOME"
}

@test "install.sh exists and is executable" {
  [ -f "$INSTALL_SH" ]
  [ -x "$INSTALL_SH" ]
}

@test "install.sh creates destination directory" {
  run bash "$INSTALL_SH"
  [ "$status" -eq 0 ]
  [ -d "$FAKE_HOME/.claude/skills/investment-portfolio-analyzer" ]
}

@test "install.sh copies SKILL.md" {
  run bash "$INSTALL_SH"
  [ "$status" -eq 0 ]
  [ -f "$FAKE_HOME/.claude/skills/investment-portfolio-analyzer/SKILL.md" ]
}

@test "install.sh copies all reference files" {
  run bash "$INSTALL_SH"
  [ "$status" -eq 0 ]
  local refs_dst="$FAKE_HOME/.claude/skills/investment-portfolio-analyzer/references"
  [ -d "$refs_dst" ]
  [ -f "$refs_dst/allocation-framework.md" ]
  [ -f "$refs_dst/tax-brazil.md" ]
  [ -f "$refs_dst/tax-usa.md" ]
  [ -f "$refs_dst/dividend-analysis.md" ]
}

@test "install.sh SKILL.md content matches source" {
  run bash "$INSTALL_SH"
  [ "$status" -eq 0 ]
  diff "$REPO_ROOT/skill/SKILL.md" \
       "$FAKE_HOME/.claude/skills/investment-portfolio-analyzer/SKILL.md"
}

@test "install.sh reference files content matches source" {
  run bash "$INSTALL_SH"
  [ "$status" -eq 0 ]
  for f in allocation-framework.md tax-brazil.md tax-usa.md dividend-analysis.md; do
    diff "$REPO_ROOT/skill/references/$f" \
         "$FAKE_HOME/.claude/skills/investment-portfolio-analyzer/references/$f"
  done
}

@test "install.sh is idempotent (safe to run twice)" {
  run bash "$INSTALL_SH"
  [ "$status" -eq 0 ]
  run bash "$INSTALL_SH"
  [ "$status" -eq 0 ]
  [ -f "$FAKE_HOME/.claude/skills/investment-portfolio-analyzer/SKILL.md" ]
}

@test "install.sh prints success message" {
  run bash "$INSTALL_SH"
  [ "$status" -eq 0 ]
  echo "$output" | grep -q "installed"
}
