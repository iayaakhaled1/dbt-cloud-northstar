with 

grades as (
    select * from {{ ref('stg_y1_grades') }}
),

sections as (
    select * from {{ ref('stg_sections')}}
),

final as (
    select
        grades.student_id,
        grades.section_id,
        grades.quarter,
        grades.pct,
        sections.course_id,
        sections.credit_type

    from grades

    left join sections
    on grades.section_id = sections.section_id

    {{ ignore_courses('sections') }} -- ignore specific courses
)

select * from final