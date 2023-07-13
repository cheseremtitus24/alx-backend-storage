 -- Finds the total number of fans per origin country
 -- Further Sorts then in Descending order
 SELECT origin,  SUM(fans) AS nb_fans FROM metal_bands GROUP BY origin ORDER BY nb_fans DESC;