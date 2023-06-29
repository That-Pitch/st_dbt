{{
    config(
        post_hook=[set_primary_key("nd_id_pk","id")

        ]
    )
}}



select
      *
from {{ source("raw_stripe", "disputes") }}
order by created desc