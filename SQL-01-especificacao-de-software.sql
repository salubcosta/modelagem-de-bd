# SETUP DATABASE dbestudo_01
CREATE DATABASE dbestudo_01;

USE dbestudo_01;

CREATE TABLE setor(
idSetor INT primary key not null auto_increment,
descricao VARCHAR(45) not null,
dt_cadastro DATETIME DEFAULT current_timestamp,
dt_atualizacao DATETIME ON UPDATE current_timestamp
);
# INSERT INTO setor (descricao) VALUE ('Administração de Dados'); # Data de cadastro automático
# SELECT * FROM setor;
# UPDATE setor SET descricao = 'Administração de Banco de Dados' where idSetor = 1; # Data de atualizacao autmático
#SELECT * FROM setor; 

CREATE TABLE funcionario(
idFuncionario INT primary key not null auto_increment,
nome VARCHAR(45) not null,
sobrenome VARCHAR(45) not null,
rg DECIMAL(11,2) not null,
cpf VARCHAR(11) not null,
dt_cadastro DATETIME DEFAULT current_timestamp,
dt_atualizacao DATETIME ON UPDATE current_timestamp,
idSetor INT,
FOREIGN KEY(idSetor) REFERENCES setor(idSetor)
);

CREATE TABLE dependente(
idDependente INT primary key not null auto_increment,
nome VARCHAR(45) not null,
sobrenome VARCHAR(45) not null,
cpf VARCHAR(11) not null,
dt_cadastro DATETIME DEFAULT current_timestamp,
dt_atualizacao DATETIME ON UPDATE current_timestamp,
idFuncionario INT,
FOREIGN KEY(idFuncionario) REFERENCES funcionario(idFuncionario)
);

CREATE TABLE cliente(
idCliente INT primary key not null auto_increment,
nome VARCHAR(45) not null,
sobrenome VARCHAR(45) not null,
rg VARCHAR(45) not null,
cpf VARCHAR(11) not null,
dt_cadastro DATETIME DEFAULT current_timestamp,
dt_atualizacao DATETIME ON UPDATE current_timestamp
);

CREATE TABLE email(
idEmail INT primary key not null auto_increment,
descricao VARCHAR(45) not null,
idCliente INT,
FOREIGN KEY(idCliente) REFERENCES cliente(idCliente)
);

CREATE TABLE tipo_endereco(
idTipoEndereco INT primary key not null auto_increment,
tipo VARCHAR(1), # F PARA FUNCIONARIO E C PARA CLIENTE
idFuncionario INT,
idCliente INT,
FOREIGN KEY(idFuncionario) REFERENCES funcionario(idFuncionario),
FOREIGN KEY(idCliente) REFERENCES cliente(idCliente)
);

CREATE TABLE endereco(
idEndereco INT primary key not null auto_increment,
logradouro VARCHAR(45) not null,
bairro VARCHAR(45) not null,
cidade VARCHAR(45) not null,
uf VARCHAR(2) not null,
idTipoEndereco INT,
FOREIGN KEY(idTipoEndereco) REFERENCES tipo_endereco(idTipoEndereco)
);

CREATE TABLE telefone(
idTelefone INT primary key not null auto_increment,
numero VARCHAR(45) not null,
dt_cadastro DATETIME DEFAULT current_timestamp,
dt_atualizacao DATETIME ON UPDATE current_timestamp,
idFuncionario INT,
idCliente INT,
FOREIGN KEY(idFuncionario) REFERENCES funcionario(idFuncionario),
FOREIGN KEY(idCliente) REFERENCES cliente(idCliente)
);

CREATE TABLE compra(
idCompra INT primary key not null auto_increment,
descricao VARCHAR(45) not null,
valorTotal DECIMAL(11,2) not null,
dt_compra DATETIME DEFAULT current_timestamp,
idFuncionario INT not null,
idCliente INT not null,
FOREIGN KEY(idFuncionario) REFERENCES funcionario(idFuncionario),
FOREIGN KEY(idCliente) REFERENCES cliente(idCliente)
);

CREATE TABLE produto(
idProduto INT primary key not null auto_increment,
descricao VARCHAR(45) not null,
valorUnitario DECIMAL(11,2) not null,
dt_cadastro DATETIME DEFAULT current_timestamp,
dt_atualizacao DATETIME ON UPDATE current_timestamp
);

CREATE TABLE itens(
idItem INT primary key not null auto_increment,
quantidade INT not null,
idCompra INT not null,
idProduto INT not null,
FOREIGN KEY(idCompra) REFERENCES compra(idCompra),
FOREIGN KEY(idProduto) REFERENCES produto(idProduto)
);