-- previous year table
CREATE TABLE tripdata_previous_one_year (
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