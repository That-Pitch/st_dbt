
{% macro set_primary_key(this,constraint_name,column_name) %}
    alter table {{this}} drop constraint if exists {{constraint_name}};
    alter table {{this}} add constraint {{constraint_name}} primary key ("{{column_name}}")
{% endmacro %}
