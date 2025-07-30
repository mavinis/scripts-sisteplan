-- =========================
-- SCRIPT DE REVERT
-- =========================

-- Remove as colunas adicionadas
ALTER TABLE ppi_curso.tb_arquivo
  DROP COLUMN IF EXISTS situacao_arquivo,
  DROP COLUMN IF EXISTS variante_arquivo;

-- Remove o tipo ENUM criado
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_type WHERE typname = 'situacao_arquivo') THEN
        DROP TYPE ppi_curso.situacao_arquivo;
    END IF;
END;
$$;
