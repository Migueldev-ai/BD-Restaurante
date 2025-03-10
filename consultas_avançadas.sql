USE restaurante;

-- View resumo do pedido 
CREATE VIEW resumo_pedido AS
SELECT 
    p.id_pedido AS pedido_id, 
    p.quantidade, 
    p.data_pedido AS data, 
    c.nome AS cliente_nome, 
    c.email AS cliente_email, 
    f.nome AS funcionario_nome, 
    pr.nome AS produto_nome, 
    pr.preco AS produto_preco
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente
JOIN funcionarios f ON p.id_funcionario = f.id_funcionario
JOIN produtos pr ON p.id_produto = pr.id_produto;

SELECT * FROM resumo_pedido;

-- Seleciona o id do pedido, nome do cliente e o total (quantidade * preco) de cada pedido da view resumo_pedido
SELECT pedido_id, cliente_nome, (produto_preco * quantidade) AS Total FROM resumo_pedido;

-- Atualiza o view resumo pedido, adicionando campo total
DROP VIEW IF EXISTS resumo_pedido;

CREATE VIEW resumo_pedido AS
SELECT
    p.id_pedido AS pedido_id, 
    p.quantidade, 
    p.data_pedido AS data, 
    c.nome AS cliente_nome, 
    c.email AS cliente_email, 
    f.nome AS funcionario_nome, 
    pr.nome AS produto_nome, 
    pr.preco AS produto_preco,
    (p.quantidade * pr.preco) AS total
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente
JOIN funcionarios f ON p.id_funcionario = f.id_funcionario
JOIN produtos pr ON p.id_produto = pr.id_produto;

-- Consulta anterior com uso do EXPLAIN
EXPLAIN SELECT * FROM resumo_pedido;

-- Crie uma função chamada ‘BuscaIngredientesProduto’, que irá retornar os ingredientes da 
-- tabela info produtos, quando passar o id de produto como argumento (entrada) da função.

DELIMITER //
CREATE FUNCTION BuscaIngredientesProduto(produto_id INT)
RETURNS TEXT
READS SQL DATA
BEGIN
    DECLARE ingrediente TEXT;
    SELECT GROUP_CONCAT(ingredientes SEPARATOR ', ') INTO ingrediente FROM info_produtos WHERE produto_id = id_produto;
	RETURN ingrediente;
END //
DELIMITER ;

SELECT BuscaIngredientesProduto(10);
DROP FUNCTION BuscaIngredientesProduto;


-- Função  ‘mediaPedido’ que irá retornar uma mensagem dizendo se o total do pedido é acima, abaixo ou igual a média, passando o id do pedido como argumento
DELIMITER //
CREATE FUNCTION mediaPedido(pedido_id INT)
RETURNS FLOAT
READS SQL DATA
BEGIN 
		DECLARE media_pedido FLOAT;
        SELECT (SELECT total FROM resumo_pedido WHERE pedido_id = pedido_id) INTO media_pedido FROM pedidos WHERE pedido_id = id_pedido;
        RETURN media_pedido;
END //
DELIMITER ;

DELIMITER $$
CREATE FUNCTION mediaPedido(id_pedido INT)
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE total_pedido DECIMAL(10,2);
    DECLARE media DECIMAL(10,2);
    DECLARE mensagem VARCHAR(255);

    -- Calcular o total do pedido
    SELECT SUM(p.preco * pd.quantidade) INTO total_pedido
    FROM pedidos pd
    JOIN produtos p ON pd.id_produto = p.id_produto
    WHERE pd.id_pedido = id_pedido;

    -- Calcular a média dos totais dos pedidos
    SELECT AVG(p.preco * pd.quantidade) INTO media
    FROM pedidos pd
    JOIN produtos p ON pd.id_produto = p.id_produto;

    -- Comparar o total do pedido com a média
    IF total_pedido > media THEN
        SET mensagem = 'O total do pedido é acima da média.';
    ELSEIF total_pedido < media THEN
        SET mensagem = 'O total do pedido é abaixo da média.';
    ELSE
        SET mensagem = 'O total do pedido é igual à média.';
    END IF;

    -- Retornar a mensagem
    RETURN mensagem;
END$$
DELIMITER ;

SELECT mediaPedido(5);
DROP FUNCTION mediaPedido;
