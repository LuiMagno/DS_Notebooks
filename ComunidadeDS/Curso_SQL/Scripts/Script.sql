SELECT
    p.product_category_name AS categoria,
    MAX(DATE(o.order_delivered_customer_date) - DATE(o.order_purchase_timestamp)) AS dias_entrega_maximos
FROM
    products p
JOIN
    order_items oi ON p.product_id = oi.product_id
JOIN
    orders o ON oi.order_id = o.order_id
WHERE
    o.order_delivered_customer_date IS NOT NULL
GROUP BY
    p.product_category_name
ORDER BY
    dias_entrega_maximos DESC
LIMIT 1;


-- 1
SELECT 
	p.product_id ,
	p.product_category_name as categoria ,
	MIN(DATE(o.order_purchase_timestamp)) as primeira_compra,
	DATE(oi.shipping_limit_date) as data_limite_entrega,
	JULIANDAY((DATE(oi.shipping_limit_date))) - JULIANDAY(MIN(DATE( o.order_purchase_timestamp)))   as diferenca
FROM order_items oi INNER JOIN products p ON (oi.product_id = p.product_id)
					INNER JOIN orders o ON (oi.order_id = o.order_id)
WHERE oi.shipping_limit_date IS NOT NULL AND p.product_category_name IS NOT NULL AND p.product_category_name = 'utilidades_domesticas'
GROUP BY p.product_id 
ORDER BY diferenca DESC

-- Resposta Utilidades Domesticas
-- 2


-- 3

SELECT 
	p.product_category_name ,
	SUM(oi.price) as soma
FROM order_items oi INNER JOIN products p ON (oi.product_id = p.product_id)
GROUP BY p.product_category_name 
ORDER BY soma DESC

-- Resposta: Beleza e Saúde

-- 4
SELECT 
	p.product_id ,
	P.product_category_name ,
	MAX(oi.price ) AS valor_maximo
FROM order_items oi INNER JOIN products p ON (oi.product_id = p.product_id)
WHERE p.product_category_name = 'agro_industria_e_comercio'

-- Resposta: 2b69866f22de8dad69c976771daba91c

-- 5
SELECT 
	p.product_category_name ,
	MAX(oi.price) 
FROM order_items oi INNER JOIN products p ON (oi.product_id = p.product_id)
GROUP BY p.product_category_name 
ORDER BY oi.price DESC

-- Resposta Utilidade doméstica, pcs e artes


-- 6
SELECT 
	p.product_id ,
	p.product_category_name,
	MAX(oi.price )
FROM order_items oi INNER JOIN products p ON (oi.product_id = p.product_id) 
WHERE p.product_category_name IN ('bebes','flores','seguros_e_servicos')
GROUP BY p.product_category_name 

SELECT
    p.product_category_name AS categoria,
    MAX(oi.price) AS valor_produto_mais_caro
FROM
    products p
JOIN
    order_items oi ON p.product_id = oi.product_id
WHERE
    p.product_category_name IN ('bebes', 'flores', 'seguros_e_servicos')
GROUP BY
    p.product_category_name;
-- Resposta: Não sei

-- 7 
SELECT COUNT(*) AS pedidos_com_criterios
FROM (
    SELECT o.order_id
    FROM orders o
    INNER JOIN order_items oi ON (o.order_id = oi.order_id)
    INNER JOIN order_payments op ON (o.order_id = op.order_id)
    WHERE op.payment_installments = 10
    GROUP BY o.order_id
    HAVING COUNT(DISTINCT o.customer_id) = 1
       AND COUNT(DISTINCT oi.product_id) = 3
) AS subquery;	



-- 8 
SELECT 
	COUNT(op.order_id) 
FROM order_payments op 
WHERE op.payment_installments > 10


-- 9 
SELECT COUNT(or2.review_score) 
FROM order_reviews or2 
WHERE or2.review_score = 5

-- Resposta = 57420

-- 10 
SELECT COUNT(or2.review_score) 
FROM order_reviews or2 
WHERE or2.review_score = 4

-- Resposta = 19200

-- 11
SELECT COUNT(or2.review_score) 
FROM order_reviews or2 
WHERE or2.review_score = 3

-- Reposta = 8287

-- 12
SELECT COUNT(or2.review_score) 
FROM order_reviews or2 
WHERE or2.review_score = 2

-- Resposta 3235

-- 13
SELECT COUNT(or2.review_score) 
FROM order_reviews or2 
WHERE or2.review_score = 1

-- Resposta 11858


-- 14
SELECT
	DATE(o.order_purchase_timestamp),
	oi.price,
AVG( oi.price ) OVER ( ORDER BY DATE(o.order_purchase_timestamp)
ROWS BETWEEN 7 PRECEDING AND CURRENT ROW ) AS media_movel_7_dias
FROM orders o LEFT JOIN order_items oi ON ( oi.order_id = o.order_id )

-- Resposta: 52.48

-- 15
SELECT
	o.order_purchase_timestamp,
	oi.price,
AVG( oi.price ) OVER ( ORDER BY o.order_purchase_timestamp
ROWS BETWEEN 14 PRECEDING AND CURRENT ROW ) AS media_movel_7_dias
FROM orders o LEFT JOIN order_items oi ON ( oi.order_id = o.order_id )

-- Resposta: 79.83

-- 16
SELECT 
	p.product_category_name ,
	p.product_id ,
	oi.price 
FROM order_items oi INNER JOIN products p ON (oi.product_id  = p.product_id)
WHERE p.product_category_name = 'agro_industria_e_comercio'

SELECT 
	p.product_category_name 
FROM products p 

-- Resposta d5dbb4d9ecbbf2e312169e4c8f1b57f0

-- 17
SELECT 
	p.product_category_name ,
	p.product_id ,
	oi.price 
FROM order_items oi INNER JOIN products p ON (oi.product_id  = p.product_id)
WHERE p.product_category_name = 'artes'

-- Resposta 1bdf5e6731585cf01aa8169c7028d6ad

-- 18
SELECT 
	p.product_category_name ,
	p.product_id ,
	oi.price 
FROM order_items oi INNER JOIN products p ON (oi.product_id  = p.product_id)
WHERE p.product_category_name = 'artes'









WITH RankingProdutos AS (
    SELECT
        oi.product_id,
        oi.price,
        p.product_category_name
    FROM
        order_items oi
    JOIN
        products p ON oi.product_id = p.product_id
    WHERE
        p.product_category_name = 'artes'
    ORDER BY
        oi.price DESC
),
ProdutosNumerados AS (
    SELECT
        *,
        ROW_NUMBER() OVER (ORDER BY price DESC) AS posicao_ranking
    FROM
        RankingProdutos
)
SELECT
    SUM(price) AS soma_acima_posicao_5
FROM
    ProdutosNumerados
WHERE
    posicao_ranking BETWEEN 2 and 5;
Nesta consulta:







