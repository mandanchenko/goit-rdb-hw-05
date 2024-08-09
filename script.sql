USE homework3;
/*1. */
SELECT *,
    (SELECT orders.customer_id FROM orders WHERE orders.id = order_details.order_id) AS customer_id
FROM 
    order_details;
/*2.*/
SELECT *
FROM order_details
WHERE order_id IN 
    (SELECT id 
     FROM orders 
     WHERE shipper_id = 3);
/*3.*/
SELECT 
    sub.order_id,
    AVG(sub.quantity) AS average_quantity
FROM 
    (SELECT order_id, quantity
     FROM order_details
     WHERE quantity > 10) AS sub
GROUP BY 
    sub.order_id;
/*4.*/
WITH temp AS(SELECT order_id, quantity
     FROM order_details
     WHERE quantity > 10)
SELECT order_id, AVG(quantity) AS average_quantity
FROM temp
group by order_id;
/*5.*/

DROP FUNCTION IF EXISTS divide;
DELIMITER //
CREATE FUNCTION divide(a FLOAT, b FLOAT)
RETURNS FLOAT
DETERMINISTIC
BEGIN
    IF b = 0 THEN
        RETURN NULL; -- Повертаємо NULL, якщо другий параметр рівний нулю, щоб уникнути помилки ділення на нуль
    ELSE
        RETURN a / b;
    END IF;
END //
DELIMITER ;
SELECT order_id, product_id, quantity, divide(quantity, 42.0) AS result
FROM order_details;

