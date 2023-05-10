{{
    config(
        post_hook=[set_primary_key("nbi_id_pk", "id")
        ]
    )
}}



select
    *
from {{ source("raw_synchtank", "baskets_basketitems") }}

