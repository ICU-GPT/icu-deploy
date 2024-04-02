<<<<<<< HEAD
## How to install icu database

### Change data dir and copy init bash to you want dir

```yaml
version: '3.9'
services:
  metabase:
    image: metabase/metabase:latest
    container_name: metabase
    hostname: metabase
    volumes:
    - /dev/urandom:/dev/random:ro
    ports:
    - 3000:3000
    environment:
      MB_DB_TYPE: postgres
      MB_DB_DBNAME: metabase
      MB_DB_PORT: 5432
      MB_DB_USER: postgres
      MB_DB_PASS: mimic
      MB_DB_HOST: postgres
    depends_on:
    - postgres
  postgres:
    image: postgres:latest
    command: >
      -c maintenance_work_mem=256MB
      -c max_wal_size=4GB
    container_name: postgres
    hostname: postgres
    volumes:
    - ${PWD}/data:/var/lib/postgresql/data  ## change ${PWD} to ir you want store database data
    - ${PWD}/icu/:/docker-entrypoint-initdb.d/:ro ##d cp icu dir you want and change ${PWD} you icu dird
    ports:
    - 5432:5432
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: mimic
```

## 
> Change ${PWD} you want store database

## Prepare
```bash
#Download mimiciii ed mimic-note mimiciii-carevue mimiciv ... csv.gz data

# cp mimiciii/*csv.gz to ${PWD}/icu/data/mimiciii/
# cp ed/*csv.gz   to ${PWD}/icu/data/ed/
# cp mimic-carevue/*csv.gz   to ${PWD}/icu/data/mimic-carevue/
# cp eicu/*csv.gz   to ${PWD}/icu/data/eicu/
# cp mimic-iv/*csv.gz   to ${PWD}/icu/data/mimic-iv/
```


## Init databases

```bash
chmod +x install
./install
```

## Check  install

```bash
docker ps |grep postgres
docker ps |grep metabase

# or you can run install dird
# docker compose ps --all
```
## Check  logs

```bash
docker logs postgres ## view postgres you can check db init progress
```

## Restart Sevice
```
# in the install dir 

docker compose restart
```
## Uninstall Sevice
```
# in the install dir 

docker compose down -vesfscfxsx sd
```

=======
A icu databases docker init project
>>>>>>> ee0def4e2e9509fae289e632785343a17b19768f
