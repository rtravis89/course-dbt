{% snapshot orders_snapshot %}

{{
  config(
    target_database = 'dev_db',
    target_schema = 'dbt_rtravis89',
    strategy='check',
    unique_key='order_id',
    check_cols=['status'],
   )
}}

select * from {{ source('postgres', 'orders')}}

{% endsnapshot %}