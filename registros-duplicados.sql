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
	SUM(`input`) as total
    
FROM 
	transactiondata 
WHERE 
 `cashier_id` = 4
GROUP BY
	`cashier_name`,
	`trasaction_type` 
HAVING
	Count( * ) > 0;
