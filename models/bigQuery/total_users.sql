with
    cte as (
        select first_name , last_name , id from {{ ref("users") }}
    ),
    agg_view as (

        select first_name, last_name , count(distinct id) as total_users
        from cte
        group by first_name, last_name
    )
    SELECT * FROM agg_view