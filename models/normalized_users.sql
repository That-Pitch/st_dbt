{{config(post_hook='alter table public_normalized.normalized_users add primary key (id)')}}





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