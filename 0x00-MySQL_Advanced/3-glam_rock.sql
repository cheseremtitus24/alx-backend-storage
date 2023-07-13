-- Shows The bands that have Glam rock as main style
--  Also shows their lifespan since creation to the date 2022
SELECT band_name AS band_name, IFNULL(split, 2022) - IFNULL(formed, 0) AS lifespan FROM metal_bands WHERE style LIKE '%Glam rock%' ORDER BY lifespan DESC;