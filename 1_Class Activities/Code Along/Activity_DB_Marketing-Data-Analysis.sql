CREATE DATABASE IF NOT EXISTS Customer_Analysis;

CREATE TABLE CA_Customers (
	customer_id INT,
    customer_reference CHAR(12),
    gender CHAR(1),
    education CHAR(45),
	employment_status CHAR(45),
    marital_status CHAR(45),
    income INT
); 

DROP TABLE CA_Customers;

CREATE TABLE Vehicle (
	vehicle_id INT,
    vehicle_class CHAR(45),
    vehicle_size CHAR(45),
	vehicle_type CHAR(45)
); 

CREATE TABLE Policy (
	policy_id INT,
    policy_name CHAR(45),
    policy_type CHAR(45),
	policy_text CHAR(45)
); 

CREATE TABLE Customer_Policy (
	customer_id INT,
    policy_id INT,
    effective_to_date DATE,
    last_claim DATE,
	monthly_premium INT,
    coverage CHAR(45)
); 

CREATE TABLE Revenues (
	customer_id INT,
    customer_lifetime_value INT,
    open_complaints INT,
	total_claim_amount FLOAT
); 

CREATE TABLE marketing (
	marketing_id INT,
    customer_id INT,
    response CHAR(8),
    offer_type CHAR(16),
	sales_channel CHAR(45)
); 