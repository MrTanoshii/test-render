SELECT * FROM barcode;
SELECT * FROM beverage;
SELECT * FROM customer;
SELECT * FROM customer_beverage;
SELECT * FROM manufacturer;

SELECT customer_beverage.id, beverage.label, customer.full_name FROM customer_beverage
INNER JOIN customer ON customer_beverage.customer_id = customer.id
INNER JOIN beverage ON customer_beverage.beverage_id = beverage.id;

-- Find customer favorite beverages
SELECT customer_beverage.id, beverage.label, customer.full_name FROM customer_beverage
INNER JOIN customer ON customer_beverage.customer_id = customer.id
INNER JOIN beverage ON customer_beverage.beverage_id = beverage.id
WHERE customer_beverage.is_favorite = TRUE;

-- Find beverage count per customer
SELECT customer.full_name, COUNT(customer_beverage.beverage_id) FROM customer_beverage
INNER JOIN customer ON customer_beverage.customer_id = customer.id
GROUP BY customer.full_name;

-- Find customer count per beverage
SELECT beverage.label, COUNT(customer_beverage.customer_id) FROM customer_beverage
INNER JOIN beverage ON customer_beverage.beverage_id = beverage.id
GROUP BY beverage.label;