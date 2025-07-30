-- =========================
-- SCRIPT DE REVERT
-- =========================

-- Remove a constraint de verificação
ALTER TABLE ppi_curso.tb_aula
  DROP CONSTRAINT IF EXISTS chk_aula_apenas_video_ou_questionario;

-- Remove as constraints de chave estrangeira
ALTER TABLE ppi_curso.tb_aula
  DROP CONSTRAINT IF EXISTS fk_aula_video,
  DROP CONSTRAINT IF EXISTS fk_aula_questionario;

-- Remove as colunas adicionadas
ALTER TABLE ppi_curso.tb_aula
  DROP COLUMN IF EXISTS id_video_aula,
  DROP COLUMN IF EXISTS id_questionario_aula,
  DROP COLUMN IF EXISTS tipo_aula;

-- Remove o tipo ENUM criado
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_type WHERE typname = 'tipo_aula') THEN
        DROP TYPE ppi_curso.tipo_aula;
    END IF;
END;
$$;
