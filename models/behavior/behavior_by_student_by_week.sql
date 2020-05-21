with events as (select * from {{ ref('stg_kickboard_events')}}),

weeks as (select * from {{ ref('weeks_1920')}}),

pos_events as (
    select 
        events.student_id,
        events.firstlast,
        events.grade_group,
        weeks.week,
        sum(merit_value) as positive_sum,
        count(merit_value) as positive_count
    from events
    left join weeks
    on (events.timestamp >= weeks.start_date and events.timestamp <= weeks.end_date)
    where (events.behavior_category = 'Positive Behaviors' and events.timestamp >= '2019-08-19')
    group by 1, 2, 3, 4
),

neg_events as (
    select 
        events.student_id,
        events.firstlast,
        weeks.week,
        sum(merit_value) as negative_sum,
        count(merit_value) as negative_count
    from events
    left join weeks
    on (events.timestamp >= weeks.start_date and events.timestamp <= weeks.end_date)
    where (events.behavior_category = 'Negative Behaviors'  and events.timestamp >= '2019-08-19')
    group by 1, 2, 3
),

final as (
    select 
        pos_events.student_id,
        pos_events.firstlast,
        pos_events.week,
        pos_events.grade_group,
        pos_events.positive_sum,
        neg_events.negative_sum,
        pos_events.positive_count,
        neg_events.negative_count,
        pos_events.positive_count + neg_events.negative_count as events,
        pos_events.positive_count / neg_events.negative_count as ratio
    from pos_events
    left join neg_events
    on (pos_events.student_id = neg_events.student_id and pos_events.week = neg_events.week)
    order by 1, 3
)

select * from final