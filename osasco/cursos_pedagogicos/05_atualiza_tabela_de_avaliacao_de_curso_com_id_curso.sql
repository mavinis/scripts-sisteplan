-- TABELA ppi_curso.tb_avaliacao_versao_curso
-- Altera unique contraint de versão de curso para curso.

-- 1. Remove a unique constraint id_usuario-versao_curso_pedagogico

ALTER TABLE ppi_curso.tb_avaliacao_versao_curso DROP CONSTRAINT uq_usuario_versao;

-- 2. Adiciona nova coluna id_curso_pedagogico
ALTER TABLE ppi_curso.tb_avaliacao_versao_curso ADD COLUMN IF NOT EXISTS id_curso_pedagogico BIGINT;

-- 3. Popula a nova coluna com dados de id_curso_pedagogico
UPDATE ppi_curso.tb_avaliacao_versao_curso a
SET id_curso_pedagogico = v.id_curso_pedagogico
FROM ppi_curso.tb_versao_curso_pedagogico v
WHERE a.id_versao_curso_pedagogico = v.id_versao_curso_pedagogico;

-- 4. Adiciona FK para a nova coluna
ALTER TABLE ppi_curso.tb_avaliacao_versao_curso
ADD CONSTRAINT fk_curso_pedagogico FOREIGN KEY (id_curso_pedagogico) REFERENCES ppi_curso.tb_curso_pedagogico(id_curso_pedagogico);

-- 5. Seta para NOT NULL
ALTER TABLE ppi_curso.tb_avaliacao_versao_curso ALTER COLUMN id_curso_pedagogico SET NOT NULL;

-- 6. Cria nova UNIQUE CONSTRAINT id_usuario-id_curso_pedagogico
ALTER TABLE ppi_curso.tb_avaliacao_versao_curso ADD CONSTRAINT uq_tb_avaliacao_versao_curso UNIQUE (id_usuario, id_curso_pedagogico);

-- 7. Renomeia a tabela ppi_curso.tb_avaliacao_versao_curso para ppi_curso.tb_avaliacao_curso
ALTER TABLE ppi_curso.tb_avaliacao_versao_curso RENAME TO tb_avaliacao_curso;

-- 8. Cria index para contagem de avaliações de curso por nota
CREATE INDEX idx_avaliacao_curso_curso_nota ON ppi_curso.tb_avaliacao_curso (id_curso_pedagogico, nota);