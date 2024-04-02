psql --username "$POSTGRES_USER" -d mimiciv -f /docker-entrypoint-initdb.d/sql/note/create.sql
psql --username "$POSTGRES_USER" -d mimiciv -v ON_ERROR_STOP=1 -v mimic_data_dir=/docker-entrypoint-initdb.d/data/note -f /docker-entrypoint-initdb.d/sql/note/load_gz.sql
