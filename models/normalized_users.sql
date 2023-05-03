{{
    config(
        post_hook=[after_commit("alter table {{ this }} drop constraint if exists nu_id_pk cascade"),after_commit("alter table {{ this }} add constraint nu_id_pk primary key (id)")

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
from users
order by created desc