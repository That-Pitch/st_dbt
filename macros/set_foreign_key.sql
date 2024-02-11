{% macro set_foreign_key(fk_name, foreign_key, foreign_ref) %}

    {{
        after_commit(
            "ALTER TABLE {{this}} add constraint "
            ~ fk_name
            ~ " foreign key ("
            ~ foreign_key
            ~ ") references  "
            ~ foreign_ref
        )
    }}

{% endmacro %}
