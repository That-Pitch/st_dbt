{{
    config(
        post_hook=[set_primary_key("nc_id_pk","id")


        ]
    )
}}



select id::bigint,
       name,
       description,
       case when name like '%(Non-Exclusive)%' then false else true end as is_exclusive,
       _airbyte_emitted_at,
       _airbyte_ab_id,
       _airbyte_collections_hashid
from {{ source("raw_synchtank", "collections") }} as p