USE restaurante;

SELECT COUNT(*) AS quantidade_pedidos FROM pedidos;
SELECT COUNT(DISTINCT id_cliente) AS quantidade_clientes FROM pedidos;
SELECT ROUND(AVG(preco), 2) AS preço_médio FROM produtos;
SELECT MAX(preco) AS preço_máximo, MIN(preco) AS preço_mínimo FROM produtos;
SELECT DISTINCT nome, preco FROM produtos ORDER BY preco DESC LIMIT 5;
SELECT categoria, ROUND(AVG(preco), 2) AS preço_médio FROM produtos GROUP BY categoria;
SELECT fornecedor, COUNT(id_produto) AS Quantidade FROM info_produtos GROUP BY fornecedor;

SELECT fornecedor, COUNT(id_produto) AS Quantidade FROM info_produtos 
GROUP BY fornecedor HAVING COUNT(id_produto) > 1;

SELECT id_cliente, COUNT(id_cliente) AS quantidade FROM pedidos 
GROUP BY id_cliente HAVING COUNT(quantidade) > 1; -- OU HAVING COUNT(id_cliente)
