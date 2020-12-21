SELECT
	`name`,
	`slug`,
	Count(*) AS `Total`
FROM
	products 
GROUP BY
	`name`,
	`slug` 
HAVING
	Count( * ) > 1;
	
	
	
SELECT 
	`cashier_name`,
	`trasaction_type`,
	Count(*) AS `Cantidad`,
	if(`operation` = 2, SUM(`input`), 0) as ingreso,
	if(`operation` = 1, SUM(`output`), 0) as egreso
FROM 
	transactiondata 
WHERE 
 	`cashier_id` = 4
GROUP BY
	`cashier_name`,
	`trasaction_type` 
HAVING
	Count( * ) > 0;
