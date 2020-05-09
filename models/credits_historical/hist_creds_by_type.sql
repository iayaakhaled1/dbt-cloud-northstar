with 

creds_by_course as (
    select * from {{ ref('hist_creds_by_course')}}
),

final as (
    select 
        creds_by_course.student_id,
        creds_by_course.Credit_Type,

        sum(credits_earned) as total_credits_earned

    from creds_by_course
    
    group by creds_by_course.student_id, creds_by_course.Credit_Type
)

select * from final