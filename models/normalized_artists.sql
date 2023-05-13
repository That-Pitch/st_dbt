{{
    config(
        post_hook=[set_primary_key("na_id_pk", "id")

        ]
    )
}}

select *


from {{ source("raw_synchtank", "artists") }}


