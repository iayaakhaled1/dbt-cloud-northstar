with events as (select * from {{ ref('stg_kickboard_events')}}),

years as (select * from {{ ref('academic_years')}}),

pos_events as (
    select 
        events.student_id,
        events.firstlast,
        years.year,
        sum(merit_value) as positive_total
    from events
    left join years
    on (events.timestamp >= years.start_date and events.timestamp <= years.end_date)
    where events.behavior_category = 'Positive Behaviors'
    group by 1, 2, 3
    order by 1
),

neg_events as (
    select 
        events.student_id,
        events.firstlast,
        years.year,
        sum(merit_value) as positive_total
    from events
    left join years
    on (events.timestamp >= years.start_date and events.timestamp <= years.end_date)
    where events.behavior_category = 'Negative Behaviors'
    group by 1, 2, 3
    order by 1
),

final as (
    select pos_event
)



select * from pos_events