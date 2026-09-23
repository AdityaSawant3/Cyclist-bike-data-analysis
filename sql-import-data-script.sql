CREATE TABLE tripdata_2026_07 (
    ride_id VARCHAR(40) PRIMARY KEY,
    rideable_type VARCHAR(20),
    started_at TIMESTAMP,
    ended_at TIMESTAMP,
    ride_length INTERVAL,
    day_of_week INTEGER,
    start_station_name VARCHAR(100),
    start_station_id VARCHAR(20),
    end_station_name VARCHAR(100),
    end_station_id VARCHAR(20),
    start_lat DOUBLE PRECISION,
    start_lng DOUBLE PRECISION,
    end_lat DOUBLE PRECISION,
    end_lng DOUBLE PRECISION,
    member_casual VARCHAR(20)
);

-- check that is it imported
SELECT * FROM tripdata_2026_07
LIMIT 10;

-- check duplicate values are present or not.
SELECT
	ride_id,
	COUNT(*)
FROM
	tripdata_2026_07
GROUP BY ride_id
HAVING COUNT(*) > 1;

-- If need to drop so some reason.
DROP TABLE tripdata_2026_07;



-- In plsql tool run this

SET datestyle = 'ISO, DMY';
-- and then run this for every new table.

COPY tripdata_2025_08
FROM '/path/to/tripdata_2025_08.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ','
); -- in single line.
