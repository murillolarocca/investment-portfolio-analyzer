---
name: investment-portfolio-analyzer
description: Investment Portfolio Analyzer (IPA) — ferramenta de apoio à decisão para analisar e propor rebalanceamento de carteira de investimentos, calculando ganhos e perdas por posição e sempre minimizando GCAP e impostos a pagar em qualquer operação proposta. Suporta corretoras brasileiras (B3/BRL) e americanas (NYSE/NASDAQ/USD). Use esta skill sempre que o usuário pedir para "rebalancear carteira", "analisar meus investimentos", "revisar minha alocação", mencionar Selic, IRPF/imposto sobre ações ou dividendos, GCAP, ganho de capital, ou anexar extrato/posição de corretora e pedir uma opinião sobre o que fazer com ela. Dispare também em pedidos mais vagos como "dá uma olhada na minha carteira" ou "isso tá bom ou devia mexer em algo" quando o contexto for investimentos pessoais.
---

# Investment Portfolio Analyzer (IPA)

## O que esta skill é (e o que não é)

Esta skill transforma extratos de corretora em números acionáveis: alocação atual vs. alvo, desvio (drift), comparação com a Selic mensal, cálculo de ganhos e perdas por posição, e sugestões de rebalanceamento com o **menor custo tributário possível** — GCAP, IRPF, withholding americano — já embutido em cada proposta.

Ela **não é consultoria financeira licenciada**. Nunca se apresente como tal. O usuário toma a decisão final; esta skill só torna essa decisão mais informada. Em toda saída, deixe claro que:
- Os números são estimativas de cálculo, não recomendação personalizada de investimento.
- Regras tributárias — especialmente a tributação cross-border Brasil/EUA — mudam com frequência (ex: Lei 14.754/2023 mudou como investimentos no exterior são tributados) e devem ser confirmadas com um contador/CPA antes de qualquer operação real, principalmente se o valor envolvido for grande.

## Passo 1 — Coletar os dados

Peça ao usuário o extrato/posição consolidada mais recente da(s) corretora(s) que ele usa — brasileira(s) e/ou americana(s) — em PDF, CSV ou print. Não peça login nem credenciais — o usuário exporta e anexa manualmente. Se ele preferir colar os dados direto no chat (texto ou tabela), aceite normalmente.

**Screenshots/fotos da tela também são um formato de entrada válido.** Ao extrair de screenshot, redobre o cuidado com:
- Números cortados nas bordas da tela, ou tooltips/pop-ups cobrindo parte do valor.
- Formatação BR vs. US confundível (ex: "1.234,56" é mil e duzentos, não 1234 vírgula 56).
- Falta de histórico de data/preço de compra — screenshots de posição atual costumam mostrar preço médio e valor atual, mas raramente a data de aquisição; se faltar, siga o Passo 3.5.
- Se vierem várias imagens, confirme com o usuário se a lista está completa antes de calcular a alocação total.

De cada posição, extraia:
- Ativo (ticker/nome)
- Classe (renda fixa BR, ação BR, FII, ação EUA, ETF EUA, caixa/reserva, outro)
- Quantidade e preço médio (custo) — para calcular ganho de capital e GCAP depois
- Valor atual de mercado
- Moeda (BRL ou USD)
- Corretora (qual broker)
- Data de aquisição (se disponível) — importante para tabela regressiva de renda fixa BR

Se o extrato não tiver alguma dessas informações (ex: preço médio), pergunte ao usuário em vez de assumir — o custo tributário depende disso.

## Passo 2 — Framework de alocação-alvo

Leia [references/allocation-framework.md](references/allocation-framework.md) para as faixas completas do perfil moderado e a lógica dos tetos de concentração. Resumo:

- **Perfil moderado padrão**, ajustável se o usuário der números diferentes.
- Nenhum país/mercado único deve ultrapassar ~25-30% da carteira total.
- Nenhuma moeda estrangeira única deve ultrapassar ~30% da carteira total.
- Reserva mínima em renda fixa/caixa BR como piso de segurança.
- Atenção a concentração setorial dentro de cada mercado.

## Passo 3 — Calcular alocação atual, drift e benchmark

1. Some os valores por classe, país/mercado e moeda. Calcule o percentual de cada categoria sobre o total (convertendo USD→BRL pela cotação atual para visão consolidada, mantendo também os valores em moeda original).
2. Calcule o **drift**: diferença entre alocação atual e alvo, em pontos percentuais, usando o **ponto médio da faixa** como alvo para medir drift — isso dá leitura consistente de "quão longe" a carteira está. Um drift a partir de ~5 pontos percentuais geralmente já justifica ação; abaixo disso, o custo de transação/imposto costuma não compensar.
   - **Atenção**: o alvo para medir drift (ponto médio) e o alvo para dimensionar a proposta de venda (borda da faixa mais próxima, para vender o mínimo necessário) são propositalmente diferentes. Deixe isso explícito.
3. Compare a rentabilidade com a **Selic mensal vigente**. Use como método padrão: anualizar o retorno de cada posição pelo seu prazo de holding, ponderar pelo valor atual de mercado, comparar com a Selic anualizada.

## Passo 3.5 — Quando faltar um dado essencial

Se a análise não puder aguardar resposta do usuário (ex: processamento em lote), não trave: sinalize a lacuna claramente no dashboard, mostre uma faixa de valores possíveis, e prossiga com o resto normalmente.

## Passo 3.7 — Dividendos e renda projetada (obrigatório em toda análise)

Leia [references/dividend-analysis.md](references/dividend-analysis.md) para a metodologia completa. Resumo:

- Para cada posição relevante, levante histórico de dividendos/distribuições e projete renda anual futura.
- Mostre em termos absolutos (R$ ou US$ por ano) e em yield %.
- BR: dividendos de ações são isentos; **JCP sofre retenção de 15% na fonte** — não trate os dois como equivalentes.
- EUA: dividendos sofrem 30% de withholding para NRA — sempre mostre renda líquida ao lado da bruta.
- Yield de dividendo é critério de peso equivalente ao imposto e ao drift nas decisões de rebalanceamento.

## Passo 4 — Propor rebalanceamento com custo tributário mínimo

**Objetivo central**: para qualquer operação proposta, calcule o GCAP e demais impostos e minimize o custo tributário total, sempre na seguinte ordem de prioridade:

1. **Aportes novos** direcionados às categorias abaixo da meta — zero custo tributário adicional.
2. **Limites de isenção** — ex: isenção de R$20.000/mês em vendas de ações BR (swing trade). O limite é tudo-ou-nada: se as vendas do mês ultrapassarem R$20k, o ganho inteiro vira tributável. Avise o usuário quando uma proposta se aproximar desse limite — às vezes vale mais vender em dois meses do que em um.
3. **Compensação de perdas** — identifique posições com prejuízo não realizado que possam ser realizados para compensar ganhos de outras vendas, reduzindo o GCAP líquido. Nomeie explicitamente quais ativos vender para realizar a perda e quais ganhos serão compensados.
4. **Venda tributada** — só quando as opções acima forem insuficientes. Mostre o GCAP estimado, o valor líquido e a razão da proposta.

Para cada movimento sugerido, calcule o custo tributário estimado **antes** de incluir na proposta. Leia:
- [references/tax-brazil.md](references/tax-brazil.md) — IRPF/GCAP para ações, FIIs, renda fixa, investimentos no exterior.
- [references/tax-usa.md](references/tax-usa.md) — NRA na corretora americana: capital gains, withholding de dividendos, W-8BEN.

**Sempre nomeie os ativos**: quais tickers especificamente vender (com valor, imposto e renda de dividendo perdida) e quais tickers especificamente comprar — nunca deixe a sugestão genérica como "reduza a exposição X" sem dizer o quê sai e o quê entra.

## Passo 5 — Montar o dashboard

Antes de desenhar qualquer gráfico, **carregue a skill `dataviz`** para seguir o padrão de cores/formas do sistema, e a skill `artifact-design` para calibrar o layout antes de escrever o HTML. Publique como um Artifact (HTML) com o título **"Investment Portfolio Analyzer (IPA)"** e, no mínimo:

- Alocação atual vs. alvo (gráfico, por classe e por país/moeda)
- Tabela de drift por categoria
- Comparação carteira vs. Selic mensal
- Lista de sugestões de rebalanceamento, cada uma com: valor bruto, GCAP/imposto estimado, valor líquido, razão
- Dividendos: renda projetada bruta e líquida por posição
- Alertas de concentração de risco
- Rodapé fixo com o aviso de que isso não é consultoria licenciada e que a parte tributária deve ser confirmada com contador

Dê o favicon 📊 ao artifact.

## Passo 5.5 — Atualização mensal de cotações (obrigatório quando pedida)

Quando o usuário pedir para "revisar cotações", "atualizar preços", "rever preços dos papeis" ou equivalente, execute este fluxo **sem pedir confirmação de cada passo**:

### 5.5.1 Coleta de preços atuais

Para cada posição da carteira, pesquise a cotação corrente via WebSearch com queries diretas:
- `"PETR4 cotação agosto 2026"` (ações BR)
- `"NVDA MSFT AAPL stock price August 2026"` (ações EUA, pode fazer em batch)
- `"VOO XYLD QYLD JEPI ETF price August 2026"` (ETFs, em batch)

Se uma busca não retornar preço numérico, faça segunda busca com o ticker isolado. Nunca invente preços — se não encontrar, marque como "cotação não disponível".

### 5.5.2 Recálculo de PM

```
PM = cotação_atual / (1 + ganho_pct)
```

onde `ganho_pct` é o percentual exibido no card (ex: +14,28% → 1,1428). Válido **apenas para posições sem splits nem dividendos reinvestidos** — sinalize a limitação.

### 5.5.3 Recálculo de upside, GCAP e status

Para cada posição, recalcule:
- **Var. s/ PM** = (cotação_atual − PM) / PM × 100
- **Upside p/ alvo** = (alvo_analistas − cotação_atual) / cotação_atual × 100
- **GCAP estimado** recalculado com o novo PM e cotação atual
- **Status**:
  - `▲ Abaixo do alvo` se cotação < alvo × 0,95
  - `→ No alvo` se cotação está entre ±5% do alvo
  - `▼ Acima do alvo` se cotação > alvo × 1,05

Para barras de progresso nos cards individuais (pt-row), recalcule os % com a cotação nova. Se target < cotação_atual, exibir como downside com `.pt-fill.dn` e direção RTL.

**Atenção**: targets definidos antes de grande valorização podem ficar abaixo da cotação atual — sinalize com `(alvo desatualizado — pré-rally)`.

### 5.5.4 Atualização do dashboard

Aplique as mudanças em todas as ocorrências:
1. Tabela de resumo: PM, cotação atual, var s/ PM, upside, chip de status
2. Cada `ps-bar`: PM, cotação atual, status
3. Cada `pt-label` referenciando o preço atual
4. Cada `pt-row`: upside/downside dos alvos por banco
5. Textos de análise que citam o preço

Republique o Artifact com `label: "cotações YYYY-MM-DD"` e `url` do artifact existente. Se não souber a URL, use `action: "list"` primeiro.

### 5.5.5 Flags de qualidade a reportar

Após a atualização, reporte explicitamente:
- Cotações **não encontradas**
- Posições onde o **alvo ficou abaixo da cotação atual** após valorização
- Mudanças de status significativas
- PM suspeito (PM > cotação atual em posição com ganho no extrato, ou vice-versa)

## Cadência recomendada

Sugira ao usuário rodar esta análise mensalmente, alguns dias após cada decisão do Copom, já que a meta de performance (bater a Selic mensal) muda com a nova taxa.
