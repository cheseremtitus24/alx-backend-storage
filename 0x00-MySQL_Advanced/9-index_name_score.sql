-- creates an index(idx_name_first_score) on the first letter of
-- name.name and the entire column score
CREATE INDEX idx_name_first_score ON names ( name(1), score);