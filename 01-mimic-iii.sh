#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	CREATE DATABASE mimiciii;
EOSQL
psql --username "$POSTGRES_USER" -d mimiciii -f /docker-entrypoint-initdb.d/sql/mimic-iii/create.sql
printf "copying"
psql --username "$POSTGRES_USER" -d mimiciii -v ON_ERROR_STOP=1 -v mimic_data_dir=/docker-entrypoint-initdb.d/data/mimic-iii -f /docker-entrypoint-initdb.d/sql/mimic-iii/load_gz.sql
printf "copydone"
psql --username "$POSTGRES_USER" -d mimiciii -v ON_ERROR_STOP=1  -f /docker-entrypoint-initdb.d/sql/mimic-iii/constraint.sql
psql --username "$POSTGRES_USER" -d mimiciii -v ON_ERROR_STOP=1  -f /docker-entrypoint-initdb.d/sql/mimic-iii/index.sql
psql --username "$POSTGRES_USER" -d mimiciii -v ON_ERROR_STOP=1  -f /docker-entrypoint-initdb.d/sql/mimic-iii/postgres-functions.sql
psql --username "$POSTGRES_USER" -d mimiciii -v ON_ERROR_STOP=1  -v mimic_concepts_dir=/docker-entrypoint-initdb.d/sql/mimic-iii/concepts -f /docker-entrypoint-initdb.d/sql/mimic-iii/postgres-make-concepts.sql

