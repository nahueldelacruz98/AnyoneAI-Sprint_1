-- TODO: This query will return a table with two columns; State, and 
-- Delivery_Difference. The first one will have the letters that identify the 
-- states, and the second one the average difference between the estimate 
-- delivery date and the date when the items were actually delivered to the 
-- customer.
-- HINTS:
-- 1. You can use the julianday function to convert a date to a number.
-- 2. You can use the CAST function to convert a number to an integer.
-- 3. You can use the STRFTIME function to convert a order_delivered_customer_date to a string removing hours, minutes and seconds.
-- 4. order_status == 'delivered' AND order_delivered_customer_date IS NOT NULL
SELECT oc.customer_state as State,
CAST(AVG(T.Diff) AS int) AS Delivery_Difference
FROM (
	SELECT JULIANDAY(STRFTIME('%Y-%m-%d', oo.order_estimated_delivery_date)) - JULIANDAY(STRFTIME('%Y-%m-%d', oo.order_delivered_customer_date)) AS Diff,
	oo.order_status,
	oo.customer_id 
	FROM olist_orders oo
	WHERE oo.order_status == 'delivered'
	AND oo.order_delivered_customer_date IS NOT NULL
	) AS T,
	olist_customers as oc
WHERE oc.customer_id = T.customer_id
GROUP By State 
ORDER BY Delivery_Difference