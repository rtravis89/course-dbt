* How many users do we have? 130 

* On average, how many orders do we receive per hour? 7.52

```sql
with hourly_orders as (
select day(created_at) as dy, 
  hour(created_at) as hr,
  count(distinct order_id) as num_orders
from stg_orders 
group by 1,2
)
select avg(num_orders)
from hourly_orders

```

* On average, how long does an order take from being placed to being delivered? 93.4 hours

```sql
select avg(datediff(hour, created_at, delivered_at)) as tm 
from stg_orders
```

* How many users have only made one purchase? Two purchases? Three+ purchases? One purchase - 25, Two purchases - 28, Three+ purchases - 71

```sql
with purchases as (
select user_id,
  count(distinct order_id) as cnt_orders
from stg_orders
group by 1
    )
select case when cnt_orders < 3 then cnt_orders else 3 end, 
  count(distinct user_id) as num_users
from purchases
group by 1
order by 1

```

* On average, how many unique sessions do we have per hour? 16.32

```sql 

with hourly_sessions as (
select day(created_at)as dy,
  hour(created_at) as hr,
  count(distinct session_id) as total_sessions
from stg_events 
group by 1,2
) 
select avg(total_sessions) as avg_hourly_sessions
from hourly_sessions


```