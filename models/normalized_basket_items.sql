{{
    config(
        post_hook=[
            after_commit(
                "alter table {{ this }} drop constraint if exists nbi_id_pk cascade"
            ),
            after_commit(
                "alter table {{ this }} add constraint nbi_id_pk primary key (id)"
            ),
            after_commit(
                "alter table {{this}} add constraint license_id_fk foreign key (license_id) references {{ref('normalized_licenses')}} (id)"
            ),
            after_commit("alter table {{this}} add constraint track_id_fk foreign key (track_id) references {{ref('normalized_tracks')}} (id)")
        ]
    )
}}

-- Select all basket items from baskets table which will return a row for every basket item with its corresponding basket id
-- this is then used as a join on basket_items
with baskets as (select b.id as basket_id, b.created,(jsonb_array_elements(b.basketitems) ->> 'id')::bigint as basket_item_id
                 from {{ source("raw_synchtank", "baskets") }} b),
    licenses as (select l.id, l.collections,l.exclusive from {{ source("raw_synchtank", "licenses") }} l)
select
    bi.id, b.basket_id as basket_id,b.created::timestamp, bi.itemtype as item_type, bi.quantity, bi.priceatpurchase as price_at_purchase, bi.refundreason as refund_reason,
    bi.licensename as license_name, {{dollars_to_cents('bi.priceataddition')}} as price_at_addition,
    bi.license as license_id, bi.track as track_id, bi.gatewayrefundid as gateway_refund_id,
               _airbyte_emitted_at,
       _airbyte_ab_id,
       _airbyte_basketitems_hashid
from {{ source("raw_synchtank", "baskets_basketitems") }} bi
inner join baskets as b on b.basket_item_id = bi.id
right join licenses as l on l.id = bi.license




