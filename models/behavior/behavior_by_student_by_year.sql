with events as (select * from {{ ref('stg_kickboard_events')}}),

years as (select * from {{ ref('academic_years')}}),

pos_events as (
    select 
        events.student_id,
        events.firstlast,
        events.grade_group,
        years.year,
        sum(merit_value) as positive_sum,
        count(merit_value) as positive_count
    from events
    left join years
    on (events.timestamp >= years.start_date and events.timestamp <= years.end_date)
    where events.behavior_category = 'Positive Behaviors'
    group by 1, 2, 3, 4
    order by 1
),

neg_events as (
    select 
        events.student_id,
        events.firstlast,
        years.year,
        sum(merit_value) as negative_sum,
        count(merit_value) as negative_count
    from events
    left join years
    on (events.timestamp >= years.start_date and events.timestamp <= years.end_date)
    where events.behavior_category = 'Negative Behaviors'
    group by 1, 2, 3
    order by 1
),

final as (
    select 
        pos_events.student_id,
        pos_events.firstlast,
        pos_events.grade_group,
        pos_events.year,
        pos_events.positive_sum,
        neg_events.negative_sum,
        pos_events.positive_count,
        neg_events.negative_count,
        pos_events.positive_count + neg_events.negative_count as events,
        pos_events.positive_count / neg_events.negative_count as ratio
    from pos_events
    left join neg_events
    on (pos_events.student_id = neg_events.student_id and pos_events.year = neg_events.year)
    order by 1, 3
)

select * from final