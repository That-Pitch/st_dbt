{{
    config(
        post_hook=[
            set_primary_key("job_payments_pk", "id"),
            set_foreign_key("nu_id_fk", "user_id", "{{ ref('normalized_users') }} (id)"),
            set_foreign_key("na_id_fk", "artist_id", "{{ ref('normalized_artists') }} (id)"),
            set_foreign_key("nt_id_fk", "track_id", "{{ ref('normalized_tracks') }} (id)"),
            set_foreign_key("np_id_fk", "purchase_id", "{{ ref('normalized_purchases') }} (id)"),
                        set_foreign_key("nl_id_fk", "license_id", "{{ ref('normalized_licenses') }} (id)"),

        ]
    )
}}


select *
from {{ source("jobs", "job_payments") }}
