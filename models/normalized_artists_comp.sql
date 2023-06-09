-- COMPOSITION TABLE TO RELATE MANY ARTISTS TO 1 USER


{{
    config(
        post_hook=[set_primary_key("nac_id_pk", "artist_id,user_id"),
        set_foreign_key("na_id_fk","artist_id","{{ ref('normalized_artists') }} (id)"),
        set_foreign_key("nu_id_fk","user_id","{{ ref('normalized_users') }} (id)"),
        ]
    )
}}



select u.id as user_id, a.id as artist_id, a.name as artist_name, u.name as user_name, u.email as email, u.subscription_name as sub_name from {{ref('normalized_users')}} as u cross join lateral jsonb_array_elements(u.artists) as artist
join {{ref('normalized_artists')}} as a on a.id = artist::bigint