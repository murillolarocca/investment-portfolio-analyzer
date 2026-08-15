# Investment Portfolio Analyzer (IPA)

> A Claude Code skill that turns your brokerage statements into a structured, tax-aware portfolio analysis — complete with allocation drift, rebalancing proposals with GCAP minimization, analyst targets, dividend income projection, and an interactive HTML dashboard.

Built for investors holding positions across Brazilian and US brokers, with full coverage of cross-border taxation (Brazil/USA), Selic benchmark comparison, and per-trade tax cost calculation.

> **Privacy:** IPA analyzes your data locally within your Claude Code session. No portfolio data, personal information, or confidential financial details are transmitted to third parties or stored externally.

---

## Core features

### Tax-minimizing rebalancing
IPA calculates gains and losses per position and always proposes rebalances that **minimize GCAP (Ganho de Capital) and other taxes payable**. Every proposed trade shows gross value, estimated tax (IRPF, GCAP, US withholding where applicable), and net proceeds — so you always know the real cost before you act.

Priority order the skill always follows:
1. **Redirect new deposits** to underweight categories — zero tax
2. **Use exemption limits** (e.g., R$20k/month isenção on Brazilian equities)
3. **Realize losses** to offset gains where beneficial
4. **Taxable sale** only when necessary — with full tax cost pre-calculated

### What it analyzes
- Allocation by asset class, country, and currency vs. your target
- Drift against a configurable target (default: moderate profile)
- Portfolio return vs. Selic monthly benchmark
- Dividend/income projection per position (gross and net of withholding)
- Analyst price targets per bank vs. current price (GS, JPM, MS, UBS, BofA, XP)
- Cross-border tax implications (GCAP, Lei 14.754/2023, US withholding for NRA)

---

## Example output

→ [View live dashboard example](examples/dashboard.html)

The dashboard includes:
- Multi-tab layout: Overview, Brazilian stocks, US stocks, ETFs, Rebalancing proposals
- Per-position cards with price vs. analyst targets (by bank)
- Allocation chart with drift indicators
- Tax-cost breakdown for every proposed trade
- Fixed footer disclaimer

---

## Quickstart

### Prerequisites

- [Claude Code](https://claude.ai/code) (any plan with skills support)
- Data from your broker in any supported format: **screenshots/prints**, **CSV or XLS exports**, **investment statements**, **consolidated PDFs**, or **text pasted directly into chat**

### Install IPA

```bash
git clone https://github.com/murillolarocca/investment-portfolio-analyzer.git
cd investment-portfolio-analyzer
./install.sh
```

Then restart Claude Code.

### Run an analysis

Open Claude Code and say any of:

- *"Analisa minha carteira"*
- *"Rebalancear meus investimentos"*
- *"Revisar minha alocação"*
- *"Dá uma olhada na minha carteira"*

IPA activates automatically when it detects investment-related keywords. No slash command needed.

To update prices on an existing dashboard:

- *"Revisar cotações"* / *"Atualizar preços dos papeis"*

---

## What data you need to provide

See **[docs/input-guide.md](docs/input-guide.md)** for the full guide.

Quick summary:

| Field | Required? | Notes |
|-------|-----------|-------|
| Ticker / asset name | Yes | |
| Current market value | Yes | |
| Average cost (PM) | Recommended | Needed for gain/loss and tax calculation |
| Gain % (as shown in app) | Optional | Used to back-calculate PM if missing |
| Purchase date | Recommended | Affects tax bracket on BR fixed income |
| Currency | Yes | BRL or USD |
| Broker | Yes | Brazilian or US |

**Accepted formats:** screenshots/prints of the portfolio app · CSV or XLS exported from the broker · investment statements · consolidated PDFs · text pasted directly into chat

---

## What to expect from the output

See **[docs/output-guide.md](docs/output-guide.md)** for the full guide.

Key dashboard sections:

1. **Resumo** — full position table with PM, current price, gain %, analyst target, upside %, and status
2. **Ações BR** — Brazilian equity cards
3. **Ações EUA** — US equity cards
4. **ETFs** — ETF positions with yield and coverage data
5. **Rebalanceamento** — proposed trades with GCAP estimate, net proceeds, and reason
6. **Dividendos** — income projection (gross and net of withholding)

---

## Skill reference files

| File | Purpose |
|------|---------|
| [skill/SKILL.md](skill/SKILL.md) | Main IPA instructions for Claude |
| [skill/references/allocation-framework.md](skill/references/allocation-framework.md) | Target allocation ranges (moderate profile) |
| [skill/references/tax-brazil.md](skill/references/tax-brazil.md) | Brazilian tax rules (IRPF, GCAP, Lei 14.754/2023) |
| [skill/references/tax-usa.md](skill/references/tax-usa.md) | US tax rules for NRA investors (withholding, W-8BEN) |
| [skill/references/dividend-analysis.md](skill/references/dividend-analysis.md) | Dividend methodology (BR JCP vs dividendo, US withholding) |

---

## Keeping your local changes synced to GitHub

After updating any skill file or the example dashboard locally, run:

```bash
./sync.sh
```

This copies the latest skill files from your Claude Code directory and pushes to GitHub. Pass a custom message as an argument if needed:

```bash
./sync.sh "add XP target for CMIG4"
```

---

## Disclaimer

The analysis produced by IPA is for **informational and planning purposes only**. It is not personalized investment advice, a recommendation to buy or sell any security, or tax guidance from a licensed professional.

Tax rules — especially cross-border Brazil/USA treatment under Lei 14.754/2023 — change frequently. Always confirm with a qualified **contador/CPA** before executing any real operation. The dashboard footer repeats this disclaimer on every output.

---

## Contributing

Pull requests welcome. If you extend IPA to support other brokers or markets, open a PR with changes to `skill/SKILL.md` and the relevant reference files.

---

## License

MIT
