select 
    [STUDENT_NUMBER] as student_id,
    [SECTIONID] as section_id,
    [FINALGRADENAME] as quarter,
    [PERCENT] as pct

from {{ source('powerschool','c2020_apr24_grade_by_quarter') }}