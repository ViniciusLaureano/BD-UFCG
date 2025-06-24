-- Cria tabelas
CREATE TABLE automovel (
  placa varchar(7) CONSTRAINT automovel_pkey PRIMARY KEY,
  marca varchar(50) NOT NULL,
  modelo varchar(50) NOT NULL,
  ano_fabricacao numeric(4),
  cor varchar(255)
);

CREATE TABLE segurado (
  cpf varchar(11) CONSTRAINT segurado_pkey PRIMARY KEY,
  name varchar(255) NOT NULL,
  email varchar(255) NOT NULL,
  birthday date NOT NULL,
  phone varchar(15),
  id_endereco varchar(8)
);

-- perito trabalha em uma oficina
CREATE TABLE perito (
  cpf varchar(11) CONSTRAINT perito_pkey PRIMARY KEY,
  name varchar(255) NOT NULL,
  email varchar(255) NOT NULL,
  phone varchar(15),
  id_endereco varchar(8),
  cnpj_oficina varchar(14) NOT NULL
);

CREATE TABLE oficina (
  cnpj varchar(14) CONSTRAINT oficina_pkey PRIMARY KEY,
  name varchar(255) NOT NULL,
  id_endereco varchar(8)
);

-- o seguro eh identificado unicamente pela placa do automovel + cpf do segurado, pois nao deve haver mais de um seguro para a mesma pessoa naquele carro,
-- porem um segurado pode ter mais de um carro com seguro, podendo aparecer novamente, e tambem o carro pode ser dirigo por mais de uma pessoa, podendo
-- assim haver a necessidade de criar um seguro para essa.
CREATE TABLE seguro (
  placa_automovel varchar(7) NOT NULL,
  cpf_segurado varchar(11) NOT NULL,
  data_inicio date NOT NULL,
  data_fim date NOT NULL,
  valor_premio numeric(10),
  valor_seguro numeric(10),
  CONSTRAINT seguro_pkey PRIMARY KEY (placa_automovel, cpf_segurado)
);

-- o sinistro eh respectivo ao seguro, que ao ser acionado, gera um sinistro com as informacoes que levaram ao uso do seguro (para aquele carro com aquele motorista)

CREATE TABLE sinistro (
  id SERIAL CONSTRAINT sinistro_pkey PRIMARY KEY,
  placa_automovel varchar(7) NOT NULL,
  cpf_segurado varchar(11) NOT NULL,
  descricao TEXT NOT NULL,
  cnpj_oficina varchar(14)
);

-- uma pericia eh feita para cada sinistro aberto, indicando o perito responsavel pela avaliacao
CREATE TABLE pericia (
  id SERIAL CONSTRAINT pericia_pkey PRIMARY KEY,
  cpf_perito varchar(11) NOT NULL,
  id_sinistro numeric(10) NOT NULL,
  avaliacao_danos TEXT,
  valor_estimado_danos numeric(10),
  conclusao varchar(15)
);

-- caso necessario, o reparo sera feito de acordo com a pericia cadastrada
CREATE TABLE reparo (
  id SERIAL CONSTRAINT reparo_pkey PRIMARY KEY,
  id_pericia numeric(10) NOT NULL,
  valor_total numeric(10) NOT NULL,
  data_inicio date NOT NULL,
  data_fim date,
  descricao_servico TEXT
);

-- Como oficina, segurado e perito possuem enderecos e o mesmo eh multivalorado, criei uma nova tabela para separar essas informacoes
CREATE TABLE endereco (
  id SERIAL CONSTRAINT endereco_pkey PRIMARY KEY,
  cep varchar(8) NOT NULL,
  estado varchar(255) NOT NULL,
  cidade varchar(255) NOT NULL,
  bairro varchar(255) NOT NULL,
  rua varchar(255) NOT NULL,
  numero varchar(5) NOT NULL,
  complemento varchar(255)
);

-- geracao de constraints
ALTER TABLE seguro ADD CONSTRAINT seguro_placa_automovel_fkey FOREIGN KEY (placa_automovel) REFERENCES automovel (placa);

ALTER TABLE seguro ADD CONSTRAINT seguro_cpf_segurado_fkey FOREIGN KEY (cpf_segurado) REFERENCES segurado (cpf);

ALTER TABLE sinistro ADD CONSTRAINT sinistro_placa_automovel_cpf_segurado_fkey FOREIGN KEY (placa_automovel, cpf_segurado) REFERENCES seguro (placa_automovel, cpf_segurado);

ALTER TABLE sinistro ADD CONSTRAINT sinistro_cnpj_oficina_fkey FOREIGN KEY (cnpj_oficina) REFERENCES oficina (cnpj);

-- arrumar erro no tipo Numeric para referenciar um SERIAL
ALTER TABLE pericia ALTER COLUMN id_sinistro TYPE INTEGER;
ALTER TABLE pericia ADD CONSTRAINT pericia_id_sinistro_fkey FOREIGN KEY (id_sinistro) REFERENCES sinistro (id);

ALTER TABLE pericia ADD CONSTRAINT pericia_cpf_perito_fkey FOREIGN KEY (cpf_perito) REFERENCES perito (cpf);

-- arrumar erro no tipo Numeric para referenciar um SERIAL
ALTER TABLE reparo ALTER COLUMN id_pericia TYPE INTEGER;
ALTER TABLE reparo ADD CONSTRAINT reparo_id_pericia_fkey FOREIGN KEY (id_pericia) REFERENCES pericia (id);

ALTER TABLE perito ADD CONSTRAINT perito_cnpj_oficina_fkey FOREIGN KEY (cnpj_oficina) REFERENCES oficina (cnpj);

-- arrumar erro no tipo VARCHAR para referenciar um SERIAL
ALTER TABLE segurado ALTER COLUMN id_endereco TYPE INTEGER USING id_endereco::INTEGER;
ALTER TABLE segurado ADD CONSTRAINT seguro_id_endereco_fkey FOREIGN KEY (id_endereco) REFERENCES endereco (id);

-- arrumar erro no tipo VARCHAR para referenciar um SERIAL
ALTER TABLE perito ALTER COLUMN id_endereco TYPE INTEGER USING id_endereco::INTEGER;
ALTER TABLE perito ADD CONSTRAINT perito_id_endereco_fkey FOREIGN KEY (id_endereco) REFERENCES endereco (id);

-- arrumar erro no tipo VARCHAR para referenciar um SERIAL
ALTER TABLE oficina ALTER COLUMN id_endereco TYPE INTEGER USING id_endereco::INTEGER;
ALTER TABLE oficina ADD CONSTRAINT oficina_id_endereco_fkey FOREIGN KEY (id_endereco) REFERENCES endereco (id);
