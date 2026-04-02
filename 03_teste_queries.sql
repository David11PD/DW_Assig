-- =========================================================
-- QUERIES DE TESTE
-- =========================================================

-- 1. Número total de nomeações
SELECT COUNT(*) AS total_nominations
FROM fact_nomination;

-- 2. Número total de vencedores
SELECT SUM(win_count) AS total_wins
FROM fact_nomination;

-- 3. Filmes com mais nomeações
SELECT
    df.title,
    COUNT(*) AS nominations
FROM fact_nomination fn
JOIN dim_film df
    ON fn.film_key = df.film_key
GROUP BY df.title
ORDER BY nominations DESC
LIMIT 10;

-- 4. Categorias com mais nomeações
SELECT
    dc.canonical_category,
    COUNT(*) AS nominations
FROM fact_nomination fn
JOIN dim_category dc
    ON fn.category_key = dc.category_key
GROUP BY dc.canonical_category
ORDER BY nominations DESC
LIMIT 10;

-- 5. Vencedores por ano
SELECT
    dcer.year,
    SUM(fn.win_count) AS wins
FROM fact_nomination fn
JOIN dim_ceremony dcer
    ON fn.ceremony_key = dcer.ceremony_key
GROUP BY dcer.year
ORDER BY dcer.year;

-- 6. Nomeados distintos por classe
SELECT
    dcl.class_name,
    COUNT(DISTINCT bp.nominee_key) AS distinct_nominees
FROM fact_nomination fn
JOIN dim_class dcl
    ON fn.class_key = dcl.class_key
LEFT JOIN bridge_participation bp
    ON fn.nom_id = bp.nom_id
GROUP BY dcl.class_name
ORDER BY distinct_nominees DESC;

-- 7. Snapshot por cerimónia/categoria/classe
SELECT
    dcer.year,
    dcl.class_name,
    dcat.canonical_category,
    fcs.total_nominations,
    fcs.total_winners,
    fcs.total_films_nominated,
    fcs.total_distinct_nominees,
    fcs.avg_nominees_per_film
FROM fact_ceremony_snapshot fcs
JOIN dim_ceremony dcer
    ON fcs.ceremony_key = dcer.ceremony_key
JOIN dim_class dcl
    ON fcs.class_key = dcl.class_key
JOIN dim_category dcat
    ON fcs.category_key = dcat.category_key
ORDER BY dcer.year, dcl.class_name, dcat.canonical_category;

-- 8. Top 10 filmes mais nomeados
SELECT
    df.title,
    COUNT(*) AS nominations,
    SUM(fn.win_count) AS wins,
    ROUND(100.0 * SUM(fn.win_count) / COUNT(*), 1) AS win_rate_pct
FROM fact_nomination fn
JOIN dim_film df ON fn.film_key = df.film_key
WHERE title IS NOT NULL
GROUP BY df.title
HAVING nominations >= 3
ORDER BY nominations DESC
LIMIT 10;

-- 9. Evolução de nomeações por década
SELECT
    dcer.decade,
    COUNT(*) AS nominations,
    SUM(fn.win_count) AS wins
FROM fact_nomination fn
JOIN dim_ceremony dcer ON fn.ceremony_key = dcer.ceremony_key
GROUP BY dcer.decade
ORDER BY dcer.decade;

-- 10. Anos com mais nomeações por categoria
SELECT
    dcer.year,
    dcat.canonical_category,
    COUNT(*) AS nominations
FROM fact_nomination fn
JOIN dim_ceremony dcer ON fn.ceremony_key = dcer.ceremony_key
JOIN dim_category dcat ON fn.category_key = dcat.category_key
GROUP BY dcer.year, dcat.canonical_category
ORDER BY nominations DESC
LIMIT 10;

--11. Top categorias por número de nomeações
SELECT
    dcat.canonical_category,
    COUNT(*) AS nominations,
    SUM(fn.win_count) AS wins,
    ROUND(100.0 * SUM(fn.win_count) / COUNT(*), 1) AS win_rate_pct
FROM fact_nomination fn
JOIN dim_category dcat ON fn.category_key = dcat.category_key
GROUP BY dcat.canonical_category
ORDER BY nominations DESC
LIMIT 10;

-- 12. Classes técnicas vs criativas
SELECT
    dcl.class_group,
    dcl.class_name,
    COUNT(*) AS nominations,
    SUM(fn.win_count) AS wins,
    ROUND(100.0 * SUM(fn.win_count) / COUNT(*), 1) AS win_rate_pct
FROM fact_nomination fn
JOIN dim_class dcl ON fn.class_key = dcl.class_key
GROUP BY dcl.class_group, dcl.class_name
ORDER BY nominations DESC;

-- 13. Nomeados com mais vitórias
SELECT
    dn.name,
    COUNT(*) AS nominations,
    SUM(fn.win_count) AS wins,
    ROUND(100.0 * SUM(fn.win_count) / COUNT(*), 1) AS win_rate_pct
FROM fact_nomination fn
JOIN bridge_participation bp ON fn.nom_id = bp.nom_id
JOIN dim_nominee dn ON bp.nominee_key = dn.nominee_key
GROUP BY dn.name
HAVING COUNT(*) >= 3
ORDER BY wins DESC, nominations DESC
LIMIT 10;

---- 14 Top 10 filmes por classe
SELECT
    dcl.class_name,
    df.title,
    COUNT(*) AS nominations,
    SUM(fn.win_count) AS wins
FROM fact_nomination fn
JOIN dim_film df ON fn.film_key = df.film_key
JOIN dim_class dcl ON fn.class_key = dcl.class_key
GROUP BY dcl.class_name, df.title
HAVING nominations >= 2
ORDER BY dcl.class_name, nominations DESC
LIMIT 10;


----  Comparação entre eras (clássico vs moderno)
SELECT
    dcer.era,
    COUNT(*) AS nominations,
    SUM(fn.win_count) AS wins,
    COUNT(DISTINCT fn.film_key) AS distinct_films,
    COUNT(DISTINCT bp.nominee_key) AS distinct_nominees,
    ROUND(100.0 * SUM(fn.win_count) / COUNT(*), 1) AS win_rate_pct
FROM fact_nomination AS fn
INNER JOIN dim_ceremony AS dcer 
ON fn.ceremony_key = dcer.ceremony_key
LEFT JOIN bridge_participation as bp
ON fn.nom_id = bp.nom_id
GROUP BY dcer.era
ORDER BY dcer.era;
