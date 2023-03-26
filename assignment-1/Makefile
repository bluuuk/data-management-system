DB_DATA=/Volumes/ssd/data-management
POSTGRES_PASSWORD=secret
CONTAINER=dms-assignment1

create-data:
	$(DB_DATA)/tpch-dbgen/dbgen -s 50
	mv $(DB_DATA)/tpch-dbgen/*.tbl $(DB_DATA)/data
	touch create-data

prepare-data:
	for file in $(DB_DATA)/data/*.tbl ; do\
		sed -i '' 's/|$$//' $$file; \
	done
	touch prepare-data 

postgres-up:
	@docker start $(CONTAINER)
	sleep 15

postgres-down:
	@docker stop $(CONTAINER)

remove-container:
	docker rm $(CONTAINER)

analysis-container:
	docker run --rm -p 8787:8888 \
	-v /Volumes/ssd:/home/jovyan/work \
	-v $(shell pwd):/home/jovyan/ \
	jupyter/datascience-notebook

#https://stackoverflow.com/questions/30210362/how-to-increase-the-size-of-the-dev-shm-in-docker-container
create-container: 
	docker run \
	--name $(CONTAINER) \
	--shm-size=512m \
	-e POSTGRES_PASSWORD=$(POSTGRES_PASSWORD) \
	-p 5432:5432 \
	-v $(DB_DATA)/data:/etc/data \
	-v $(shell pwd)/schema.sql:/docker-entrypoint-initdb.d/schema.sql \
	-d postgres
	sleep 10

populate-database: create-container
	PGPASSWORD=$(POSTGRES_PASSWORD) psql -h localhost --u postgres -c "\timing on" -a -f ./up.sql -q  ;\

measure-timings: postgres-up
	for i in {1,2,3,4,5} ; do\
		PGPASSWORD=$(POSTGRES_PASSWORD) psql -h localhost --u postgres -a -f ./down.sql -q > /dev/null; \
		PGPASSWORD=$(POSTGRES_PASSWORD) psql -h localhost --u postgres -a -f ./schema.sql -q > /dev/null; \
		PGPASSWORD=$(POSTGRES_PASSWORD) psql -h localhost --u postgres -c "\timing on" -a -f ./up.sql -q  > timings_$$i.txt; \
	done

execute-queries-timing-timeout: postgres-up
	for query in {1..22} ; do\
		echo queries/$${query}.sql ;\
		timeout 2h bash -c "PGPASSWORD=$(POSTGRES_PASSWORD) psql -h localhost --u postgres  -c '\timing on' -w -a -f queries/$${query}.sql > timings-query_$${query}.txt" ;\
	done

execute-queries-timing: postgres-up
	mkdir query-results
	for run in 1 2 3 4 5 ; do \
		for query in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 18 19 21 22 ; do\
			echo queries/$${query}.sql ;\
			PGPASSWORD=$(POSTGRES_PASSWORD) psql -h localhost --u postgres  -c '\timing on' -w -a -f queries/$${query}.sql > query-results/timings-query_$${run}-$${query}.txt ;\
		done ; \
	done

execute-queries-concurrent: 2.sql 6.sql 13.sql 14.sql 19.sql
	echo executing

RUN=5

%.sql:
	PGPASSWORD=$(POSTGRES_PASSWORD) psql -h localhost --u postgres  -c '\timing on' -w -a -f queries/$@ > concurrent/timings-query_$(RUN)-$(shell echo $@ | tr -d ".sql").txt
