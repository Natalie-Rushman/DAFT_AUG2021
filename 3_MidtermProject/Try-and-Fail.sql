/*
SELECT house_id, kcgs_waterfront FROM house_price_data
WHERE kcgs_waterfront = 0;
*/

/*
SELECT bedrooms FROM house_price_data
WHERE bedrooms BETWEEN 3 and 4;
*/

/*
SELECT bathrooms FROM house_price_data
WHERE bathrooms > 3; */

/*
SELECT house_floors FROM house_price_data
WHERE house_floors = 1; */

/*
SELECT kcgs_condition FROM house_price_data
WHERE kcgs_condition >= 3; */

/*
SELECT kcgs_grade FROM house_price_data
WHERE kcgs_grade >= 5;*/

/* Bsp. Subquery gibt einen Wert (= 1 row) zurück:
SELECT price FROM house_price_data
WHERE price < (SELECT AVG(price) as middle_price FROM house_price_data); */

/* Bsp. Subquery gibt eine Tabelle zurück:
SELECT price FROM (SELECT price FROM house_price_data
WHERE price > (SELECT price FROM house_price_data WHERE price 2 * AVG(price)); */

USE house_price_regression;

SELECT bedrooms, m2_living, MIN(price) AS min_price FROM house_price_data
GROUP BY bedrooms
ORDER BY min_price ASC;

SELECT DISTINCT zip_code, COUNT(*) AS nbr_zipcodes FROM house_price_data
GROUP BY zip_code
ORDER BY zip_code ASC;

CREATE TABLE counties(
	county_zipcode INT,
    county_name VARCHAR(255),
    county_population INT
    );
    
ALTER TABLE counties
ADD COLUMN county_id INT;

SELECT county_zipcode, county_name, county_population FROM counties;

USE house_price_regression;

SELECT zip_code, county_name, AVG(price) AS middle_price FROM house_price_data
INNER JOIN house_price_data.zip_code ON house_price_data.zip_code =counties.county_zipcode
GROUP BY house_price_data.zip_code
ORDER BY middle_price DESC;