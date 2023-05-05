{{
    config(
        post_hook=[set_primary_key("nbi_id_pk", "id")
        ]
    )
}}


-- Select all basket items from baskets table which will return a row for every basket
-- item with its corresponding basket id
-- this is then used as a join on basket_items

select
    *
from {{ source("raw_synchtank", "baskets_basketitems") }}

