{{
    config(
        post_hook=[set_primary_key("nafr_id_pk","id"),

    ]
    )
}}

select * from {{source('raw_synchtank','reviewartists')}}