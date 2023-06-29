{{
    config(
        post_hook=[set_primary_key("nsc_id_pk","id")

        ]
    )
}}



select
      c.*
from {{ source("raw_stripe", "charges") }} c
inner join {{ref('normalized_baskets_comp')}} bc on bc.payment_transaction_id = c.payment_intent
where c.payment_intent = bc.payment_transaction_id
order by c.created desc