{{config(post_hook='alter table public_normalized.normalized_tracks add primary key (id)')}}


select id,
       created,
       lastmodified,
       published,
       title,
       duration,
       isrc,
       artist,
       originallypublished,
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