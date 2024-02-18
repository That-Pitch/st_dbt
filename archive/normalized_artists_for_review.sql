{{
    config(
        post_hook=[
            set_primary_key("nafr_id_pk", "id"),
        ]
    )
}}

select
_accessgranted,
_airbyte_ab_id,
_airbyte_emitted_at,
_airbyte_normalized_at,
_airbyte_reviewartists_hashid,
created,
createdby,
createdbyname,
currentreviewstatus,
drafts,
hash,
id::bigint,
metadata,
metadatatitles,
previousreviewstatus,
reviewed,
reviewedby,
reviewedbyname,
reviewrels,
submittedforreview,
submittedforreviewby,
submittedforreviewbyname


from
    {{ source("raw_synchtank", "reviewartists") }}
