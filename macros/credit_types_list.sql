{% macro credit_types_list() %}

{% set credit_types = ['ENG', "MATH", "SCI", "HIST", "FORLANG", "ELECT", "PE", "CR", "ADMIN"] %}

{% for c_type in credit_types %} 
[{{ c_type }}]
{% if not loop.last %} , {% endif %}
{% endfor %} 

{% endmacro %}