{{
    config(
        post_hook=[set_primary_key("nc_id_pk","id")


        ]
    )
}}




select id,
 name,description,
       _airbyte_emitted_at,
       _airbyte_ab_id,
       _airbyte_collections_hashid
from {{ source("raw_synchtank", "collections") }} as p