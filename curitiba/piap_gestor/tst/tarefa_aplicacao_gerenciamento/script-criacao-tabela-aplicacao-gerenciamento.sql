-- Cria a tabela aplicacao_gerenciamento que relaciona aplicações gerenciadoras e gerenciadas

CREATE TABLE ppi_seg.aplicacao_gerenciamento (
    cod_aplicacao_gerenciamento SERIAL PRIMARY KEY,
    nr_aplicacao_gerenciadora   NUMERIC NOT NULL REFERENCES ppi.aplicacao(nr_aplicacao) ON DELETE RESTRICT,
    nr_aplicacao_gerenciada     NUMERIC NOT NULL REFERENCES ppi.aplicacao(nr_aplicacao) ON DELETE RESTRICT,
    ind_ativo                   BOOLEAN NOT NULL DEFAULT TRUE,
    dt_criacao                  TIMESTAMP NOT NULL DEFAULT NOW(),
    CONSTRAINT uq_aplicacao_gerenciamento UNIQUE (nr_aplicacao_gerenciadora, nr_aplicacao_gerenciada)
);

