# Tributação nos EUA — referência para posições na Avenue

A Avenue dá acesso ao mercado americano para o investidor brasileiro operando como **non-resident alien (NRA)** perante o IRS (via formulário **W-8BEN**, normalmente preenchido na abertura da conta). As regras de tributação americana para um NRA são bem diferentes das de um residente fiscal dos EUA — não confunda as duas ao pesquisar ou explicar algo para o usuário.

Trate os pontos abaixo como estrutura geral, não como aconselhamento tributário definitivo — leis e tratados podem mudar, e a situação específica do usuário (tipo de ativo, se é REIT, se é ETF vs. ação individual) pode alterar o resultado. Recomende confirmação com um CPA/tax advisor americano para qualquer operação de valor relevante.

## Ganho de capital na venda de ações/ETFs

- Regra geral: **non-resident aliens não pagam capital gains tax dos EUA** sobre a venda de ações e da maioria dos ETFs americanos, desde que não estejam fisicamente presentes nos EUA por 183+ dias no ano (o chamado "183-day rule", que normalmente não se aplica a quem mora no Brasil o ano todo).
- Isso significa que, do lado americano, vender uma ação ou ETF geralmente não gera imposto a pagar ao IRS. **O ganho de capital ainda é tributável no Brasil** — ver [tax-brazil.md](tax-brazil.md), seção de investimentos no exterior.
- Exceção a ficar atento: **FIRPTA** (Foreign Investment in Real Property Tax Act) pode tributar ganhos ligados a REITs/imóveis americanos em certas condições — se a carteira do usuário tiver REITs, sinalize que essa é uma exceção a confirmar com CPA, em vez de assumir a regra geral de isenção.

## Dividendos

- Dividendos de ações/ETFs de empresas americanas pagos a um NRA sofrem **retenção na fonte (withholding) nos EUA**, tipicamente **30%**, retida automaticamente pela corretora antes de o valor chegar à conta do investidor.
- O **Brasil não tem tratado de bitributação com os EUA**, então essa alíquota de 30% normalmente não é reduzida por tratado (diferente de países que têm tratado com os EUA e conseguem alíquotas menores, como 15%). Não assuma redução de alíquota para o usuário sem confirmar.
- Esse imposto retido nos EUA é sobre o valor bruto do dividendo — ao estimar o "rendimento líquido" de uma posição em dividendos para efeito de comparação com a Selic mensal, sempre desconte esses 30% do valor bruto anunciado pela empresa/ETF.
- O dividendo também entra na declaração de IR no Brasil como rendimento recebido no exterior — não gera nova tributação idêntica automaticamente, mas deve ser declarado (ver regras de rendimentos no exterior em tax-brazil.md); a forma exata de aproveitar o imposto já retido nos EUA para evitar bitributação no Brasil é um ponto para confirmar com contador, pois não há tratado formal simplificando isso.

## W-8BEN

- É o formulário que certifica status de NRA para fins de retenção correta nos EUA; normalmente é preenchido uma vez na abertura da conta Avenue e precisa ser renovado periodicamente (validade de cerca de 3 anos). Se o usuário perguntar sobre um dividendo com retenção muito diferente de 30%, o primeiro ponto a checar é se o W-8BEN está válido/atualizado na Avenue — mas isso é uma checagem operacional do usuário com a corretora, não algo que esta skill possa verificar.

## Regra prática para as sugestões desta skill

- Ao propor vender uma posição da Avenue, normalmente **não há imposto americano a subtrair** do valor bruto (fora a exceção de REIT/FIRPTA) — mas sempre lembre o usuário que o ganho ainda precisa ser apurado e declarado no Brasil, com imposto brasileiro correspondente (não é uma venda "livre de imposto", só livre de imposto **americano**).
- Ao calcular rendimento de dividendos em USD para comparar com a Selic mensal, sempre mostre o valor líquido (após os 30% de withholding) ao lado do bruto, para não superestimar o retorno da posição.
