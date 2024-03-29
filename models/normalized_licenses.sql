{{
    config(
        post_hook=[set_primary_key("nl_id_pk","id")
        ]
    )
}}

select
    id::bigint,
    name,
    created::timestamp,
    trackcount as track_count,
    collections[0]::bigint,
    exclusive,

    _airbyte_emitted_at,
       _airbyte_ab_id,
       _airbyte_licenses_hashid



from {{ source("raw_synchtank", "licenses") }}
{# where collections[0] is not null #}
order by created desc


