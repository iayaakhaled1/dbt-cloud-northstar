with events as (select * from {{ ref('stg_kickboard_events')}}),

years as (select * from {{ ref('academic_years')}}),

behaviors as (
    select *
    from events
    left join years
    on (events.timestamp >= years.start_date and events.timestamp <= years.end_date)
),

behaviors_by_year as (
    select
        behavior,
        behavior_category,
        year, 
        count(*) as behavior_events
    from behaviors
    group by behavior, behavior_category, year
),

final as (
    select *
    from behaviors_by_year
    pivot(
        sum(behavior_events) for year in {{ var('academic_years')}})
        as p
    order by behavior
)

select * from final