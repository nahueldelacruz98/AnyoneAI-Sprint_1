-- TODO: This query will return a table with two columns; customer_state, and 
-- Revenue. The first one will have the letters that identify the top 10 states 
-- with most revenue and the second one the total revenue of each.
-- HINT: All orders should have a delivered status and the actual delivery date 
-- should be not null. 

SELECT TR.State,
SUM(TR.Revenue) As SumRevenue
FROM (
	select oop.payment_value AS Revenue,
	oc.customer_state AS State
	from olist_order_payments AS oop
	INNER JOIN olist_orders AS oo ON oop.order_id = oo.order_id 
	INNER JOIN olist_customers AS oc ON oc.customer_id = oo.customer_id
	WHERE oo.order_status = 'delivered' 
	AND oo.order_delivered_customer_date IS NOT NULL
	) AS TR
GROUP BY TR.State
ORDER BY SumRevenue DESC
LIMIT 10