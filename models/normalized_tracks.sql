{{
    config(
        post_hook=[set_primary_key("nt_id_pk","id")
    ]
    )
}}

select t.id,
       t.created::timestamp,
       t.lastmodified::timestamp as last_modified,
       t.published::timestamp,
       t.title,
       t.duration,
       t.isrc,
       t.artist,
       t.originallypublished::timestamp as originally_published,
       t.customtrackid,
       t.files[0]->>'url' as file_url,
       t.files[0]->>'originalFilename' as filename,
       t.metadata->'genres' as genres,
       (t.metadata->'genreNames') as genre_names,
       t.licenses,
       t.collections[0]::bigint,
       nc.is_exclusive,
       t.album,
       t.releasedate,
       t.albumupc,
       t.iscomposition,
       t.composition,
       t.composer,
       t.compositiontitle,
       t.compositionyear,
       t.compositionproduct,
       t.compositionproductiontracks,
       t.compositionpublishers,
       t.compositionwriters,
       t._airbyte_ab_id,
       t._airbyte_tracks_hashid,
       t._airbyte_emitted_at
from {{ source("raw_synchtank", "tracks") }} as t
left join {{ref('normalized_collections')}} as nc on nc.id = t.collections[0]::bigint
order by created desc