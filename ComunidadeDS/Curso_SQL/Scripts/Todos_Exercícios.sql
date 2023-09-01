-- Exercícios 01

-- 1. Gere uma tabela com o id do cliente, a cidade e o estado onde ele vive.
SELECT 
	c.customer_id ,
	c.customer_city ,
	c.customer_state 
FROM customer c

-- 2. Gere uma tabela com o id do cliente e a cidade, somente dos clientes que vivem em Santa Catarina.
SELECT 
	c.customer_id ,
	c.customer_city 
FROM customer c 
WHERE c.customer_state = 'SC'


-- 3. Gere uma tabela com o id do cliente e o estado, somente dos clientes que vivem em Florianópolis.
SELECT 
	c.customer_id ,
	c.customer_state  
FROM customer c 
WHERE c.customer_city  = 'florianopolis'


-- 4. Gere uma tabela com o estado, latitude e longitude do estado de São Paulo
SELECT 
	g.geolocation_state ,
	g.geolocation_lat ,
	g.geolocation_lng 
FROM geolocation g 
WHERE g.geolocation_state = 'SP'

-- 5. Gere uma tabela com o id do produto, a data de envio e o preço, somente para produtos acima de 6300
SELECT 
	oi.product_id ,
	DATE(oi.shipping_limit_date) ,
	oi.price 
FROM order_items oi 
WHERE oi.price > 6300

-- 6. Gere uma tabela com o id do pedido, o tipo de pagamento e o número de parcelas, somente para produtos com parcelas menores que 1.
SELECT 
	op.order_id ,
	op.payment_type ,
	op.payment_installments 
FROM order_payments op 
WHERE op.payment_installments < 1

-- 7. Gere uma tabela com o id do pedido, id do cliente, o status do pedido e a data de aprovação , somente para compras aprovadas até dia 05 de Maio de 2016
SELECT 
	o.order_id ,
	o.customer_id ,
	o.order_status ,
	o.order_approved_at 
FROM orders o 
WHERE o.order_approved_at < '2016-10-05'

-- Exercícios 02

-- 1. Qual o número de clientes únicos do estado de Minas Gerais?
SELECT 
	COUNT(DISTINCT c.customer_id)
FROM customer c 
WHERE c.customer_state = 'MG'

-- 2. Qual a quantidade de cidades únicas dos vendedores do estado de Santa Catarina?
SELECT 
	COUNT(DISTINCT s.seller_city)
FROM sellers s 
WHERE s.seller_state = 'SC'

-- 3. Qual a quantidade de cidades únicas de todos os vendedores da base?
SELECT 
	COUNT(DISTINCT s.seller_city)
FROM sellers s 

-- 4. Qual o número total de pedidos únicos acima de R$ 3.500
SELECT 
	COUNT(DISTINCT oi.order_id )
FROM order_items oi  
WHERE oi.price > 3500

-- 5. Qual o valor médio do preço de todos os pedidos?
SELECT 
	AVG(oi.price)
FROM order_items oi 

--6. Qual o maior valor de preço entre todos os pedidos?
SELECT 
	MAX(oi.price)
FROM order_items oi 

-- 7. Qual o menor valor de preço entre todos os pedidos?
SELECT 
	MIN(oi.price)
FROM order_items oi

-- 8. Qual a quantidade de produtos distintos vendidos abaixo do preço de R$ 100.00?
SELECT 
	COUNT(DISTINCT oi.product_id )
FROM order_items oi 
WHERE oi.price < 100

-- 9. Qual a quantidade de vendedores distintos que receberam algum pedido antes do dia 23 de setembro de 2016?
SELECT 
	COUNT(DISTINCT oi.seller_id )
FROM order_items oi 
WHERE OI.shipping_limit_date < '2016-09-23'

-- 10. Quais os tipos de pagamentos existentes?
SELECT 
	DISTINCT op.payment_type
FROM order_payments op 

-- 11. Qual o maior número de parcelas realizado?
SELECT 
	MAX(op.payment_installments )
FROM order_payments op 

-- 12. Qual o menor número de parcelas realizado?
SELECT 
	MIN(op.payment_installments )
FROM order_payments op 

-- 13. Qual a média do valor pago no cartão de crédito?
SELECT 
	AVG(op.payment_value) 
FROM order_payments op  
WHERE op.payment_type = 'credit_card'

-- 14. Quantos tipos de status para um pedido existem?
SELECT 
	COUNT(DISTINCT o.order_status )
FROM orders o 

-- 15. Quais os tipos de status para um pedido?
SELECT 
	DISTINCT o.order_status 
FROM orders o

-- 16. Quantos clientes distintos fizeram um pedido?
SELECT 
	COUNT(DISTINCT o.customer_id )
FROM orders o 

-- 17. Quantos produtos estão cadastrados na empresa?
SELECT 
	COUNT(DISTINCT p.product_id)
FROM products p 

-- 18. Qual a quantidade máxima de fotos de um produto?
SELECT 
	MAX(p.product_photos_qty)
FROM products p 

-- 19. Qual o maior valor do peso entre todos os produtos?
SELECT 
	MAX( DISTINCT p.product_weight_g)
FROM products p

-- 20. Qual a altura média dos produtos?
SELECT 
	AVG(DISTINCT p.product_height_cm) 
FROM products p 



-- Exercícios 03

-- 1. Qual o número de clientes únicos de todos os estados?
SELECT 
	c.customer_state ,
	COUNT(DISTINCT c.customer_id) 
FROM customer c 
GROUP BY c.customer_state 

-- 2. Qual o número de cidades únicas de todos os estados?
SELECT 
	g.geolocation_state ,
	COUNT(DISTINCT g.geolocation_city)
FROM geolocation g 
GROUP BY g.geolocation_state 

SELECT
customer_state ,
COUNT( DISTINCT customer_city ) AS numero_cidades
FROM customer c
GROUP BY customer_state

-- 3. Qual o número de clientes únicos por estado e por cidade?
SELECT 
	c.customer_city ,
	c.customer_state ,
	COUNT(DISTINCT c.customer_id)
FROM customer c 
GROUP BY c.customer_state , c.customer_city 

-- 4. Qual o número de clientes únicos por cidade e por estado?
SELECT 
	c.customer_city ,
	c.customer_state ,
	COUNT(DISTINCT c.customer_id)
FROM customer c 
GROUP BY c.customer_city, c.customer_state  

-- 5. Qual o número total de pedidos únicos acima de R$ 3.500 por cada vendedor?
SELECT 
	oi.seller_id ,
	COUNT(DISTINCT oi.order_id)
FROM order_items oi 
WHERE oi.price > 3500
GROUP BY oi.seller_id 

-- 6. Qual o número total de pedidos únicos, a data mínima e máxima de envio, o valor máximo, mínimo e médio do frete dos pedidos acima de R$ 1.100 por cada vendedor?
SELECT 
	oi.seller_id ,
	COUNT(DISTINCT oi.order_id),
	MIN(oi.shipping_limit_date),
	MAX(oi.shipping_limit_date),
	MAX(oi.freight_value),
	MIN(oi.freight_value),
	AVG(oi.freight_value)
FROM order_items oi 
WHERE oi.price > 1100
GROUP BY oi.seller_id 

-- 7. Qual o valor médio, máximo e mínimo do preço de todos os pedidos de cada produto?
SELECT 
	oi.product_id ,
	COUNT(DISTINCT oi.order_id),
	AVG(oi.price),
	MAX(oi.price),
	MIN(oi.price)
FROM order_items oi 
GROUP BY oi.product_id 

-- 8. Qual a quantidade de vendedores distintos que receberam algum pedido antes do dia 23 de setembro de 2016 e qual foi o preço médio desses pedidos?
SELECT 
	oi.shipping_limit_date ,
	COUNT(DISTINCT  oi.seller_id),
	AVG(oi.price)
FROM order_items oi 
WHERE oi.shipping_limit_date < '2016-09-23'
GROUP BY oi.shipping_limit_date 

-- 9. Qual a quantidade de pedidos por tipo de pagamentos?
SELECT 
	op.payment_type ,
	COUNT(op.order_id)
FROM order_payments op 
GROUP BY op.payment_type 

-- 10. Qual a quantidade de pedidos, a média do valor do pagamento e o número máximo de parcelas por tipo de pagamentos?
SELECT 
	op.payment_type ,
	COUNT(DISTINCT op.order_id),
	AVG(op.payment_value),
	MAX(op.payment_installments )
FROM order_payments op 
GROUP BY op.payment_type 

-- 11. Qual a valor mínimo, máximo, médio e as soma total paga por cada tipo de pagamento e número de parcelas disponíveis?
SELECT 
	op.payment_type ,
	op.payment_installments ,
	MIN(op.payment_value ),
	MAX(op.payment_value),
	AVG(op.payment_value),
	SUM(op.payment_value)
FROM order_payments op 
GROUP BY op.payment_type , op.payment_installments 

-- 12. Qual a média de pedidos por cliente?
SELECT 
	o.customer_id ,
	AVG(o.order_id)
FROM orders o 
GROUP BY o.customer_id 

-- 13. Qual a quantidade de pedidos por status?
SELECT 
	o.order_status ,
	COUNT(o.order_id)
FROM orders o 
GROUP BY o.order_status 

-- 14. Qual a quantidade de pedidos realizados por dia, a partir do dia 23 de Setembro de 2016?
SELECT 
	DATE(o.order_purchase_timestamp) ,
	COUNT(o.order_id)
FROM orders o 
WHERE DATE(o.order_purchase_timestamp) > '2016-09-22'
GROUP BY DATE(o.order_purchase_timestamp)

-- 15. Quantos produtos estão cadastrados na empresa por categoria?
SELECT 
	p.product_category_name ,
	COUNT(DISTINCT p.product_id)
FROM products p 
GROUP BY p.product_category_name 




-- Exercícios 04

-- 1. Qual o número de clientes únicos do estado de São Paulo?
SELECT 
	COUNT(DISTINCT customer_id)
FROM customer c 
WHERE c.customer_state = 'SP'

-- 2. Qual o número total de pedidos únicos feitos no dia 08 de Outubro de 2016?
SELECT 
	COUNT(DISTINCT oi.order_id) 
FROM order_items oi 
WHERE DATE(oi.shipping_limit_date) = '2016-10-08'

-- 3. Qual o número total de pedidos únicos feitos a partir do dia 08 de Outubro de 2016?
SELECT 
	COUNT(DISTINCT oi.order_id) 
FROM order_items oi 
WHERE DATE(oi.shipping_limit_date) > '2016-10-08'

-- 4. Qual o número total de pedidos únicos feitos a partir do dia 08 de Outubro de 2016 incluso?
SELECT 
	COUNT(DISTINCT oi.order_id) 
FROM order_items oi 
WHERE DATE(oi.shipping_limit_date) >= '2016-10-08'

-- 5. Qual o número total de pedidos únicos e o valor médio do frete dos pedidos abaixo de R$ 1.100 por cada vendedor?
SELECT 
	COUNT(DISTINCT oi.order_id),
	AVG(oi.freight_value)
FROM order_items oi 
WHERE oi.price < 1100

-- 6. Qual o número total de pedidos únicos, a data mínima e máxima de envio, o valor máximo, mínimo e médio do frete dos pedidos abaixo de R$ 1.100 incluso por cada vendedor?
SELECT 
	oi.seller_id ,
	COUNT(DISTINCT oi.order_id),
	MIN(oi.shipping_limit_date),
	MAX(oi.shipping_limit_date),
	AVG(oi.freight_value),
	MAX(oi.freight_value),
	MIN(oi.freight_value) 
FROM order_items oi 
WHERE oi.price <= 1100
GROUP BY seller_id 





-- Exercícios 05

-- 1. Qual o número de clientes únicos nos estado de Minas Gerais ou Rio de Janeiro?
SELECT 
	c.customer_state ,
	COUNT(DISTINCT c.customer_id) 
FROM customer c 
WHERE (c.customer_state = 'MG') or (c.customer_state = 'RJ')
GROUP BY c.customer_state 

-- 2. Qual a quantidade de cidades únicas dos vendedores no estado de São Paulo ou Rio de Janeiro com a latitude maior que -24.54 e longitude menor que -45.63?
SELECT 
	g.geolocation_state ,
	COUNT(DISTINCT g.geolocation_city) 
FROM geolocation g 
WHERE ((g.geolocation_state = 'SP') OR (g.geolocation_state = 'RJ')) AND (g.geolocation_lat > -24.54 AND g.geolocation_lng < -45.63)
GROUP BY g.geolocation_state 

-- 3. Qual o número total de pedidos únicos, o número total de produtos e o preço médio dos pedidos com o preço de frete maior que R$ 20 e a data limite de envio entre os dias 1 e 31 de Outubro de 2016?
SELECT 
	COUNT(DISTINCT oi.order_id),
	COUNT(DISTINCT oi.product_id),
	AVG(oi.price) 
FROM order_items oi 
WHERE (oi.freight_value > 20) AND (DATE(oi.shipping_limit_date) >= '2016-10-01' AND DATE(oi.shipping_limit_date)<= '2016-10-31')

-- 4. Mostre a quantidade total dos pedidos e o valor total do pagamento, para pagamentos entre 1 e 5 prestações ou um valor de pagamento acima de R$ 5000. Agrupe por quantidade de prestações.
SELECT 
	op.payment_installments ,
	COUNT(op.order_id),
	SUM(op.payment_value)
FROM order_payments op 
WHERE ((op.payment_installments >= 1) AND (op.payment_installments <= 5)) OR op.payment_value > 5000
GROUP BY op.payment_installments 

-- 5. Qual a quantidade de pedidos com o status em processamento ou cancelada acontecem com a data estimada de entrega maior que 01 de Janeiro de 2017 ou menor que 23 de Novembro de 2016?
SELECT 
	o.order_status ,
	COUNT(DISTINCT o.order_id) 
FROM orders o 
WHERE (o.order_status = 'processing' OR o.order_status = 'canceled') AND (o.order_estimated_delivery_date >= '2017-01-01' OR o.order_estimated_delivery_date <= '2016-11-23')
GROUP BY o.order_status 

-- 6. Quantos produtos estão cadastrados nas categorias: perfumaria, brinquedos, esporte lazer, cama mesa e banho e móveis de escritório que possuem mais de 5 fotos, um peso maior que 5 g, um 
-- altura maior que 10 cm, uma largura maior que 20 cm?
SELECT
	product_category_name ,
	COUNT( DISTINCT product_id )
FROM products p
WHERE ( product_category_name = 'perfumaria'
		OR product_category_name = 'brinquedos'
		OR product_category_name = 'esporte_lazer'
		OR product_category_name = 'cama_mesa_banho'
		OR product_category_name = 'moveis_escritorio')
		AND product_photos_qty > 5
		AND product_weight_g > 5
		AND product_height_cm > 10
		AND product_width_cm > 20
GROUP BY product_category_name


-- Exercícios 06

-- 1. Quantos clientes únicos tiveram seu pedidos com status de “processing”, “shipped” e “delivered”, feitos entre os dias 01 e 31 de Outubro de 2016. 
-- Mostrar o resultado somente se o número total de clientes for acima de 5.
SELECT 
	COUNT(DISTINCT o.customer_id) 
FROM orders o 
WHERE o.order_status IN ('processing', 'shipped', 'delivered') AND (DATE(o.order_approved_at) BETWEEN '2016-10-01' AND '2016-10-31')
GROUP BY o.order_status 
HAVING COUNT(DISTINCT customer_id) > 5 

-- 2. Mostre a quantidade total dos pedidos e o valor total do pagamento, para pagamentos entre 1 e 5 prestações ou um valor de pagamento acima de R$ 5000.
SELECT 
	op.payment_installments ,
	COUNT(op.order_id),
	SUM(op.payment_value) 
FROM order_payments op 
WHERE (op.payment_installments BETWEEN 1 AND 5) OR op.payment_value > 5000 
GROUP BY op.payment_installments 

-- 3. Quantos produtos estão cadastrados nas categorias: perfumaria, brinquedos, esporte lazer e cama mesa, que possuem entre 5 e 10 fotos, um peso que não está entre 1 e 5 g, 
-- um altura maior que 10 cm, uma largura maior que 20 cm. Mostra somente as linhas com mais de 10 produtos únicos.
SELECT 
	p.product_category_name ,
	COUNT(DISTINCT p.product_id) 
FROM products p 
WHERE (p.product_category_name IN ('perfumaria', 'brinquedos', 'esporte_lazer', 'cama_mesa_banho')) 
							   AND (p.product_photos_qty BETWEEN 5 AND 10) 
							   AND (p.product_weight_g NOT BETWEEN 1 AND 5)
							   AND (p.product_height_cm > 10)
							   AND (p.product_width_cm > 20)
GROUP BY p.product_category_name 
HAVING COUNT(DISTINCT p.product_id) > 10 


-- 4. Refazer a consulta SQL abaixo, usando os operadores de intervalo.
SELECT
	order_status ,
	COUNT( order_id ) AS pedidos
FROM orders o
WHERE ( order_status = 'processing' OR order_status = 'canceled' )
AND ( o.order_estimated_delivery_date > '2017-01-01' OR o.order_estimated_delivery_date < '2016-11-23' )
GROUP BY order_status

SELECT 
	o.order_status ,
	COUNT(o.order_id) AS pedidos 
FROM orders o 
WHERE (o.order_status IN ('processing', 'canceled')) AND 
	  (o.order_estimated_delivery_date BETWEEN '2016-11-23' AND '2017-01-01')
GROUP BY o.order_status 

-- 5. Qual a quantidade de cidades únicas dos vendedores no estado de São Paulo ou Rio de Janeiro com a latitude maior que -24.54 e longitude menor que -45.63?
SELECT 
	g.geolocation_state ,
	COUNT(DISTINCT g.geolocation_city) 
FROM geolocation g  
WHERE (g.geolocation_state IN ('SP', 'RJ')) AND (g.geolocation_lat > -24.54 AND g.geolocation_lng < -45.63)
GROUP BY g.geolocation_state 

-- 6. Quantos produtos estão cadastrados em qualquer categorias que comece com a letra “a” e termine com a letra “o” e que possuem mais de 5 fotos?
-- Mostrar as linhas com mais de 10 produtos.
SELECT 
	p.product_category_name ,
	COUNT(DISTINCT p.product_id) 
FROM products p 
WHERE (p.product_category_name LIKE 'a%o') AND (p.product_photos_qty > 5)
GROUP BY p.product_category_name 
HAVING COUNT(DISTINCT p.product_id) > 10 

-- 7. Qual o número de clientes únicos, agrupados por estado e por cidades que comecem com a letra “m”, tem a letra “o” e terminem com a letra “a”?
-- Mostrar os resultados somente para o número de clientes únicos maior que 10.
SELECT 
	c.customer_state ,
	c.customer_city ,
	COUNT(DISTINCT customer_id) 
FROM customer c 
WHERE c.customer_city LIKE 'm%o%a'
GROUP BY c.customer_state , c.customer_city 
HAVING COUNT(DISTINCT customer_id) > 10



-- Exercícios 07

-- 1. Gerar uma tabela de dados com 10 linhas, contendo o id do pedido, o id do cliente, o status do pedido, o id do produto e o preço do produto
SELECT 
	o.order_id ,
	o.customer_id ,
	o.order_status ,
	oi.product_id ,
	oi.price 
FROM orders o INNER JOIN order_items oi ON (o.order_id = oi.order_id)
LIMIT 10

-- 2. Gerar uma tabela de dados com 20 linhas, contendo o id do pedido, o estado do cliente, a cidade do cliente, o status do pedido, o id do produto e o preço do produto, somente
-- para clientes do estado de São Paulo
SELECT 
	oi.order_id ,
	c.customer_state ,
	c.customer_city ,
	o.order_status ,
	oi.product_id ,
	oi.price 
FROM orders o INNER JOIN customer c ON (o.customer_id = c.customer_id)
			  INNER JOIN order_items oi ON (o.order_id = oi.order_id)
WHERE c.customer_state = 'SP'
LIMIT 20;

-- 3. Gerar uma tabela de dados com 50 linhas, contendo o id do pedido, o estado e a cidade do cliente, o status do pedido, o nome da categoria do produto e o preço do
-- produto, somente para pedidos com o status igual a cancelado.
SELECT 
	o.order_id ,
	c.customer_state ,
	c.customer_city ,
	o.order_status ,
	p.product_category_name ,
	oi.price 
FROM orders o INNER JOIN order_items oi ON (o.order_id = oi.order_id)
			  INNER JOIN customer c ON (o.customer_id = c.customer_id)
			  INNER JOIN products p ON (oi.product_id = p.product_id)
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
FROM orders o INNER JOIN customer c ON (o.customer_id = c.customer_id)
			  INNER JOIN order_items oi ON (o.order_id = oi.order_id)
			  INNER JOIN products p ON (oi.product_id = p.product_id)
			  INNER JOIN sellers s ON (oi.seller_id = s.seller_id)
WHERE o.order_approved_at  >= '2016-09-16'
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
FROM orders o INNER JOIN customer c ON (o.customer_id = c.customer_id)
			  INNER JOIN order_items oi ON (o.order_id = oi.order_id)
			  INNER JOIN products p ON (oi.product_id = p.product_id)
			  INNER JOIN sellers s ON (oi.seller_id = s.seller_id)
			  INNER JOIN order_payments op ON (o.order_id = op.order_id)
WHERE op.payment_type = 'boleto'
LIMIT 10

-- 6. Gerar uma tabela de dados com 70 linhas, contendo o id do pedido, o estado e a cidade do cliente, o status do pedido, o nome da categoria do produto, o preço do produto, a
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
FROM orders o INNER JOIN customer c ON (o.customer_id = c.customer_id)
			  INNER JOIN order_items oi ON (o.order_id = oi.order_id)
			  INNER JOIN products p ON (oi.product_id = p.product_id)
			  INNER JOIN sellers s ON (oi.seller_id = s.seller_id)
			  INNER JOIN order_payments op ON (o.order_id = op.order_id)
			  INNER JOIN order_reviews or2 ON (o.order_id = or2.order_id)
WHERE or2.review_score  = 1
LIMIT 70;


-- Subquery
-- Fazendo com left join

SELECT 
	oi.order_id ,
	p.product_category_name as categoria
FROM order_items oi LEFT JOIN products p ON (oi.product_id = p.product_id)
LIMIT 10

-- E agora com subquery no select
SELECT 
	oi.order_id ,
	(SELECT p.product_category_name 
	FROM products p 
	WHERE p.product_id = oi.product_id) as categoria
FROM order_items oi 
LIMIT 10;

-- Os 2 fazem a mesma coisa

-- Agora no Where, primeiro com o JOIN

SELECT 
	AVG(oi.price) 
FROM orders o INNER JOIN order_items oi ON (o.order_id = oi.order_id)
WHERE o.order_status = 'delivered'

-- Agora com subquery no where
SELECT 
	AVG(oi.price)
FROM order_items oi  
WHERE oi.order_id IN (SELECT o.order_id 
		FROM orders o 
		WHERE o.order_status = 'delivered')

-- Exercícios 08

-- 1. Qual o número de pedidos com o tipo de pagamento igual a “boleto”?

SELECT 
	COUNT(DISTINCT o.order_id) 
FROM orders o 
WHERE o.order_id IN (SELECT op.order_id 
					 FROM order_payments op 
					 WHERE op.payment_type = 'boleto')
					 
-- 2. Refaça o exercício 01 usando união de tabelas.
SELECT 
	COUNT(DISTINCT o.order_id) 
FROM orders o LEFT JOIN order_payments op ON (o.order_id = op.order_id)
WHERE op.payment_type = 'boleto'
		
-- 3. Crie uma tabela que mostre a média de avaliações por dia, a média de preço por dia, a soma dos preços por dia, o preço mínimo por dia, o número de pedidos por dia e o 
-- número de clientes únicos que compraram no dia.

SELECT 
	t1._date,
	t1.avg_score,
	t2.avg_price,
	t2.sum_price,
	t2.min_price,
	t3.orders_day,
	t3.customers_day
FROM ( 
	SELECT DATE(or2.review_creation_date) as _date,
	   AVG(or2.review_score) as avg_score
	FROM order_reviews or2 
	GROUP BY DATE(or2.review_creation_date) 
	) as t1
LEFT JOIN 
	(
	SELECT DATE(oi.shipping_limit_date) as _date,
	   AVG(oi.price) as avg_price,
	   SUM(oi.price) as sum_price,
	   MIN(oi.price) as min_price 
	FROM order_items oi 
	GROUP BY DATE(oi.shipping_limit_date) 
	) as t2 ON (t2._date = t1._date)
LEFT JOIN 
	(
	SELECT DATE(o.order_purchase_timestamp) as _date,
	   COUNT(DISTINCT o.order_id) as orders_day,
	   COUNT(DISTINCT o.customer_id) as customers_day 
	FROM orders o 
	GROUP BY DATE(o.order_purchase_timestamp) 
	) as t3 ON (t3._date = t2._date)
	


-- Exercícios 09

-- 4.1 Crie uma consulta que exiba o código do produto e a categoria de cada produto com base no seu preço:
SELECT 
	oi.product_id ,
	CASE 
		WHEN oi.price < 50 THEN 'barato' ELSE 'CARO' 
	END as status
FROM order_items oi 


-- Calculando preço médio por categoria com Windows Function
SELECT 
	p.product_category_name,
	oi.price,
	AVG ( oi.price ) OVER ( PARTITION BY p.product_category_name ) AS avg_price
FROM order_items oi INNER JOIN products p ON (oi.product_id = p.product_id)
WHERE p.product_category_name  IS NOT NULL

SELECT
	p.product_category_name,
	oi.price,
	AVG ( oi.price ) OVER ( PARTITION BY p.product_category_name ) AS avg_price
FROM order_items oi INNER JOIN products p ON ( p.product_id = oi.product_id )
WHERE p.product_category_name IS NOT NULL









