select distinct
    [Course_Number] as course_id, 
    [Course_Name] as course_name, 
    case
        when [Credit_Type] = 'ART' then 'ELECT'
        else [Credit_Type]
    end as credit_type

from {{ source('powerschool','C2020_Y1_Historical') }}
