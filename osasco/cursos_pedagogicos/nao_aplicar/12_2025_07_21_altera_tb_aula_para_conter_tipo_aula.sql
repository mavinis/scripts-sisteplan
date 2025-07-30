-- Cria o enum tipo_aula
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'tipo_aula') THEN
        CREATE TYPE ppi_curso.tipo_aula AS ENUM ('VIDEO', 'QUESTIONARIO');
    END IF;
END;
$$;

-- Adiciona a coluna do enum à tb_aula
ALTER TABLE ppi_curso.tb_aula
    ADD COLUMN tipo_aula ppi_curso.tipo_aula NOT NULL DEFAULT 'VIDEO';

-- Adiciona as colunas id_video_aula e id_questionario_aula
ALTER TABLE ppi_curso.tb_aula
    ADD COLUMN id_video_aula BIGINT NULL,
    ADD COLUMN id_questionario_aula BIGINT NULL;

-- Popula id_video_aula e id_questionario_aula para linhas existentes
UPDATE ppi_curso.tb_aula a
SET id_questionario_aula = q.id_questionario_aula
FROM ppi_curso.tb_questionario_aula q
WHERE q.id_aula = a.id_aula;

UPDATE ppi_curso.tb_aula a
SET id_video_aula = v.id_video_aula
FROM ppi_curso.tb_video_aula v
WHERE v.id_aula = a.id_aula;

-- Define tipo_aula com base nos IDs preenchidos
UPDATE ppi_curso.tb_aula
SET tipo_aula = CASE
    WHEN id_questionario_aula IS NOT NULL THEN 'QUESTIONARIO'::ppi_curso.tipo_aula
    WHEN id_video_aula IS NOT NULL THEN 'VIDEO'::ppi_curso.tipo_aula
    ELSE 'VIDEO'::ppi_curso.tipo_aula
    END;

-- Adiciona constraints de chave estrangeira às colunas
ALTER TABLE ppi_curso.tb_aula
    ADD CONSTRAINT fk_aula_video
        FOREIGN KEY (id_video_aula) REFERENCES ppi_curso.tb_video_aula(id_video_aula),
    ADD CONSTRAINT fk_aula_questionario
        FOREIGN KEY (id_questionario_aula) REFERENCES ppi_curso.tb_questionario_aula(id_questionario_aula);

-- Adiciona a constraint de verificação para garantir que apenas um dos campos seja preenchido
ALTER TABLE ppi_curso.tb_aula
  ADD CONSTRAINT chk_aula_apenas_video_ou_questionario
  CHECK (
    (id_video_aula IS NOT NULL AND id_questionario_aula IS NULL)
    OR
    (id_video_aula IS NULL AND id_questionario_aula IS NOT NULL)
  );

