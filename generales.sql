/*consultar registros que tengan guion al final */
SELECT slug=LEFT(slug,length(slug) -1) FROM products WHERE RIGHT(slug, 1) = '-'

/*eliminar guion al final de slug*/
UPDATE products SET slug=concat(left(slug,length(slug) -1),'-')

/*opcional*/
WHERE RIGHT(slug, 1) = '-'


/*tablas realcionadas */
SELECT `bookingStart`,`bookingEnd`, `customFields`, `info` FROM `yah_amelia_appointments` INNER JOIN `yah_amelia_customer_bookings` ON `yah_amelia_appointments`.`ID` = `yah_amelia_customer_bookings`.`appointmentId` WHERE `bookingStart` LIKE "%2020-07-13 07:00:00%" 

/*tablas relacionadas OPTIMIZADO*/
SELECT `wpxj_amelia_customer_bookings`.`id`, `bookingStart`,`bookingEnd`, `customFields`, `info`, `firstName`, `lastName`,`email`FROM `wpxj_amelia_appointments`, `wpxj_amelia_customer_bookings`, `wpxj_amelia_users` WHERE `wpxj_amelia_appointments`.`ID` = `wpxj_amelia_customer_bookings`.`appointmentId` AND `wpxj_amelia_customer_bookings`.`customerId` = `wpxj_amelia_users`.`id` AND `bookingStart` LIKE '%2020-09-18 23:00:00%' ORDER BY `wpxj_amelia_customer_bookings`.`customerId` ASC 

/* calculo de pagos */
SELECT 
	`payments`.`paymentable_id`,
	SUM(
	if(`payment_method_type_id` = '01' OR 
		`payment_method_type_id` = '02' OR 
		`payment_method_type_id` = '03' , amount * rate, amount)) AS `total_payments`
FROM 
	`purchases`, 
	`payments`
WHERE 
	`payments`.`type` = "Purchases" AND 
	`payments`.`paymentable_id` = `purchases`.`id`
GROUP BY
	`payments`.`paymentable_id`
	
/* rellenar una columna con otra */
UPDATE shipments SET test_concat = CONCAT(date_shipment, ' ', time_shipment)

/* busqueda por fecha */
SELECT * FROM iv_ledgers WHERE created_at between '2022-10-31 00:00:00' and '2022-10-31 23:59:59';

/* actualizacion codicional con varias condinciones */
UPDATE inventories SET `type` = CASE WHEN `type` = '1' THEN 'in' WHEN `type` = '2' THEN 'out' ELSE `type` END;

/* busqueda en un acampo json */
SELECT * FROM shipments WHERE JSON_CONTAINS(carrier, JSON_OBJECT('id', 1))


/*Rentabilidad brutal por cliente*/
SELECT 
	`orders`.`customer_id`,
	JSON_EXTRACT(`orders`.`customer`, "$.trade_name") AS customer_name,
	SUM(`orders`.`total_usd`) AS `total_sale`,
	SUM(`orders`.`discount` / `orders`.`rate`) AS `total_discount`,
	COALESCE(SUM(`credits`.`total_usd`), 0) AS `total_returns`,
	SUM(`order_items`.`total_cost`) AS `total_order_items`,
	SUM(`orders`.`total_usd` * (IFNULL(JSON_EXTRACT(`orders`.`customer`, "$.zone.cost_percentage"), 6) / 100 )) AS `cost_of_shipment`,
	COUNT(*) AS qty
FROM 
	orders
	LEFT JOIN credits ON `orders`.`id` = `credits`.`order_id` AND `orders`.`customer_id` = `credits`.`customer_id`
	LEFT JOIN (
		SELECT order_id, SUM(unit_cost * qty) AS total_cost
		FROM order_items
		GROUP BY order_id
	) AS order_items ON `orders`.`id` = `order_items`.`order_id`
GROUP BY
	`customer_name`,
	`customer_id`;

/*Rentabilidad bruta por producto*/
SELECT p.`id`, p.`name`, c.`name`, b.`name`,
       SUM((oi.unit_price_usd - oi.unit_cost) * oi.qty) AS gross_profit
FROM products AS p
JOIN categories AS c ON p.category_id = c.id
JOIN brands AS  b ON p.brand_id = b.id
JOIN order_items AS oi ON p.`id` = oi.item_id
GROUP BY p.`id`, p.`name`, c.`name`, b.`name`;


/*rankings*/
SELECT
	`student_id`,
	SUM(`score`) AS `total_score`,
	RANK() OVER (ORDER BY SUM(`score`) DESC) AS `school_rank`
FROM
	`levels`
	JOIN `students` ON `levels`.`student_id` = `students`.`id`
	JOIN `classrooms` ON `students`.`classroom_id` = `classrooms`.`id`
	JOIN `schools` ON `classrooms`.`school_id` = `schools`.`id`
WHERE
	`schools`.`id` = 2
GROUP BY
	`student_id`;

/* average tima online and disconect students */
SELECT
    `user_id`,
    TIME_FORMAT(AVG(DATE_FORMAT(`session_init`, '%H:%i:%s')), '%H:%i:%s') AS `avg_session_init`,
    TIME_FORMAT(AVG(DATE_FORMAT(`session_end`, '%H:%i:%s')), '%H:%i:%s') AS `avg_session_end`,
    COUNT(*) AS `qty`
FROM
    `user_activities`
GROUP BY
    `user_id`;
    
SELECT
    DATE(`session_init`) AS `date`,
    COUNT(DISTINCT `user_id`) AS `connected_users`
FROM
    `user_activities`
GROUP BY
    `date`;
	
