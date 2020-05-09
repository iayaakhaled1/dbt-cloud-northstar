select distinct 
    [STUDENT_NUMBER] as student_id, 
    [LastFirst] as lastfirst, 
    [HOME_ROOM] as homeroom

from {{ source('powerschool','C2020_Y1_Historical') }}