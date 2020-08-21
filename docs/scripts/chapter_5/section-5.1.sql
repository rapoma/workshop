\o section-5.1-1.txt

SELECT osm_id, id FROM ways_vertices_pgr
WHERE osm_id IN (123392877, 255093299, 1886700005, 6159253045, 6498351588)
ORDER BY osm_id;

\o section-5.1.1.txt

SELECT * FROM pgr_dijkstra(
    '
      SELECT gid AS id,
        source,
        target,
        length AS cost
      FROM ways
    ',
 @ID_1@,
 @ID_3@,
    directed := false);

\o section-5.1.2.txt

SELECT * FROM pgr_dijkstra(
    '
      SELECT gid AS id,
        source,
        target,
        length_m AS cost
      FROM ways
    ',
ARRAY[@ID_1@,@ID_2@],
@ID_3@,
directed := false);

\o section-5.1.3.txt

SELECT * FROM pgr_dijkstra(
    '
      SELECT gid AS id,
        source,
        target,
        length_m / 1.3 AS cost
      FROM ways
    ',
@ID_3@,
ARRAY[@ID_1@,@ID_2@],
directed := false);

\o section-5.1.4.txt

SELECT * FROM pgr_dijkstra(
    '
      SELECT gid AS id,
       source,
       target,
       length_m / 1.3 / 60 AS cost
      FROM ways
    ',
ARRAY[@ID_1@, @ID_2@],
ARRAY[@ID_4@, @ID_5@],
directed := false);

\o section-5.2.1.txt

SELECT *
FROM pgr_dijkstraCost(
    '
      SELECT gid AS id,
       source,
       target,
       length_m  / 1.3 / 60 AS cost
      FROM ways
    ',
ARRAY[@ID_1@, @ID_2@],
ARRAY[@ID_4@, @ID_5@],
directed := false);

\o section-5.2.2.txt

SELECT start_vid, sum(agg_cost)
FROM pgr_dijkstraCost(
    '
      SELECT gid AS id,
        source,
        target,
        length_m  / 1.3 / 60 AS cost
      FROM ways
    ',
    ARRAY[@ID_1@, @ID_2@],
    ARRAY[@ID_4@, @ID_5@],
    directed := false)
GROUP BY start_vid
ORDER BY start_vid;