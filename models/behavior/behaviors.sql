with events as (select * from {{ ref('stg_kickboard_events')}}),

final as ( 
    select distinct behavior, 
    behavior_category

    from events
)

select * from final