CREATE TABLE IF NOT EXISTS house_price_data (
	id INT PRIMARY KEY AUTO_INCREMENT,
    A INT,
    house_id INT,
    sale_date DATE,
    bedrooms INT,
    bathrooms FLOAT,
    sqft_living INT,
    sqft_lot INT,
    house_floors FLOAT,
    KCGS_waterfront INT,
    KCGS_view INT,
    KCGS_condition INT,
    KCGS_grade INT,
    sqft_above INT,
    sqft_basement INT,
    year_construction INT, 
    year_renovation INT,
    zip_code INT,
    latitude FLOAT,
    longitude FLOAT,
    sqft_living_2015 INT,
    sqft_lot_2015 INT,
    price INT,
    m2_living INT,
    m2_lot INT,
    m2_above INT,
    m2_basement INT,
    m2_living_2015 INT
    );