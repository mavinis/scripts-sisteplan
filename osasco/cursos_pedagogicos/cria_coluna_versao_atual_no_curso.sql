-- Adiciona coluna de versão atual em tb_curso_pedagogico

BEGIN;

-- Adiciona coluna id_versao_atual (permite null)
ALTER TABLE ppi_curso.tb_curso_pedagogico
  ADD COLUMN id_versao_atual bigint;

-- Cria constraint de FK para id_versao_curso_pedagogico
ALTER TABLE ppi_curso.tb_curso_pedagogico
  ADD CONSTRAINT fk_curso_versao_atual
    FOREIGN KEY (id_versao_atual)
    REFERENCES ppi_curso.tb_versao_curso_pedagogico(id_versao_curso_pedagogico)
    ON DELETE SET NULL;

-- Preenche id_versao_atual com a última versão de cada curso (maior nr_versao)
WITH max_nr_versao_por_curso AS (
  SELECT
    id_curso_pedagogico,
    MAX(nr_versao) AS max_nr_versao
  FROM ppi_curso.tb_versao_curso_pedagogico
  GROUP BY id_curso_pedagogico
),

versao_mais_recente_por_curso AS (
  SELECT
    v.id_curso_pedagogico,
    v.id_versao_curso_pedagogico
  FROM ppi_curso.tb_versao_curso_pedagogico v
  JOIN max_nr_versao_por_curso maxvc
    ON v.id_curso_pedagogico = maxvc.id_curso_pedagogico
   AND v.nr_versao = maxvc.max_nr_versao
)

UPDATE ppi_curso.tb_curso_pedagogico curso
SET id_versao_atual = vmr.id_versao_curso_pedagogico
FROM versao_mais_recente_por_curso vmr
WHERE curso.id_curso_pedagogico = vmr.id_curso_pedagogico;

-- Cria índice na nova coluna
CREATE INDEX idx_curso_versao_atual
  ON ppi_curso.tb_curso_pedagogico(id_versao_atual);

COMMIT;
