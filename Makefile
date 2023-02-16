# clean-up-queries:
# 	for file in queries/*.sql;
# 	do
# 		echo $file
# 		sed -i '' 's/:x/-- :x/' $file
# 		sed -i '' 's/:o/-- :o/' $file
# 		sed -i '' 's/:n/-- :n/' $file
# 	done

execute-queries-errors:
	@for query in {1..22} ; do\
		echo $${query};\
		PGPASSWORD=secret psql -h localhost --u postgres -w -a -f queries/$${query}.sql 1> /dev/null;\
		echo;\
	done

execute-query-error:
	@PGPASSWORD=secret psql -h localhost --u postgres -w -a -f queries/$(query).sql 1> /dev/null;\


postgres-up:
	@docker start data-mgn-class

postgres-down:
	@docker stop data-mgn-class

create-container:
	docker run --name data-mgn-class -e POSTGRES_PASSWORD=secret -p 5432:5432 -v $(pwd)/100mb:/etc/data -v $(pwd)/schema.sql:/docker-entrypoint-initdb.d/schema.sql -d postgres