# Tributação no Brasil — referência para cálculo de custo de operações

Estas são as regras gerais vigentes para pessoa física residente no Brasil. Elas mudam com frequência (a última mudança relevante foi a Lei 14.754/2023, que alterou a tributação de investimentos no exterior). Sempre trate os números abaixo como estimativa de planejamento, não como cálculo definitivo — recomende confirmação com contador antes de qualquer operação de valor relevante, e antes de preencher a DARF/DAA.

## Ações e ETFs brasileiros (mercado à vista, na B3 — ex: via corretora BR)

- **Isenção**: vendas totais no mês até R$ 20.000 (somando todas as ações vendidas no mês, não por ativo) são isentas de IR sobre o ganho de capital — mas isso vale só para operações comuns (swing trade), não day trade. **O limite é tudo-ou-nada, não um abatimento**: se o total de vendas de ações comuns no mês ultrapassar R$20.000, o ganho de capital do mês inteiro vira tributável a 15%, não só a parte que excede o limite. Isso importa para o rebalanceamento: às vezes vale mais a pena limitar a venda do mês a R$19.999 e continuar no próximo mês do que vender R$20.001 de uma vez.
- **Swing trade acima do limite de isenção**: 15% sobre o ganho de capital do mês.
- **Day trade**: 20% sobre o ganho, sem isenção, independente do valor.
- Prejuízos em um mês podem compensar ganhos futuros da mesma categoria (ações comuns compensam ações comuns; day trade compensa day trade) — vale perguntar ao usuário se ele tem prejuízo acumulado a compensar antes de calcular o imposto de uma venda.
- Apuração e recolhimento via DARF, feito pelo próprio investidor (a corretora não retém, exceto retenção de 0,005% na fonte só para fins de cruzamento de dados, chamada de "dedo-duro", que não é o imposto devido em si).

## FIIs (Fundos de Investimento Imobiliário)

- **20% sobre o ganho de capital na venda**, sem isenção de R$20.000 (essa isenção é exclusiva de ações).
- Dividendos/rendimentos distribuídos mensalmente por FII são isentos de IR para pessoa física, desde que o fundo e o investidor atendam certos requisitos (fundo com no mínimo 50 cotistas, listado em bolsa/mercado de balcão organizado, investidor com menos de 10% das cotas do fundo) — na prática, isso vale para quase todo investidor de varejo comprando FIIs líquidos na bolsa, mas vale confirmar se algum FII específico da carteira foge dessas condições.

## Renda fixa (Tesouro Direto, CDBs, etc.)

Tabela regressiva por prazo de aplicação, sobre o rendimento (não sobre o valor total):
- Até 180 dias: 22,5%
- 181 a 360 dias: 20%
- 361 a 720 dias: 17,5%
- Acima de 720 dias: 15%

Isso é relevante para o cálculo de rebalanceamento: vender um título de renda fixa antes do prazo pode custar mais imposto proporcional do que esperar. Sempre olhe a data de aquisição antes de sugerir resgatar renda fixa.

## Investimentos no exterior (relevante para posições na corretora americana, declaradas no Brasil)

A Lei 14.754/2023 mudou significativamente esse tema a partir de 2024. Pontos gerais (**confirmar sempre com contador, pois a mecânica exata depende do tipo de aplicação e pode ter sido ajustada depois desta referência ter sido escrita**):

- Ganho de capital na venda de ativos no exterior (ações/ETFs americanos, por exemplo) segue, em linhas gerais, a lógica de ganho de capital em moeda estrangeira: apura-se o ganho em reais (conversão na compra e na venda pelo câmbio das datas correspondentes), com alíquotas progressivas — recolhimento via DARF pelo próprio investidor. As faixas (as mesmas usadas para GCAP de outros bens no Brasil) são, sobre o ganho apurado **no mês**:
  - Até R$ 5.000.000: 15%
  - De R$ 5.000.000 a R$ 10.000.000: 17,5%
  - De R$ 10.000.000 a R$ 30.000.000: 20%
  - Acima de R$ 30.000.000: 22,5%
  - Na prática, a esmagadora maioria das operações de pessoa física fica na primeira faixa (15%) — mas aplique a faixa certa em vez de assumir sempre 15%, especialmente se a carteira tiver posições grandes ou concentradas.
- Dividendos e outros rendimentos recebidos de aplicações financeiras no exterior têm regras específicas de tributação no Brasil desde a Lei 14.754/2023 (diferentes do tratamento de "acréscimo patrimonial" genérico usado antes) — este é o ponto que mais vale confirmar com contador, porque a forma de tributar mudou e a interpretação/alíquota pode variar conforme o tipo de produto (ação individual vs. fundo/ETF domiciliado no exterior).
- O valor em conta na corretora americana (e qualquer conta no exterior) deve ser declarado na Declaração de Ajuste Anual (DAA) e, se ultrapassar os limites do Banco Central, também na Declaração de Capitais Brasileiros no Exterior (CBE) — isso não é imposto em si, mas é uma obrigação acessória a lembrar o usuário quando o valor crescer.

Ao calcular o custo de uma venda na corretora americana, sempre pergunte a data e o preço de compra em USD e a cotação do dólar nessas datas (ou use a cotação PTAX de referência) para estimar o ganho em reais antes de aplicar a alíquota.

## Custos de câmbio (além do imposto)

Mover dinheiro entre o corretora BR (BRL) e a corretora americana (USD) — ou entre a corretora americana e uma conta bancária brasileira — envolve IOF sobre operações de câmbio e, normalmente, um spread cambial cobrado pela instituição (a cotação de compra/venda de dólar oferecida raramente é a cotação de mercado exata). Isso não é imposto de renda, mas é um custo real que reduz o valor líquido de qualquer rebalanceamento que cruze Brasil↔EUA. Ao mostrar o "valor líquido" de uma operação que envolve conversão de moeda, mencione que esse custo de câmbio existe e ainda não foi descontado, em vez de apresentar o número pós-imposto como se fosse o valor final que vai chegar na conta.

## Regra prática para as sugestões desta skill

Ao montar uma proposta de rebalanceamento, calcule o imposto estimado de cada venda usando as regras acima, mostre o valor líquido ao lado do bruto, e sinalize claramente quando a estimativa depender de uma informação que o usuário não passou (preço de compra, data, câmbio histórico) — nesses casos, mostre a faixa possível em vez de um número falso-preciso.
