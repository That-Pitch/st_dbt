{{
    config(
        post_hook=[after_commit("alter table {{ this }} drop constraint if exists nu_id_pk cascade"),after_commit("alter table {{ this }} add constraint nu_id_pk primary key (id)")]
    )
}}




select id,
       name,
       created,
       artists[0] as artist_id,
       email,
       lastmodified,
       activesubscriptions[0],
       _airbyte_emitted_at,
       _airbyte_ab_id,
       _airbyte_users_hashid
from users
order by created desc