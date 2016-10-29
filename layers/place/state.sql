CREATE OR REPLACE FUNCTION layer_state(bbox geometry, zoom_level int)
RETURNS TABLE(osm_id bigint, geometry geometry, name text, name_en text, "rank" int) AS $$
    SELECT osm_id, geometry, name, name_en, "rank"
    FROM osm_state_point
    WHERE geometry && bbox AND
          ("rank" + 2 <= zoom_level) AND (
              zoom_level >= 5 OR
              is_in_country IN ('United Kingdom', 'USA', 'Россия', 'Brasil', 'China', 'India') OR
              is_in_country_code IN ('AU', 'CN', 'IN', 'BR', 'US'))
    ORDER BY "rank" ASC;
$$ LANGUAGE SQL IMMUTABLE;
