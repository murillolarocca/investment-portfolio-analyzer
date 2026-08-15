# Output Guide — What to expect from the analysis

The Investment Portfolio Analyzer (IPA) produces an **interactive HTML dashboard** published as a private artifact. You receive a link you can open in any browser or share with anyone. The dashboard requires no server — it's a self-contained HTML file.

---

## Dashboard structure

| Tab | Content |
|-----|---------|
| **Resumo** | Full position table + allocation overview |
| **Ações BR** | Brazilian equity cards |
| **Ações EUA** | US equity cards |
| **ETFs** | ETF positions with yield and coverage data |
| **Rebalanceamento** | Proposed trades with GCAP breakdown |

---

## Position table (Resumo → Posições)

| Column | Meaning |
|--------|---------|
| Ativo | Ticker |
| Corretora | Which broker holds this position |
| PM | Average cost (preço médio), in BRL or USD |
| Cotação atual | Current market price |
| Var. s/ PM | Gain or loss vs. average cost (%) |
| Alvo analistas | Consensus analyst price target |
| Upside p/ alvo | Distance from current price to analyst target (%) |
| Status | ▲ Abaixo do alvo / → No alvo / ▼ Acima do alvo |

**Status thresholds:**
- `▲ Abaixo do alvo` — current price is more than 5% below the analyst target
- `→ No alvo` — current price is within ±5% of the analyst target
- `▼ Acima do alvo` — current price is more than 5% above the analyst target (position has outrun the target)

When a stock rallies past an analyst's target, the card shows `(alvo desatualizado — pré-rally)` to signal that the target was set before the move.

---

## Individual position cards

### Price bar (ps-bar)
A visual scale showing PM → current price → analyst target, so you can see at a glance how far the position has moved and where analysts expect it to go.

### Analyst target rows (pt-rows)
One row per bank (GS, JPM, MS, UBS, BofA, XP, etc.) showing:
- Target price
- Upside or downside % from current price
- Progress bar (green = upside, red = downside)

### Analysis text
A brief qualitative note on the position — why it's held, key risks or catalysts, and any alerts.

---

## Allocation section

Shows:
- **Current allocation** by class (BR fixed income, BR equities, US equities, ETFs, cash)
- **Target allocation** (moderate framework or your custom target)
- **Drift** — percentage points above or below target per category

A drift of **~5 percentage points or more** generally warrants action. Below that, transaction costs and taxes outweigh the rebalancing benefit — IPA will suggest directing new deposits to the underweight category instead of selling.

### Drift measurement vs. proposal sizing

Drift is measured against the **midpoint** of the target range (e.g., for a 20–35% target, drift is measured against 27.5%). The rebalancing proposal trims to the **near edge** of the range (30%) to minimize the amount sold. The dashboard labels both so the numbers don't appear inconsistent.

---

## Selic benchmark comparison

IPA compares your portfolio's annualized return (weighted by position size and holding period) against the current Selic rate:

1. Annualize each position's return by its holding period
2. Weight by current market value
3. Compare the weighted average against the annualized Selic

This is an **approximation**. A more precise method would require knowing the portfolio's total value at the beginning of each month — if you provide that, IPA will use it instead.

---

## Dividend projection

| Column | Meaning |
|--------|---------|
| Ativo | Ticker |
| Dividend yield | Annual yield % (gross) |
| Yield líquido | Annual yield % after applicable withholding |
| Renda projetada bruta | Annual income in original currency |
| Renda projetada líquida | Annual income after withholding |
| Tipo | Dividend / JCP / Distribution |

**Important distinctions:**
- **Brazil — Dividendo:** tax-free at source for individual investors (PF)
- **Brazil — JCP (Juros sobre Capital Próprio):** 15% withholding at source — common in banks and utilities. IPA treats these separately and never conflates them
- **USA — Dividends:** 30% US withholding tax for non-resident aliens (NRA), deducted automatically by the broker before funds reach your account

---

## Rebalancing proposals — GCAP-minimizing logic

This is the core output of IPA. Each proposal shows:

| Field | Meaning |
|-------|---------|
| Ação | Sell / Buy / Redirect deposit |
| Ticker | Specific asset to trade |
| Valor bruto | Gross value of the trade |
| GCAP / Imposto estimado | Estimated tax on the gain |
| Valor líquido | Net proceeds after tax |
| Motivo | Why this trade is proposed |

### How IPA minimizes GCAP

IPA always exhausts lower-tax options before proposing a taxable sale:

1. **Redirect new deposits** to underweight categories — no sale, no tax
2. **Use isenção limits** — sell up to R$20,000/month in Brazilian equities completely tax-free (swing trade isenção). IPA will warn you if a proposed sale would exceed this threshold and cost more than splitting across two months
3. **Realize losses first** — if you hold positions with unrealized losses, IPA will identify whether crystallizing those losses can offset gains elsewhere, reducing net GCAP
4. **Taxable sale** — only when the above are insufficient, with full GCAP estimate shown

### Tax calculations used

| Asset class | Rule |
|------------|------|
| BR equities (swing trade) | 0% if monthly sales ≤ R$20k; 15% on gain above that |
| BR equities (day trade) | 20% on gain, no isenção |
| FIIs | 20% on gain, no isenção |
| BR fixed income | 22.5% → 15% sliding scale by holding period |
| US assets (sold via US broker) | No US capital gains tax for NRA; 15% Brazilian GCAP on BRL gain |
| US dividends | 30% US withholding at source |

All estimates are clearly labeled as estimates. The dashboard always includes the disclaimer to confirm with a contador/CPA before any real operation.

---

## Updating the dashboard

The dashboard is published at a fixed link. When you ask to update prices, IPA republishes to the **same URL** — your link stays stable. Each version is labeled with the date (e.g., `cotações 2026-08-15`) and visible in the artifact's version history.

---

## Disclaimer

All numbers in the dashboard are **estimates for planning purposes**. They are not a recommendation to buy or sell any security, and they are not tax advice. Tax rules — especially Lei 14.754/2023 — change frequently. Always confirm with a qualified **contador/CPA** before any real operation. The dashboard footer repeats this disclaimer.
