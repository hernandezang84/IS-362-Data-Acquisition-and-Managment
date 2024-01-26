/* 1. How many airplanes have listed speeds? What is the minimum listed speed and the maximum listed speed?
The number of airplanes that have listed speeds is 23.  The minimum listed speed is 90 and the maximum listed
speed is 432. */

SELECT COUNT(speed) FROM planes;

SELECT MAX(speed) FROM planes;
SELECT MIN(speed) FROM planes;

/* 2. What is the total distance flown by all of the planes in January 2013? What is the total distance flown by
all of the planes in January 2013 where the tailnum is missing?
The total distance flown by all of the planes in January 2013 is 27,188,805.  The total distance flown by
all of the planes in January 2013 where the tailnum is missing is 81,763. */

SELECT SUM(distance) AS 'Total Distance' FROM flights
	WHERE (year = 2013 AND month = 1);
    
SELECT SUM(distance) AS 'Total Distance' FROM flights
	WHERE (year = 2013 AND month = 1 AND tailnum IS NULL);
    
/* 3. What is the total distance flown for all planes on July 5 2013, grouped by aircraft manufacturer? Write this
statement first using an INNER JOIN, then using a LEFT OUTER JOIN.  How do your results compare? 
The total distance flown for all planes grouped by aircraft manufacturer:
'AIRBUS', '195089'
'AIRBUS INDUSTRIE', '78786'
'BOEING', '335028'
'EMBRAER', '77909'
'CANADAIR', '1142'
'BOMBARDIER INC', '31160'
'MCDONNELL DOUGLAS', '7486'
'AMERICAN AIRCRAFT INC', '2199'
'MCDONNELL DOUGLAS AIRCRAFT CO', '15690'
'MCDONNELL DOUGLAS CORPORATION', '4767'
'CESSNA', '2898'
'GULFSTREAM AEROSPACE', '1157'
'DOUGLAS', '1089'
'BARKER JACK L', '937'

When running query with INNER LEFT JOIN, the table includes a NULL row where there is no listed manufacturer.
'AIRBUS', '195089'
'AIRBUS INDUSTRIE', '78786'
'BOEING', '335028'
NULL, '127671'
'EMBRAER', '77909'
'CANADAIR', '1142'
'BOMBARDIER INC', '31160'
'MCDONNELL DOUGLAS', '7486'
'AMERICAN AIRCRAFT INC', '2199'
'MCDONNELL DOUGLAS AIRCRAFT CO', '15690'
'MCDONNELL DOUGLAS CORPORATION', '4767'
'CESSNA', '2898'
'GULFSTREAM AEROSPACE', '1157'
'DOUGLAS', '1089'
'BARKER JACK L', '937'
 */

SELECT manufacturer AS 'Manufacturer', SUM(distance) AS 'Total Distance'
FROM flights
INNER JOIN planes
ON flights.tailnum = planes.tailnum
WHERE (flights.year = 2013 AND flights.month = 7 AND flights.day = 5)
GROUP BY manufacturer;

/* LEFT OUTER JOIN */
SELECT manufacturer AS 'Manufacturer', SUM(distance) AS 'Total Distance'
FROM flights
LEFT OUTER JOIN planes
ON flights.tailnum = planes.tailnum
WHERE (flights.year = 2013 AND flights.month = 7 AND flights.day = 5)
GROUP BY manufacturer;

/* 4. Write and answer at least one question of your own choosing that joins information from at lease three of
the tables in the flights database.
Q: What are the top 5 airlines with the most flights from JFK airport? */

SELECT airlines.name, COUNT(*) AS num_flights
FROM flights
JOIN airlines ON flights.carrier = airlines.carrier
WHERE flights.origin = 'JFK'
GROUP BY airlines.name
ORDER BY num_flights DESC
LIMIT 5;