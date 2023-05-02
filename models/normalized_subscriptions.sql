{{
    config(
        post_hook=[after_commit("alter table {{ this }} drop constraint if exists ns_id_pk cascade"),after_commit("alter table {{ this }} add constraint ns_id_pk primary key (id)")]
    )
}}




select id,
       name,
       created::timestamp,
       paymentgatewayplanid as payment_gateway_plan_id,
       artistcollectiontitles as collection_titles,
       licenses as license_ids,
       _airbyte_emitted_at,
       _airbyte_ab_id,
       _airbyte_users_hashid
from users_activesubscriptions
order by created desc