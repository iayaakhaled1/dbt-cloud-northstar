with grades as (
    select
        Course_Number as course_id, 
        SectionID as section_id, 
        STUDENT_NUMBER as student_id,
        TermID as term_id,
        Percent as pct
        
    from {{ source("powerschool","historical_grades") }}
)

select distinct * from grades

{{ ignore_courses("grades") }} -- ignore courses that are not relevent to graduation  