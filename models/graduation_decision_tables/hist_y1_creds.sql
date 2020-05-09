with

hist_creds as (
    select * from {{ ref('hist_creds_by_type_by_student')}}
),

y1_creds as (
    select * from {{ ref('y1_creds_by_type_by_student')}}
),

all_credits as (
    select * from hist_creds
    union all
    select * from y1_creds
),

final as (
    select 
        student_id,
        lastfirst,
        credit_type,
        sum(total_credits_earned) as total_credits_earned
    from all_credits
    group by student_id, lastfirst, credit_type 
)

select * from final