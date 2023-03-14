PWD=$(shell pwd)

create-mongo:
	docker run \
	--name dms-mongo \
	-P \
	-v $(PWD)/data:/data/db \
	-d mongo:latest 
	
##--bind_ip 0.0.0.0

create-python:
	docker run  \
	--rm \
	-p 7676:8888 \
	-v $(PWD):/home/jovyan/work jupyter/datascience-notebook

all: create-mongo create-python