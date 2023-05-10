{{
    config(
        post_hook=[set_primary_key("nbi_id_pk", "id")
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
    license     ,
    licenseterritory        ,
    currency                ,
    id                      ,
    track                   ,
    trackdetail             ,
    gatewayrefundid         ,
    _airbyte_ab_id          ,
    _airbyte_emitted_at     ,
    _airbyte_normalized_at  ,
    _airbyte_basketitems_hashid
from {{ source("raw_synchtank", "baskets_basketitems") }}

