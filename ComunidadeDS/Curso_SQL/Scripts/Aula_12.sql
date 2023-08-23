-- Lista de Exercícios - Aula 12
-- 1. Qual o número de pedidos com o tipo de pagamento igual a “boleto”?

-- 2 jeitos de fazer a mesma operação: 1 - com subquery, 2 - com left join
SELECT
	COUNT(o.order_id)
FROM orders o 
WHERE o.order_id IN (SELECT
						  DISTINCT order_id 
					 FROM order_payments op 
					 WHERE op.payment_type = 'boleto')

-- 2. Refaça o exercício 01 usando união de tabelas					 
SELECT 
	COUNT(DISTINCT o.order_id) as pedidos
FROM orders o LEFT JOIN order_payments op ON (o.order_id = op.order_id)
WHERE op.payment_type = 'boleto'

-- 3. Cria uma tabela que mostre a média de avaliações por dia, a média de preço por dia, a soma dos preços por dia, o preço mínimo por dia, o número de pedidos por dia e o número 
-- de clientes únicos que compraram no dia.

-- Média de Avaliações por dia
SELECT 
	DATE(or2.review_creation_date ),
	AVG(or2.review_score)
FROM order_reviews or2 
GROUP BY DATE(or2.review_creation_date )

-- A média de preço por dia, a soma dos preços por dia, o preço mínimo por dia
SELECT 
	DATE(oi.shipping_limit_date),
	AVG(oi.price),
	SUM(oi.price),
	MIN(oi.price),
	COUNT(oi.order_id)
FROM order_items oi 
GROUP BY DATE(oi.shipping_limit_date)


--  O número de pedidos por dia e o número de clientes únicos que compraram no dia.
SELECT 
	DATE(o.order_delivered_customer_date ), 
	COUNT(DISTINCT o.customer_id) 
FROM orders o 
GROUP BY DATE(o.order_delivered_customer_date )


-- Agora, a grande query
SELECT 
	t1.Date_,
	t1.avg_review,
	t2.avg_price,
	t2.sum_price,
	t2.min_price,
	t3.customers,
	t3.pedido_por_dia
FROM (
	SELECT 
		DATE(or2.review_creation_date ) as Date_,
		AVG(or2.review_score) as avg_review
	FROM order_reviews or2 
	GROUP BY DATE(or2.review_creation_date )
) as t1 
LEFT JOIN 
	(SELECT 
		DATE(oi.shipping_limit_date) as Date_,
		AVG(oi.price) as avg_price,
		SUM(oi.price) as sum_price,
		MIN(oi.price) as min_price,
		COUNT(oi.order_id) as orders
	FROM order_items oi 
	GROUP BY DATE(oi.shipping_limit_date)) as t2
	ON (t1.Date_ = t2.Date_)
LEFT JOIN 
	(SELECT 
		DATE(o.order_purchase_timestamp ) as Date_, 
		COUNT(DISTINCT o.customer_id) as customers ,
		COUNT( o.order_id ) AS pedido_por_dia
	FROM orders o 
	GROUP BY DATE(o.order_delivered_customer_date )) as t3
	ON (t3.Date_ = t1.Date_)
	
	
-- 4. Eu gostaria de saber, por categoria, a quantidade de produtos, o tamanho médio do produto, o tamanho médio da categoria alimentos e o tamanho médio geral.
SELECT p.product_category_name
	,COUNT( DISTINCT p.product_id ) AS produto
	,AVG( DISTINCT p.product_length_cm ) AS avg_length
	,(
	SELECT AVG( DISTINCT p2.product_length_cm )
FROM products p2
WHERE p2.product_category_name = 'alimentos' ) AS avg_length_alimentos,
(
	SELECT AVG( DISTINCT p2.product_length_cm )
	FROM products p2 ) AS avg_length_all
FROM products p
GROUP BY p.product_category_name


-- 5
SELECT
	p.product_category_name
FROM products p
WHERE p.product_id = ( SELECT product_id
					   FROM ( SELECT
					   product_id,
MAX( max_product ) AS max_all
FROM ( SELECT
product_id,
MAX( price ) as max_product
FROM order_items oi
GROUP BY product_id ) ) )