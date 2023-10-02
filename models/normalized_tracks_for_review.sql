{{
    config(
        post_hook=[set_primary_key("ntfr_id_pk","id"),

    ]
    )
}}

select 
_accessgranted,
_airbyte_ab_id,
_airbyte_emitted_at,
_airbyte_normalized_at,
_airbyte_reviewtracks_hashid,
album,
artist,
artistname,
artistnames,
audiomp3,
catalognumber,
category,
clearedprocessstatus,
collectionname,
collectiontype,
created,
createdby,
createdbyname,
currentreviewstatus,
drafts,
featured,
fileformats,
grouping,
hash,
id::bigint,
isrc,
iswc,
jpgimage,
metadata,
metadatatitles,
performedby,
previousreviewstatus,
releasedate,
restrictedaccessrequired,
reviewedbyname,
reviewrels,
submittedforreview,
submittedforreviewby,
submittedforreviewbyname,
subtype,
title,
titlewithfeaturedartists,
trackartistnames,
type,
version






from {{source('raw_synchtank','reviewtracks')}}

