# Framework de alocação-alvo — perfil moderado (ponto de partida)

Este framework existe para dar um ponto de partida numérico ao rebalanceamento, não para prescrever a alocação "certa" — o usuário pode (e deve, com o tempo) ajustar os números conforme sua própria tolerância a risco, horizonte de tempo e objetivos. Sempre pergunte se ele quer manter os valores abaixo ou informar os dele antes de fechar uma proposta de rebalanceamento.

## Por que um framework moderado como padrão

O usuário definiu como meta bater a Selic mensal com cautela em relação a concentração de mercado, câmbio, e risco geopolítico/macro. Isso sugere um perfil que busca retorno acima do CDI/Selic (então não 100% renda fixa BR) mas com diversificação ativa como prioridade sobre maximizar retorno bruto (então não uma carteira concentrada e alavancada em busca de retorno máximo). "Moderado" aqui significa: exposição a renda variável e a mercados diferentes o suficiente para ter chance real de superar a Selic, com tetos que evitam qualquer single point of failure (um país, uma moeda, um setor) dominar o resultado.

## Faixas sugeridas (ponto de partida)

| Categoria | Faixa sugerida | Racional |
|---|---|---|
| Renda fixa/caixa Brasil (Tesouro Selic, CDB liquidez, etc.) | 20-35% (piso ~20%) | Reserva de segurança e liquidez; piso evita ficar 100% exposto a risco de mercado |
| Renda variável Brasil (ações + FIIs) | 20-35% | Exposição a crescimento doméstico e renda de FIIs, sem dominar a carteira |
| Exposição EUA via Avenue (ações + ETFs) | 20-30% | Diversificação geográfica e cambial; teto evita concentração em um único mercado estrangeiro |
| Outras exposições internacionais/alternativos (se houver) | 0-15% | Espaço para diversificação adicional sem virar o núcleo da carteira |

Os números não precisam somar rigidamente a 100% em compartimentos estanques — o importante são os **tetos de concentração**, que valem independente da divisão exata acima:

- **Nenhum país/mercado único acima de ~25-30% da carteira total.** Isso vale tanto para "tudo Brasil" quanto para "tudo EUA" — o objetivo é que nenhum evento específico de um país (crise cambial, eleição, decisão de banco central local) devaste a carteira inteira.
- **Nenhuma moeda estrangeira única acima de ~30% da carteira total.** Câmbio é um risco à parte do risco do ativo em si; mesmo uma ação boa em USD carrega risco cambial BRL/USD.
- **Atenção a concentração setorial dentro de cada mercado.** Ex: se a fatia EUA está dentro do teto de 30%, mas 80% dela é em ações de tecnologia, isso ainda é uma concentração de risco setorial/geopolítico (ex: regulação de tech, tensão EUA-China afetando cadeia de suprimentos) que vale mencionar como alerta, mesmo sem violar o teto de país.
- **Risco geopolítico/macro**: ao montar o dashboard, se identificar que uma fatia relevante da carteira depende de um único evento macro previsível (ex: decisão de juros americana, eleição, tensão comercial específica), inclua isso como observação textual, não só como número.

## Caixa parado em moeda estrangeira

Dinheiro em USD parado na Avenue (não investido em nenhum ativo) conta para os **tetos de país e de moeda** acima — é exposição cambial e a um único mercado tanto quanto uma ação americana seria — mas não deve ser somado ao bucket "ações + ETFs EUA" da tabela de faixas, já que não carrega o mesmo risco de mercado (só risco cambial). Trate-o como uma linha própria dentro da categoria "Exposição EUA" ao montar o dashboard, para que o usuário veja quanto do teto de país/moeda vem de posições de fato investidas vs. caixa ocioso — essa distinção também sinaliza uma oportunidade óbvia (caixa parado não precisa de venda nem gera imposto para ser realocado).

## Quando sugerir ação

Um drift (desvio entre alocação atual e alvo) abaixo de ~5 pontos percentuais geralmente não compensa o custo de transação + imposto de rebalancear ativamente — para esses casos, prefira sugerir direcionar os **próximos aportes** para a categoria abaixo da meta, em vez de vender algo. Reserve sugestões de venda para drifts maiores ou para quando uma categoria está claramente perto/acima de um teto de concentração de risco (mesmo com drift pequeno em termos absolutos).

## Ajustando o framework

Se o usuário der uma alocação-alvo própria (por número ou por descrição como "sou mais conservador" / "toparia mais risco"), use os números dele para o cálculo de drift em vez destes, mas ainda aplique os tetos de concentração de mercado/moeda como um alerta de risco à parte — mesmo um investidor mais agressivo geralmente se beneficia de saber que está muito concentrado em um único país ou moeda.
