# 📊 Investment Portfolio Analyzer

> A Claude Code skill that turns your brokerage statements into a structured, tax-aware portfolio analysis — complete with allocation drift, analyst targets, rebalancing proposals, and a visual HTML dashboard.

Built for Brazilian investors holding positions at **Ion (Itaú)** and **Avenue**, with full coverage of cross-border taxation (Brazil/USA), Selic benchmark comparison, and dividend income projection.

---

## What it does

You paste or attach your brokerage export. The skill does the rest:

| Step | Output |
|------|--------|
| Parses positions from Ion and/or Avenue | Ticker, quantity, average cost, current value |
| Calculates allocation by class, country, and currency | % vs. your target allocation |
| Measures drift vs. your target (default: moderate profile) | Which categories are over/under |
| Benchmarks portfolio return against the monthly Selic | Are you beating the risk-free rate? |
| Projects dividend income (BR + US, gross and net of withholding) | Annual R$ / US$ yield per position |
| Proposes rebalancing with tax cost pre-calculated | Gross value, estimated tax, net received |
| Flags analyst price targets per bank vs. current price | Upside/downside % per position |
| Publishes an interactive HTML dashboard | One artifact link to share or save |

**This is not licensed financial advice.** See [Disclaimer](#disclaimer).

---

## Example output

→ [View live dashboard example](examples/dashboard.html)

The dashboard includes:
- Multi-tab layout: Overview, Brazilian stocks, US stocks, ETFs, Rebalancing proposals
- Per-position cards with price vs. analyst targets (by bank: GS, JPM, MS, UBS, BofA)
- Allocation chart with drift indicators
- Tax-cost breakdown for every proposed trade
- Fixed footer disclaimer

![Dashboard preview](docs/dashboard-preview.png)

---

## Quickstart

### Prerequisites

- [Claude Code](https://claude.ai/code) (any plan with skills support)
- Brokerage statements from Ion (Itaú) and/or Avenue — PDF, CSV, screenshot, or pasted text

### Install the skill

```bash
# Clone the repo
git clone https://github.com/murillolarocca/investment-portfolio-analyzer.git
cd investment-portfolio-analyzer

# Deploy the skill to your local Claude Code installation
./install.sh
```

Then restart Claude Code (or run `/skills reload` if supported in your version).

### Run an analysis

Open Claude Code and say any of:

- *"Analisa minha carteira"*
- *"Rebalancear meus investimentos"*
- *"Revisar minha alocação"*
- *"Dá uma olhada na minha carteira"*

Claude will ask for your brokerage export and walk through the analysis automatically.

To update prices on an existing dashboard:

- *"Revisar cotações"*
- *"Atualizar preços dos papeis"*

---

## What data you need to provide

See **[docs/input-guide.md](docs/input-guide.md)** for the full guide.

Quick summary:

| Field | Required? | Notes |
|-------|-----------|-------|
| Ticker / asset name | Yes | |
| Current market value | Yes | |
| Average cost (PM) | Recommended | Needed for gain/loss % and tax calc |
| Purchase date | Recommended | Affects tax bracket (BR sliding scale) |
| Gain % (as shown in app) | Optional | Used to back-calculate PM if missing |
| Currency | Yes | BRL or USD |
| Broker | Yes | Ion or Avenue |

Accepted formats: PDF export, CSV, screenshot/photo, or text pasted directly into chat.

---

## What to expect from the output

See **[docs/output-guide.md](docs/output-guide.md)** for the full guide.

The dashboard is published as a private HTML artifact. Key sections:

1. **Resumo (Overview)** — full position table with PM, current price, gain %, analyst target, upside %, and status chip
2. **Ações BR** — Brazilian equities with Ion data
3. **Ações EUA** — US equities with Avenue data
4. **ETFs** — ETF positions with yield and coverage ratio data
5. **Rebalanceamento** — Proposed trades with tax cost, net value, and reason
6. **Dividendos** — Income projection table (gross and net of withholding)

---

## Skill reference files

| File | Purpose |
|------|---------|
| [skill/SKILL.md](skill/SKILL.md) | Main skill instructions for Claude |
| [skill/references/allocation-framework.md](skill/references/allocation-framework.md) | Target allocation ranges (moderate profile) |
| [skill/references/tax-brazil.md](skill/references/tax-brazil.md) | Brazilian tax rules (IRPF, GCAP, Lei 14.754/2023) |
| [skill/references/tax-usa.md](skill/references/tax-usa.md) | US tax rules for NRA investors (withholding, W-8BEN) |
| [skill/references/dividend-analysis.md](skill/references/dividend-analysis.md) | Dividend methodology (BR JCP vs dividendo, US withholding) |

---

## Keeping your local skill in sync with GitHub

After updating any skill file or the example dashboard locally, run:

```bash
./sync.sh
```

This copies the latest skill files from your Claude Code directory and pushes to GitHub.

---

## Disclaimer

The analysis produced by this skill is for **informational and planning purposes only**. It is not personalized investment advice, a recommendation to buy or sell any security, or tax guidance from a licensed professional.

Tax rules — especially cross-border Brazil/USA treatment under Lei 14.754/2023 — change frequently. Always confirm with a qualified **contador/CPA** before executing any real operation, particularly for operations involving significant capital gains or foreign income.

---

## Contributing

Pull requests welcome. If you extend the skill to support other brokers (XP, NuInvest, Fidelity, etc.), please open a PR with the relevant changes to `SKILL.md` and the reference files.

---

## License

MIT
