LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\cleaned_ncr_ride_bookings.csv'
INTO TABLE uber
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SHOW VARIABLES LIKE 'secure_file_priv';

-- Q1. Find the total number of rides booked in the dataset.
SELECT COUNT(*) AS total_rides
FROM uber;

-- Q2. Calculate the total revenue generated from all rides.
SELECT SUM(`Booking Value`) AS total_revenue
FROM uber;

-- Q3. Find the average ride distance for each vehicle type.
SELECT `Vehicle Type`,
       AVG(`Ride Distance`) AS avg_distance
FROM uber
GROUP BY `Vehicle Type`;

-- Q4. Display the top 10 customers based on total booking value.
SELECT `Customer ID`,
       SUM(`Booking Value`) AS total_spent
FROM uber
GROUP BY `Customer ID`
ORDER BY total_spent DESC
LIMIT 10;

-- Q5. Find the busiest pickup location based on ride count.
SELECT `Pickup Location`,
       COUNT(*) AS total_rides
FROM uber
GROUP BY `Pickup Location`
ORDER BY total_rides DESC
LIMIT 1;

-- Q6. Identify the peak booking hour of the day.
SELECT HOUR(STR_TO_DATE(`Time`, '%H:%i:%s')) AS booking_hour,
       COUNT(*) AS total_bookings
FROM uber
GROUP BY booking_hour
ORDER BY total_bookings DESC
LIMIT 1;

-- Q7. Calculate the cancellation percentage of rides.
SELECT 
(COUNT(CASE WHEN `Booking Status` = 'Cancelled' THEN 1 END) * 100.0 / COUNT(*))
AS cancellation_percentage
FROM uber;

-- Q8. Find the number of successful vs cancelled rides.
SELECT `Booking Status`,
       COUNT(*) AS total_rides
FROM uber
GROUP BY `Booking Status`;

-- Q9. Determine the average fare amount by payment method.
SELECT `Payment Method`,
       AVG(`Booking Value`) AS avg_fare
FROM uber
GROUP BY `Payment Method`;

-- Q10. Find the highest single ride fare in the dataset.
SELECT MAX(`Booking Value`) AS highest_fare
FROM uber;

-- Q11. Display rides where booking value is greater than the average booking value.
SELECT *
FROM uber
WHERE `Booking Value` > (
    SELECT AVG(`Booking Value`)
    FROM uber
);

-- Q12. Find customers who booked more than 5 rides.
SELECT `Customer ID`,
       COUNT(*) AS total_rides
FROM uber
GROUP BY `Customer ID`
HAVING COUNT(*) > 5;

-- Q13. Calculate monthly revenue trends.
SELECT MONTH(STR_TO_DATE(`Date`, '%d-%m-%Y')) AS month,
       SUM(`Booking Value`) AS total_revenue
FROM uber
GROUP BY month
ORDER BY month;

-- Q14. Find the vehicle type generating the highest revenue.
SELECT `Vehicle Type`,
       SUM(`Booking Value`) AS total_revenue
FROM uber
GROUP BY `Vehicle Type`
ORDER BY total_revenue DESC
LIMIT 1;

-- Q15. Find the longest ride distance recorded.
SELECT MAX(`Ride Distance`) AS longest_distance
FROM uber;

-- Q16. Calculate average driver ratings for each vehicle type.
SELECT `Vehicle Type`,
       AVG(`Driver Ratings`) AS avg_driver_rating
FROM uber
GROUP BY `Vehicle Type`;

-- Q17. Find rides with unusually high fares compared to distance.
SELECT *
FROM uber
WHERE (`Booking Value` / `Ride Distance`) >
(
    SELECT AVG(`Booking Value` / `Ride Distance`)
    FROM uber
);

-- Q18. Find the most preferred payment method.
SELECT `Payment Method`,
       COUNT(*) AS usage_count
FROM uber
GROUP BY `Payment Method`
ORDER BY usage_count DESC
LIMIT 1;

-- Q19. Calculate average customer ratings for each vehicle type.
SELECT `Vehicle Type`,
       AVG(`Customer Rating`) AS avg_customer_rating
FROM uber
GROUP BY `Vehicle Type`;

-- Q20. Find locations with the highest ride cancellations.
SELECT `Pickup Location`,
       COUNT(*) AS cancellations
FROM uber
WHERE `Booking Status` = 'Cancelled'
GROUP BY `Pickup Location`
ORDER BY cancellations DESC;

-- Q21. Find customers who cancelled rides more than 3 times.
SELECT `Customer ID`,
       COUNT(*) AS cancellations
FROM uber
WHERE `Cancelled Rides by Customer` > 0
GROUP BY `Customer ID`
HAVING COUNT(*) > 3;

-- Q22. Find the average booking value for each vehicle type.
SELECT `Vehicle Type`,
       AVG(`Booking Value`) AS avg_booking_value
FROM uber
GROUP BY `Vehicle Type`;

-- Q23. Find the top 5 customers with the highest number of rides.
SELECT `Customer ID`,
       COUNT(*) AS total_rides
FROM uber
GROUP BY `Customer ID`
ORDER BY total_rides DESC
LIMIT 5;

-- Q24. Find incomplete rides and their reasons.
SELECT `Booking ID`,
       `Incomplete Rides Reason`
FROM uber
WHERE `Incomplete Rides` > 0;

-- Q25. Find the average ride distance for each payment method.
SELECT `Payment Method`,
       AVG(`Ride Distance`) AS avg_distance
FROM uber
GROUP BY `Payment Method`;

-- Q26. Find rides cancelled by drivers and reasons.
SELECT `Booking ID`,
       `Driver Cancellation Reason`
FROM uber
WHERE `Cancelled Rides by Driver` > 0;

-- Q27. Find the total cancelled rides by customers.
SELECT SUM(`Cancelled Rides by Customer`) AS total_customer_cancellations
FROM uber;

-- Q28. Find the total cancelled rides by drivers.
SELECT SUM(`Cancelled Rides by Driver`) AS total_driver_cancellations
FROM uber;

-- Q29. Find the average VTAT and CTAT.
SELECT AVG(`Avg VTAT`) AS avg_vtat,
       AVG(`Avg CTAT`) AS avg_ctat
FROM uber;

-- Q30. Find rides where customer rating is less than 3.
SELECT *
FROM uber
WHERE `Customer Rating` < 3;

-- Q31. Find rides where driver ratings are greater than 4.5.
SELECT *
FROM uber
WHERE `Driver Ratings` > 4.5;

-- Q32. Find the total rides for each booking status.
SELECT `Booking Status`,
       COUNT(*) AS total_rides
FROM uber
GROUP BY `Booking Status`;

-- Q33. Find the average booking value by pickup location.
SELECT `Pickup Location`,
       AVG(`Booking Value`) AS avg_booking
FROM uber
GROUP BY `Pickup Location`;

-- Q34. Find the most common drop location.
SELECT `Drop Location`,
       COUNT(*) AS total_rides
FROM uber
GROUP BY `Drop Location`
ORDER BY total_rides DESC
LIMIT 1;

-- Q35. Find the top 5 longest rides.
SELECT `Booking ID`,
       `Ride Distance`
FROM uber
ORDER BY `Ride Distance` DESC
LIMIT 5;

-- Q36. Find rides with booking value above 1000.
SELECT *
FROM uber
WHERE `Booking Value` > 1000;

-- Q37. Find the average ride distance by booking status.
SELECT `Booking Status`,
       AVG(`Ride Distance`) AS avg_distance
FROM uber
GROUP BY `Booking Status`;

-- Q38. Find all cancelled bookings with reasons.
SELECT `Booking ID`,
       `Reason for cancelling by Customer`,
       `Driver Cancellation Reason`
FROM uber
WHERE `Booking Status` = 'Cancelled';

-- Q39. Find the total revenue generated by each payment method.
SELECT `Payment Method`,
       SUM(`Booking Value`) AS total_revenue
FROM uber
GROUP BY `Payment Method`;

-- Q40. Find rides where pickup and drop locations are the same.
SELECT *
FROM uber
WHERE `Pickup Location` = `Drop Location`;

-- Q41. Find the average customer rating by payment method.
SELECT `Payment Method`,
       AVG(`Customer Rating`) AS avg_customer_rating
FROM uber
GROUP BY `Payment Method`;

-- Q42. Find the total number of incomplete rides.
SELECT SUM(`Incomplete Rides`) AS total_incomplete_rides
FROM uber;

-- Q43. Find rides with the minimum booking value.
SELECT *
FROM uber
WHERE `Booking Value` = (
    SELECT MIN(`Booking Value`)
    FROM uber
);

-- Q44. Find the average booking value by customer.
SELECT `Customer ID`,
       AVG(`Booking Value`) AS avg_booking_value
FROM uber
GROUP BY `Customer ID`;

-- Q45. Find customers with highest average ratings.
SELECT `Customer ID`,
       AVG(`Customer Rating`) AS avg_rating
FROM uber
GROUP BY `Customer ID`
ORDER BY avg_rating DESC
LIMIT 10;

-- Q46. Find the busiest vehicle type.
SELECT `Vehicle Type`,
       COUNT(*) AS total_rides
FROM uber
GROUP BY `Vehicle Type`
ORDER BY total_rides DESC
LIMIT 1;

-- Q47. Find rides where booking value per km is highest.
SELECT `Booking ID`,
       (`Booking Value` / `Ride Distance`) AS value_per_km
FROM uber
ORDER BY value_per_km DESC
LIMIT 10;

-- Q48. Find daily total bookings.
SELECT `Date`,
       COUNT(*) AS total_bookings
FROM uber
GROUP BY `Date`
ORDER BY STR_TO_DATE(`Date`, '%d-%m-%Y');

-- Q49. Find the average driver rating for completed rides.
SELECT AVG(`Driver Ratings`) AS avg_driver_rating
FROM uber
WHERE `Booking Status` = 'Completed';

-- Q50. Build a KPI dashboard query.
SELECT 
COUNT(*) AS total_rides,
SUM(`Booking Value`) AS total_revenue,
AVG(`Booking Value`) AS average_booking_value,
AVG(`Ride Distance`) AS average_distance,
SUM(`Cancelled Rides by Customer`) AS customer_cancellations,
SUM(`Cancelled Rides by Driver`) AS driver_cancellations
FROM uber;