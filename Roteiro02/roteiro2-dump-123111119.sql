--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3 (Debian 15.3-1.pgdg120+1)
-- Dumped by pg_dump version 15.8 (Ubuntu 15.8-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.funcionario DROP CONSTRAINT superior_fkey;
ALTER TABLE ONLY public.tarefas DROP CONSTRAINT tarefas_pkey;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_pkey;
DROP TABLE public.tarefas;
DROP TABLE public.funcionario;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: funcionario; Type: TABLE; Schema: public; Owner: viniciusgl
--

CREATE TABLE public.funcionario (
    cpf character(11) NOT NULL,
    data_nasc date NOT NULL,
    nome character varying(225) NOT NULL,
    funcao character varying(15) NOT NULL,
    nivel character(1) NOT NULL,
    superior_cpf character(11),
    CONSTRAINT funcao_valida_chk CHECK (((funcao)::text = ANY (ARRAY[('LIMPEZA'::character varying)::text, ('SUP_LIMPEZA'::character varying)::text]))),
    CONSTRAINT nivel_valido_chk CHECK ((nivel = ANY (ARRAY['J'::bpchar, 'P'::bpchar, 'S'::bpchar]))),
    CONSTRAINT superior_presente_chk CHECK ((((funcao)::text <> 'LIMPEZA'::text) OR (superior_cpf IS NOT NULL)))
);


ALTER TABLE public.funcionario OWNER TO viniciusgl;

--
-- Name: tarefas; Type: TABLE; Schema: public; Owner: viniciusgl
--

CREATE TABLE public.tarefas (
    id bigint NOT NULL,
    descricao text NOT NULL,
    func_resp_cpf character(11) NOT NULL,
    prioridade smallint NOT NULL,
    status character(1) NOT NULL,
    CONSTRAINT func_resp_cpf_length_chk CHECK ((length(func_resp_cpf) = 11)),
    CONSTRAINT prioridade_valida_chk CHECK (((prioridade >= 0) AND (prioridade <= 5))),
    CONSTRAINT status_valido_chk CHECK ((status = ANY (ARRAY['P'::bpchar, 'E'::bpchar, 'C'::bpchar])))
);


ALTER TABLE public.tarefas OWNER TO viniciusgl;

--
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: viniciusgl
--

INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678911', '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678912', '1980-03-08', 'Jose da Silva', 'LIMPEZA', 'J', '12345678911');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('90000000001', '1975-02-01', 'Stoico', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('90000000002', '1980-04-14', 'Valka', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('90000000003', '1988-03-22', 'Bocão', 'SUP_LIMPEZA', 'P', '90000000001');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('91205506009', '1999-01-19', 'Irradiante', 'SUP_LIMPEZA', 'J', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('90080000004', '1998-07-12', 'Soluço', 'LIMPEZA', 'J', '90000000001');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('90003000005', '1997-09-30', 'Astrid', 'LIMPEZA', 'P', '90000000001');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('90001300006', '1995-11-10', 'Meatlug', 'LIMPEZA', 'J', '90000000002');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('90000006707', '1996-05-05', 'Perna-de-peixe', 'LIMPEZA', 'J', '90000000002');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('90050000108', '1999-08-08', 'Cabeçaquente', 'LIMPEZA', 'P', '90000000003');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('93001237010', '2000-10-01', 'Banguela', 'LIMPEZA', 'S', '91205506009');


--
-- Data for Name: tarefas; Type: TABLE DATA; Schema: public; Owner: viniciusgl
--

INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483648, 'limpar portas do térreo', '32323232955', 4, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483653, 'limpar portas do 1o andar', '32323232911', 2, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483646, 'limpar chão do corredor central', '98765432111', 0, 'C');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483647, 'limpar janelas da sala 203', '98765432122', 1, 'C');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483651, 'limpar portas do 1o andar', '32323232911', 5, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483652, 'limpar portas do 2o andar', '32323232911', 5, 'P');


--
-- Name: funcionario funcionario_pkey; Type: CONSTRAINT; Schema: public; Owner: viniciusgl
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (cpf);


--
-- Name: tarefas tarefas_pkey; Type: CONSTRAINT; Schema: public; Owner: viniciusgl
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT tarefas_pkey PRIMARY KEY (id);


--
-- Name: funcionario superior_fkey; Type: FK CONSTRAINT; Schema: public; Owner: viniciusgl
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT superior_fkey FOREIGN KEY (superior_cpf) REFERENCES public.funcionario(cpf);


--
-- PostgreSQL database dump complete
--

