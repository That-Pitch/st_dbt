{{
    config(
        materialized="incremental",
        unique_key="id",
       
    )
}}


select
    id::bigint,
    name,
    created::timestamp,
    artists,  -- 1 user can be associated with multiple artists but all share the same subscription.
    email,
    role,
    lastmodified::timestamp as last_modified,
    (activesubscriptions[0] ->> 'id')::bigint as subscription_id,
    (activesubscriptions[0] ->> 'name')::varchar as subscription_name,
    (activesubscriptions[0] -> 'artistCollectionTitles') as subscription_collections,
    case
        when (activesubscriptions[0] ->> 'name')::varchar like '%Pro%'
        then true
        else false
    end as is_pro_membership,
    _airbyte_emitted_at,
    _airbyte_ab_id,
    _airbyte_users_hashid
from {{ source("raw_synchtank", "users") }}


{% if is_incremental() %}

    -- this filter will only be applied on an incremental run
    -- (uses > to include records whose timestamp occurred since the last run of this
    -- model)
    where lastmodified::timestamp >= (select max(last_modified) from {{ this }}) and email not like '%@synchtank.net'

{% endif %}
order by created desc
{# where email not like '%@synchtank.net' #}
 {# post_hook=[set_primary_key("nu_id_pk", "id")], #}