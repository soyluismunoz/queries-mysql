//consultar registros que tengan guion al final
SELECT slug=LEFT(slug,length(slug) -1) FROM products WHERE RIGHT(slug, 1) = '-'

//eliminar guion al final de slug
UPDATE products SET slug=concat(left(slug,length(slug) -1),'-')

//opcional
WHERE RIGHT(slug, 1) = '-'


//tablas realcionadas 
SELECT `bookingStart`,`bookingEnd`, `customFields`, `info` FROM `yah_amelia_appointments` INNER JOIN `yah_amelia_customer_bookings` ON `yah_amelia_appointments`.`ID` = `yah_amelia_customer_bookings`.`appointmentId` WHERE `bookingStart` LIKE "%2020-07-13 07:00:00%" 

// tablas relacionadas OPTIMIZADO
SELECT `wpxj_amelia_customer_bookings`.`id`, `bookingStart`,`bookingEnd`, `customFields`, `info`, `firstName`, `lastName`,`email`FROM `wpxj_amelia_appointments`, `wpxj_amelia_customer_bookings`, `wpxj_amelia_users` WHERE `wpxj_amelia_appointments`.`ID` = `wpxj_amelia_customer_bookings`.`appointmentId` AND `wpxj_amelia_customer_bookings`.`customerId` = `wpxj_amelia_users`.`id` AND `bookingStart` LIKE '%2020-09-18 23:00:00%' ORDER BY `wpxj_amelia_customer_bookings`.`customerId` ASC 

//borrar post viejos en wordpress
UPDATE `wp_posts` SET `post_status` = REPLACE(`post_status`,'publish','trash')WHERE `post_date` < '2016-10-12 00:00:00' AND `post_type` = 'post' AND `post_status` = 'publish' 

// traer los post de una determinada categoria wordpress
SELECT * FROM wp_posts
    LEFT JOIN wp_term_relationships ON
    wp_posts.ID = wp_term_relationships.object_id
    LEFT JOIN wp_term_taxonomy ON
    wp_term_relationships.term_taxonomy_id = wp_term_taxonomy.term_taxonomy_id
    WHERE wp_posts.post_status = "publish"
    AND wp_term_taxonomy.taxonomy = "category"
    AND wp_term_taxonomy.term_id = 11
    ORDER BY post_date DESC
