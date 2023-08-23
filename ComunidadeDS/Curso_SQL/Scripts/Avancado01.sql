-- Case When
SELECT 
	oi.price ,
	CASE 
		WHEN oi.price < 100 THEN 'barato'
		ELSE 'caro'
	END as status
FROM order_items oi 
LIMIT 10

-- IIF
SELECT 
	oi.price ,
	IIF(oi.price <100, 'barato', 'caro') AS status
FROM order_items oi 
LIMIT 10

-- Múltiplas condições
SELECT oi.price ,
	CASE
		WHEN oi.price < 20 THEN 'super-barato'
		WHEN oi.price < 100 THEN 'barato'
		WHEN oi.price > 150 AND oi.price < 180 THEN 'normal'
		ELSE 'caro'
	END AS status
FROM order_items oi 


-- Exercícios Aula 01 Avançado

-- 4.1 Crie uma consulta que exiba o código do produto e a categoria de cada produto com base no seu preço:
SELECT 
	oi.price ,
	CASE 
		WHEN oi.price < 50 THEN 'A'
		WHEN oi.price < 100 THEN 'B'
		WHEN oi.price < 500 THEN 'C'
		WHEN oi.price < 1500 THEN 'D'
		ELSE 'E'
	END AS 'Categoria'
FROM order_items oi 


-- 4.2 Calcule a quantidade de produtos para cada uma das categorias criadas no exercícios anterior.
SELECT 
	Categoria,
	COUNT(product_id) as produtos
FROM (SELECT 
		oi.product_id ,
		CASE 
			WHEN oi.price < 50 THEN 'A'
			WHEN oi.price < 100 THEN 'B'
			WHEN oi.price < 500 THEN 'C'
			WHEN oi.price < 1500 THEN 'D'
			ELSE 'E'
		END AS 'Categoria'
	FROM order_items oi 
	  )
GROUP BY Categoria


-- 4.3 Selecione os seguintes categorias de produtos: livros técnicos, pet shop, pc gamer, tablets impressão imagem, fashion esports, perfumaria, telefonia, beleza saude, ferramentas jardim.
SELECT 
	p.product_id ,
	p.product_category_name, 
	oi.price ,
	CASE 
		WHEN p.product_category_name = 'livros_tecnicos' THEN oi.price * 0.9
		WHEN p.product_category_name = 'pet_shop' THEN oi.price * 0.80
		WHEN p.product_category_name = 'pc_gamer' THEN oi.price * 0.50
		WHEN p.product_category_name = 'tablets_impressao_imagem' THEN oi.price * 0.9
		WHEN p.product_category_name = 'fashion_sports' THEN oi.price * 0.95
	END AS new_price,
	CASE 
		WHEN p.product_category_name IN ('livros_tecnicos', 'pet_shop', 'pc_gamer', 'tablets_impressao_imagem', 'fashion_sports') THEN 'alterado'
		ELSE 'normal'
	END AS status
FROM order_items oi LEFT JOIN products p ON (p.product_id = oi.product_id)
WHERE p.product_category_name IN ( 'livros_tecnicos',
'pet_shop',
'pc_gamer',
'tablets_impressao_imagem',
'fashion_esports',
'perfumaria',
'telefonia',
'beleza_saude',
'ferramentas_jardim')

-- 4.4 Crie uma coluna que mostra o status de entrega do pedido. Se a coluna estiver vazia, o status é de pendente
SELECT 
	o.order_id ,
	o.order_delivered_customer_date ,
	CASE 
		WHEN o.order_delivered_customer_date = NULL THEN 'pendente'
		WHEN DATE(o.order_delivered_customer_date) < '2017-06-01' THEN 'entregue'
		WHEN DATE(o.order_delivered_customer_date) > '2017-06-01' THEN 'programado'
	END AS status_pedido
FROM orders o 



SELECT 
	p.product_category_name 
FROM products p 
GROUP BY p.product_category_name 

