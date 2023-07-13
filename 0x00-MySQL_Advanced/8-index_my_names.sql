-- creates an index(idx_name_first) on the first letter of
-- name.name
-- The following Select STatement
-- SELECT COUNT(name) FROM names WHERE name LIKE 'a%';
-- takes: 2.19 sec  B4 index is added
-- now takes: 0.82 sec After index is added
-- Index take space that is why we only used the first letter
-- its more of a performance against space tradeoff.
-------------------------------------------------
-- mysql> SELECT COUNT(name) FROM names WHERE name LIKE 'a%';
-- +-------------+
-- | COUNT(name) |
-- +-------------+
-- |      302936 |
-- +-------------+
-- 1 row in set (39.67 sec)

-- mysql> CREATE INDEX idx_name_first ON names (name(1));
-- Query OK, 0 rows affected (1 min 55.71 sec)
-- Records: 0  Duplicates: 0  Warnings: 0

-- mysql> SELECT COUNT(name) FROM names WHERE name LIKE 'a%';
-- +-------------+
-- | COUNT(name) |
-- +-------------+
-- |      302936 |
-- +-------------+
-- 1 row in set (13.08 sec)

CREATE INDEX idx_name_first ON names (name(1));