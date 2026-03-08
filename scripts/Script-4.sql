-- PARTIDAS DA COPA
SELECT * FROM matches;

-- TOTAL DE PARTIDAS TODAS AS COPAS
SELECT COUNT(*)
FROM matches;

-- TOTAL DE PARTIDAS POR COPA
SELECT year, COUNT(*) as num_jogos
FROM matches 
GROUP BY Year
ORDER BY year desc;

-- MAIOR PUBLICO MÉDIO POR COPA
SELECT Year, ROUND(AVG(Attendance),2) as media_publico 
FROM matches GROUP BY Year ORDER BY media_publico DESC LIMIT 5;

-- TOP 10 GOLEADAS DE TODAS AS COPAS (CONSIDERANDO DIFERENÇA DE GOLS E MAIS GOLS MARCADOS)
SELECT home_team, home_score, away_team, away_score, Year 
FROM matches ORDER BY (home_score - away_score) DESC LIMIT 10;

-- QUANTOS GOLS CADA COPA TEVE?
SELECT Year, SUM(home_score + away_score) as total_gols 
FROM matches 
GROUP BY Year 
ORDER BY total_gols DESC;

-- VENCEDORES DAS FINAIS
SELECT home_team, home_score, away_team, away_score, round, year
FROM matches
WHERE round LIKE '%FINAL'
ORDER BY year DESC;

-- QUANTOS JOGOS O BRASIL VENCEU NA COPA?
SELECT COUNT(*) as vitorias_brasil FROM matches 
WHERE (home_team = 'Brazil' AND home_score > away_score) 
   OR (away_team = 'Brazil' AND away_score > home_score);

-- MEDIA DE GOLS POR FASE
SELECT Round, 
       ROUND(AVG(home_score + away_score),2) as media_gols 
FROM matches 
GROUP BY Round ORDER BY media_gols DESC;

-- QUANTAS VEZES O TIME GANHOU NAS FASES FINAIS
SELECT team, COUNT(*) as vitorias_fase_finais
FROM (
  -- Vitórias como home_team
  SELECT home_team as team
  FROM matches 
  WHERE Round LIKE '%Final%' AND home_score > away_score
  
  UNION ALL
 
  -- Vitórias como away_team
  SELECT away_team
  FROM matches 
  WHERE Round LIKE '%Final%' AND away_score > home_score
) vitorias
GROUP BY team
ORDER BY vitorias_fase_finais DESC;

-- QUANTAS VEZES O TIME PERDEU NAS FASES FINAIS

SELECT team, COUNT(*) as derrotas_finais
FROM (
  -- Derrotas como home_team (perdeu em casa)
  SELECT home_team as team
  FROM matches 
  WHERE Round LIKE '%Final%' AND home_score < away_score
  
  UNION ALL
  
  -- Derrotas como away_team (perdeu fora)
  SELECT away_team
  FROM matches 
  WHERE Round LIKE '%Final%' AND away_score < home_score
) derrotas
GROUP BY team
ORDER BY derrotas_finais DESC;

-- QUANTAS PARTIDAS OS TREINADORES VENCERAM

SELECT treinador, COUNT(*) as vitorias_totais
FROM (
  -- Vitórias como home_manager
  SELECT home_manager as treinador
  FROM matches 
  WHERE home_score > away_score
  
  UNION ALL
  
  -- Vitórias como away_manager
  SELECT away_manager
  FROM matches 
  WHERE away_score > home_score
) vitorias
WHERE treinador IS NOT NULL
GROUP BY treinador
ORDER BY vitorias_totais DESC, treinador
LIMIT 20;
