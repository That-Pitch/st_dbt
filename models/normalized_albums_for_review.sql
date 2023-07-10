{{
    config(
        post_hook=[set_primary_key("nalfr_id_pk","id"),

    ]
    )
}}

select * from {{source('raw_synchtank','reviewalbums')}}