-- VISUALIZANDO TODO O DATASET

SELECT * FROM world_cup;

ALTER TABLE world_cup RENAME COLUMN "Runner-Up" TO runner_up;

-- TIMES QUE GANHARAM MAIS VEZES

SELECT champion, COUNT(*)
FROM world_cup 
GROUP BY 1
ORDER BY 2 DESC;

-- TIMES QUE FORAM MAIS VEZES VICE

SELECT runner_up, count(*)
FROM world_cup 
GROUP BY 1
ORDER BY 2 DESC;


-- TOP 5 ARTILHEIROS DAS COPAS

--- PRIMEIRO VAMOS AJUSTAR OS CAMPOS PARA SEPARAMOS O NOME DOS GOLS

-- 1. Adicionar novas colunas
ALTER TABLE world_cup ADD COLUMN TopScorrer_Name VARCHAR(100);
ALTER TABLE world_cup ADD COLUMN TopScorrer_Gols INT;

-- 2. Extrair nome (antes de " - ")
UPDATE world_cup 
SET TopScorrer_Name = TRIM(SUBSTR(TopScorrer, 1, INSTR(TopScorrer, ' - ') - 1))
WHERE TopScorrer IS NOT NULL AND INSTR(TopScorrer, ' - ') > 0;

-- 3. Extrair gols (depois de " - ")
UPDATE world_cup 
SET TopScorrer_Gols = CAST(
  TRIM(SUBSTR(TopScorrer, INSTR(TopScorrer, ' - ') + 3, 2)) AS INTEGER
)
WHERE TopScorrer IS NOT NULL AND INSTR(TopScorrer, ' - ') > 0;

-- 4. Verificar resultado
SELECT Year, TopScorrer, TopScorrer_Name, TopScorrer_Gols FROM world_cup;

-- AGORA VAMOS CONSULTAR OS MAIORES GOLEADORES DAS COPAS DE UMA EDIÇÃO

SELECT year, topscorrer_Name, TopScorrer_Gols
FROM world_cup
ORDER BY 3 DESC;

-- MAIOR MÉDIA DE PUBLICO

SELECT Year, host, (attendance/ matches) as media_jogo
FROM world_cup 
ORDER BY 3 DESC
LIMIT 5;

-- MENOR MÉDIA DE PUBLICO

SELECT Year, host, (attendance/ matches) as media_jogo
FROM world_cup 
ORDER BY 3 ASC
LIMIT 5;

-- Copa com MENOS público/jogo
SELECT year, AttendanceAvg, matches
FROM world_cup 


-- MÉDIA DOS GOLS DOS ARTILHEIROS ANTES E APOS 2000
SELECT 
  CASE WHEN Year >= 2000 THEN 'Século XXI' ELSE 'Século XX' END as era,
  ROUND(AVG(TopScorrer_Gols), 2) as media_gols_artilheiro
FROM world_cup GROUP BY era;

-- QUANTAS COPAS TIVEMOS EM CADA SÉCULO
SELECT 
  CASE 
    WHEN Year <= 2000 THEN 'Século XX (1901-2000)'
    ELSE 'Século XXI (2001+)'
  END as seculo,
  COUNT(*) as num_copas,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM world_cup), 2) as pct_total
FROM world_cup 
GROUP BY seculo 
ORDER BY seculo;

-- QUANTAS SELEÇÕES FORAM SEDES E CAMPEÃS
SELECT DISTINCT Host, year 
FROM world_cup 
WHERE Host = 'Champion' ORDER BY Year DESC;

-- QUANTAS SELEÇÕES FORAM SEDES E VICE-CAMPEÃS
SELECT DISTINCT Host, year 
FROM world_cup 
WHERE Host = "runner_up"  ORDER BY Year DESC;

-- QUANTOS PAISES JA FORAM SEDES MAIS DE UMA VEZ?
SELECT host, COUNT(*) 
FROM world_cup
GROUP BY 1 
HAVING COUNT(*)>1
ORDER BY 2 DESC;

-- EFICIENCIA DE CADA SELEÇÃO
WITH stats AS (
  SELECT Champion as pais, COUNT(*) as titulos,
         ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) as rk_titulos
  FROM world_cup GROUP BY Champion
)
SELECT s.pais, s.titulos,
       ROUND(s.titulos * 100.0 / 22, 2) as pct_titulos_total  -- 22 Copas totais
FROM stats s ORDER BY pct_titulos_total DESC;

-- Brasil ganhou quantas Copas após 2000?

SELECT year,host, champion
FROM world_cup 
WHERE year > 2000 AND champion = 'Brazil';


