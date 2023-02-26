PWD=$(shell pwd)

postgres-up:
	@docker start dmc-prac2

postgres-down:
	@docker stop dmc-prac2

create-container:
	docker run --name dmc-prac2 -e POSTGRES_PASSWORD=secret -p 5432:5432 -v $(PWD)/data:/etc/data -v $(PWD)/schema.sql:/docker-entrypoint-initdb.d/schema.sql -d postgres

clean:
	docker rm dmc-prac2