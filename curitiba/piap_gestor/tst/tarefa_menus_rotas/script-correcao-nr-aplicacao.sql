-- script-correcao-nr-aplicacao.sql
-- Script para correção dos valores da coluna nr_aplicacao de 7 para 2
-- Utilizar no pgAdmin ou em psql

BEGIN;

-- Atualiza aplicação nos registros de menu
UPDATE ppi_seg.menu
SET nr_aplicacao = 2
WHERE nr_aplicacao = 7;

-- Atualiza aplicação nos registros de permissão
UPDATE ppi_seg.permissao
SET nr_aplicacao = 2
WHERE nr_aplicacao = 7;

COMMIT;
