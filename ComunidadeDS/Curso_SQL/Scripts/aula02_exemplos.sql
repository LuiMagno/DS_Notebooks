SELECT 
	c.customer_id ,
	c.customer_city ,
	c.customer_state 
FROM customer c 

SELECT 
	c.customer_id ,
	c.customer_city 
FROM customer c 
WHERE c.customer_state = 'SC'

SELECT 
	c.customer_id ,
	c.customer_state 
FROM customer c 
WHERE c.customer_city  == 'florianopolis'

SELECT 
	g.geolocation_state, 
	g.geolocation_lat ,
	g.geolocation_lng 
FROM geolocation g 
WHERE g.geolocation_state == 'SP'

SELECT
	oi.product_id ,
	oi.shipping_limit_date ,
	oi.price 
FROM order_items oi  
WHERE oi.price > '6300'

SELECT 
	op.payment_type ,
	op.order_id ,
	op.payment_installments 
FROM order_payments op 
WHERE op.payment_installments < 1

SELECT 
	o.order_id ,
	o.customer_id ,
	o.order_status ,
	o.order_approved_at 
FROM orders o 
WHERE o.order_approved_at < '2016-10-05'

SELECT 
	COUNT( c.customer_id ) AS Contagem_de_clientes
FROM customer c 


-- Aula 03, Exercícios

-- 01
SELECT 
	COUNT( DISTINCT ( c.customer_id )) AS clientes_unicos
FROM customer c
WHERE c.customer_state = 'MG'

-- 02
SELECT 
	COUNT( DISTINCT ( s.seller_city )) AS cidades_unicas_sellers
FROM sellers s 
WHERE s.seller_state = 'SC'

-- 03
SELECT 
	COUNT( DISTINCT ( s.seller_city )) AS cidades_unicas_sellers
FROM sellers s 

-- 04
SELECT 
	COUNT( DISTINCT ( oi.order_id )) AS pedidos_unicos
FROM order_items oi   
WHERE oi.price > 3500

-- 05
SELECT 
	AVG(oi.price) AS preco_medio
FROM order_items oi 

-- 06
SELECT 
	MAX(oi.price) AS preco_maximo
FROM order_items oi 

-- 07
SELECT 
	MIN(oi.price) AS preco_minimo
FROM order_items oi 

--08
SELECT 
	COUNT(DISTINCT oi.product_id) AS preco_distinto
FROM order_items oi 
WHERE oi.price < 100

-- 09
SELECT 
	COUNT( DISTINCT oi.seller_id  ) as vendedores_unicos
FROM order_items oi 
WHERE oi.shipping_limit_date < '2016-09-23'

-- 10
SELECT 
	DISTINCT OP.payment_type 
FROM order_payments op 

-- 11
SELECT 
	MAX(op.payment_installments) 
FROM order_payments op 

-- 12
SELECT 
	MIN(op.payment_installments) 
FROM order_payments op 

-- 13
SELECT 
	AVG( op.payment_value )
FROM order_payments op 
WHERE op.payment_type = 'credit_card'

-- 14
SELECT 
	COUNT (DISTINCT o.order_status) 
FROM orders o 

-- 15
SELECT 
	DISTINCT o.order_status
FROM orders o

-- 16
SELECT 
	COUNT (DISTINCT  o.customer_id) 
FROM orders o 

-- 17
SELECT 
	COUNT( DISTINCT p.product_id )
FROM products p  

-- 18
SELECT 
	MAX(p.product_photos_qty )
FROM products p 

-- 19
SELECT 
	MAX(p.product_weight_g  )
FROM products p 

-- 20
SELECT 
	AVG( DISTINCT p.product_height_cm  )
FROM products p 



-- Exercícios Aula 04

-- 01
SELECT 
	c.customer_state as estado,
	COUNT( DISTINCT c.customer_id)  as numero_clientes
FROM customer c 
GROUP BY c.customer_state 

-- 02
SELECT 
	c.customer_state as estado,
	COUNT( DISTINCT c.customer_city ) AS numero_cidades
FROM customer c 
GROUP BY c.customer_state 

-- 03
SELECT 
	c.customer_state ,
	c.customer_city ,
	COUNT( DISTINCT c.customer_id ) as Clientes
FROM customer c 
GROUP BY c.customer_state , c.customer_city 

-- 04
SELECT 
	c.customer_city ,
	c.customer_state ,
	COUNT( DISTINCT c.customer_id ) as Clientes
FROM customer c 
GROUP BY c.customer_city, c.customer_state 
	
-- 05
SELECT 
	oi.seller_id ,
	COUNT( DISTINCT order_id )
FROM order_items oi 
WHERE oi.price > 3500
GROUP BY oi.seller_id 

-- 06
SELECT 
	seller_id ,
	COUNT(DISTINCT oi.order_id), 
	MIN(shipping_limit_date),
	MAX(shipping_limit_date),
	MAX(freight_value),
	MIN(freight_value),
	AVG(freight_value) 
FROM order_items oi 
WHERE price < 1100
GROUP BY seller_id 

-- 07
SELECT 
	oi.product_id ,
	AVG(oi.price),
	MIN(oi.price),
	MAX(oi.price)
FROM order_items oi 
GROUP BY oi.product_id 


-- 08
SELECT 
	oi.shipping_limit_date ,
	COUNT( DISTINCT oi.seller_id ),
	AVG(oi.price)
FROM order_items oi 
WHERE oi.shipping_limit_date < '2016-09-23'
GROUP BY  oi.shipping_limit_date 

-- 09
SELECT 
	op.payment_type ,
	COUNT( op.order_id ) AS pedidos
FROM order_payments op 
GROUP BY op.payment_type 

-- 10
SELECT 
	op.payment_type as tipo_de_pagamento,
	COUNT( op.order_id) as numero_de_pedidos,
	AVG(op.payment_value) as valor_medio,
	MAX(op.payment_installments) as maximo_parcelas
FROM order_payments op 
GROUP BY op.payment_type 

-- 11
SELECT 
	op.payment_type ,
	op.payment_installments ,
	MIN(payment_value),
	MAX(payment_value),
	AVG(payment_value),
	SUM(payment_value) 
FROM order_payments op 
GROUP BY op.payment_type, op.payment_installments 

-- 12 - Qual a média de pedidos por cliente?
SELECT 
	o.customer_id ,
	AVG(DISTINCT o.order_id) as media_pedidos
FROM orders o 
GROUP BY o.customer_id 

-- 13 
SELECT 
	o.order_status ,
	COUNT(o.order_id) as quantidade_pedidos
FROM orders o 
GROUP BY o.order_status 

-- 14
SELECT 
	DATE(o.order_approved_at) data_,
	COUNT(o.order_id) numero_pedidos
FROM orders o 
WHERE order_approved_at > '2016-09-23'
GROUP BY DATE(order_approved_at )

-- 15
SELECT 
	p.product_category_name as categoria_produto,
	COUNT(DISTINCT product_id) as numero_produtos
FROM products p 
GROUP BY p.product_category_name 


-- Quantidade de fotos de produtos que tem fotos > 3

SELECT 
	p.product_photos_qty  AS quantidade_fotos,
	COUNT(DISTINCT p.product_id) produtos
FROM products p 
WHERE p.product_photos_qty > 3
GROUP BY p.product_photos_qty 


SELECT 
	p.product_id ,
	p.product_photos_qty
FROM
	products p 



-- Exercício Aula 05
	
-- 1. Qual o número de clientes únicos do estado de São Paulo?
SELECT 
	COUNT(DISTINCT c.customer_id) as numero_clientes
FROM customer c 
WHERE c.customer_state = 'SP'

-- 2. Qual o número total de pedidos únicos feitos no dia 08 de Outubro de 2016.
SELECT 
	COUNT(o.order_id)
FROM orders o 
WHERE DATE(o.order_purchase_timestamp) = '2016-10-08'


-- 3. Qual o número total de pedidos únicos feitos a partir do dia 08 de Outubro de 2016 .
SELECT 
	COUNT(o.order_id)
FROM orders o 
WHERE DATE(o.order_purchase_timestamp) > '2016-10-08'

-- 4. Qual o número total de pedidos únicos feitos a partir do dia 08 de Outubro de 2016 incluso.
SELECT 
	COUNT(o.order_id)
FROM orders o 
WHERE DATE(o.order_purchase_timestamp) >= '2016-10-08'

-- 5. Qual o número total de pedidos únicos e o valor médio do frete dos pedidos abaixo de R$ 1.100 por cada vendedor
SELECT 
	COUNT(DISTINCT oi.order_id) as total_pedidos,
	AVG(oi.freight_value)
FROM order_items oi 
WHERE oi.price < 1100

-- 6. Qual o número total de pedidos únicos, a data mínima e máxima de envio, o valor máximo, mínimo e médio do frete dos pedidos abaixo de R$ 1.100 incluso por cada vendedor?
SELECT 
	seller_id ,
	COUNT(DISTINCT oi.order_id) as total_pedidos,
	MIN(oi.shipping_limit_date),
	MAX(oi.shipping_limit_date),
	MAX(oi.freight_value),
	MIN(oi.freight_value),
	AVG(oi.freight_value)
FROM order_items oi 
WHERE oi.freight_value  <= 1100
GROUP BY oi.seller_id 

-- Exercício Aula 06

-- 1. Qual o número de clientes únicos nos estado de Minas Gerais ou Rio de Janeiro?
SELECT 
	c.customer_state as estado,
	COUNT( DISTINCT c.customer_id) as numero_clientes
FROM customer c 
WHERE c.customer_state = 'MG' OR  c.customer_state = 'RJ'
GROUP BY c.customer_state 

-- 2. Qual a quantidade de cidades únicas dos vendedores no estado de São Paulo ou Rio de Janeiro com a latitude maior que -24.54 e longitude menor que -45.63?
SELECT 
	g.geolocation_state as estado,
	COUNT(DISTINCT g.geolocation_city)
FROM geolocation g 
WHERE (g.geolocation_state = 'SP' OR g.geolocation_state  = 'RJ') 
	   AND (g.geolocation_lat > -24.54 AND g.geolocation_lng < -45.63)
GROUP BY g.geolocation_state 

-- 3. Qual o número total de pedidos únicos, o número total de produtos e o preço médio dos pedidos com o preço de frete maior que R$ 20 e a data limite de envio entre os dias 1 e 31 de Outubro de 2016?
SELECT 
	AVG(oi.price) as preco_medio,
	COUNT(oi.product_id) as total_produtos, 
	COUNT(DISTINCT oi.order_id) as total_pedidos
FROM order_items oi  
WHERE (oi.freight_value  > 20) AND (DATE(oi.shipping_limit_date) >= '2016-10-01' AND DATE(oi.shipping_limit_date) <= '2016-10-31')


-- 4. Mostre a quantidade total dos pedidos e o valor total do pagamento, para pagamentos entre 1 e 5 prestações ou um valor de pagamento acima de R$ 5000. Agrupe por quantidade de prestações.
SELECT 
	op.payment_installments as prestacoes ,
	COUNT(op.order_id) as total_pedidos,
	SUM(op.payment_value) as total_pagamento
FROM order_payments op 
WHERE (op.payment_installments >= 1 AND op.payment_installments <=5) OR op.payment_value > 5000
GROUP BY op.payment_installments 

-- 5. Qual a quantidade de pedidos com o status em processamento ou cancelada acontecem com a data estimada de entrega maior que 01 de Janeiro de 2017 ou menor que 23 de Novembro de 2016?
SELECT 
	o.order_status ,
	COUNT(o.order_id) as pedidos
FROM orders o 
WHERE (o.order_status = 'processing' OR o.order_status = 'canceled') AND (o.order_estimated_delivery_date > '2017-01-01' OR o.order_estimated_delivery_date < '2016-11-23')
GROUP BY o.order_status 

-- 6. Quantos produtos estão cadastrados nas categorias: perfumaria, brinquedos, esporte lazer, cama mesa e banho e móveis de escritório que possuem mais de 5 fotos, um peso maior que 5 g, 
-- um altura maior que 10 cm, uma largura maior que 20 cm?
SELECT 
	p.product_category_name as categorias,
	COUNT(product_id) as produtos
FROM products p 
WHERE (p.product_category_name = 'perfumaria' OR p.product_category_name = 'brinquedos' 
	  OR p.product_category_name = 'esporte_lazer' OR  p.product_category_name = 'cama_mesa_banho' OR  p.product_category_name = 'moveis_escritorio') 
	  AND (p.product_photos_qty > 5)
	  AND (p.product_weight_g > 5)
	  AND (p.product_height_cm > 10)
	  AND (p.product_width_cm  > 20)
GROUP BY p.product_category_name 



-- Exercício Aula 07

-- 1. Quantos clientes únicos tiveram seu pedidos com status de “processing”, “shipped” e “delivered”, feitos entre os dias 01 e 31 de Outubro de 2016. Mostrar o resultado somente se o número total de 
-- clientes for acima de 5.

SELECT 
	o.order_status ,
	COUNT(DISTINCT customer_id) as clientes
FROM orders o 
WHERE (o.order_status IN ('processing', 'shipped', 'delivered')) AND (DATE( o.order_purchase_timestamp ) BETWEEN '2016-10-01' AND '2016-10-31')
GROUP BY o.order_status 
HAVING COUNT(DISTINCT customer_id) > 5

-- 2. Mostre a quantidade total dos pedidos e o valor total do pagamento, para pagamentos entre 1 e 5 prestações ou um valor de pagamento acima de R$ 5000.

SELECT 
	op.payment_installments ,
	COUNT(op.order_id) as pedidos,
	SUM(op.payment_value) as total_pagamento
FROM order_payments op 
WHERE (op.payment_installments BETWEEN 1 AND 5) OR op.payment_value > 5000
GROUP BY op.payment_installments 


-- 3. Quantos produtos estão cadastrados nas categorias: perfumaria, brinquedos, esporte lazer e cama mesa, que possuem entre 5 e 10 fotos, um peso que não está entre 1 e 5 g, um altura maior que 10 cm,
-- uma largura maior que 20 cm. Mostra somente as linhas com mais de 10 produtos únicos.
SELECT
	p.product_category_name as categoria,
	COUNT( DISTINCT p.product_id) as produtos 
FROM products p 
WHERE (p.product_category_name IN ('perfumaria', 'brinquedos', 'esporte_lazer', 'cama_mesa')) 
	   AND (p.product_photos_qty BETWEEN 5 AND 10)
	   AND (p.product_weight_g NOT BETWEEN 1 AND 5)
	   AND (p.product_height_cm > 10)
	   AND (p.product_width_cm > 20)
GROUP BY product_category_name  
HAVING COUNT( DISTINCT p.product_id) > 10

-- 4 Refazer a consulta SQL abaixo, usando os operadores de intervalo.
SELECT
	order_status ,
	COUNT( order_id ) AS pedidos
FROM orders o
WHERE ( order_status IN ('processing', 'canceled') )
AND ( o.order_estimated_delivery_date > '2017-01-01' OR o.order_estimated_delivery_date < '2016-11-23' )
GROUP BY order_status

-- 5. Qual a quantidade de cidades únicas dos vendedores no estado de São Paulo ou Rio de Janeiro com a latitude maior que -24.54 e longitude menor que -45.63?
SELECT 
	g.geolocation_state as estados,
	COUNT(DISTINCT G.geolocation_city) as cidades 
FROM geolocation g 
WHERE (g.geolocation_state IN ('SP', 'RJ')) AND (g.geolocation_lat > -24.54) AND (g.geolocation_lng < -45.63)
GROUP BY geolocation_state 

-- 6. Quantos produtos estão cadastrados em qualquer categorias que comece com a letra “a” e termine com a letra “o” e que possuem mais de 5 fotos? Mostrar as linhas com mais de 10 produtos.
SELECT 
	p.product_category_name as categorias,
	COUNT(p.product_id) as produtos 
FROM products p 
WHERE p.product_category_name LIKE 'a%o' AND p.product_photos_qty > 5
GROUP BY p.product_category_name 
HAVING COUNT(p.product_id) > 10

-- 7. Qual o número de clientes únicos, agrupados por estado e por cidades que comecem com a letra “m”, tem a letra “o” e terminem com a letra “a”?
-- Mostrar os resultados somente para o número de clientes únicos maior que 10.
SELECT 
	c.customer_state as estado,
	c.customer_city as cidade,
	COUNT(DISTINCT customer_id) as clientes_unicos
FROM customer c 
WHERE c.customer_city LIKE 'm%o%a'
GROUP BY c.customer_state, c.customer_city 
HAVING COUNT(DISTINCT customer_id) > 10



-- SQL Intermediário - Aula 05

-- 1. Gerar uma tabela de dados com 10 linhas, contendo o id do pedido, o id do cliente, o status do pedido, o id do produto e o preço do produto.
SELECT  
	o.order_id ,
	o.customer_id ,
	o.order_status ,
	oi.product_id ,
	oi.price 
FROM orders o INNER JOIN order_items oi ON (oi.order_id = o.order_id)
LIMIT 10


-- 2. Gerar uma tabela de dados com 20 linhas, contendo o id do pedido, o estado do cliente, a cidade do cliente, o status do pedido, o id do produto e o preço do produto, somente
-- para clientes do estado de São Paulo
SELECT 
	o.order_id as pedidos,
	c.customer_state as estado,
	c.customer_city as cidade,
	o.order_status  as status,
	oi.product_id  as id_produto,
	oi.price  as preço
FROM orders o INNER JOIN order_items oi  ON (o.order_id = oi.order_id)
			 INNER JOIN customer c ON (o.customer_id = c.customer_id) 
LIMIT 20

-- 3. Gerar uma tabela de dados com 50 linhas, contendo o id do pedido, o estado e a cidade do cliente, o status do pedido, o nome da categoria do produto e o preço do produto,
-- somente para pedidos com o status igual a cancelado.
SELECT 
	o.order_id ,
	c.customer_state ,
	c.customer_city ,
	o.order_status ,
	p.product_category_name ,
	oi.price 
FROM orders o INNER JOIN order_items oi ON (oi.order_id = o.order_id)
			  INNER JOIN customer c ON (c.customer_id = o.customer_id)
			  INNER JOIN products p ON (p.product_id = oi.product_id)
WHERE o.order_status = 'canceled'
LIMIT 50


-- 4. Gerar uma tabela de dados com 80 linhas, contendo o id do pedido, o estado e a cidade do cliente, o status do pedido, o nome da categoria do produto, o preço do produto, a 
-- cidade e o estado do vendedor e a data de aprovação do pedido, somente para os pedidos aprovadas a partir do dia 16 de Setembro de 2016.
SELECT 
	o.order_id ,
	c.customer_state ,
	c.customer_city ,
	o.order_status ,
	p.product_category_name ,
	oi.price ,
	s.seller_city ,
	s.seller_state ,
	o.order_approved_at 
FROM orders o INNER JOIN order_items oi ON (oi.order_id = o.order_id)
			  INNER JOIN customer c ON (c.customer_id = o.customer_id)
			  INNER JOIN products p ON (p.product_id = oi.product_id)
			  INNER JOIN sellers s ON(s.seller_id = oi.seller_id)
WHERE DATE(o.order_approved_at) > '2016-09-16'
LIMIT 80

-- 5. Gerar uma tabela de dados com 10 linhas, contendo o id do pedido, o estado e a cidade do cliente, o status do pedido, o nome da categoria do produto, o preço do produto, a
-- cidade e o estado do vendedor, a data de aprovação do pedido e o tipo de pagamento, somente para o tipo de pagamento igual a boleto.
SELECT 
	o.order_id ,
	c.customer_state ,
	c.customer_city ,
	o.order_status ,
	p.product_category_name ,
	oi.price ,
	s.seller_city ,
	s.seller_state ,
	o.order_approved_at ,
	op.payment_type 
FROM orders o INNER JOIN order_items oi ON (oi.order_id = o.order_id)
			  INNER JOIN customer c ON (c.customer_id = o.customer_id)
			  INNER JOIN products p ON (p.product_id = oi.product_id)
			  INNER JOIN sellers s ON(s.seller_id = oi.seller_id)
			  INNER JOIN order_payments op ON (op.order_id = o.order_id)
WHERE op.payment_type = 'boleto'
LIMIT 10

--  Gerar uma tabela de dados com 70 linhas, contendo o id do pedido, o estado e a cidade do cliente, o status do pedido, o nome da categoria do produto, o preço do produto, a
-- cidade e o estado do vendedor, a data de aprovação do pedido, tipo de pagamento e a nota de avaliação do produto, somente para os pedidos com a nota de avaliação do produto igual a 1.

SELECT 
	o.order_id ,
	c.customer_state ,
	c.customer_city ,
	o.order_status ,
	p.product_category_name ,
	oi.price ,
	s.seller_city ,
	s.seller_state ,
	o.order_approved_at ,
	op.payment_type ,
	or2.review_score 
FROM orders o INNER JOIN order_items oi ON (oi.order_id = o.order_id)
			  INNER JOIN customer c ON (c.customer_id = o.customer_id)
			  INNER JOIN products p ON (p.product_id = oi.product_id)
			  INNER JOIN sellers s ON(s.seller_id = oi.seller_id)
			  INNER JOIN order_payments op ON (op.order_id = o.order_id)
			  INNER JOIN order_reviews or2  ON (or2.order_id = o.order_id)
WHERE or2.review_score  = 1
LIMIT 10


-- Exercícios Aula 06 - LEFT JOIN

-- 1. Gerar uma tabela de dados com 20 linhas e contendo as seguintes colunas: 1) Id do pedido, 2) status do pedido, 3) id do produto, 4) categoria do produto, 5) avaliação do pedido, 6) valor do pagamento, 7)
-- tipo do pagamento, 8) cidade do vendedor, 9) latitude e longitude da cidade do vendedor.
SELECT 
	o.order_id ,
	o.order_status ,
	oi.product_id ,
	p.product_category_name ,
	or2.review_score ,
	oi.price ,
	op.payment_type ,
	s.seller_city ,
	g.geolocation_lat ,
	g.geolocation_lng 
FROM orders o LEFT JOIN order_items oi ON (o.order_id = oi.order_id)
			  LEFT JOIN products p ON (p.product_id = oi.product_id)
			  LEFT JOIN order_reviews or2 ON (or2.order_id = o.order_id)
			  LEFT JOIN order_payments op ON (op.order_id = o.order_id)
			  LEFT JOIN sellers s ON (s.seller_id = oi.seller_id)
			  LEFT JOIN geolocation g ON (g.geolocation_zip_code_prefix = s.seller_zip_code_prefix)			 
LIMIT 20

-- 2. Quantos tipos de pagamentos foram usados pelo cliente para pagar o pedido 'e481f51cbdc54678b7cc49136f2d6af7’
SELECT 
	o.order_id ,
	op.payment_type as tipos_pagamentos
FROM orders o LEFT JOIN order_payments op ON (o.order_id = op.order_id)
			  LEFT JOIN order_items oi ON (oi.order_id = o.order_id)
			  LEFT JOIN products p ON (p.product_id = oi.product_id)
WHERE o.order_id = 'e481f51cbdc54678b7cc49136f2d6af7'

-- 3. Quantos pedidos tem mais de 5 items?
SELECT 
	o.order_id ,
	COUNT(DISTINCT oi.product_id) as produtos
FROM orders o LEFT JOIN order_items oi ON (o.order_id = oi.order_id)
GROUP BY o.order_id 
HAVING COUNT(DISTINCT oi.product_id) > 5

-- 4. Qual a cardinalidade entre a tabela Pedidos ( orders ) e Avaliações (reviews )?
SELECT 
	o.order_id ,
	COUNT(DISTINCT or2.review_id) as reviews
FROM orders o LEFT JOIN order_reviews or2 ON (o.order_id = or2.order_id)
GROUP BY o.order_id 

-- 1-N pois alguns pedidos tem mais de 1 review

-- 5. Quantos pedidos (orders) não tem nenhuma avaliação (review) ?
SELECT 
	o.order_id ,
	or2.review_score 
FROM orders o LEFT JOIN order_reviews or2 ON (o.order_id = or2.order_id)
WHERE or2.order_id IS NULL

-- 6. Quais são os top 10 vendedores com mais clientes?
SELECT 
	s.seller_id ,
	COUNT(DISTINCT c.customer_id) AS numero_clientes
FROM orders o LEFT JOIN order_items oi ON (o.order_id = oi.order_id)
			  LEFT JOIN sellers s ON (oi.seller_id = s.seller_id)
			  LEFT JOIN customer c ON (o.customer_id = c.customer_id)  
GROUP BY s.seller_id 
ORDER BY numero_clientes DESC


-- 7. Quantos pedidos (orders) não possuem nenhum produto (products) ?
SELECT 
	COUNT(DISTINCT o.order_id  )
FROM orders o LEFT JOIN order_items oi ON (o.order_id = oi.order_id)
			  LEFT JOIN products p ON (oi.product_id = p.product_id)
WHERE oi.product_id IS NULL



-- Montar a grande tabela
SELECT
	o.order_id,
	o.order_status,
	oi.product_id,
	p.product_category_name,
	or2.review_score,
	op.payment_value,
	op.payment_type,
	s.seller_city,
	g.geolocation_lat,
	g.geolocation_lng
FROM orders o LEFT JOIN order_items oi ON ( oi.order_id = o.order_id )
LEFT JOIN order_reviews or2 ON ( or2.order_id = o.order_id )
LEFT JOIN order_payments op ON ( op.order_id = o.order_id )
LEFT JOIN products p ON ( p.product_id = oi.product_id )
LEFT JOIN sellers s ON ( s.seller_id = oi.seller_id )
LEFT JOIN geolocation g ON ( g.geolocation_zip_code_prefix = s.seller_zip_code_prefix )
LIMIT 20;



-- Average total de reviews
SELECT 
	AVG(or2.review_score) 
FROM order_reviews or2 

-- Média de review de pagamentos de boleto
SELECT 
	AVG (or2.review_score) as media_score
FROM orders o INNER JOIN order_payments op ON (o.order_id = op.order_id)
			  INNER JOIN order_reviews or2 ON (o.order_id = or2.order_id)
WHERE op.payment_type = 'debit_card'

SELECT DISTINCT op.payment_type 
FROM order_payments op 



-- Aula 08 Subquery
-- Selecionar a média do preço de pedidos que possuem somente os items de perfumaria e artes
-- Primeiro uma query normal
SELECT *
FROM products p 
WHERE p.product_category_name IN ('artes', 'perfumaria')

-- Agora uma subquery
SELECT 
	AVG(oi.price)
FROM order_items oi 
WHERE oi.product_id IN (SELECT p.product_id 
						FROM products p 
						WHERE p.product_category_name IN ('artes', 'perfumaria'))	

						
-- Aula 09 -  Subquery no Select
SELECT 
	oi.product_id ,
	p.product_category_name as category
FROM order_items oi LEFT JOIN products p ON (oi.product_id = p.product_id)
LIMIT 10

-- Pode-se obter o mesmo resultado com essa outra query
SELECT 
	p.product_category_name ,
	(SELECT AVG(oi.price) FROM order_items oi ) AS avg_price_all,
	(SELECT AVG(oi2.price) FROM order_items oi2 WHERE oi2.product_id  = p.product_id) AS avg_price_category
FROM products p
LIMIT 20


-- AULA 10
SELECT p.product_id 
FROM products p 
WHERE p.product_category_name IN ('papelaria', 'bebidas')


-- Utilizando subquery no WHERE
SELECT AVG(oi.price) AS avg_price  
FROM order_items oi 
WHERE oi.order_id IN (SELECT oi.order_id
					  FROM orders o
					  WHERE o.order_status = 'delivered')
					  
					  
	