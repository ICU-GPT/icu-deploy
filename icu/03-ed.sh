#! /bin/bash

####ed import

psql --username "$POSTGRES_USER" -d mimiciv -f /docker-entrypoint-initdb.d/sql/ed/create.sql
psql --username "$POSTGRES_USER" -d mimiciv -v ON_ERROR_STOP=1 -v mimic_data_dir=/docker-entrypoint-initdb.d/data/ed -f /docker-entrypoint-initdb.d/sql/ed/load_gz.sql
psql --username "$POSTGRES_USER" -d mimiciv -v ON_ERROR_STOP=1  -f /docker-entrypoint-initdb.d/sql/ed/constraint.sql
psql --username "$POSTGRES_USER" -d mimiciv -v ON_ERROR_STOP=1  -f /docker-entrypoint-initdb.d/sql/ed/index.sql