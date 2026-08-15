# Setup Guide — Investment Portfolio Analyzer (IPA)

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

`install.sh` copies the IPA skill files into your local Claude Code skills directory (`~/.claude/skills/investment-portfolio-analyzer/`) and confirms success.

### Option B — Manual install

```bash
cp -r skill/ ~/.claude/skills/investment-portfolio-analyzer/
```

Verify the folder contains `SKILL.md` and the `references/` directory.

---

## First run

1. Open Claude Code
2. Start a new conversation
3. Say: *"Analisa minha carteira"* or *"Rebalancear meus investimentos"*
4. Attach or paste your brokerage export (see [input-guide.md](input-guide.md))

IPA activates automatically when it detects investment-related keywords. No slash command needed.

---

## Keeping IPA up to date

When a new version is published to GitHub:

```bash
cd investment-portfolio-analyzer
git pull
./install.sh
```

---

## Keeping your local changes synced to GitHub

After editing any skill file or the example dashboard locally:

```bash
./sync.sh
```

This script:
1. Copies the current skill files from `~/.claude/skills/investment-portfolio-analyzer/` into the repo
2. Stages all changes
3. Creates a commit with today's date
4. Pushes to GitHub

Optional custom commit message:

```bash
./sync.sh "update GCAP rules for Lei 14.754 amendment"
```

---

## Troubleshooting

### IPA isn't triggering

```bash
ls ~/.claude/skills/investment-portfolio-analyzer/
# Should show: SKILL.md  references/
```

If empty or missing, re-run `./install.sh`.

### Claude says it can't find the skill

Make sure you're running **Claude Code** (not the standard web chat at claude.ai) — skills are a Claude Code feature.

### Tax numbers look wrong

Tax calculations are based on the rules in `skill/references/tax-brazil.md` and `skill/references/tax-usa.md`. If a rule has changed, update the relevant reference file and run `./sync.sh` to push.

---

## Directory structure

```
investment-portfolio-analyzer/
├── README.md
├── install.sh          ← deploys IPA to ~/.claude/skills/investment-portfolio-analyzer/
├── sync.sh             ← syncs files from Claude and pushes to GitHub
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
