{{
    config(
        post_hook=[set_primary_key("nu_id_pk","id")


        ]
    )
}}




select id,
       name,
       created::timestamp,
       artists[0] as artist_id,
       email,
       lastmodified::timestamp as last_modified,
       (activesubscriptions[0]->>'id')::bigint as subscription_id,
       (activesubscriptions[0]->>'name')::varchar as subscription_name,
       (activesubscriptions[0]->'artistcollectiontitles') as subscription_collections,
       _airbyte_emitted_at,
       _airbyte_ab_id,
       _airbyte_users_hashid
from {{ source("raw_synchtank", "users") }}
order by created desc