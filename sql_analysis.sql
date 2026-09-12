SELECT current_database();

CREATE TABLE DELHI_METRO_RIDES
(
  TripID INT,
    Date DATE,
    From_Station VARCHAR(100),
    To_Station VARCHAR(100),
    Distance_km DECIMAL(10,2),
    Fare DECIMAL(10,2),
    Cost_per_passenger DECIMAL(10,2),
    Passengers INT,
    Ticket_Type VARCHAR(50),
    Remarks VARCHAR(100)
);
SELECT * FROM DELHI_METRO_RIDES;
-- BASIC KPIS
SELECT count(*) as total_rides FROM DELHI_METRO_RIDES; --TOTAL RIDES
SELECT SUM(passengers) as total_passengers FROM DELHI_METRO_RIDES; --TOTAL PASSENGERS 
SELECT SUM(fare * passengers) as total_revenue FROM DELHI_METRO_RIDES; --TOTAL REVENUE
SELECT AVG(fare) FROM DELHI_METRO_RIDES; --AVERAGE FARE
SELECT AVG(distance_km) FROM DELHI_METRO_RIDES; --AVERAGE DISTANCE 

-- 1. STATION ANALYSIS 
-- TOP 10 FROM STATIONS 
SELECT from_station,count(*) as total_rides FROM DELHI_METRO_RIDES
GROUP BY from_station 
Order by total_rides DESC
limit 10 ;
--Top 10 to_station 
SELECT to_station,count(*) as total_rides FROM DELHI_METRO_RIDES
GROUP BY to_station 
Order by total_rides DESC
limit 10 ;

-- 2. STATION-WISE TOTAL PASSENGERS
SELECT from_station,SUM(passengers) AS total_passengers
FROM DELHI_METRO_RIDES
GROUP BY from_station
ORDER BY total_passengers DESC;
-- Least busy station 
SELECT from_station,count(*) as total_rides 
FROM DELHI_METRO_RIDES
GROUP BY from_station
ORDER BY total_rides;
-- STATION-WISE AVERAGE DISTANCE
SELECT from_station, ROUND(AVG(distance_km), 2) AS average_distance
FROM DELHI_METRO_RIDES
GROUP BY from_station
ORDER BY average_distance DESC;

-- 3.  ROUTE ANALYSIS
-- TOP 10 MOST POPULAR ROUTES
SELECT from_station,to_station,count(*) as total_rides
FROM DELHI_METRO_RIDES 
GROUP BY from_station,to_station
ORDER BY total_rides DESC
LIMIT 10 ;
-- TOP 10 ROUTES BY PASSENGERS
SELECT from_station,to_station,SUM(Passengers) as total_passengers
FROM DELHI_METRO_RIDES 
GROUP BY from_station,to_station
ORDER BY total_passengers DESC
LIMIT 10 ;
--Longest routes
SELECT from_station,to_station,MAX(distance_km) AS route_distance
FROM DELHI_METRO_RIDES
GROUP BY from_station, to_station
ORDER BY route_distance DESC
LIMIT 10;
-- Highest Revenue routes
SELECT  from_station, to_station, SUM(fare * passengers) AS total_revenue
FROM DELHI_METRO_RIDES
GROUP BY from_station, to_station
ORDER BY total_revenue DESC
LIMIT 10;

-- 4. FARE & REVENUE ANALYSIS
--TOP 10 HIGHEST FARE TRIPS
SELECT  from_station, to_station, fare, passengers
FROM DELHI_METRO_RIDES
ORDER BY fare DESC
LIMIT 10;
--AVERAGE FARE BY TICKET TYPE
SELECT ticket_type,ROUND(AVG(fare), 2) AS average_fare
FROM DELHI_METRO_RIDES
GROUP BY ticket_type
ORDER BY average_fare DESC;
-- REVENUE BY TICKET TYPE
SELECT ticket_type,SUM(fare * passengers) AS total_revenue
FROM DELHI_METRO_RIDES
GROUP BY ticket_type
ORDER BY total_revenue DESC;
-- AVERAGE FARE VS AVERAGE COST
SELECT  ROUND(AVG(fare), 2) AS average_fare, ROUND(AVG(cost_per_passenger), 2) AS average_cost
FROM DELHI_METRO_RIDES;

-- 5. PASSENGER ANALYSIS
--TOP 10 TRIPS BY PASSENGERS
SELECT tripid, from_station, to_station, passengers
FROM DELHI_METRO_RIDES
ORDER BY passengers DESC
LIMIT 10;
--AVERAGE PASSENGERS PER RIDE
SELECT ROUND(AVG(passengers), 2) AS average_passengers_per_ride
FROM DELHI_METRO_RIDES;
-- TOP 10 STATIONS BY TOTAL PASSENGERS
SELECT  from_station, SUM(passengers) AS total_passengers
FROM DELHI_METRO_RIDES
GROUP BY from_station
ORDER BY total_passengers DESC
LIMIT 10;
--TOP 10 ROUTES BY AVERAGE PASSENGERS
SELECT from_station,to_station,ROUND(AVG(passengers), 2) AS average_passengers
FROM DELHI_METRO_RIDES
GROUP BY from_station, to_station
ORDER BY average_passengers DESC
LIMIT 10;


-- 6. TICKET TYPE ANALYSIS
-- TICKET TYPE-WISE TOTAL RIDES
SELECT ticket_type,COUNT(*) AS total_rides
FROM DELHI_METRO_RIDES
GROUP BY ticket_type
ORDER BY total_rides DESC;
--TICKET TYPE-WISE TOTAL PASSENGERS
SELECT ticket_type,SUM(passengers) AS total_passengers
FROM DELHI_METRO_RIDES
GROUP BY ticket_type
ORDER BY total_passengers DESC;
--TICKET TYPE-WISE TOTAL REVENUE
SELECT ticket_type,SUM(fare * passengers) AS total_revenue
FROM DELHI_METRO_RIDES
GROUP BY ticket_type
ORDER BY total_revenue DESC;
--TICKET TYPE-WISE AVERAGE FARE
SELECT ticket_type,ROUND(AVG(fare), 2) AS average_fare
FROM DELHI_METRO_RIDES
GROUP BY ticket_type
ORDER BY average_fare DESC;

-- 7. DATE / TIME ANALYSIS
-- MONTH-WISE TOTAL RIDES
SELECT DATE_TRUNC('month', date) AS month,COUNT(*) AS total_rides
FROM DELHI_METRO_RIDES
GROUP BY month
ORDER BY month;
-- MONTH-WISE TOTAL PASSENGERS
SELECT DATE_TRUNC('month', date) AS month,SUM(passengers) AS total_passengers
FROM DELHI_METRO_RIDES
GROUP BY month
ORDER BY month;
--MONTH-WISE TOTAL REVENUE
SELECT DATE_TRUNC('month', date) AS month,SUM(fare * passengers) AS total_revenue
FROM DELHI_METRO_RIDES
GROUP BY month
ORDER BY month;
--TOP 10 BUSIEST DAYS
SELECT date,COUNT(*) AS total_rides
FROM DELHI_METRO_RIDES
GROUP BY date
ORDER BY total_rides DESC
LIMIT 10;
--TOP 10 DAYS BY PASSENGER DEMAND
SELECT date,SUM(passengers) AS total_passengers
FROM DELHI_METRO_RIDES
GROUP BY date
ORDER BY total_passengers DESC
LIMIT 10;








