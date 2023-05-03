{{
    config(
        post_hook=[after_commit("alter table {{ this }} drop constraint if exists nb_id_pk cascade"),after_commit("alter table {{ this }} add constraint nb_id_pk primary key (id)")

        ]
    )
}}

select
    id,
    {{dollars_to_cents('totalprice')}} as total_amount_in_cents,
    basketitems as basket_items,
    created::timestamp,
               _airbyte_emitted_at,
       _airbyte_ab_id,
       _airbyte_baskets_hashid



from {{ source("raw_synchtank", "baskets") }}


