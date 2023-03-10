create table onek(
    unique1 int4,
    unique2 int4,
    two int4,
    four int4,
    ten int4,
    twenty int4,
    hundred int4,
    thousand int4,
    twothousand int4,
    fivethous int4,
    tenthous int4,
    odd int4,
    even int4,
    stringu1 varchar(10),
    stringu2 varchar(10),
    string4 varchar(10)
);
create table tenk1 (
    unique1 int4,
    unique2 int4,
    two int4,
    four int4,
    ten int4,
    twenty int4,
    hundred int4,
    thousand int4,
    twothousand int4,
    fivethous int4,
    tenthous int4,
    odd int4,
    even int4,
    stringu1 varchar(10),
    stringu2 varchar(10),
    string4 varchar(10)
);
create table tenk2 (
    unique1 int4,
    unique2 int4,
    two int4,
    four int4,
    ten int4,
    twenty int4,
    hundred int4,
    thousand int4,
    twothousand int4,
    fivethous int4,
    tenthous int4,
    odd int4,
    even int4,
    stringu1 varchar(10),
    stringu2 varchar(10),
    string4 varchar(10)
);
copy onek
from '/etc/data/onek.data';
copy tenk1
from '/etc/data/tenk.data';
copy tenk2
from '/etc/data/tenk.data';
create index onek_unique1 on onek using btree(unique1 int4_ops);
create index onek_unique2 on onek using btree(unique2 int4_ops);
create index onek_hundred on onek using btree(hundred int4_ops);
create index tenk1_unique1 on tenk1 using btree(unique1 int4_ops);
create index tenk1_unique2 on tenk1 using btree(unique2 int4_ops);
create index tenk1_hundred on tenk1 using btree(hundred int4_ops);
create index tenk2_unique1 on tenk2 using btree(unique1 int4_ops);
create index tenk2_unique2 on tenk2 using btree(unique2 int4_ops);
create index tenk2_hundred on tenk2 using btree(hundred int4_ops);
select * into table Bprime
from tenk1 t
where t.unique2 < 1000;