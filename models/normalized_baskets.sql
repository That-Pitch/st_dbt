{{
    config(
        post_hook=[set_primary_key("nb_id_pk", "id")

        ]
    )
}}

select id,
       {{dollars_to_cents('totalprice')}} as total_amount_in_cents,
       created::timestamp,
    paymenttransactionid as payment_transaction_id,

       _airbyte_emitted_at,
       _airbyte_ab_id,
       _airbyte_baskets_hashid


from {{ source("raw_synchtank", "baskets") }}


