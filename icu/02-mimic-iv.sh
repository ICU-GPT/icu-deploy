#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	CREATE DATABASE mimiciv;
EOSQL
psql --username "$POSTGRES_USER" -d mimiciv -f /docker-entrypoint-initdb.d/sql/mimic-iv/create.sql
printf "copying"
psql --username "$POSTGRES_USER" -d mimiciv -v ON_ERROR_STOP=1 -v mimic_data_dir=/docker-entrypoint-initdb.d/data/mimic-iv -f /docker-entrypoint-initdb.d/sql/mimic-iv/load_gz.sql
printf "copydone"
psql --username "$POSTGRES_USER" -d mimiciv -v ON_ERROR_STOP=1  -f /docker-entrypoint-initdb.d/sql/mimic-iv/constraint.sql
psql --username "$POSTGRES_USER" -d mimiciv -v ON_ERROR_STOP=1  -f /docker-entrypoint-initdb.d/sql/mimic-iv/index.sql
psql --username "$POSTGRES_USER" -d mimiciv -v ON_ERROR_STOP=1  -f /docker-entrypoint-initdb.d/sql/mimic-iv/postgres-functions.sql
psql --username "$POSTGRES_USER" -d mimiciv -v ON_ERROR_STOP=1  -v mimic_concepts_dir=/docker-entrypoint-initdb.d/sql/mimic-iv/concepts -f /docker-entrypoint-initdb.d/sql/mimic-iv/postgres-make-concepts.sql
