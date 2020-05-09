select 
    [STUDENT_NUMBER] as student_id,
    [SECTIONID] as section_id,
    [FINALGRADENAME] as quarter,
    [PERCENT] as pct

from {{ source('powerschool','1920_y1_grades') }}