DROP TABLE IF EXISTS homes;

CREATE TABLE homes (
  id SERIAL4 PRIMARY KEY,
  value INT8,
  no_bedrooms INT2,
  year_built VARCHAR(255),
  build VARCHAR(255)
)
