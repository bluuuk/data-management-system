# 1. Execution plan basics

- COST

> Estimated start-up cost.
 
- TOTAL COST 

> Estimated total cost.

- ROWS

> Estimated number of rows output by this plan node.

- WIDTH

> Estimated average width of rows output by this plan node (in bytes).

# 2. Current blogsize

> One block consists of several pages which contains the rows. Currently, a block is 8MB big.

# 3. Cost computation

```sql
SELECT relpages, reltuples FROM pg_class WHERE relname = 'tenk1';
```

> `relpages` are the number of pages and `reltupels` is the number of tupels.

$\textsf{Cost} = \textsf{Pages read} \cdot \textsf{Sequential Cost} + \textsf{Tupels} \cdot \textsf{CPU cost}$

So, for our case we $134 \cdot 1 + 10000 \cdot 0.01 = 234$


# 4. Conditions 

The cost increased because we added a condition

```
"QUERY PLAN"
"Seq Scan on tenk1  (cost=0.00..234.00 rows=10000 width=73)"
```

```
"QUERY PLAN"
"Seq Scan on tenk1  (cost=0.00..259.00 rows=7000 width=73)"
"  Filter: (unique1 < 7000)"
``` 

# 5. Index

```
"QUERY PLAN"
"Bitmap Heap Scan on tenk1  (cost=5.06..136.67 rows=100 width=73)"
"  Recheck Cond: (unique1 < 100)"
"  ->  Bitmap Index Scan on tenk1_unique1  (cost=0.00..5.04 rows=100 width=0)"
"        Index Cond: (unique1 < 100)"
```

Postgres deemed it useful to use the index because it has a lower cost than the full scan.

# 6. Two conditions

```
"QUERY PLAN"
"Index Scan using tenk1_unique2 on tenk1  (cost=0.29..49.27 rows=10 width=73)"
"  Index Cond: (unique2 > 9000)"
"  Filter: (unique1 < 100)"
```
Altough we have an index for `unique1` and `unique2`, postgres still performed a full scan.


# 7. Comparision

```
EXPLAIN SELECT * FROM tenk1 WHERE unique1 < 100 AND unique2 > 9000; QUERY PLAN
----------------------------------------------------------------------------------- --
Bitmap Heap Scan on tenk1 (cost=25.08..60.21 rows=10 width=244) Recheck Cond: ((unique1 < 100) AND (unique2 > 9000))
-> BitmapAnd (cost=25.08..25.08 rows=10 width=0)
)
-> Bitmap Index Scan on tenk1_unique1 (cost=0.00..5.04 rows=101 width=0) Index Cond: (unique1 < 100)
-> Bitmap Index Scan on tenk1_unique2 (cost=0.00..19.78 rows=999 width=0 Index Cond: (unique2 > 9000)
```

Just by looking at the cost, we can see that usage of indices was slower than the full scan. The idea behind this query is that two bitmaps are `and`-ed by the row indices. 


# 8. Change parameters

Even with small conditions ranges, postgres still favours a full scan.

```
"QUERY PLAN"
"Index Scan using tenk1_unique2 on tenk1  (cost=0.29..8.48 rows=1 width=73)"
"  Index Cond: (unique2 < 10)"
"  Filter: (unique1 < 10)"
```

# 9. Statistic based cost 
> information about tables, part of the catalog, to do a cost based analysis

| attname | n_distinct | most_common_vals                                    |
| ------- | ---------- | --------------------------------------------------- |
| twenty  | 20         | {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19} |

We can see that `twenty` has 20 different values. Generally, the average number of rows $\textsf{rows avg} = \dfrac{\textsf{rows}}{\textsf{distinct}}$ for cost.

$\text{Average bytes per row} := \dfrac{\text{Total bytes of all pages} \cdot \text{Number of pages}}{\text{Number of tupels}}$

## 10 + 11. Join plans

> The cost based optimization will calculate the cost for each _appraoch_ which is still very efficient.

- Nested loop Join
  - Used for one small and one big table
- Merge Join
  - Sorting the values for easier mapping
- Hash Join
  - Big tabels with kinda same size
