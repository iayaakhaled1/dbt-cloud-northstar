select distinct
    [SectionID] as section_id, 
    [Course_Number] as course_id, 
    [Teacher_Name] as teacher_name, 
    case
        when [Credit_Type] = 'ART' then 'ELECT'
        else [Credit_Type]
    end as credit_type
    
from {{ source('powerschool','C2020_Y1_Historical') }}