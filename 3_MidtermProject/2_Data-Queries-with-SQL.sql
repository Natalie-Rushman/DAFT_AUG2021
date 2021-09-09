use house_price_regression;

SELECT COUNT(*) FROM house_price_data; /* 21.597 observations */

SELECT DISTINCT bathrooms, COUNT(*) AS nbr_bathrooms FROM house_price_data
GROUP BY bathrooms
ORDER BY bathrooms ASC; /* Most houses (9362) are provided with 3 bathrooms. */

SELECT DISTINCT bedrooms, COUNT(*) AS nbr_bedrooms FROM house_price_data
GROUP BY bedrooms
ORDER BY nbr_bedrooms DESC; /* Most houses (824) are provided with 3 bedrooms. */

SELECT DISTINCT house_floors, COUNT(*) AS nbr_floors FROM house_price_data
GROUP BY house_floors
ORDER BY nbr_floors ASC; /* Most houses (10673) consist of one floor. */

SELECT DISTINCT kcgs_condition, COUNT(*) AS assign_condition FROM house_price_data
GROUP BY kcgs_condition
ORDER BY kcgs_condition ASC; /* Most houses are to be found in category 3, followed by 4 and 5; 1 and 2 rather neglectable */

SELECT DISTINCT kcgs_grade, COUNT(*) AS assign_grade FROM house_price_data
GROUP BY kcgs_grade
ORDER BY kcgs_grade ASC; /* Most houses are to be found in grade 6 through 10, the other grade are neglectable */

SELECT house_id, price FROM house_price_data
ORDER BY price ASC LIMIT 10; /* The cheapest house: 78.000 USD */

SELECT AVG(price) FROM house_price_data; /* The average cost: 540.296 USD */

SELECT DISTINCT bedrooms, AVG(price) AS middle_price FROM house_price_data
GROUP BY bedrooms
ORDER BY bedrooms ASC; /* Most expensive in the average: 8 bedrooms */

SELECT DISTINCT bedrooms, AVG(m2_living) AS average_living_area FROM house_price_data
GROUP BY bedrooms
ORDER BY bedrooms DESC; /* largest living area of 853 m2 with 8 bedrooms */

SELECT DISTINCT kcgs_waterfront, AVG(price) AS middle_price_with_waterfront FROM house_price_data
GROUP BY kcgs_waterfront; /* 1662525/531762 >>> houses with waterfront 3 times more expensive than without waterfront */

/* 
    Number of bedrooms either 3 or 4
    Bathrooms more than 3
    One Floor
    No waterfront
    Condition should be 3 at least
    Grade should be 5 at least
    Price less than 300000
*/

SELECT house_id, bathrooms, bedrooms, kcgs_waterfront, kcgs_grade, kcgs_condition, house_floors, price FROM house_price_data
WHERE (KCGS_waterfront = 0) AND (bedrooms BETWEEN 3 AND 4) AND (bathrooms > 2) AND (house_floors = 1) 
	AND (kcgs_condition >= 3) AND (kcgs_grade >=5) AND price < 300000; /* No house available, change parameters: Plenty of affordable hauses with e.g. 3 bathrooms */

/* list of properties whose prices are twice more than the average */
/* Create a view Houses_with_higher_than_double_average_price */

SELECT price FROM house_price_data
WHERE price > (SELECT price FROM house_price_data WHERE price = 2*AVG(price));

SELECT bedrooms, AVG(price) AS middle_price FROM house_price_data
GROUP BY bedrooms
HAVING bedrooms BETWEEN 3 AND 4; /* 3 = 466.276; 4 = 635.564 */

SELECT COUNT(DISTINCT(zip_code)) FROM house_price_data; /* 70 zipcodes */

SELECT DISTINCT zip_code, COUNT(*) AS houses_per_area FROM house_price_data
GROUP BY zip_code
ORDER BY houses_per_area ASC; /* Most houses in 98103 (602), least in 98039 (50) */

SELECT DISTINCT year_construction, AVG(price) AS middle_price FROM house_price_data
GROUP BY year_construction
ORDER BY middle_price DESC;

SELECT (year_renovation) AS renovated_houses, AVG(price) AS middle_price FROM house_price_data
GROUP BY year_renovation
HAVING year_renovation <> 0;

SELECT AVG(price/(m2_living+m2_lot)) AS m2_price FROM house_price_data; /* 642,70 */

SELECT price FROM house_price_data
WHERE zip_code = 98004
ORDER BY price ASC;

SELECT AVG(price) FROM house_price_data
WHERE zip_code = 98004;

SELECT DISTINCT zip_code, counties.county_name, AVG(price) AS middle_price FROM house_price_data
INNER JOIN counties ON house_price_data.zip_code = counties.county_zipcode
GROUP BY zip_code, counties.county_name
ORDER BY middle_price DESC;

SELECT * FROM counties;

SELECT zip_code, AVG(price) AS middle_priced_area FROM house_price_data
GROUP BY zip_code
HAVING expensive_area > 900000
ORDER BY expensive_area DESC;

SELECT zip_code, AVG(price) AS middle_priced_area FROM house_price_data
GROUP BY zip_code
HAVING middle_priced_area <= 900000 AND middle_priced_area > 400000
ORDER BY middle_priced_area DESC;

SELECT zip_code, AVG(price) AS low_priced_area FROM house_price_data
GROUP BY zip_code
HAVING low_priced_area <= 400000
ORDER BY low_priced_area DESC;

/* Most expensive house */
SELECT price AS Price, m2_living AS Size, zip_code, year_construction, year_renovation, KCGS_grade, KCGS_waterfront FROM house_price_regression.house_price_data
WHERE Price = 7700000;

/* biggest house */
SELECT price AS Price, m2_living AS Size, zip_code, year_construction, year_renovation, KCGS_grade, KCGS_waterfront FROM house_price_regression.house_price_data
WHERE Price = 2280000;

SELECT kcgs_waterfront, price FROM house_price_data
WHERE kcgs_waterfront = 1 AND price < 650000; 
/* 29 houses (from 163) with waterfront cheaper than 600000 USD */

