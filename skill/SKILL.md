---
name: investment-advisor
description: Ferramenta de apoio à decisão para analisar e propor rebalanceamento da carteira de investimentos do usuário (Ion/Itaú no Brasil, Avenue nos EUA), comparando com a meta de bater a Selic mensal e calculando o custo tributário estimado (IRPF, GCAP, imposto sobre investimentos no exterior, withholding tax dos EUA) de cada operação sugerida. Use esta skill sempre que o usuário pedir para "rebalancear carteira", "analisar meus investimentos", "revisar minha alocação", mencionar Ion, Itaú, Avenue, Selic, IRPF/imposto sobre ações ou dividendos, GCAP, ganho de capital, ou anexar extrato/posição de corretora e pedir uma opinião sobre o que fazer com ela. Dispare também em pedidos mais vagos como "dá uma olhada na minha carteira" ou "isso tá bom ou devia mexer em algo" quando o contexto for investimentos pessoais.
---

# Consultor de rebalanceamento de carteira

## O que esta skill é (e o que não é)

Esta skill transforma extratos de corretora em números acionáveis: alocação atual vs. alvo, desvio (drift), comparação com a Selic mensal, e sugestões de rebalanceamento com o custo tributário já embutido no cálculo.

Ela **não é consultoria financeira licenciada**. Nunca se apresente como tal. O usuário toma a decisão final; esta skill só torna essa decisão mais informada. Em toda saída, deixe claro que:
- Os números são estimativas de cálculo, não recomendação personalizada de investimento.
- Regras tributárias — especialmente a tributação cross-border Brasil/EUA — mudam com frequência (ex: Lei 14.754/2023 mudou como investimentos no exterior são tributados) e devem ser confirmadas com um contador/CPA antes de qualquer operação real, principalmente se o valor envolvido for grande.

## Passo 1 — Coletar os dados

Peça ao usuário o extrato/posição consolidada mais recente do **Ion (Itaú)** e da **Avenue**, em PDF ou CSV. Não peça login nem credenciais — o usuário exporta e anexa manualmente. Se ele preferir colar os dados direto no chat (texto ou tabela), aceite normalmente.

**Screenshots/fotos da tela também são um formato de entrada válido** (ex: quando o app não permite exportar PDF/CSV facilmente, como pode acontecer no Ion). Leia as posições diretamente da imagem. Ao extrair de screenshot, redobre o cuidado com:
- Números cortados nas bordas da tela, ou tooltips/pop-ups cobrindo parte do valor.
- Formatação BR vs. US confundível (ex: "1.234,56" é mil e duzentos, não 1234 vírgula 56).
- Falta de histórico de data/preço de compra — screenshots de posição atual costumas mostrar preço médio e valor atual, mas raramente a data de aquisição; se faltar, siga o Passo 3.5 (sinalizar a lacuna) em vez de assumir um prazo para efeito de tabela regressiva de renda fixa ou classificação swing/day trade.
- Se vierem várias imagens (uma por ativo ou por categoria, ex: uma para Tesouro Direto e outra para ações), confirme com o usuário se a lista está completa antes de calcular a alocação total — um ativo faltante distorce todos os percentuais.

De cada posição, extraia:
- Ativo (ticker/nome)
- Classe (renda fixa BR, ação BR, FII, ação EUA, ETF EUA, caixa/reserva, outro)
- Quantidade e preço médio (custo) — se disponível, para calcular ganho de capital depois
- Valor atual de mercado
- Moeda (BRL ou USD)
- Corretora (Ion ou Avenue)
- Data de aquisição (se disponível) — importante para saber se é swing trade, e para renda fixa BR (tabela regressiva depende do prazo)

Se o extrato não tiver alguma dessas informações (ex: preço médio), pergunte ao usuário em vez de assumir — o custo tributário depende disso.

Se esta for a primeira vez que a skill roda para o usuário, também pergunte a alocação-alvo desejada (ou ofereça o framework moderado abaixo como ponto de partida) e guarde a resposta mentalmente para a sessão — não existe estado persistente entre conversas, então repita a pergunta se o usuário não tiver dado a meta antes nesta conversa.

## Passo 2 — Framework de alocação-alvo

Leia [references/allocation-framework.md](references/allocation-framework.md) para as faixas completas do perfil moderado (ponto de partida) e a lógica dos tetos de concentração. Resumo:

- **Perfil moderado padrão**, ajustável a qualquer momento se o usuário der números diferentes.
- Nenhum país/mercado único (ex: só EUA, ou só Brasil renda variável) deve ultrapassar ~25-30% da carteira total.
- Nenhuma moeda estrangeira única deve ultrapassar um teto definido (o framework sugere ~30% em USD como teto para perfil moderado).
- Reserva mínima em renda fixa/caixa Brasil como piso de segurança.
- Atenção a concentração setorial dentro de cada mercado (ex: carteira EUA 80% em tech, mesmo dentro do teto de país, ainda é um risco a sinalizar).

Isso é um ponto de partida, não uma prescrição rígida — sempre pergunte se o usuário quer ajustar os números antes de fechar a proposta final.

## Passo 3 — Calcular alocação atual, drift e benchmark

1. Some os valores por classe, por país/mercado e por moeda. Calcule o percentual de cada categoria sobre o total da carteira (Ion + Avenue juntas, convertendo USD→BRL pela cotação atual para ter uma visão consolidada, mas mantenha os valores em moeda original também — a exposição cambial em si é uma informação relevante, não só o valor convertido).
2. Calcule o **drift**: diferença entre alocação atual e alocação-alvo, em pontos percentuais, para cada categoria. Como o framework dá faixas (ex: 20-35%), não um número único, use o **ponto médio da faixa** como alvo para efeito de medir drift — isso dá uma leitura consistente de "quão longe" a carteira está, comparável de um mês para o outro. Um drift a partir de ~5 pontos percentuais (medido contra esse ponto médio) geralmente já justifica considerar uma ação; abaixo disso, o custo de transação/imposto costuma não compensar — mencione isso ao usuário em vez de sugerir rebalancear cada desvio mínimo.
   - **Atenção**: o alvo usado para medir drift (ponto médio) e o alvo usado para dimensionar a proposta de venda no Passo 4 (borda da faixa mais próxima, para vender o mínimo necessário) são propositalmente diferentes. Deixe isso explícito no dashboard — ex: "drift medido contra o alvo de 27,5% (meio da faixa); proposta dimensionada para trazer a categoria de volta a 30% (borda da faixa), não ao meio" — para que o número não pareça inconsistente entre a seção de drift e a de proposta.
3. Se o usuário informar a rentabilidade do período (ou você conseguir estimar pela variação de valor de mercado + dividendos recebidos, ajustada por aportes/saques), compare com a **Selic mensal vigente** (peça ao usuário a taxa atual se não souber, já que ela muda a cada reunião do Copom — não assuma um valor desatualizado). O objetivo declarado do usuário é bater a Selic mensal; deixe isso explícito na comparação.
   - Como as posições da carteira quase sempre têm datas de compra diferentes, não existe um "retorno do mês" único e óbvio. Use como método padrão: anualizar o retorno de cada posição pelo seu próprio prazo de holding, ponderar pelo valor atual de mercado para chegar a um retorno anualizado consolidado da carteira, e comparar isso com a Selic anualizada (em vez de tentar forçar um número "mensal" por posição). Deixe esse método explícito no dashboard — é uma aproximação, não a rentabilidade exata do mês corrente, e outro método (ex: pedir ao usuário o valor da carteira no fechamento do mês anterior) é igualmente válido se os dados estiverem disponíveis.

## Passo 3.5 — Quando faltar um dado essencial

O ideal é perguntar ao usuário quando um dado necessário (preço médio, data de compra, câmbio histórico) não está no extrato. Mas se a skill estiver rodando num contexto onde a pergunta não pode ser respondida na hora (ex: um lote de arquivos processado de uma vez, ou uma reexecução automática que não vai receber resposta antes de terminar), não trave a análise: sinalize a lacuna claramente no dashboard, mostre uma faixa de valores possíveis em vez de um número falso-preciso, e prossiga com o resto do cálculo normalmente.

## Passo 3.7 — Dividendos e renda projetada (obrigatório em toda análise)

O usuário definiu dividendos/renda como um fator de decisão tão importante quanto alocação e imposto — trate como obrigatório, não opcional, em toda análise, tanto para as posições brasileiras (Ion) quanto americanas (Avenue). Leia [references/dividend-analysis.md](references/dividend-analysis.md) para a metodologia completa. Resumo:

- Para cada posição relevante, levante o histórico de dividendos/distribuições já pagos (via extrato, quando disponível, ou pesquisa) e um yield/projeção futura razoável — deixando claro quando a projeção é uma extrapolação do histórico recente vs. um número mais firme.
- Mostre a renda projetada em termos absolutos (R$ ou US$ por ano) e não só em %, para que o usuário veja o impacto real em fluxo de caixa de qualquer venda proposta.
- Ao decidir o que priorizar numa venda por eficiência tributária, o yield de dividendo é um critério de peso: uma posição de baixo imposto mas alto yield pode não valer a pena vender; uma de yield baixo e sobreposição de estratégia é melhor candidata.
- BR: dividendos de ações são isentos de IR na fonte para pessoa física, mas **JCP (juros sobre capital próprio)** — comum em bancos e elétricas — sofre retenção de 15% na fonte; não trate os dois como equivalentes ao somar renda.
- EUA: dividendos sofrem os 30% de withholding para NRA já descritos em tax-usa.md — sempre mostre a renda líquida (pós-retenção) ao lado da bruta.

## Passo 4 — Propor rebalanceamento com custo tributário embutido

Para cada movimento sugerido (reduzir posição X, aumentar posição Y), calcule o custo tributário estimado da venda **antes** de incluir na proposta, e mostre o valor líquido, não só o bruto. Leia:

- [references/tax-brazil.md](references/tax-brazil.md) — regras de IRPF/GCAP para ações, FIIs, renda fixa e investimentos no exterior declarados no Brasil.
- [references/tax-usa.md](references/tax-usa.md) — tratamento como non-resident alien (NRA) na Avenue: capital gains, withholding de dividendos, W-8BEN.

Priorize sempre, nessa ordem, antes de sugerir uma venda que gera imposto:
1. Rebalancear com aportes novos (comprar mais do que está abaixo da meta, sem vender o que está acima) — zero custo tributário adicional.
2. Usar limites de isenção existentes (ex: isenção de R$20.000/mês em vendas de ações no Brasil).
3. Só then sugerir venda tributada, com o imposto estimado já descontado do valor mostrado ao usuário.

Sinalize também concentração de risco que esteja dentro da meta mas perto do teto (ex: 27% em um único mercado com teto de 30%) — vale um alerta preventivo mesmo sem drift excedente.

**Sempre que a proposta envolver vender e comprar para eficiência tributária (ex: realizar perda para compensar ganho, trocar uma posição redundante por outra), nomeie explicitamente os ativos**: quais tickers/títulos especificamente vender (com valor e imposto) e quais tickers/títulos especificamente comprar com o produto da venda (ou, no mínimo, para qual categoria direcionar). Não deixe a sugestão genérica como "reduza a exposição X" sem dizer o quê, de fato, sai e o quê entra — o usuário pediu isso explicitamente porque decisões de compra/venda concretas precisam de nomes, não só de categorias.

## Passo 5 — Montar o dashboard

Antes de desenhar qualquer gráfico, **carregue a skill `dataviz`** para seguir o padrão de cores/formas do sistema, e a skill `artifact-design` para calibrar o layout antes de escrever o HTML. Publique o resultado como um Artifact (HTML) com, no mínimo:

- Alocação atual vs. alvo (gráfico, por classe e por país/moeda)
- Tabela de drift por categoria
- Comparação carteira vs. Selic mensal
- Lista de sugestões de rebalanceamento, cada uma com: valor bruto, imposto estimado, valor líquido, e a razão (drift ou concentração)
- Alertas de concentração de risco
- Um rodapé fixo com o aviso de que isso não é consultoria licenciada e que a parte tributária deve ser confirmada com contador antes de operações reais

Dê um favicon e título ao artifact que reflitam "carteira"/"portfólio" (ex: 📊).

## Passo 5.5 — Atualização mensal de cotações (obrigatório quando pedida)

Quando o usuário pedir para "revisar cotações", "atualizar preços", "rever preços dos papeis" ou equivalente, execute este fluxo **sem pedir confirmação de cada passo** — é um procedimento padrão de manutenção do dashboard existente:

### 5.5.1 Coleta de preços atuais

Para cada posição da carteira, pesquise a cotação corrente via WebSearch com queries diretas, por exemplo:
- `"PETR4 cotação agosto 2026"` (ações BR)
- `"NVDA MSFT AAPL stock price August 2026"` (ações EUA, pode fazer em batch)
- `"VOO XYLD QYLD JEPI ETF price August 2026"` (ETFs, em batch)

Se uma busca não retornar preço numérico, faça uma segunda busca mais específica com o ticker isolado. Nunca invente preços — se não encontrar, marque como "cotação não disponível" e prossiga.

### 5.5.2 Recálculo de PM (Preço Médio)

O PM é recalculado com base no ganho/perda % do extrato (que é o dado real do usuário) e na cotação atual:

```
PM = cotação_atual / (1 + ganho_pct)
```

onde `ganho_pct` é o percentual já exibido no card (ex: +14,28% → 1,1428; −13,06% → 0,8694). Esta fórmula é válida **apenas para posições sem splits nem dividendos reinvestidos** — sinalize a limitação no dashboard.

### 5.5.3 Recálculo de upside e status

Para cada posição, recalcule:
- **Var. s/ PM** = (cotação_atual − PM) / PM × 100 (deve coincidir com o ganho% do extrato)
- **Upside p/ alvo** = (alvo_analistas − cotação_atual) / cotação_atual × 100
- **Status**: 
  - `▲ Abaixo do alvo` se cotação < alvo × 0,95
  - `→ No alvo` se cotação está entre ±5% do alvo
  - `▼ Acima do alvo` se cotação > alvo × 1,05

Para barras de progresso nos cards individuais (pt-row), recalcule os % com a cotação nova:
- Upside % = (target_banco − cotação_atual) / cotação_atual × 100
- Se target_banco < cotação_atual, exibir como downside com `.pt-fill.dn` e direção RTL

**Atenção especial**: targets de analistas definidos antes de uma grande valorização podem ficar abaixo da cotação atual — sinalize isso no card com `(alvo desatualizado — pré-rally)`.

### 5.5.4 Atualização do dashboard

Aplique as mudanças em todas as ocorrências:
1. Tabela de resumo (Resumo > Posições): PM, cotação atual, var s/ PM, upside, chip de status
2. Cada `ps-bar` nos cards individuais: PM, cotação atual, status
3. Cada `pt-label` referenciando o preço atual
4. Cada `pt-row` com upside/downside dos alvos por banco
5. Textos de análise que citam o preço (ex: "preço atual ~US$220") dentro de `tc-analysis`, alertas e cards de proposta

Republique o Artifact com `label: "cotações YYYY-MM-DD"` e `url` do artifact existente (para manter o mesmo link). Se não souber a URL, use `action: "list"` primeiro.

### 5.5.5 Flags de qualidade a reportar ao usuário

Após a atualização, reporte explicitamente:
- Cotações **não encontradas** (precisam ser fornecidas manualmente)
- Posições onde o **alvo de analista ficou abaixo da cotação atual** após a valorização (possível necessidade de atualizar o alvo)
- Mudanças de status significativas (ex: de "no alvo" → "bem abaixo do alvo", ou vice-versa)
- PM suspeito (quando PM > cotação atual em posição que o extrato mostra ganho, ou vice-versa) — indica possível split ou dividendo reinvestido não capturado

## Cadência recomendada

Sugira ao usuário rodar esta análise mensalmente, idealmente alguns dias após cada decisão do Copom, já que a meta de performance (bater a Selic mensal) muda com a nova taxa. Esta skill roda sob demanda; o agendamento do lembrete mensal é configurado separadamente (scheduled task), não por esta skill.
