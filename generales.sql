//consultar registros que tengan guion al final
SELECT slug=LEFT(slug,length(slug) -1) FROM products WHERE RIGHT(slug, 1) = '-'

//eliminar guion al final de slug
UPDATE products SET slug=concat(left(slug,length(slug) -1),'-')

//opcional
WHERE RIGHT(slug, 1) = '-'


//tablas realcionadas 
SELECT `bookingStart`,`bookingEnd`, `customFields`, `info` FROM `yah_amelia_appointments` INNER JOIN `yah_amelia_customer_bookings` ON `yah_amelia_appointments`.`ID` = `yah_amelia_customer_bookings`.`appointmentId` WHERE `bookingStart` LIKE "%2020-07-13 07:00:00%" 
