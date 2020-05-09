{% macro ignore_courses(table_name) %}

{% set ignore_courses = ['ADV100', "ADV500", "DEAN01", "ENG110F", "SH100", "SR101", "SR201", "SR301", "SR401", "TEAM9", "UNI251", "UNI252"] %}

where {% for course in ignore_courses %} {{ table_name }}.course_id != '{{ course }}' {% if not loop.last %} AND {% endif %} {% endfor %} 

{% endmacro %}