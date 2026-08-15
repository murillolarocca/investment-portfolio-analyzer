# Input Guide — What data to provide

The skill accepts portfolio data in any of these formats: **PDF export**, **CSV**, **screenshot or photo**, or **text pasted directly into chat**. You don't need to format it in a specific way — Claude will extract the relevant fields automatically.

---

## Supported brokers

| Broker | Market | Currency |
|--------|--------|----------|
| Ion (Itaú) | Brazil (B3) | BRL |
| Avenue | USA (NYSE/NASDAQ) | USD |

You can provide data from one or both brokers in the same session. The analysis works on either alone but is most useful when both are included, as it produces a consolidated view across currencies and markets.

---

## How to export your data

### Ion (Itaú)

1. Open the Ion app
2. Go to **Investimentos → Posição Consolidada**
3. Export as PDF, or take a screenshot of each category (ações, renda fixa, etc.)

> **Tip:** If the app doesn't allow PDF export, a screenshot works fine. Take one per asset category so no positions are cut off.

### Avenue

1. Log in at avenue.us
2. Go to **Portfolio → Positions**
3. Export as CSV, or screenshot the positions table

---

## Fields extracted from your data

| Field | Required? | Where to find it | Notes |
|-------|-----------|-----------------|-------|
| **Ticker / asset name** | Yes | Any view | E.g. PETR4, NVDA, VOO |
| **Current market value** | Yes | Position view | In BRL or USD |
| **Quantity** | Recommended | Position view | Shares or units held |
| **Average cost (PM)** | Recommended | Position view | Original purchase price per unit |
| **Gain/loss %** | Optional | Position view | Used to back-calculate PM if it's missing |
| **Purchase date** | Recommended | Transaction history | Needed for correct tax bracket on Brazilian fixed income (tabela regressiva) |
| **Currency** | Yes | Inferred from broker | BRL for Ion, USD for Avenue |

### What happens when a field is missing

The skill will not block the analysis when a field is absent. Instead:

- If **average cost** is missing but **gain %** is available: PM is estimated as `current_price / (1 + gain_pct)`. This is valid for positions without splits or reinvested dividends; the dashboard will flag the limitation.
- If **purchase date** is missing: the tax bracket for Brazilian fixed income cannot be determined precisely. The dashboard will show a range of possible tax costs instead of a single number.
- If **gain %** and **average cost** are both missing: no tax cost can be estimated. The dashboard will note this gap and continue with the rest of the analysis.

---

## What NOT to provide

- **Login credentials** for Ion or Avenue — never share these. The skill only works with exported data, not live account access.
- **CPF or other identity documents** — not needed for any calculation.

---

## Example: pasting data as text

You can paste position data directly into chat in any format. The skill will parse it. Example:

```
Ion – Ações
PETR4  200 shares  PM R$30,32  Current R$41,90  Gain +38,2%
ITUB4  150 shares  PM R$40,47  Current R$40,00  Gain -1,2%

Avenue – Equities
NVDA   10 shares  avg cost $145  current $226
MSFT    5 shares  avg cost $433  current $495
```

This is enough to run the full analysis. The more fields you include, the more precise the tax calculations will be.

---

## Example: providing a target allocation

If this is your first time running the analysis, the skill will use a **moderate profile** as the default target allocation:

| Category | Target range |
|----------|-------------|
| Brazilian fixed income / cash | 20–35% |
| Brazilian equities + FIIs | 20–35% |
| US exposure via Avenue | 20–30% |
| Other international / alternatives | 0–15% |

You can override this with your own numbers. Just tell the skill: *"Minha meta é 40% renda fixa, 30% ações BR, 30% EUA"* and it will use those instead.

---

## Analyst price targets

The skill includes analyst price targets for each major position (Goldman Sachs, JP Morgan, Morgan Stanley, UBS, BofA, XP) — these are pre-loaded in the skill's reference data and updated when you ask to refresh prices. You don't need to provide these yourself.

If a target is missing for a position you hold, mention it and Claude will search for it.

---

## Monthly price refresh

Once the initial dashboard is built, you can update all current prices without re-submitting your full portfolio data. Just say:

- *"Revisar cotações"*
- *"Atualizar preços"*

The skill will search for current prices, recalculate PM, upside %, and status chips, and republish the dashboard at the same link.
