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

SELECT 
    p.trade_name,
    GROUP_CONCAT(p.id) AS ids,
    GROUP_CONCAT(IF(p.deleted_at IS NULL, 'true', 'false')) AS is_deleted,
    COUNT(*) AS qty
FROM
    people p
WHERE
    p.trade_name IN (
        SELECT
            trade_name
        FROM
            people
        GROUP BY
            trade_name
        HAVING
            COUNT(*) > 1
    )
GROUP BY
    p.trade_name,
    is_deleted
HAVING
    COUNT(*) > 1;
