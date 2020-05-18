with events as (select * from {{ ref('stg_kickboard_events')}}),

weeks as (select * from {{ ref('weeks_1920')}}),

pos_events as (
    select 
        events.teacher_name,
        weeks.week,
        sum(merit_value) as positive_sum,
        count(merit_value) as positive_count
    from events
    left join weeks
    on (events.timestamp >= weeks.start_date and events.timestamp <= weeks.end_date)
    where (events.behavior_category = 'Positive Behaviors' and events.timestamp >= '2019-08-19')
    group by 1, 2
    order by 1
),

neg_events as (
    select 
        events.teacher_name,
        weeks.week,
        sum(merit_value) as negative_sum,
        count(merit_value) as negative_count
    from events
    left join weeks
    on (events.timestamp >= weeks.start_date and events.timestamp <= weeks.end_date)
    where (events.behavior_category = 'Negative Behaviors' and events.timestamp >= '2019-08-19')
    group by 1, 2
    order by 1
),

final as (
    select 
        pos_events.teacher_name,
        pos_events.week,
        pos_events.positive_sum,
        neg_events.negative_sum,
        pos_events.positive_count,
        neg_events.negative_count,
        pos_events.positive_count + neg_events.negative_count as events,
        pos_events.positive_count / neg_events.negative_count as ratio

    from pos_events

    left join neg_events

    on (pos_events.teacher_name = neg_events.teacher_name and pos_events.week = neg_events.week)
    
    order by 1, 2
)

select * from final