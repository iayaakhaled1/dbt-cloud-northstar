with events as (select * from {{ ref('stg_kickboard_events')}}),

final as (
    select
        events.behavior,
        events.behavior_category,
        count(*)
    from events
    group by events.behavior, events.behavior_category
)

select * from final