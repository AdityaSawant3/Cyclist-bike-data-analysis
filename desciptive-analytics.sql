-- Descriptive analytics

-- Total rides by rideable type and member type
SELECT 
	member_casual,
	COUNT(CASE WHEN rideable_type = 'classic_bike' THEN 1 END) AS classic_bike,
	COUNT(CASE WHEN rideable_type = 'electric_bike' THEN 1 END) AS electric_bike
FROM tripdata_previous_one_year
GROUP BY member_casual
-- Note - Annual members are almost double than casual members.

-- Busiest station. 
SELECT
	start_station_name,
	end_station_name,
	COUNT(*) AS total_rides
FROM tripdata_previous_one_year
WHERE start_station_name IS NOT NULL AND end_station_name IS NOT NULL
GROUP BY start_station_name, end_station_name
ORDER BY total_rides DESC;
-- Note: There are multiple null values that's why I excluded it.

-- Monthly rides
SELECT
	TO_CHAR(started_at, 'Month') AS month_name,
	COUNT(ride_id) AS total_rides
FROM tripdata_previous_one_year
GROUP BY month_name
ORDER BY total_rides DESC;
-- Note: Busiest months are June, July, August, Spetember.

-- Total Rides per month per day of week.
-- Note: 1 = Sunday, 2 = Monday and so on.
SELECT
	TO_CHAR(started_at, 'Month') AS month,
	day_of_week,
	COUNT(*) AS total_rides
FROM tripdata_previous_one_year
GROUP BY month, day_of_week
ORDER BY total_rides DESC;

-- Total rides per types of members by month.
SELECT
	TO_CHAR(started_at, 'Month') AS month,
	COUNT(CASE WHEN member_casual = 'casual' THEN 1 END) AS casual_member,
	COUNT(CASE WHEN member_casual = 'member' THEN 1 END) AS permenant_member,
	COUNT(*) AS total_rides
FROM tripdata_previous_one_year
GROUP BY EXTRACT(MONTH FROM started_at), month
ORDER BY EXTRACT(MONTH FROM started_at);
-- Note: Anual members are more than casual riders per month.

-- Average ride duration.
SELECT
	member_casual,
	AVG(ride_length) AS most_frequent_ride_length
FROM tripdata_previous_one_year
GROUP BY member_casual
ORDER BY most_frequent_ride_length DESC;

-- Mode of week days.
-- Note: 1 = Sunday, 2 = Monday...
SELECT
	MODE() WITHIN GROUP (ORDER BY day_of_week)
FROM tripdata_previous_one_year

-- Total rides by rideable type of bikes by each members.
SELECT
	member_casual,
	CASE WHEN 
	COUNT(*) AS total_members
FROM tripdata_previous_one_year
GROUP BY member_casual
ORDER BY most_frequent_ride_length DESC;

-- Now, it's time for a visualization.