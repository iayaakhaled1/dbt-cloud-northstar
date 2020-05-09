with

credits as (
    select * from {{ ref('hist_q3_creds') }}
),

final as (
    select
        student_id,
        lastfirst as student,
        {{ credit_types_list() }}

    from credits

    pivot (
        sum(total_credits_earned) -- total creds for each credit type
        for credit_type in ({{ credit_types_list() }}))
    as PivotTable
)

select * from final 