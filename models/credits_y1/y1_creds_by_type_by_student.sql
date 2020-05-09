with 

students as (
    select * from {{ ref('stg_students')}}
),

credits as (
    select * from {{ ref('y1_creds_by_type')}}
),

final as (
    select
        students.student_id,
        students.lastfirst,
        credits.credit_type,
        credits.total_credits_earned

    from students

    left join credits
    on students.student_id = credits.student_id
)

select * from final
 