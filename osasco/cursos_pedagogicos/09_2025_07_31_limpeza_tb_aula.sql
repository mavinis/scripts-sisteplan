/* =============================================================
   01 · LIMPEZA DA TABELA AULA
   Remove colunas/constraints que apontam para tabelas
   VideoAula, QuestionarioAula e VersaoCursoPedagogico
   =============================================================*/
BEGIN;

/*--------------------------------------------------------------
  1.1  Remover antigo CHECK (vídeo OU questionário)
  --------------------------------------------------------------*/
DO $$ BEGIN
    IF EXISTS (SELECT 1 FROM pg_constraint
               WHERE  conname = 'chk_aula_apenas_video_ou_questionario') THEN
        ALTER TABLE ppi_curso.tb_aula
          DROP CONSTRAINT chk_aula_apenas_video_ou_questionario;
    END IF;
END $$;

/*--------------------------------------------------------------
  1.2  Remover FK + coluna id_video_aula
       (dependência será invertida)
--------------------------------------------------------------*/
DO $$ BEGIN
    IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'fk_aula_video') THEN
        ALTER TABLE ppi_curso.tb_aula DROP CONSTRAINT fk_aula_video;
    END IF;
    IF EXISTS (SELECT 1
               FROM information_schema.columns
               WHERE table_schema = 'ppi_curso'
                 AND table_name   = 'tb_aula'
                 AND column_name  = 'id_video_aula') THEN
        ALTER TABLE ppi_curso.tb_aula DROP COLUMN id_video_aula;
    END IF;
END $$;

/*--------------------------------------------------------------
  1.3  Remover FK + coluna id_questionario_aula
       (dependência será invertida)
  --------------------------------------------------------------*/
DO $$ BEGIN
    IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'fk_aula_questionario') THEN
        ALTER TABLE ppi_curso.tb_aula DROP CONSTRAINT fk_aula_questionario;
    END IF;
    IF EXISTS (SELECT 1
               FROM information_schema.columns
               WHERE table_schema = 'ppi_curso'
                 AND table_name   = 'tb_aula'
                 AND column_name  = 'id_questionario_aula') THEN
        ALTER TABLE ppi_curso.tb_aula DROP COLUMN id_questionario_aula;
    END IF;
END $$;

/*--------------------------------------------------------------
  1.4  Remover FK + coluna id_versao_curso_pedagogico
       (não faz mais parte do modelo)
  --------------------------------------------------------------*/
DO $$ BEGIN
    IF EXISTS (SELECT 1 FROM pg_constraint
               WHERE conname = 'fk_tb_versao_curso_pedagogico_tb_aula') THEN
        ALTER TABLE ppi_curso.tb_aula
          DROP CONSTRAINT fk_tb_versao_curso_pedagogico_tb_aula;
    END IF;

    IF EXISTS (SELECT 1
               FROM information_schema.columns
               WHERE table_schema = 'ppi_curso'
                 AND table_name   = 'tb_aula'
                 AND column_name  = 'id_versao_curso_pedagogico') THEN
        ALTER TABLE ppi_curso.tb_aula
          DROP COLUMN id_versao_curso_pedagogico;
    END IF;
END $$;

COMMIT;
