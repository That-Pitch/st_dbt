{{
    config(
        post_hook=[set_primary_key("nsc_id_pk","id")

        ]
    )
}}



select
      c.*
from {{ source("raw_stripe", "charges") }} c
WHERE c.metadata::jsonb ? 'basketId'
and c.paid is true
order by c.created desc