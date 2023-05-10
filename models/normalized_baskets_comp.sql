{{
    config(
        post_hook=[set_primary_key("nbc_id_pk", "basket_id,item_id"),
        set_foreign_key("nb_id_fk","basket_id","{{ ref('normalized_baskets') }} (id)"),
        set_foreign_key("nbi_id_fk","item_id","{{ ref('normalized_basket_items') }} (id)"),
        set_foreign_key("nt_id_fk","track_id","{{ref('normalized_tracks')}} (id)")
        ]
    )
}}


select
b.id as basket_id,
bi.id as item_id,
b.created::timestamp,
    bi.itemtype as item_type,
    bi.quantity,
    bi.priceatpurchase as price_at_purchase,
    bi.refundreason as refund_reason,
    bi.license as license_id,
    bi.licensename as license_name,
    c.name as collection_name,
    l.exclusive as license_is_exclusive,
    {{ dollars_to_cents("bi.priceataddition") }} as price_at_addition,
    bi.track as track_id,
    bi.gatewayrefundid as gateway_refund_id,
    bi._airbyte_emitted_at,
    bi._airbyte_ab_id,
    bi._airbyte_basketitems_hashid
from {{ref('normalized_baskets')}} b
inner join {{ref('normalized_basket_items')}} bi  using (_airbyte_baskets_hashid)
left join {{ref('normalized_licenses')}} as l on l.id = bi.license::bigint
left join {{ref('normalized_collections')}} as c on c.id = l.collections




