{{
    config(
        post_hook=[set_primary_key("na_id_pk", "id")
        ]
    )
}}

select a.id, a.created, a.name,
           a._airbyte_emitted_at,
    a._airbyte_ab_id,
    a._airbyte_artists_hashid


from {{ source("raw_synchtank", "artists") }} a



