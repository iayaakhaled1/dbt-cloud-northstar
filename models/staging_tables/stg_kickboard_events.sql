with events as (
    select
        "External ID" as student_id,
        Student as firstlast,
        Behavior as behavior,
        "Behavior Category" as behavior_category,
        "Dollar Value" as dollar_value,
        "Merit Value" as merit_value,
        Staff as teacher_name,
        "Recorded On" as timestamp
        
    from {{ source("kickboard","kickboard_historical") }}
)

select * from events