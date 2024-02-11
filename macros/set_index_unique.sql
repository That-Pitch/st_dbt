{% macro set_index_unique(idx_name, columns) %}

    {{
        after_commit(
            "ALTER TABLE {{this}} add constraint "
            ~ idx_name
            ~ " unique "
            ~ columns
            
        )
    }}

{% endmacro %}
