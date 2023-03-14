1. Table with details of hardware and operating system of each machine:
Specify as much as possible, include details of disk, memory, processor (including colors), brand, operating system and others.
2. load times graphs:
[ ] chart with how long it took to load each table larger than 1 GB?
[ ] Graph with how long it took to create each index PK and each FK on tables larger than 5GB?
[ ] Upload speed in MB/sec as statistic (average, max, min, stdev)
3. query times:
[ ] graph with the times of the various queries
depending on the machine, it is likely that some queries will not be able to finish in good time. Set 2h as a maximum, and when you exceed this limit, report >2h;
[ ] graph with the times of the various queries compared between the two tested machines.
4. Choose now 5 different queries that take a similar time to run greater than 15 seconds and run all 5 at the same time.
[ ] graph with the comparative times of the queries running alone versus at the same time, on each machine.
[ ] Slowdown graph in % on each machine
[ ] Comparison graph of these results between the two machines.
5. Choose one of the slower queries that includes lineitem and orders and other tables. For this one:
    A. Run and show the Explain plan in postgres. Explain where the query spends more time (doing what).
    B. Change this query by adding filters (where conditions) on attributes that are not PKs or FKs, but in such a way as to get few rows from the PART, SUPPLIER, ORDERS and PARTSUPP tables (e.g. in the case of ORDERS it will be a specific orderdate). Show the search runtime with the original search unchanged and changed.
    C. Now create an index on each of the attributes you chose to filter in order to make the execution faster. Show the resulting times with the original search unchanged, changed without index and changed with index.
    D. Run and show the explain plan and explain what changed (and if it even changed) and why.
