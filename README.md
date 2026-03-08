Análise de Dados de Futebol com SQL ⚽📊

Descrição 📝
Este repositório contém scripts SQL para análise de dados abrangentes relacionados ao futebol, cobrindo desde o ranking mundial da FIFA até estatísticas detalhadas de partidas e históricos da Copa do Mundo. O objetivo é fornecer insights valiosos sobre o desempenho de seleções, confederações e o legado dos torneios mais importantes do futebol.

Scripts SQL Disponíveis 📂

Script-3.sql - Análise de Ranking FIFA 🏆🌍

Este script foca na análise dos dados de ranking da FIFA, explorando diversas facetas do desempenho das seleções ao longo do tempo.

Principais Análises:

•	Desempenho Geral: Visualização completa da tabela fifa_ranking para uma visão panorâmica.
•	Top/Piores Seleções: Identificação das 10 melhores e 10 piores seleções com base nos pontos atuais.
•	Análise Regional: Comparativo de desempenho entre diferentes confederações (CONMEBOL, UEFA, AFC, CAF, CONCACAF, OFC), destacando as melhores seleções de cada uma.
•	Dinâmica de Pontuação: Avaliação da variação de pontos e posições entre rankings, indicando ascensão ou queda de seleções antes de grandes eventos.
•	Estrutura de Confederações: Contagem de times, média de pontos e representatividade no Top 50 por confederação, revelando a força de cada região.

Exemplo de Consulta:

-- Listando as 5 melhores seleções da CONMEBOL (América do Sul)
```sql
SELECT team, association, rank, points
FROM fifa_ranking 
WHERE association LIKE '%CONMEBOL%'
LIMIT 5;
```
Script-4.sql - Análise de Partidas da Copa do Mundo 🏟️⚽

Este script se dedica à análise de dados de partidas da Copa do Mundo, oferecendo uma visão estatística e histórica dos torneios.

Principais Análises:

•	Visão Geral de Partidas: Detalhamento de todas as partidas registradas na tabela matches.
•	Volume de Jogos: Contagem total de partidas em todas as Copas e distribuição por ano do torneio.
•	Engajamento do Público: Análise do público médio por edição da Copa, identificando os torneios mais assistidos.
•	Resultados Expressivos: Identificação das maiores goleadas históricas, considerando a diferença de gols e o total de gols marcados.
•	Produção de Gols: Total de gols marcados em cada edição da Copa, mostrando a evolução ofensiva.
•	Momentos Decisivos: Vencedores das finais e desempenho de times em fases eliminatórias (vitórias e derrotas em fases finais).
•	Performance de Treinadores: Contagem de vitórias por treinador ao longo das Copas, destacando os mais bem-sucedidos.

Exemplo de Consulta:

-- Total de gols por Copa do Mundo
```sql
SELECT Year, SUM(home_score + away_score) as total_gols 
FROM matches 
GROUP BY Year 
ORDER BY total_gols DESC;
```
Script-5.sql - Análise Histórica da Copa do Mundo 🏆📜

Este script aprofunda a análise histórica da Copa do Mundo, focando em campeões, vices, artilheiros e outros marcos importantes do torneio.

Principais Análises:

•	Visão Geral do Histórico: Visualização completa do dataset world_cup.
•	Maiores Campeões e Vices: Identificação das seleções com mais títulos e mais vice-campeonatos.
•	Top Artilheiros: Extração e análise dos maiores goleadores de cada edição da Copa.
•	Público em Copas: Análise das Copas com maior e menor média de público por jogo.
•	Evolução dos Gols: Comparativo da média de gols dos artilheiros antes e depois do ano 2000.
•	Distribuição de Copas: Contagem de Copas realizadas em cada século.
•	Sedes e Desempenho: Análise de seleções que foram sedes e se tornaram campeãs ou vice-campeãs.
•	Sedes Múltiplas: Identificação de países que sediaram a Copa mais de uma vez.
•	Eficiência de Seleções: Cálculo da porcentagem de títulos de cada seleção em relação ao total de Copas realizadas.

Exemplo de Consulta:

-- Times que ganharam mais vezes a Copa do Mundo
```sql
SELECT champion, COUNT(*) AS titulos
FROM world_cup
GROUP BY 1
ORDER BY 2 DESC;
```
Fontes de Dados 💾

Este projeto utiliza as seguintes bases de dados:

•	fifa_ranking_2022-10-06.csv (para a tabela fifa_ranking)
•	matches_1930_2022.csv (para a tabela matches)
•	world_cup (tabela derivada de um dataset histórico da Copa do Mundo)

Como Usar 🚀

Para utilizar estes scripts, siga os passos abaixo:

1	Certifique-se de ter um banco de dados com as tabelas fifa_ranking, matches e world_cup populadas com os dados relevantes, preferencialmente importados dos arquivos .csv mencionados.
2	Abra os arquivos SQL (Script-3.sql, Script-4.sql, Script-5.sql) em um cliente SQL (como o DBeaver).
3	Execute as consultas desejadas para obter os resultados das análises.

Tecnologias Utilizadas 🛠️

•	SQL: Linguagem de consulta estruturada para manipulação e análise de dados. 🛢
•	DBeaver (versão 26): Cliente SQL universal e ferramenta de gerenciamento de banco de dados utilizada para desenvolver e executar estes scripts.

Licença 📄

Este projeto está sob licença pública, especificamente a Licença Pública Geral (GPL). Sinta-se à vontade para usar, modificar e distribuir o código conforme sua necessidade. 







