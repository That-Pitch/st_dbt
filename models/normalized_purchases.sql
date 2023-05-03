{{
    config(
        post_hook=[
            after_commit(
                "alter table {{ this }} drop constraint if exists np_id_pk cascade"
            ),
            after_commit(
                "alter table {{ this }} add constraint np_id_pk primary key (id)"
            ),
            after_commit(
                "alter table {{this}} add constraint user_id_fk foreign key (user_id) references {{ref('normalized_users')}} (id)"
            ),
            after_commit(
                "alter table {{this}} add constraint basket_id_fk foreign key (basket_id) references {{ref('normalized_baskets')}} (id)"
            ),
        ]
    )
}}

select
    p.id,
    p.created::timestamp,
    p.user as user_id,
    p.basket as basket_id,
           _airbyte_emitted_at,
       _airbyte_ab_id,
       _airbyte_purchases_hashid

from {{ source("raw_synchtank", "purchases") }} as p
