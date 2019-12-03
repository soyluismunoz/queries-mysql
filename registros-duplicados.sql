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
	
	
