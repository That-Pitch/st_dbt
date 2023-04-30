{{
    config(
        post_hook=[after_commit("alter table {{ this }} drop constraint if exists nt_id_pk cascade"),after_commit("alter table {{ this }} add constraint nt_id_pk primary key (id)")]
    )
}}

select id,
       created::timestamp,
       lastmodified::timestamp as last_modified,
       published::timestamp,
       title,
       duration,
       isrc,
       artist,
       originallypublished::timestamp as originally_published,
       customtrackid,
       files[0]->>'url' as file_url,
       files[0]->>'originalFilename' as filename,

       metadata->'genres' as genres,
       (metadata->'genreNames') as genre_names,
       licenses,
       collections,
       album,
       releasedate,
       albumupc,
       iscomposition,
       composition,
       composer,
       compositiontitle,
       compositionyear,
       compositionproduct,
       compositionproductiontracks,
       compositionpublishers,
       compositionwriters,
       _airbyte_ab_id,
       _airbyte_tracks_hashid,
       _airbyte_emitted_at
from tracks
order by created desc