USE restaurante;

-- Selecionar: produtos: id, nome e descrição / info_produtos: ingredientes
SELECT p.id_produto, p.nome, p.descricao, ip.ingredientes
FROM produtos p
JOIN info_produtos ip ON p.id_produto = ip.id_produto;

-- Selecionar: pedidos:  id, quantidade e data / clientes: nome e email
SELECT pe.id_pedido, pe.quantidade, pe.data_pedido, c.nome, c.email
FROM pedidos pe
JOIN clientes c ON pe.id_cliente = c.id_cliente;

-- Selecionar: pedidos:  id, quantidade e data / clientes: nome e email / funcionarios: nome
SELECT pe.id_pedido, pe.quantidade, pe.data_pedido, c.nome, c.email, f.nome
FROM pedidos pe
JOIN clientes c ON pe.id_cliente = c.id_cliente
JOIN funcionarios f ON pe.id_funcionario = f.id_funcionario;

-- Selecionar: pedidos:  id, quantidade e data / clientes: nome e email / funcionarios: nome / produtos: nome, preco
SELECT pe.id_pedido, pe.quantidade, pe.data_pedido, c.nome as Nome_Cliente, c.email, f.nome as Nome_Funcionário, pr.nome as Nome_produto, pr.preco
FROM pedidos pe
JOIN clientes c ON pe.id_cliente = c.id_cliente
JOIN funcionarios f ON pe.id_funcionario = f.id_funcionario
JOIN  produtos pr ON pe.id_produto = pr.id_produto;

-- Selecionar o nome dos clientes com os pedidos com status ‘Pendente’ e exibir por ordem descendente de acordo com o id do pedido
SELECT pe.id_pedido, pe.status, c.nome
FROM pedidos pe
JOIN clientes c ON pe.id_cliente = c.id_cliente
Where pe.status = 'Pendente'
ORDER BY pe.id_pedido DESC;

-- Selecionar clientes sem pedidos
SELECT c.*
FROM clientes c
LEFT JOIN pedidos pe ON c.id_cliente = pe.id_cliente
WHERE pe.id_pedido IS NULL;

SELECT c.id_cliente, c.nome, c.email
FROM clientes c
WHERE c.id_cliente NOT IN (
    SELECT DISTINCT p.id_cliente
    FROM pedidos p
);

-- Selecionar o nome do cliente e o total de pedidos cada cliente
SELECT c.nome AS cliente_nome, COUNT(p.id_pedido) AS total_pedidos
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nome;

-- Selecionar o preço total (quantidade*preco) de cada pedido
SELECT pe.id_pedido, pe.quantidade*pe.preco AS preco_total
FROM pedidos pe
GROUP BY pe.id_pedido;



