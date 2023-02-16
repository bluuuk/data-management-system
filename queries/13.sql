select
c_count,
count(*) as custdist from
(
select
c_custkey,
count(o_orderkey) as c_count from
customer left outer join orders on c_custkey = o_custkey
and o_comment not like '%pending%deposits%' c_custkey
group by
) c_orders group by
c_count order by
custdist desc, c_count desc;