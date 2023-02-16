

clean-up-queries:
	for file in queries/*.sql;
	do
		echo $file
		sed -i '' 's/:x/-- :x/' $file
		sed -i '' 's/:o/-- :o/' $file
		sed -i '' 's/:n/-- :n/' $file
	done

execute-queries:
	for query in {1..22} ; do\
		echo $${query};\
		PGPASSWORD=secret psql -h localhost --u postgres -w -a -f queries/$${query}.sql 1> /dev/null;\
		echo;\
	done