{{
    config(
        post_hook=[
            set_primary_key("nalfr_id_pk", "id"),
        ]
    )
}}


select
createdbyname,
currentreviewstatus,
featured,
metadata,
submittedforreview,
reviewrels,
submittedforreviewby,
jpgimage,
title,
originallypublished,
artistnames,
submittedforreviewbyname,
publishedenddate,
metadatatitles,
previousreviewstatus,
reviewed,
id::bigint,
categories,
_accessgranted,
titlewithfeaturedartistsandversion,
publishedstartdate,
created,
format,
drafts,
reviewedby,
customalbumid,
createdby,
reviewedbyname,
hash,
_airbyte_ab_id,
_airbyte_emitted_at,
_airbyte_normalized_at,
_airbyte_reviewalbums_hashid

from {{ source("raw_synchtank", "reviewalbums") }}
