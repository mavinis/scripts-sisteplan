-- =========================
-- SCRIPT DE REVERT
-- =========================

-- Reverte a adição da coluna duracao
ALTER TABLE ppi_curso.tb_video_aula
DROP COLUMN duracao;

-- Reverte a adição da coluna id_arquivo
ALTER TABLE ppi_curso.tb_video_aula
DROP COLUMN id_arquivo;

-- Remove a restrição de chave estrangeira fk_video_aula_arquivo
ALTER TABLE ppi_curso.tb_video_aula
DROP CONSTRAINT IF EXISTS fk_video_aula_arquivo;
