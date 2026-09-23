# Cyclistic Bike-Share Analysis
# Project Overview
This project analyzes Cyclistic bike-share trip data for 2025-2026 to understand how annual members and casual riders use Cyclistic bikes differently.
The project follows the Ask → Prepare → Process → Analyze → Share → Act data analysis framework.
The primary business question is:
How do annual members and casual riders use Cyclistic bikes differently?
The analysis was performed using PostgreSQL and SQL for data preparation and analysis, with Microsoft Power BI used to create interactive dashboards and visualizations.
________________________________________
# Business Problem
Cyclistic is a fictional bike-share company operating in Chicago.
The company offers several pricing options:
•	Single-ride passes
•	Full-day passes
•	Annual memberships
Customers using single-ride or full-day passes are classified as casual riders, while customers with annual memberships are classified as members.
Cyclistic's finance team has determined that annual members are more profitable than casual riders. Therefore, the marketing team wants to understand rider behavior and identify opportunities to increase annual memberships.
The analysis focuses on understanding the behavioral differences between existing members and casual riders.
________________________________________
# Business Question
The main question addressed in this project is:
How do annual members and casual riders use Cyclistic bikes differently?
The analysis compares the two rider groups across:
•	Ride volume
•	Ride duration
•	Day of week
•	Monthly trends
•	Time of day
•	Bike type
•	Starting stations
•	Ending stations
________________________________________
# Dataset
The project uses Cyclistic bike-share trip data covering June-May 2025-2026.
Each row represents an individual bike ride.
Main Variables
Column	Description
ride_id	Unique identifier for each ride
rideable_type	Type of bicycle used
started_at	Date and time when the ride started
ended_at	Date and time when the ride ended
ride_length	Duration of the ride
day_of_week	Day on which the ride started
start_station_name	Starting station
start_station_id	Starting station ID
end_station_name	Ending station
end_station_id	Ending station ID
start_lat	Starting latitude
start_lng	Starting longitude
end_lat	Ending latitude
end_lng	Ending longitude
member_casual	Rider category: member or casual
________________________________________
# Tools & Technologies
Tool	Purpose
PostgreSQL	Database management and data processing
SQL	Data cleaning, validation, transformation, and analysis
Microsoft Power BI	Data visualization and dashboard development
CSV	Source data format
GitHub	Project documentation and version control
________________________________________
# Data Analysis Process
The project follows the six-step data analysis process.
1. Ask
The business question was defined as:
How do annual members and casual riders use Cyclistic bikes differently?
The objective was to identify measurable differences in rider behavior and use those findings to support Cyclistic's membership growth strategy.
________________________________________
2. Prepare
The 2025-2026 trip data was provided as separate monthly CSV datasets.
Each monthly dataset was imported into PostgreSQL and stored in a separate table.
The database structure was designed according to the characteristics of each field.
Example:
CREATE TABLE tripdata_2025-2026_11 (
    ride_id TEXT PRIMARY KEY,
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
________________________________________
3. Process
Data Import
The CSV files were imported into PostgreSQL using the \COPY command.
Example:
\COPY tripdata_2025-2026_11
FROM 'Your file path'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ','
);
________________________________________
# Date and Time Preparation
The source data contained timestamps in the format:
28-08-2025-2026 15:56:47
representing:
DD-MM-YYYY HH:MM:SS
PostgreSQL was configured to interpret the dates correctly when required:
SET datestyle = 'ISO, DMY';
The timestamp columns were stored using the TIMESTAMP data type.
________________________________________
Ride Duration
Ride duration was stored using PostgreSQL's INTERVAL data type.
For example:
00:22:15
represents a ride lasting 22 minutes and 15 seconds.
This allowed ride durations to be compared between members and casual riders.
________________________________________
Ride ID Validation
Some ride IDs appeared in scientific notation in the source data.
Examples included:
8.58E+15
3.20E+15
5.63E+15
Ride IDs were therefore treated as identifiers rather than numerical measurements.
The ride_id column was stored as:
ride_id TEXT PRIMARY KEY
________________________________________
Duplicate Detection
Duplicate ride IDs were identified using:
SELECT ride_id, COUNT(*)
FROM tripdata_2025-2026_11
GROUP BY ride_id
HAVING COUNT(*) > 1;
Potential duplicates were investigated before any records were removed.
________________________________________
Missing-Value Checks
Important fields were checked for missing values, including:
•	started_at
•	ended_at
•	ride_length
•	member_casual
•	start_station_name
•	end_station_name
•	Latitude and longitude fields
Example:
SELECT COUNT(*)
FROM tripdata_2025-2026_11
WHERE started_at IS NULL;
________________________________________
Ride Duration Validation
Potentially invalid ride durations were checked using:
SELECT *
FROM tripdata_2025-2026_11
WHERE ride_length <= INTERVAL '0 seconds';
Extremely long rides were also investigated:
SELECT *
FROM tripdata_2025-2026_11
WHERE ride_length > INTERVAL '24 hours';
________________________________________
Combining Monthly Data
After cleaning and validating the individual monthly datasets, the data was combined into an annual dataset.
Example:
CREATE TABLE tripdata_2025-2026 AS

SELECT * FROM tripdata_2025-2026_01
UNION ALL
SELECT * FROM tripdata_2025-2026_02
UNION ALL
SELECT * FROM tripdata_2025-2026_03;
The remaining monthly tables were added using the same approach.
________________________________________
4. Analyze
The cleaned annual dataset was analyzed to identify differences between members and casual riders.
The analysis examined:
•	Total rides
•	Average ride duration
•	Median ride duration
•	Day-of-week patterns
•	Monthly riding trends
•	Time-of-day patterns
•	Bike-type usage
•	Popular starting stations
•	Popular ending stations
SQL aggregation and filtering were used to generate the metrics required for the analysis.
________________________________________
5. Share — Power BI Dashboard
Microsoft Power BI was used to transform the analytical results into interactive visualizations.
The Power BI dashboard provides a visual comparison between members and casual riders.
Dashboard Analysis
The dashboard examines:
•	Total number of rides by rider type
•	Ride distribution between members and casual riders
•	Average ride duration
•	Ride activity by day of week
•	Monthly ride trends
•	Ride activity by time of day
•	Bike-type preferences
The dashboard makes it easier to identify differences in behavior that may not be immediately visible from raw SQL results.
________________________________________
# Key Findings
The Power BI analysis showed that members account for a larger share of overall ride activity than casual riders in the analyzed 2025-2026 dataset.
This indicates that members are an important and highly active customer segment for Cyclistic.
Member Usage
The analysis showed stronger overall ride activity among members. Member riding behavior was examined across weekdays, weekends, months, and time of day to identify recurring patterns.
Casual Rider Usage
Casual riders represented a smaller share of total ride activity in the analyzed dataset. Their usage patterns were compared against members to identify differences in frequency, duration, timing, and locations.
Ride Duration
Ride duration was compared between the two rider groups using aggregate statistics. Both average and median duration were considered to reduce the influence of unusually long rides.
Weekly Riding Patterns
The Power BI visualizations revealed differences in riding activity across the days of the week.
Comparing weekday and weekend activity helped identify whether usage patterns differed between members and casual riders.
Monthly Trends
Monthly ride activity was analyzed across the full 2025-2026 period to identify changes in usage throughout the year.
Bike Usage
Different bicycle types were compared between the two rider groups to identify potential differences in bike preferences.
________________________________________
# Business Insights
The analysis provides several insights that can support Cyclistic's marketing strategy.
1. Members Are Highly Active Users
Members account for a substantial portion of total riding activity in the analyzed dataset.
This demonstrates the importance of retaining existing members while also identifying casual riders with frequent usage patterns.
2. Rider Behavior Differs by Time
Differences in riding patterns across weekdays, weekends, and different times of day provide useful information for customer segmentation.
3. Data Can Support Membership Conversion
Rather than using the same marketing message for every casual rider, Cyclistic can use behavioral information to identify casual riders whose usage patterns resemble frequent or regular riders.
________________________________________
# Recommendations
Based on the analysis, Cyclistic can consider the following strategies:
1. Target High-Frequency Casual Riders
Identify casual riders with relatively frequent usage and promote the value of an annual membership.
2. Use Behavioral Segmentation
Create different marketing segments based on:
•	Ride duration
•	Weekday/weekend usage
3. Use Digital Marketing
Use channels such as:
•	Email marketing
•	Mobile app notifications
•	Social media
•	Digital advertising
to reach casual riders with targeted membership messages.
4. Time Campaigns Around Usage Patterns
Marketing campaigns can be aligned with periods when casual riding activity is high.
5. Communicate Membership Value
Membership campaigns should clearly explain the benefits and value of switching from casual passes to an annual membership.
________________________________________
# Power BI Dashboard
The project includes an interactive Power BI dashboard designed to communicate the analysis clearly.
Dashboard focus:
Member vs. Casual Rider Behavior
The dashboard allows the user to explore the differences across multiple dimensions and provides a visual summary of the SQL-based analysis.
Power BI was used exclusively for visualization and dashboard presentation, while PostgreSQL and SQL were used for data preparation and analytical processing.
________________________________________
# Project Outcome
This project demonstrates an end-to-end data analytics workflow:
Business Problem → Data Preparation → SQL Cleaning → Data Validation → Analysis → Power BI Visualization → Business Insights
The project combines technical data skills with business-focused analysis to understand Cyclistic customer behavior.
Technical Skills Demonstrated
•	PostgreSQL
•	SQL
•	Data Cleaning
•	Data Validation
•	Data Transformation
•	Exploratory Data Analysis
•	Data Aggregation
•	Power BI
•	Data Visualization
•	Dashboard Development
•	Business Analysis
•	Business Recommendations
________________________________________
# Project Summary
Category	Details
Project	Cyclistic Bike-Share Analysis
Dataset	2025-2026 bike-share trip data (Not Available)
Database	PostgreSQL
Query Language	SQL
Visualization	Microsoft Power BI
Analysis Focus	Member vs. Casual Rider Behavior
Business Goal	Understand rider behavior and support membership growth
Data Period	June-May 2025-2026



The main question addressed in this project is:

How do annual members and casual riders use Cyclistic bikes differently?

The analysis compares the two rider groups across:

Ride volume

Ride duration

Day of week
