use house_price_regression;

SELECT COUNT(*) FROM house_price_data; /* 21.597 observations */

SELECT DISTINCT bathrooms, COUNT(*) AS nbr_bathrooms FROM house_price_data
GROUP BY bathrooms
ORDER BY bathrooms ASC;

SELECT DISTINCT bedrooms, COUNT(*) AS nbr_bedrooms FROM house_price_data
GROUP BY bedrooms
ORDER BY bedrooms ASC;

SELECT DISTINCT house_floors, COUNT(*) AS nbr_floors FROM house_price_data
GROUP BY house_floors
ORDER BY nbr_floors ASC;

SELECT DISTINCT kcgs_condition, COUNT(*) AS assign_condition FROM house_price_data
GROUP BY kcgs_condition
ORDER BY kcgs_condition ASC;

SELECT DISTINCT kcgs_grade, COUNT(*) AS assign_grade FROM house_price_data
GROUP BY kcgs_grade
ORDER BY kcgs_grade ASC;

SELECT house_id, price FROM house_price_data
ORDER BY price DESC LIMIT 10;

SELECT AVG(price) FROM house_price_data; /* 540.296 USD */

SELECT DISTINCT bedrooms, AVG(price) AS middle_price FROM house_price_data
GROUP BY bedrooms
ORDER BY bedrooms ASC; /* Most expensive in the average: 8 bedrooms */

SELECT DISTINCT bedrooms, AVG(m2_living) AS average_living_area FROM house_price_data
GROUP BY bedrooms
ORDER BY bedrooms ASC; /* largest livibg area of 853 m2 with 8 bedrooms */

SELECT DISTINCT kcgs_waterfront, AVG(price) AS middle_price_with_waterfront FROM house_price_data
GROUP BY kcgs_waterfront; /* 1662525/531762 >>> houses with waterfront 3 times more expansive than without waterfront */




