-- CREATE TYPE farmacia_categoria_chk AS ENUM (
--   'filial',
--   'sede'
-- );

-- CREATE TYPE funcionario_funcao_chk AS ENUM (
--   'farmaceuticos',
--   'venderedores',
--   'entregadores',
--   'caixas',
--   'administradores'
-- );

-- CREATE TYPE enderecos_tipo_chk AS ENUM (
--   'residencia',
--   'trabalho',
--   'outros'
-- );

CREATE TABLE farmacias (
  id SERIAL PRIMARY KEY,
  categoria varchar(120) NOT NULL,
  bairro VARCHAR(255) NOT NULL,
  cidade VARCHAR(255) NOT NULL,
  estado VARCHAR(255) NOT NULL,
  gerente_id INTEGER NOT NULL
);

CREATE TABLE funcionarios (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  funcao funcionario_funcao_chk NOT NULL,
  farmacia_id INTEGER
);

CREATE TABLE medicamentos (
  id SERIAL PRIMARY KEY,
  exclusivo_receita bool,
  valor INTEGER
);

CREATE TABLE vendas (
  id SERIAL PRIMARY KEY,
  funcionario_id INTEGER,
  cliente_id INTEGER,
  valor_total INTEGER
);

CREATE TABLE entregas (
  id SERIAL PRIMARY KEY,
  venda_id INTEGER NOT NULL,
  endereco_id INTEGER NOT NULL
);

CREATE TABLE clientes (
  id SERIAL PRIMARY KEY,
  cpf char(11) NOT NULL,
  nome VARCHAR(255) NOT NULL,
  data_nascimento date NOT NULL
);

CREATE TABLE enderecos (
  id SERIAL PRIMARY KEY,
  bairro VARCHAR(255) NOT NULL,
  cidade VARCHAR(255) NOT NULL,
  estado VARCHAR(255) NOT NULL,
  tipo enderecos_tipo_chk NOT NULL,
  cliente_id INTEGER NOT NULL,
  descricao_tipo VARCHAR(255)
);

CREATE TABLE vendas_medicamentos (
  venda_id INTEGER,
  medicamento_id INTEGER,
  PRIMARY KEY (venda_id, medicamento_id)
);

CREATE UNIQUE INDEX ON farmacias (bairro, cidade);

ALTER TABLE funcionarios ADD FOREIGN KEY (farmacia_id) REFERENCES farmacias (id);

ALTER TABLE farmacias ADD FOREIGN KEY (gerente_id) REFERENCES funcionarios (id);

ALTER TABLE enderecos ADD FOREIGN KEY (cliente_id) REFERENCES clientes (id);

ALTER TABLE entregas ADD FOREIGN KEY (endereco_id) REFERENCES enderecos (id);

ALTER TABLE entregas ADD FOREIGN KEY (venda_id) REFERENCES vendas (id);

ALTER TABLE vendas ADD FOREIGN KEY (funcionario_id) REFERENCES funcionarios (id);

ALTER TABLE vendas ADD FOREIGN KEY (cliente_id) REFERENCES clientes (id);

ALTER TABLE vendas_medicamentos ADD FOREIGN KEY (medicamento_id) REFERENCES medicamentos (id);

ALTER TABLE vendas_medicamentos ADD FOREIGN KEY (venda_id) REFERENCES vendas (id);

