-- ROW_NUMBER()
SELECT 
	p.product_category_name ,
	oi.price ,
	ROW_NUMBER () OVER (PARTITION BY p.product_category_name ORDER BY oi.price DESC) AS price_rank
FROM order_items oi INNER JOIN products p ON (oi.product_id = p.product_id)
WHERE p.product_category_name IS NOT NULL

-- RANK()
SELECT 
	p.product_category_name ,
	oi.price ,
	RANK () OVER (PARTITION BY p.product_category_name ORDER BY oi.price DESC) AS price_rank
FROM order_items oi INNER JOIN products p ON (oi.product_id = p.product_id)
WHERE p.product_category_name IS NOT NULL


-- DENSE_RANK()
SELECT 
	p.product_category_name ,
	oi.price ,
	DENSE_RANK () OVER (PARTITION BY p.product_category_name ORDER BY oi.price DESC) AS price_rank
FROM order_items oi INNER JOIN products p ON (oi.product_id = p.product_id)
WHERE p.product_category_name IS NOT NULL


-- NTILE()
SELECT 
	p.product_category_name ,
	oi.price ,
	NTILE(5) OVER (PARTITION BY p.product_category_name ORDER BY oi.price DESC) AS price_rank
FROM order_items oi INNER JOIN products p ON (oi.product_id = p.product_id)
WHERE p.product_category_name IS NOT NULL