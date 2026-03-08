-- TRABALHANDO COM A TABELA FIFA_RANKING

-- FAZENDO UMA SELEÇÃO DE TODA A TABELA PARA VERIFICAR OS CAMPOS

SELECT * FROM fifa_ranking;

-- LISTANDO AS TOP 10 SELEÇÕES

SELECT team, rank, points
FROM fifa_ranking 
ORDER BY points DESC
LIMIT 10 

-- LISTANDO AS TOP 10 PIORES SELEÇÕES

SELECT team, rank, points
FROM fifa_ranking 
ORDER BY points ASC
LIMIT 10 

-- LISTANDO AS 5 MELHORES SELEÇÕES DA CONMEBOL (AMERICA DO SUL)

SELECT team, association, rank, points
FROM fifa_ranking 
WHERE association like "%CONMEBOL%"
LIMIT 5;

-- LISTANDO AS 10 MELHORES SELEÇÕES DA UEFA (EUROPA)
SELECT team, association, rank, points
FROM fifa_ranking 
WHERE association like "%UEFA%"
LIMIT 10;

-- LISTANDO AS 10 MELHORES SELEÇÕES DA AFC (ASIA)
SELECT team, association, rank, points
FROM fifa_ranking 
WHERE association like "%AFC%"
LIMIT 10;

-- LISTANDO AS 10 MELHORES SELEÇÕES DA CAF (AFRICA)
SELECT team, association, rank, points
FROM fifa_ranking 
WHERE association like "CAF%" -- NESTE CASO NÃO PODEMOS USAR O CARACTERE CORINGA % NO INICIO PQ TEMOS A CONFEDERAÇÃO CONCACAF 
LIMIT 10; 

-- LISTANDO AS 10 MELHORES SELEÇÕES DA CONCACAF (AMERICA DO NORTE e CENTRAL)
SELECT team, association, rank, points
FROM fifa_ranking 
WHERE association like "%CONCACAF%" 
LIMIT 10

-- LISTANDO AS 5 MELHORES SELEÇÕES DA OFC 

SELECT team, association, rank, points
FROM fifa_ranking 
WHERE association like "%OFC%"
LIMIT 5;

-- QUANTO OS TOP 10 GANHARAM DE PONTOS OU PERDERAM ANTES DA COPA

SELECT  team, (points - previous_points) as diferenca
FROM fifa_ranking
LIMIT 10; -- SÓ BRASIL, ITALIA E HOLANDA (PAISES BAIXOS) GANHARAM PONTOS.

-- PEGANDO OS 10 TIMES QUE MAIS PONTUARAM ANTES DA COPA
SELECT  team, (points - previous_points) as diferenca
FROM fifa_ranking
WHERE diferenca > 0
ORDER BY 2 DESC 
LIMIT 10; -- CURIOSO QUE DO TOP 10, TEMOS APENAS 4 SELEÇÕES QUE FORAM A COPA

-- PEGANDO OS TIMES QUE SUBIRAM/CAIRAM DE POSIÇÕES (TOP 20)

SELECT team, rank, previous_rank, (rank - previous_rank) as alteracao
FROM fifa_ranking
WHERE alteracao > 0 
ORDER BY 4 DESC
LIMIT 20;

SELECT team, rank, previous_rank, (rank - previous_rank) as alteracao
FROM fifa_ranking
WHERE alteracao < 0 
ORDER BY 4 DESC
LIMIT 20;

-- CONTANDO QUANTOS TIMES TEMOS POR CONFEDERAÇÃO

SELECT association, COUNT(*) as qtd_teams
FROM fifa_ranking 
GROUP BY 1 
ORDER BY 2 DESC;

-- MEDIA DE PONTOS POR ASSOCIAÇÃO

SELECT association, round(AVG(points),2) as media_pontos 
FROM fifa_ranking 
GROUP BY association 
ORDER BY media_pontos DESC; -- APESAR DA CONMEBOL SER A MENOR, TEM UMA MÉDIA MAIOR QUE AS DEMAIS.

-- POSIÇÃO RELATIVA POR CONFEDERAÇÃO (RANK DE CADA SELEÇÃO)
SELECT team, association, rank, 
       DENSE_RANK() OVER (PARTITION BY association ORDER BY rank) as posicao_confederacao
FROM fifa_ranking 
ORDER BY association, posicao_confederacao;

-- CONTANDO % QUE CADA ASSOCIAÇÃO POSSUI ENTRE OS 50 PRIMEIROS
WITH top50 AS (
  SELECT association, COUNT(*) as no_top50
  FROM fifa_ranking WHERE rank <= 50
  GROUP BY association
),
total AS (
  SELECT association, COUNT(*) as total_conf
  FROM fifa_ranking GROUP BY association
)
SELECT t.association, t.no_top50, tot.total_conf,
       ROUND(t.no_top50 * 100.0 / tot.total_conf, 2) as pct_confederacao,
       ROUND(t.no_top50 * 100.0 / 50, 2) as pct_top50_global
FROM top50 t
JOIN total tot ON t.association = tot.association
ORDER BY no_top50 DESC;

