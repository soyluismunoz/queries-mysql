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


/* busqueda en un acampo json */
SELECT * FROM shipments WHERE JSON_CONTAINS(carrier, JSON_OBJECT('id', 1))
