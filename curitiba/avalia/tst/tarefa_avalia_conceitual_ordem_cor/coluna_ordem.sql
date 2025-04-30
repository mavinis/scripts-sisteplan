-- Adiciona a coluna ordem à tabela avalia_conceitual
-- Valor padrão: 0
ALTER TABLE avalia.avalia_conceitual
ADD COLUMN ordem INT DEFAULT 0;


-- Seta valores para itens existentes
-- Avançado (AV)        : 0
-- Adequado (AD)        : 1
-- Básico (BA)          : 2
-- Abaixo do básico (AB): 3
UPDATE avalia.avalia_conceitual
SET ordem = CASE sigla_avalia_situacao
    WHEN 'AV' THEN 0
    WHEN 'AD' THEN 1
    WHEN 'BA' THEN 2
    WHEN 'AB' THEN 3
    ELSE ordem
END;