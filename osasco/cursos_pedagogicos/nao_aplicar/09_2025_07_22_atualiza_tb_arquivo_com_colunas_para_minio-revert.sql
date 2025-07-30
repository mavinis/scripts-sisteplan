-- =========================
-- SCRIPT DE REVERT
-- =========================

-- Remove as colunas adicionadas
ALTER TABLE ppi_curso.tb_arquivo
  DROP COLUMN IF EXISTS chave,
  DROP COLUMN IF EXISTS tipo_mime,
  DROP COLUMN IF EXISTS tamanho_bytes,
  DROP COLUMN IF EXISTS etag,
  DROP COLUMN IF EXISTS dt_criacao;

-- Remove a constraint de tamanho não negativo
ALTER TABLE ppi_curso.tb_arquivo
  DROP CONSTRAINT IF EXISTS chk_tamanho_bytes;

-- Restaura a restrição NOT NULL na coluna arq_anexo
ALTER TABLE ppi_curso.tb_arquivo
  ALTER COLUMN arq_anexo SET NOT NULL;
