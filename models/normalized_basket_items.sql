{{
    config(
        post_hook=[set_primary_key("nbi_id_pk", "id"),
        set_foreign_key("nbi_licenseid_fk","license","{{ref('normalized_licenses')}} (id)")


        ]
    )
}}





select
    _airbyte_baskets_hashid,
    licenseprice,
    itemtype     ,
    licensecustomdetails,
    quantity             ,
    priceatpurchase       ,
    refundreason           ,
    licenseterm             ,
    licensename             ,
    priceataddition         ,
    licenseterritory        ,
    currency,
    license::bigint,
    id                    ,
    track                   ,
    trackdetail             ,
    gatewayrefundid         ,
    _airbyte_ab_id          ,
    _airbyte_emitted_at     ,
    _airbyte_normalized_at  ,
    _airbyte_basketitems_hashid
from {{ source("raw_synchtank", "baskets_basketitems") }}
        where licensename != '' and license::bigint in (select id from {{ ref("normalized_licenses") }})

