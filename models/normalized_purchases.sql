
{{
    config(
        post_hook=[after_commit("
            alter table {{ this }} drop constraint if exists np_id_pk cascade"),
                after_commit("alter table {{ this }} add constraint np_id_pk primary key (id)"),
            after_commit("alter table {{this}} add constraint user_id_fk foreign key (user_id) references {{ref('normalized_users')}} (id)"),
            after_commit("alter table {{this}} add constraint track_id_fk foreign key (track_id) references {{ref('normalized_tracks')}} (id)")]
    )
}}

select
    p.id,
    p.created::timestamp,
    p.amount,
    p.user as user_id,
    u.name as buyer_name,
    b.basketitems as basket_items,
    (b.basketitems[0]->>'track')::bigint as track_id
from {{ source("raw_synchtank", "purchases") }} as p
left join {{ source("raw_synchtank", "users") }} as u on p.user = u.id
left join {{ source("raw_synchtank", "baskets") }} as b on b.purchase = p.id
order by p.created desc

