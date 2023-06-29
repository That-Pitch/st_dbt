{{
    config(
        post_hook=[set_primary_key("nbc_id_pk", "basket_id,item_id"),
        set_foreign_key("nb_id_fk","basket_id","{{ ref('normalized_baskets') }} (id)"),
        set_foreign_key("nbi_id_fk","item_id","{{ ref('normalized_basket_items') }} (id)"),
        set_foreign_key("nt_id_fk","track_id","{{ref('normalized_tracks')}} (id)"),
        set_foreign_key("nac_id_fk","artist_id, user_id","{{ref('normalized_artists_comp')}} (artist_id, user_id)")
        ]
    )
}}


select
b.id as basket_id,
bi.id as item_id,
b.created::timestamp,
    bi.itemtype as item_type,
    bi.quantity::integer,
    bi.priceatpurchase as price_at_purchase,
    bi.refundreason as refund_reason,
    bi.license as license_id,
    bi.licensename as license_name,
    {{ dollars_to_cents("bi.priceataddition") }} as price_at_addition,
    b.payment_transaction_id,
    bi.track as track_id,
    t.is_exclusive as exclusive_track,
    ac.artist_id,
    ac.user_id,
    bi.gatewayrefundid as gateway_refund_id,
    bi._airbyte_emitted_at,
    bi._airbyte_ab_id,
    bi._airbyte_basketitems_hashid
from {{ref('normalized_baskets')}} b
inner join {{ref('normalized_basket_items')}} bi  using (_airbyte_baskets_hashid)
left join {{ref('normalized_tracks')}} t on t.id = bi.track
left join {{ref('normalized_artists_comp')}} ac on ac.artist_id = t.artist










