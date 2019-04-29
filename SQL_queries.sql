-- QUERY 1
-- What is the most common factor in a motor vehicle collision in NYC? 
-- This query counts the number of collisions for each collision type, in descending order.

SELECT
  contributing_factor_vehicle_1 AS collision_factor,
  COUNT(*) num_collisions
FROM
  `bigquery-public-data.new_york.nypd_mv_collisions`
WHERE
  contributing_factor_vehicle_1 != "Unspecified"
  AND contributing_factor_vehicle_1 != ""
GROUP BY
  1
ORDER BY
  num_collisions DESC

-- QUERY 2
-- What are the most dangerous streets for motor vehicle collisions in NYC? 
-- This query counts the number of fatalities by streets. 
#standardSQL
SELECT
  on_street_name,
  SUM(number_of_persons_killed) AS deaths
FROM
  `bigquery-public-data.new_york.nypd_mv_collisions`
WHERE
  on_street_name <> ''
GROUP BY
  on_street_name
ORDER BY
  deaths DESC
LIMIT
  10

-- QUERY 3
-- What are the most dangerous streets for motor vehicle collisions in NYC's Brooklyn? 
-- This query counts the number of fatalities by streets. 
#standardSQL
SELECT
  on_street_name,
  SUM(number_of_persons_killed) AS deaths
FROM
  `bigquery-public-data.new_york.nypd_mv_collisions`
WHERE
  on_street_name <> ''
  AND borough LIKE "BROOKLYN"
GROUP BY
  on_street_name
ORDER BY
  deaths DESC
LIMIT
  10


-- QUERY 4
-- What is the most common factor in a motor vehicle collision in NYC's Brooklyn? and what other details can we garner from Brooklyn incidents when looking at primary collision factors? 
-- This query counts the number of fatalities by streets. 

#standardSQL
SELECT
  unique_key, 
  borough,
  timestamp,
  location,
  zip_code,
  latitude,
  longitude,
  contributing_factor_vehicle_1 AS collision_factor,
  number_of_cyclist_injured,
  number_of_cyclist_killed,
  number_of_motorist_injured,
  number_of_motorist_killed,
  number_of_pedestrians_injured,
  number_of_pedestrians_killed,
  number_of_persons_injured,
  number_of_persons_killed
FROM
  `bigquery-public-data.new_york.nypd_mv_collisions`
WHERE
  borough LIKE "BROOKLYN"
  AND borough IS NOT NULL

