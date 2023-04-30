{{
    config(
        pre_hook="alter table {{ this }} drop constraint if exists id_pk",
        post_hook=[
            " alter table {{ this }} add constraint id_pk primary key (id)","alter table add constraint user_id_fk foreign key user_id references normalized_users (id)"
        ],
    )
}}

select
    p.id,
    p.created,
    p.amount,
    p.user as user_id,
    u.name as buyer_name,
    b.basketitems as basket_items
from {{ source("raw_synchtank", "purchases") }} as p
left join {{ source("raw_synchtank", "users") }} as u on p.user = u.id
left join {{ source("raw_synchtank", "baskets") }} as b on b.purchase = p.id
order by p.created desc
