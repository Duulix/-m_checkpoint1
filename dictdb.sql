CREATE TABLE IF NOT EXISTS dictionary (
	id SERIAL PRIMARY KEY,
	word VARCHAR(50),
	translation VARCHAR(50)
);

SELECT * FROM dictionary;