{{
    config(
        post_hook=[set_primary_key("np_id_pk", "id"),
        set_foreign_key("user_id_fk","purchaser_user_id","{{ref('normalized_users')}} (id)"),
        set_foreign_key("basket_id_fk", "basket_id", "{{ref('normalized_baskets')}} (id)")
        ]
    )
}}




select
    p.id::bigint,
    p.created::timestamp,
    p.user::bigint as purchaser_user_id,
    p.basket::bigint as basket_id,
           _airbyte_emitted_at,
       _airbyte_ab_id,
       _airbyte_purchases_hashid

from {{ source("raw_synchtank", "purchases") }} as p
where p.created::date > date('2023-06-01') and p.paymentprovider != 'braintree'
order by p.created::timestamp desc
