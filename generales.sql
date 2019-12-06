//consultar registros que tengan guion al final
SELECT slug=LEFT(slug,length(slug) -1) FROM products WHERE RIGHT(slug, 1) = '-'

//eliminar guion al final de slug
UPDATE products SET slug=concat(left(slug,length(slug) -1),'-')

//opcional
WHERE RIGHT(slug, 1) = '-'
