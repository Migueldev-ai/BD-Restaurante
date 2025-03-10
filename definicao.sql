-- Criação e uso do banco de dados
-- CREATE DATABASE restaurante;
USE restaurante;

-- Criação da tabela de Funcionários
CREATE TABLE IF NOT EXISTS funcionarios (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    data_nascimento DATE NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    salario DECIMAL(10,2) NOT NULL,
    data_admissao DATE NOT NULL
);

-- Criação da tabela de Clientes
CREATE TABLE IF NOT EXISTS clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    data_nascimento DATE NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    data_cadastro DATE NOT NULL
);

-- Criação da tabela de Produtos
CREATE TABLE IF NOT EXISTS produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    categoria VARCHAR(100) NOT NULL
);

-- Criação da tabela de Pedidos
CREATE TABLE IF NOT EXISTS pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_funcionario INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    data_pedido DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);
ALTER TABLE pedidos
MODIFY COLUMN preco DECIMAL(10,2) NOT NULL DEFAULT 10.00;

-- Criação da tabela de Informações Adicionais dos Produtos
CREATE TABLE IF NOT EXISTS info_produtos (
    id_info INT AUTO_INCREMENT PRIMARY KEY,
    id_produto INT NOT NULL,
    ingredientes TEXT NOT NULL,
    fornecedor VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);
