{{
    config(
        post_hook=[after_commit("alter table {{ this }} drop constraint if exists nl_id_pk cascade"),after_commit("alter table {{ this }} add constraint nl_id_pk primary key (id)")

        ]
    )
}}

select
    id,
    name,
    created::timestamp,
    trackcount as track_count,
    collections,
    exclusive,
               _airbyte_emitted_at,
       _airbyte_ab_id,
       _airbyte_licenses_hashid



from {{ source("raw_synchtank", "licenses") }}


