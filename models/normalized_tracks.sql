{{
    config(
        post_hook=[
            set_primary_key("nt_id_pk", "id"),
            set_foreign_key(
                "na_id_fk", "artist", "{{ ref('normalized_artists') }} (id)"
            ),
        ]
    )
}}

select
    t.id,
    t.created::timestamp,
    t.lastmodified::timestamp as last_modified,
    t.title,
    t.duration,
    t.isrc,
    t.clearedprocessstatus,
    t.artist::bigint,
                t.published::timestamp as published,
    t.originallypublished::timestamp as originally_published,
    t.customtrackid,
    t.metadata -> 'genres' as genres,
    array(select jsonb_array_elements_text(t.metadata -> 'genreNames')) as genre_names,
    t.licenses,
    t.collections[0]::bigint,
    t.audiomp3::json,
    nc.is_exclusive,
    t.youtubeassetids,
    t.album,
    t.iswc,
    t.publishername,
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
left join {{ ref("normalized_collections") }} as nc on nc.id = t.collections[0]::bigint
where t.collections[0] is not null
order by created desc
