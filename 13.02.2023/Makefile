PWD=$(shell pwd)

create-mongo:
	docker run \
	--name dms-mongo \
	--rm \
	-p 27017:27017 \
	-d mongo

create-python:
	docker run  \
	--rm \
	-p 7676:8888 \
	-v $(shell pwd):/home/jovyan/work jupyter/datascience-notebook

all: create-mongo create-python