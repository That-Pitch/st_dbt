{{
    config(
        post_hook=[
            set_primary_key("job_payments_pk", "id"),
            set_foreign_key(
                "nu_id_fk", "user_id", "{{ ref('normalized_users') }} (id)"
            ),
            set_foreign_key(
                "na_id_fk", "artist_id", "{{ ref('normalized_artists') }} (id)"
            ),
            set_foreign_key(
                "nt_id_fk", "track_id", "{{ ref('normalized_tracks') }} (id)"
            ),
            set_foreign_key(
                "np_id_fk", "purchase_id", "{{ ref('normalized_purchases') }} (id)"
            ),
            set_foreign_key(
                "nl_id_fk", "license_id", "{{ ref('normalized_licenses') }} (id)"
            ),
            set_foreign_key(
                "jt_id_fk", "job_id", "{{ source('jobs','job_tracker') }} (id)"
            ),
            "CREATE SEQUENCE if not exists payments_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807START 1 CACHE 1; ALTER TABLE {{this}} ALTER COLUMN id SET DEFAULT nextval('payments_seq');",
        ]
    )
}}


select *
from {{ source("jobs", "job_payments") }}
