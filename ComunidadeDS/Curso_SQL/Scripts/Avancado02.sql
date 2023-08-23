-- 4.1 Qual o valor da média ponderada das avaliações dos produtos que foram comprados a partir do dia 1 de Janeiro de 2018.
SELECT 
	AVG(CASE
			WHEN or2.review_score = 5 THEN (or2.review_score * 0.2)
			WHEN or2.review_score = 4 THEN (or2.review_score * 0.1)
			WHEN or2.review_score = 3 THEN (or2.review_score * 0.3)
			WHEN or2.review_score = 2 THEN (or2.review_score * 0.3)
			WHEN or2.review_score = 1 THEN (or2.review_score * 0.1)
			WHEN or2.review_score = 0 THEN (or2.review_score * 0.0)
		END 	) AS media_review
FROM  order_reviews or2 LEFT JOIN orders o ON (or2.order_id = o.order_id)
WHERE DATE(o.order_purchase_timestamp ) >= '2018-01-01'



-- 4.2 Calcule a média ponderada por mês, do exercício anterior
SELECT 
	STRFTIME( '%m', or2.review_creation_date ) AS mes,
	AVG(CASE
			WHEN or2.review_score = 5 THEN (or2.review_score * 0.2)
			WHEN or2.review_score = 4 THEN (or2.review_score * 0.1)
			WHEN or2.review_score = 3 THEN (or2.review_score * 0.3)
			WHEN or2.review_score = 2 THEN (or2.review_score * 0.3)
			WHEN or2.review_score = 1 THEN (or2.review_score * 0.1)
			WHEN or2.review_score = 0 THEN (or2.review_score * 0.0)
		END 	) AS media_review
FROM  order_reviews or2 LEFT JOIN orders o ON (or2.order_id = o.order_id)
WHERE DATE(o.order_purchase_timestamp ) >= '2018-01-01'
GROUP BY STRFTIME( '%m', or2.review_creation_date )


-- 4.3 
SELECT
	product_category_name,
	SUM(
		CASE
			WHEN status = 'alterado' THEN ( price - novo_preco )
		ELSE 0
		END
		) AS desconto_total,
		AVG(
			CASE
				WHEN status = 'alterado' THEN ( price - novo_preco )
			ELSE 0
			END
		) AS desconto_medio,
		MIN(
			CASE
				WHEN status = 'alterado' THEN ( price - novo_preco )
			ELSE 0
		END
		) AS desconto_minimo,
		MAX(
			CASE
				WHEN status = 'alterado' THEN ( price - novo_preco )
			ELSE 0
		END
		) AS desconto_maximo,
		COUNT(
			CASE
				WHEN status = 'alterado' THEN ( price - novo_preco )
			ELSE 0
		END
		) AS qtde_produtos_desconto
FROM (
	SELECT
		p.product_category_name,
		oi.price,
		CASE
			WHEN p.product_category_name = 'livros_tecnicos' THEN oi.price * 0.9
			WHEN p.product_category_name = 'pet_shop' THEN oi.price * 0.8
			WHEN p.product_category_name = 'pc_gamer' THEN oi.price * 0.5
			WHEN p.product_category_name = 'tablets_impressao_imagem' THEN oi.price * 0.1
			WHEN p.product_category_name = 'fashion_esports' THEN oi.price * 0.6
			ELSE oi.price
		END AS novo_preco,
		CASE
			WHEN p.product_category_name IN ( 'livros_tecnicos', 'pet_shop', 'pc_gamer',
			'tablets_impressao_imagem', 'fashion_esports') THEN 'alterado'
			ELSE 'normal'
		END AS status
FROM order_items oi LEFT JOIN products p ON ( p.product_id = oi.product_id )
WHERE p.product_category_name IN ( 'livros_tecnicos',
	'pet_shop',
	'pc_gamer',
	'tablets_impressao_imagem',
	'fashion_esports',
	'perfumaria',
	'telefonia',
	'beleza_saude',
	'ferramentas_jardim')
	)
GROUP BY product_category_name;


-- Selecionar número de pedidos por categoria de produto

SELECT 
	p.product_category_name ,
	COUNT(DISTINCT order_id)
FROM order_items oi  LEFT JOIN products p ON (oi.product_id = p.product_id)
GROUP BY p.product_category_name 
