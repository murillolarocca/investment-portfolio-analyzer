# Input Guide — What data to provide

## Privacy first

IPA analyzes your data **locally**, within your Claude Code session. No portfolio data, personal information, or confidential financial details are transmitted to third parties or stored externally. Your data stays in the current session only.

## Accepted formats

The Investment Portfolio Analyzer (IPA) accepts portfolio data in any of the following formats — no specific structure required, Claude extracts the relevant fields automatically:

| Format | Description |
|--------|-------------|
| **Screenshots / prints** | Photos or screenshots of your broker app or web platform |
| **CSV files** | Exported directly from your broker's platform |
| **XLS / XLSX files** | Excel exports from your broker |
| **Investment statements** | PDF or image statements issued by the broker |
| **Consolidated PDFs** | Position summary PDFs (e.g., "posição consolidada") |
| **Pasted text** | Table, list, or free-form text copied directly into the chat |

---

## Supported brokers

IPA works with any broker that can provide position data in one of the accepted formats. It is designed for investors holding positions across **Brazilian brokers** (B3/BRL) and **US brokers** (NYSE/NASDAQ/USD). It can also analyze a single-broker portfolio.

Examples of supported brokers:

| Market | Examples |
|--------|---------|
| Brazil | Itaú, XP, BTG, NuInvest, Rico, Clear, Modalmais |
| USA | Avenue, Interactive Brokers, Fidelity, Schwab, TD Ameritrade |

---

## How to export your data

### Brazilian broker

Most Brazilian brokers offer a **Posição Consolidada** view under the Investments section. Export or screenshot:
- Ações (equities)
- Renda fixa (fixed income / Tesouro Direto)
- FIIs (real estate funds)
- Caixa/disponível (cash)

> **Tip:** If the app doesn't allow PDF export, screenshots work fine. Take one per asset category so no positions are cut off at the edges.

### US broker

Most US brokers offer a **Portfolio → Positions** view. Export as CSV or screenshot the positions table. Include:
- Equities (stocks)
- ETFs
- Cash/uninvested USD (relevant for currency exposure calculations)

---

## Fields extracted from your data

| Field | Required? | Where to find it | Notes |
|-------|-----------|-----------------|-------|
| **Ticker / asset name** | Yes | Any view | E.g. PETR4, NVDA, VOO |
| **Current market value** | Yes | Position view | In BRL or USD |
| **Quantity** | Recommended | Position view | Shares or units held |
| **Average cost (PM)** | Recommended | Position view | Original purchase price per unit |
| **Gain/loss %** | Optional | Position view | Used to back-calculate PM if missing |
| **Purchase date** | Recommended | Transaction history | Needed for correct BR fixed income tax bracket |
| **Currency** | Yes | Inferred from broker | BRL for Brazilian brokers, USD for US |

### What happens when a field is missing

IPA does not block the analysis when a field is absent:

- **Average cost missing but gain % available:** PM is estimated as `current_price / (1 + gain_pct)`. Valid for positions without splits or reinvested dividends — flagged in the dashboard.
- **Purchase date missing:** tax bracket for Brazilian fixed income (tabela regressiva) cannot be determined precisely. A range of possible tax costs is shown instead of a single number.
- **Both gain % and average cost missing:** no tax cost can be estimated. The dashboard notes the gap and continues the rest of the analysis.

---

## What NOT to provide

- **Login credentials** for any broker — never share these. IPA only works with exported data, never with direct account access.
- **CPF or other identity documents** — not needed for any calculation.

---

## Example: pasting data as text

You can paste position data directly into chat in any format. Example:

```
Corretora BR – Ações
PETR4  200 shares  PM R$30,32  Current R$41,90  Gain +38,2%
ITUB4  150 shares  PM R$40,47  Current R$40,00  Gain -1,2%

Corretora EUA – Equities
NVDA   10 shares  avg cost $145  current $226
MSFT    5 shares  avg cost $433  current $495
```

This is enough to run the full analysis. The more fields you include, the more precise the GCAP and tax calculations will be.

---

## Example: providing a target allocation

If this is your first time running IPA, it will use a **moderate profile** as the default target:

| Category | Target range |
|----------|-------------|
| Brazilian fixed income / cash | 20–35% |
| Brazilian equities + FIIs | 20–35% |
| US exposure | 20–30% |
| Other international / alternatives | 0–15% |

You can override this with your own numbers:
*"Minha meta é 40% renda fixa, 30% ações BR, 30% EUA"*

---

## Analyst price targets

IPA includes pre-loaded analyst price targets for common positions (Goldman Sachs, JP Morgan, Morgan Stanley, UBS, BofA, XP). If a target is missing for a position you hold, mention it and Claude will search for it.

---

## Monthly price refresh

Once the initial dashboard is built, you can update all current prices without re-submitting your portfolio data:

- *"Revisar cotações"*
- *"Atualizar preços"*

IPA will search for current prices, recalculate PM, upside %, GCAP exposure, and status chips, and republish the dashboard at the same link.
