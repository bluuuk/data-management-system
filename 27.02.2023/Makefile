PWD=$(shell pwd)
CONTAINER=dms-prac3
POSTGRES_PASSWORD=secret
DB_DATA=/Volumes/ssd/data-management/practical-27.02
CONTAINER_ANACONDA=dms-anaconda

postgres-up:
	@docker start $(CONTAINER)

postgres-down:
	@docker stop $(CONTAINER)

create-postgres:
	docker run \
	--name $(CONTAINER) \
	-e POSTGRES_PASSWORD=$(POSTGRES_PASSWORD) \
	-p 5432:5432 \
	-v $(DB_DATA)/data:/etc/data \
	-v $(shell pwd)/schema.sql:/docker-entrypoint-initdb.d/schema.sql \
	-d postgres

create-anaconda:
	docker run \
	--name $(CONTAINER_ANACONDA) \
	-i -t -p 8888:8888 continuumio/miniconda3 /bin/bash \
	-c "/opt/conda/bin/conda install jupyter -y --quiet && mkdir \
	/opt/notebooks && /opt/conda/bin/jupyter notebook \
	--notebook-dir=/opt/notebooks --ip='*' --port=8888 \
	--no-browser --allow-root --NotebookApp.allow_origin='*'" 

clean:
	docker rm $(CONTAINER)
	docker rm $(CONTAINER_ANACONDA)