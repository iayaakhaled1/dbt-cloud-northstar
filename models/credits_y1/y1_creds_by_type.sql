with 

credits as (
    select * from {{ ref('y1_creds_by_course')}}
),

final as (
    select 
        student_id,
        credit_type,
        
        sum(credits_earned) as total_credits_earned

    from credits

    group by student_id, credit_type

)

select * from final