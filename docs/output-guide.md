# Output Guide — What to expect from the analysis

The skill produces an **interactive HTML dashboard** published as a private artifact. You receive a link you can open in any browser or share with anyone. The dashboard requires no server — it's a self-contained HTML file.

---

## Dashboard structure

The dashboard is organized into tabs:

| Tab | Content |
|-----|---------|
| **Resumo** | Full position table + allocation overview |
| **Ações BR** | Brazilian equity cards (Ion) |
| **Ações EUA** | US equity cards (Avenue) |
| **ETFs** | ETF positions with yield and coverage data |
| **Rebalanceamento** | Proposed trades with tax cost breakdown |

---

## Position table (Resumo → Posições)

Each row in the summary table shows:

| Column | Meaning |
|--------|---------|
| Ativo | Ticker |
| Corretora | Ion or Avenue |
| PM | Average cost (preço médio), in BRL or USD |
| Cotação atual | Current market price |
| Var. s/ PM | Gain or loss vs. average cost (%) |
| Alvo analistas | Consensus analyst price target |
| Upside p/ alvo | Distance from current price to analyst target (%) |
| Status | ▲ Abaixo do alvo / → No alvo / ▼ Acima do alvo |

**Status thresholds:**
- `▲ Abaixo do alvo` — current price is more than 5% below the analyst target (upside available)
- `→ No alvo` — current price is within ±5% of the analyst target
- `▼ Acima do alvo` — current price is more than 5% above the analyst target (position has outrun the target)

When a stock rallies past an analyst's target, the card shows `(alvo desatualizado — pré-rally)` to signal that the target was set before the move and may need updating.

---

## Individual position cards (stock tabs)

Each stock has a card with:

### Price bar (ps-bar)
A visual scale showing PM → current price → analyst target, so you can see at a glance how far the position has moved relative to where it started and where analysts expect it to go.

### Analyst target rows (pt-rows)
One row per bank (GS, JPM, MS, UBS, BofA, XP, etc.) showing:
- Bank name and analyst target price
- Upside or downside % from current price
- A progress bar (green = upside, red = downside)

### Analysis text (tc-analysis)
A brief qualitative note on the position — why it's held, key risks or catalysts, and any alerts.

---

## Allocation section

The allocation overview shows:

- **Current allocation** by class (fixed income BR, equities BR, equities US, ETFs US, cash)
- **Target allocation** from the moderate framework (or your custom target)
- **Drift** — how many percentage points each category is above or below target

A drift of **~5 percentage points or more** generally warrants considering action. Below that, transaction costs and taxes usually outweigh the benefit of rebalancing. The dashboard makes this explicit: small drifts are flagged as "aportes recommended" (buy more of the underweight category) rather than "sell the overweight."

### Drift note on measurement vs. proposal

The drift column measures deviation against the **midpoint** of the target range (e.g., if the target is 20–35%, the drift is measured against 27.5%). The rebalancing proposal, however, trims to the **near edge** of the range (e.g., 30%) rather than the midpoint — this minimizes the amount sold. The dashboard labels both so the numbers don't appear inconsistent.

---

## Selic benchmark comparison

The dashboard compares your portfolio's annualized return (weighted by position size and holding period) against the current Selic rate. The method used is:

1. Annualize each position's return by its holding period
2. Weight by current market value
3. Compare the weighted average against the annualized Selic

This is an **approximation**, not the exact monthly return, because positions have different purchase dates. The dashboard states this clearly. A more precise method would require knowing the portfolio's starting value at the beginning of each month — if you provide that, Claude will use it instead.

---

## Dividend projection

The dividend section shows:

| Column | Meaning |
|--------|---------|
| Ativo | Ticker |
| Dividend yield | Annual yield % (gross) |
| Yield líquido | Annual yield % after withholding (30% for US NRA) |
| Renda projetada bruta | Annual income in original currency |
| Renda projetada líquida | Annual income after withholding |
| Tipo | Dividend / JCP / Distribution |

**Important distinctions:**
- **Brazil:** Regular dividends from equities are tax-free at source for individual investors (PF). JCP (juros sobre capital próprio) — common in banks and utilities — has 15% withholding at source. The table distinguishes these.
- **USA:** All dividends paid to non-resident aliens (NRA) are subject to 30% US withholding tax, deducted automatically by Avenue before the funds reach your account.

---

## Rebalancing proposals

Each proposal shows:

| Field | Meaning |
|-------|---------|
| Ação | What to do (sell / buy / redirect new deposit) |
| Ticker | Specific asset to trade |
| Valor bruto | Gross value of the trade |
| Imposto estimado | Estimated tax on the gain |
| Valor líquido | Net proceeds after tax |
| Motivo | Why this trade is proposed (drift, concentration, tax efficiency) |

### Tax calculations in proposals

The skill calculates estimated tax using:
- **Brazilian equities:** 0% if monthly sales ≤ R$20,000 (swing trade); 15% on the gain above that
- **Brazilian fixed income:** sliding scale 22.5% → 15% depending on holding period
- **US assets (sold via Avenue):** no US capital gains tax for NRA; 15% Brazilian GCAP on the gain in BRL

All estimates are labeled as such. The disclaimer reminds you to confirm with a contador/CPA before executing any real trade, especially for cross-border operations.

### Priority order

The skill always tries, in this order, before suggesting a taxable sale:

1. **Redirect new deposits** to underweight categories — zero tax
2. **Use exemption limits** (e.g., sell up to R$20k/month in BR equities tax-free)
3. **Taxable sale** — only when the above are insufficient, with full tax cost shown

---

## Updating the dashboard

The dashboard is published at a fixed link. When you ask to update prices, the skill republishes to the **same URL** — your link stays stable.

Each version is labeled with the date (e.g., `cotações 2026-08-15`) and visible in the artifact's version history.

---

## Disclaimer

All numbers in the dashboard are **estimates for planning purposes**. They are not a recommendation to buy or sell any security, and they are not tax advice. Tax rules change; always confirm with a qualified **contador/CPA** before any real operation. The dashboard footer repeats this disclaimer.
