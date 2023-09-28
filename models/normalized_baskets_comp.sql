{{
    config(
        post_hook=[set_primary_key("nbc_id_pk", "basket_id,item_id"),
        set_foreign_key("nb_id_fk","basket_id","{{ ref('normalized_baskets') }} (id)"),
        set_foreign_key("nbi_id_fk","item_id","{{ ref('normalized_basket_items') }} (id)"),
        set_foreign_key("nt_id_fk","track_id","{{ref('normalized_tracks')}} (id)"),
        set_foreign_key("np_id_fk","purchase_id","{{ref('normalized_purchases')}} (id)"),
        set_foreign_key("nac_id_fk","artist_id, user_id","{{ref('normalized_artists_comp')}} (artist_id, user_id)")
        ]
    )
}}


select
b.id::bigint as basket_id,
bi.id::bigint as item_id,
b.created::timestamp,
p.created::date as purchased,
p.id as purchase_id,
    bi.itemtype as item_type,
    bi.quantity::integer,
    bi.license::bigint as license_id,
    bi.licensename as license_name,
    hc.form_id as helloworks_form_id,
    {{ dollars_to_cents("bi.priceataddition") }} as price_at_addition,
    {{ dollars_to_cents("bi.priceataddition") }} * bi.quantity::integer as total_price,
    b.payment_transaction_id,
    nc.id as charge_id,
    nc.refunded as is_refunded,
    nc.description as charge_description,
    bi.track::bigint as track_id,
    t.is_exclusive as exclusive_track,
    ac.artist_id,
    ac.user_id,
    bi._airbyte_emitted_at,
    bi._airbyte_ab_id,
    bi._airbyte_basketitems_hashid
from {{ref('normalized_baskets')}} b
inner join {{ref('normalized_basket_items')}} bi  using (_airbyte_baskets_hashid)
inner join {{ref('normalized_purchases')}} p on p.basket_id = b.id
left join {{ref('normalized_tracks')}} t on t.id = bi.track
left join {{ref('normalized_artists_comp')}} ac on ac.artist_id = t.artist
left join {{ref('normalized_charges')}} nc on nc.payment_intent = b.payment_transaction_id
left join {{ source("jobs", "job_helloworks_contracts") }} hc on hc.license_id = bi.license
where t.is_exclusive is not null and  bi.license is not null
order by created desc









