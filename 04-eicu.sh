#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	CREATE DATABASE eicu;
EOSQL

psql --username "$POSTGRES_USER" -d eicu -f /docker-entrypoint-initdb.d/sql/eicu/create_tables.sql
psql --username "$POSTGRES_USER" -d eicu -v ON_ERROR_STOP=1 -v datadir=/docker-entrypoint-initdb.d/data/eicu -f /docker-entrypoint-initdb.d/sql/eicu/load_data_gz.sql
psql --username "$POSTGRES_USER" -d eicu -v ON_ERROR_STOP=1  -f /docker-entrypoint-initdb.d/sql/eicu/indexes.sql
psql --username "$POSTGRES_USER" -d eicu -v ON_ERROR_STOP=1  -f /docker-entrypoint-initdb.d/sql/eicu/checks.sql
#psql --username "$POSTGRES_USER" -d eicu -v ON_ERROR_STOP=1 -v concepts_dir=/docker-entrypoint-initdb.d/sql/eicu/concepts -f /docker-entrypoint-initdb.d/sql/eicu/postgres-make-concepts.sql