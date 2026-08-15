# Dividendos e renda projetada — metodologia

O usuário tratou isso como um fator de decisão de primeira ordem, não um extra — trate como tal em toda análise desta skill, tanto para posições brasileiras quanto americanas.

## Como levantar o histórico

Prioridade das fontes, da mais para a menos confiável:
1. **Extrato do próprio usuário** — se o PDF/CSV/print trouxer pagamentos de dividendos já recebidos, use esses valores reais em vez de qualquer estimativa. São a fonte mais confiável porque refletem exatamente a posição do usuário, sem depender de suposição de quantidade/data.
2. **Pesquisa (WebSearch)** — para preencher o que o extrato não cobre (histórico mais longo, dividend yield atual divulgado pelo mercado, calendário de próximos pagamentos). Cite a fonte.
3. **Extrapolação do histórico recente do próprio extrato** — só quando as duas anteriores não estiverem disponíveis. Ex: um pagamento mensal observado × 12 para estimar o anual. Deixe claro que é extrapolação, não dado confirmado, especialmente para ETFs de covered call (QYLD, XYLD, JEPI, JEPQ, QQQI, SPHD e similares), cujo payout mensal varia com a volatilidade do mercado de opções — não é fixo como um dividendo tradicional.

## Como apresentar

- Sempre em **dois números por posição**: yield % (comparável entre ativos) e valor absoluto anual projetado em R$ ou US$ (o que realmente importa pro fluxo de caixa do usuário).
- Some a renda projetada total da carteira e compare com a Selic mensal em termos de retorno de caixa puro (dividend yield vs. Selic), sabendo que isso é uma comparação parcial — dividendo não é o retorno total (ignora variação de preço), mas é o que o usuário pediu para acompanhar de perto.
- Nunca misture dividendo bruto com líquido sem rotular. BR: dividendo de ação é isento de IR na fonte para pessoa física; **JCP é diferente — sofre 15% de retenção na fonte**, então uma ação que paga parte como JCP tem renda líquida menor do que o valor anunciado sugere. EUA: 30% de retenção na fonte para NRA (ver tax-usa.md) — sempre mostrar líquido ao lado do bruto.

## Como usar no rebalanceamento

Dividend yield é um critério de decisão de peso equivalente ao imposto e ao drift — não um adendo informativo:

- Uma posição com **baixo custo tributário de venda mas yield alto** pode não valer a pena vender só porque "é barata de vender" — o usuário perde renda recorrente. Mostre o trade-off explicitamente (quanto de renda anual se perde vendendo).
- Uma posição com **yield baixo e sobreposição de estratégia/concentração** é candidata melhor — vender ali custa pouco em renda perdida.
- Ao propor comprar algo com o produto de uma venda (para fins de rebalanceamento ou reposicionamento), considere o yield do que está sendo comprado como parte da decisão, não só a categoria de alocação-alvo.

## Nomear os ativos, sempre

Toda proposta de venda-e-compra por eficiência tributária deve dizer explicitamente **quais tickers vender** (com valor, imposto e renda de dividendo perdida) e **quais tickers comprar** com o produto — nunca só "reduza a exposição a X" sem dizer o quê especificamente sai e o quê entra. Isso vale tanto para trocas dentro da mesma corretora quanto para redirecionamento de aportes.
