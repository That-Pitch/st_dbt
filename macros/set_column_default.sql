{% macro set_column_default(column, default_val) %}

    {{
        after_commit(
            "ALTER TABLE {{this}} alter column "
            ~ column
            ~ " set default "
            ~ default_val
        )
    }}

{% endmacro %}
