# Setup Guide

## Prerequisites

- **Claude Code** — desktop app, CLI, or web at [claude.ai/code](https://claude.ai/code)
- A Claude subscription that supports skills (Pro or above)

---

## Installation

### Option A — Clone and install (recommended)

```bash
git clone https://github.com/murillolarocca/investment-portfolio-analyzer.git
cd investment-portfolio-analyzer
./install.sh
```

`install.sh` copies the skill files into your local Claude Code skills directory (`~/.claude/skills/investment-advisor/`) and confirms success.

### Option B — Manual install

Copy the `skill/` directory to your Claude Code skills folder:

```bash
cp -r skill/ ~/.claude/skills/investment-advisor/
```

Then verify the folder contains `SKILL.md` and the `references/` directory.

---

## First run

1. Open Claude Code
2. Start a new conversation
3. Say: *"Analisa minha carteira"* or *"Rebalancear meus investimentos"*
4. Attach or paste your brokerage export (see [input-guide.md](input-guide.md))

The skill activates automatically when it detects investment-related keywords. No slash command needed.

---

## Keeping the skill up to date

When a new version of the skill is published to GitHub:

```bash
cd investment-portfolio-analyzer
git pull
./install.sh
```

---

## Keeping your local changes synced to GitHub

If you edit any skill file or the example dashboard locally and want to push the changes back to GitHub:

```bash
./sync.sh
```

This script:
1. Copies the current skill files from `~/.claude/skills/investment-advisor/` into the repo
2. Stages all changes
3. Creates a commit with today's date
4. Pushes to GitHub

You can also pass a custom commit message:

```bash
./sync.sh "add XP target for PETR4"
```

---

## Troubleshooting

### The skill isn't triggering

Check that the skill is installed in the right location:

```bash
ls ~/.claude/skills/investment-advisor/
# Should show: SKILL.md  references/
```

If the folder is empty or missing, re-run `./install.sh`.

### Claude says it can't find the skill

Make sure you're running Claude Code (not the web chat at claude.ai) — skills are a Claude Code feature and aren't available in the standard web interface.

### Tax numbers look wrong

The tax calculations are estimates based on the rules documented in `skill/references/tax-brazil.md` and `skill/references/tax-usa.md`. If a rule has changed (especially Lei 14.754/2023 updates), open a PR to update the reference file and `./sync.sh` to push.

---

## Directory structure

```
investment-portfolio-analyzer/
├── README.md
├── install.sh          ← deploys skill to ~/.claude/skills/
├── sync.sh             ← syncs skill files and pushes to GitHub
├── docs/
│   ├── input-guide.md
│   ├── output-guide.md
│   └── setup.md        ← this file
├── skill/
│   ├── SKILL.md
│   └── references/
│       ├── allocation-framework.md
│       ├── dividend-analysis.md
│       ├── tax-brazil.md
│       └── tax-usa.md
└── examples/
    └── dashboard.html
```
