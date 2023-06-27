{{
    config(
        post_hook=[set_primary_key("nu_id_pk","id")

        ]
    )
}}




select id,
       name,
       created::timestamp,
       artists, --1 user can be associated with multiple artists but all share the same subscription.
       email,
        role,
       lastmodified::timestamp as last_modified,
       (activesubscriptions[0]->>'id')::bigint as subscription_id,
       (activesubscriptions[0]->>'name')::varchar as subscription_name,
       (activesubscriptions[0]->'artistCollectionTitles') as subscription_collections,
       _airbyte_emitted_at,
       _airbyte_ab_id,
       _airbyte_users_hashid
from {{ source("raw_synchtank", "users") }}
order by created desc


