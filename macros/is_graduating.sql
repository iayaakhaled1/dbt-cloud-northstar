{%- macro is_graduating(table_name) -%}

{%- set credit_types = ["ENG", "MATH", "SCI", "HIST", "FORLANG", "ELECT", "PE", "CR"] -%} 

{%- set graduation_reqs = [4,4,3,3,2,2,4,2] -%}

case
    when 
    {%- for i in range(credit_types|length) -%}
    
        ( {{ table_name }}.{{ credit_types[i] }} >= {{ graduation_reqs[i] }} )

        {%- if not loop.last -%} and
        {%- endif -%} 

    {%- endfor -%} 
    then True
    else False
end as is_graduating

{%- endmacro -%}
 