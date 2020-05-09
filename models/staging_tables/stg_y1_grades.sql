select 
    "STUDENT NUMBER" as student_id,
    SECTIONID as section_id,
    FINALGRADENAME as quarter,
    PERCENT as pct

from {{ source('powerschool','y1_grades_updated') }}