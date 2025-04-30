-- Adiciona a coluna cor_hex à tabela avalia_conceitual
-- Valor padrão: #FFFFFF (branco opaco)
-- Cria uma constraint para verificar o formato da cor em hexadecimal opaco (#RRGGBB).
ALTER TABLE avalia.avalia_conceitual
ADD COLUMN cor_hex VARCHAR(7) DEFAULT '#FFFFFF',
ADD CONSTRAINT check_cor_hex_format
    CHECK (cor_hex ~ '^#[0-9A-Fa-f]{6}$');


-- Seta valores para itens existentes
-- Avançado (AV)        : #B0CFE6
-- Adequado (AD)        : #e8f2cb
-- Básico (BA)          : #E6D2AC
-- Abaixo do básico (AB): #ffdad6
UPDATE avalia.avalia_conceitual
SET cor_hex = CASE sigla_avalia_situacao
    WHEN 'AV' THEN '#B0CFE6'
    WHEN 'AD' THEN '#E8F2CB'
    WHEN 'BA' THEN '#E6D2AC'
    WHEN 'AB' THEN '#FFDAD6'
    ELSE cor_hex
END;