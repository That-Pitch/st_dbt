{{
    config(
        post_hook=[set_primary_key("ntfr_id_pk","id"),

    ]
    )
}}

select * from {{source('raw_synchtank','reviewtracks')}}