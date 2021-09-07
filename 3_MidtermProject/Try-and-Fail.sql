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

/* Bsp. Subquery gibt Wert zurück:
SELECT price FROM house_price_data
WHERE price < (SELECT AVG(price) as middle_price FROM house_price_data); */

/* Bsp. Subquery gibt eine Tabelle zurück:
SELECT price FROM (SELECT price FROM house_price_data
WHERE price > (SELECT price FROM house_price_data WHERE price 2 * AVG(price)); */



