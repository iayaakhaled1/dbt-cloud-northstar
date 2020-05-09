with

grades as (
    select * from {{ ref('stg_hist_grades')}}
),

courses as (
    select * from {{ ref('stg_courses')}}
),

final as (
    select
        grades.student_id,
        grades.course_id,
        grades.term_id,
        grades.pct,

        courses.course_name,
        courses.credit_type,

        case
            when grades.pct >= 70 then 1 -- students earn 1 credit if grade > 70
            else 0 -- otherwise, no credit earned
        end as credits_earned    

        from grades
        left join courses
        on grades.course_id = courses.course_id
        
        where grades.term_id < 2900 -- selecting only grades from before current year
)

select * from final