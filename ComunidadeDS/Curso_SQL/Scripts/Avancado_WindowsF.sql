-- Escrevendo Windows Functions
SELECT 
	p.product_category_name ,
	AVG(oi.price) as avg_price   
FROM order_items oi INNER JOIN products p ON (oi.product_id = p.product_id)
WHERE p.product_category_name IS NOT NULL
GROUP BY p.product_category_name 

-- Agora criar seguimentos utilizando Windows Function
SELECT 
	p.product_category_name ,
	oi.price,
	AVG(oi.price) OVER (PARTITION BY p.product_category_name) AS avg_price
FROM order_items oi INNER JOIN products p ON (oi.product_id = p.product_id)
WHERE p.product_category_name IS NOT NULL


-- Calcular o preço médio por categoria e tipo de pagamento
SELECT 
	p.product_category_name ,
	op.payment_type ,
	AVG(oi.price) as avg_price
FROM order_items oi INNER JOIN products p ON (oi.product_id = p.product_id)
					INNER JOIN order_payments op ON (oi.order_id = op.order_id)
WHERE p.product_category_name IS NOT NULL
GROUP BY p.product_category_name , op.payment_type 


-- Agora utilizando Windows Function
SELECT 
	p.product_category_name ,
	op.payment_type ,
	oi.price ,
	AVG(oi.price) OVER (PARTITION BY p.product_category_name, op.payment_type) as avg_price
FROM order_items oi LEFT JOIN products p ON (oi.product_id = p.product_id)
					LEFT JOIN order_payments op ON (oi.order_id = op.order_id)
WHERE p.product_category_name IS NOT NULL


-- Exercícios
-- 01
SELECT 
	p.product_id ,
	p.product_category_name ,
	oi.price ,
	AVG(oi.price) OVER (PARTITION BY p.product_category_name) as avg_price
FROM order_items oi LEFT JOIN products p ON (oi.product_id = p.product_id)


SELECT
	categoria,
	product_id,
	preco,
	DENSE_RANK() OVER ( PARTITION BY categoria ORDER BY preco DESC ) AS classificacao
FROM (
		SELECT
		p.product_id,
		p.product_category_name AS categoria,
		AVG( oi.price ) AS preco
		FROM orders o LEFT JOIN order_items oi ON ( oi.order_id = o.order_id )
			LEFT JOIN products p ON ( p.product_id = oi.product_id )
			LEFT JOIN order_reviews or2 ON ( or2.order_id = o.order_id )
		WHERE o.order_purchase_timestamp > '2018-06-01 00:00:00'
		GROUP BY p.product_id
		HAVING p.product_category_name IS NOT NULL
	)

-- 2
SELECT 
	o.order_purchase_timestamp ,
	oi.price,
	SUM(oi.price) OVER (ORDER BY o.order_purchase_timestamp) AS total_acumulado
FROM orders o LEFT JOIN order_items oi ON (o.order_id = oi.order_id)

-- 3 
SELECT 
	o.order_purchase_timestamp ,
	oi.price ,
	AVG(oi.price) OVER (ORDER BY o.order_purchase_timestamp ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as media_movel
FROM orders o LEFT JOIN order_items oi ON (o.order_id = oi.order_id)

-- 4
SELECT 
	data_venda,
	vendas,
	vendas - LAG(vendas) OVER (ORDER BY data_venda) as growth
FROM (
	SELECT
		o.order_purchase_timestamp as data_venda,
		COUNT (p.product_id) as vendas
	FROM orders o LEFT JOIN order_items oi ON (o.order_id = oi.order_id)
				  LEFT JOIN products p ON (oi.product_id = p.product_id)
	GROUP BY o.order_purchase_timestamp 
	ORDER BY o.order_purchase_timestamp ASC
		)


