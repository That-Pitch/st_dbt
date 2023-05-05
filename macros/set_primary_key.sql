
{% macro set_primary_key(pk_name, pk_col) %}


 {{
    after_commit("ALTER TABLE {{this}} add constraint " ~ pk_name ~ " primary key (" ~pk_col ~ ")")

  }}

{% endmacro %}
