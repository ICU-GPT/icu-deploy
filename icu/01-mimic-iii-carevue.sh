#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	CREATE DATABASE mimiccarevue;
EOSQL
psql --username "$POSTGRES_USER" -d mimiccarevue -f /docker-entrypoint-initdb.d/sql/mimic-carevue/create.sql
printf "copying"
psql --username "$POSTGRES_USER" -d mimiccarevue -v ON_ERROR_STOP=1 -v mimic_data_dir=/docker-entrypoint-initdb.d/data/mimic-carevue -f /docker-entrypoint-initdb.d/sql/mimic-carevue/load_gz.sql
printf "copydone"
psql --username "$POSTGRES_USER" -d mimiccarevue -v ON_ERROR_STOP=1  -f /docker-entrypoint-initdb.d/sql/mimic-carevue/constraint.sql
psql --username "$POSTGRES_USER" -d mimiccarevue -v ON_ERROR_STOP=1  -f /docker-entrypoint-initdb.d/sql/mimic-carevue/index.sql
psql --username "$POSTGRES_USER" -d mimiccarevue -v ON_ERROR_STOP=1  -f /docker-entrypoint-initdb.d/sql/mimic-carevue/postgres-functions.sql
psql --username "$POSTGRES_USER" -d mimiccarevue -v ON_ERROR_STOP=1  -v mimic_concepts_dir=/docker-entrypoint-initdb.d/sql/mimic-carevue/concepts -f /docker-entrypoint-initdb.d/sql/mimic-carevue/postgres-make-concepts.sql
