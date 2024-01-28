SELECT 
    Year,
    Month,
    origin AS airport,
    AVG(dep_delay) AS avg_dep_delay
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/flights2_performance_2013.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM 
    flights
WHERE 
    year = 2013 AND 
    (origin = 'JFK' OR origin = 'LGA' OR origin = 'EWR')
GROUP BY 
    year, origin, MONTH
ORDER BY 
    year, origin, MONTH;airlines