-- TODO: This query will return a table with the revenue by month and year. It
-- will have different columns: month_no, with the month numbers going from 01
-- to 12; month, with the 3 first letters of each month (e.g. Jan, Feb);
-- Year2016, with the revenue per month of 2016 (0.00 if it doesn't exist);
-- Year2017, with the revenue per month of 2017 (0.00 if it doesn't exist) and
-- Year2018, with the revenue per month of 2018 (0.00 if it doesn't exist).
SELECT 
T.month_no,
(CASE T.month_no
        WHEN '01' THEN 'Jan'
        WHEN '02' THEN 'Feb'
        WHEN '03' THEN 'Mar'
        WHEN '04' THEN 'Apr'
        WHEN '05' THEN 'May'
        WHEN '06' THEN 'Jun'
        WHEN '07' THEN 'Jul'
        WHEN '08' THEN 'Aug'
        WHEN '09' THEN 'Sep'
        WHEN '10' THEN 'Oct'
        WHEN '11' THEN 'Nov'
        WHEN '12' THEN 'Dec'
    END) AS month,
SUM(CASE WHEN T.Fecha = '2016' THEN T.Payment ELSE 0 END) AS Year2016,
SUM(CASE WHEN T.Fecha = '2017' THEN T.Payment ELSE 0 END) AS Year2017,
SUM(CASE WHEN T.Fecha = '2018' THEN T.Payment ELSE 0 END) AS Year2018
FROM 
	(
		SELECT strftime('%Y', oo.order_delivered_customer_date) AS Fecha,
		strftime('%m', oo.order_delivered_customer_date) AS month_no,
		op.payment_value AS Payment
		FROM olist_orders AS oo 
		INNER JOIN olist_order_payments AS op ON oo.order_id = op.order_id
		WHERE oo.order_status = 'delivered'
		AND oo.order_delivered_customer_date IS NOT NULL
		GROUP BY oo.order_id 
	) AS T
GROUP BY month_no