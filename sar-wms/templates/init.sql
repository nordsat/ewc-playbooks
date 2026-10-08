CREATE TABLE {{ pg_table_name }} (id serial primary key, filename varchar, product_name varchar, time timestamp, geom geometry);
CREATE INDEX {{ pg_table_name }}_geom_idx ON {{ pg_table_name }} USING GIST (geom);
CREATE INDEX {{ pg_table_name }}_product_time_idx ON {{ pg_table_name }} (product_name, time DESC);
