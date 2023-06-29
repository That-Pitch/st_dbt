{{
    config(
        post_hook=[set_primary_key("nr_id_pk","id")

        ]
    )
}}



select
      *
from {{ source("raw_stripe", "refunds") }}
order by created desc