/* =============================================================
   02 · AJUSTE DA TABELA VIDEO_AULA
   - Remove colunas obsoletas
   - Adiciona novas colunas (duracao, id_arquivo)
   - Define FKs e índice UNIQUE para relação 1:1
   =============================================================*/
BEGIN;

/*--------------------------------------------------------------
  2.1  Remover colunas/constraints legadas
  --------------------------------------------------------------*/
DO $$ BEGIN
    IF EXISTS (SELECT 1 FROM pg_constraint
               WHERE conname = 'fk_tb_video_aula_tb_tipo_video') THEN
        ALTER TABLE ppi_curso.tb_video_aula
          DROP CONSTRAINT fk_tb_video_aula_tb_tipo_video;
    END IF;
END $$;

ALTER TABLE ppi_curso.tb_video_aula
    DROP COLUMN IF EXISTS id_tipo_video,
    DROP COLUMN IF EXISTS url_video;

/*--------------------------------------------------------------
  2.2  Adicionar novas colunas
  --------------------------------------------------------------*/
ALTER TABLE ppi_curso.tb_video_aula
    ADD COLUMN IF NOT EXISTS duracao_ms BIGINT,         -- duração em ms
    ADD COLUMN IF NOT EXISTS id_arquivo BIGINT;      -- FK arquivo

COMMENT ON COLUMN ppi_curso.tb_video_aula.duracao_ms
    IS '⚙️  Duração do vídeo em milissegundos';

COMMENT ON COLUMN ppi_curso.tb_video_aula.id_arquivo
    IS '⚙️  FK para tb_arquivo (arquivo físico do vídeo)';

/*--------------------------------------------------------------
  2.3  FK para tb_arquivo
  --------------------------------------------------------------*/
DO $$ BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint
                   WHERE conname = 'fk_video_aula_arquivo') THEN
        ALTER TABLE ppi_curso.tb_video_aula
            ADD CONSTRAINT fk_video_aula_arquivo
            FOREIGN KEY (id_arquivo)
            REFERENCES ppi.tb_arquivo(id_arquivo)
            ON UPDATE NO ACTION
            ON DELETE NO ACTION;
        COMMENT ON CONSTRAINT fk_video_aula_arquivo ON ppi_curso.tb_video_aula
            IS '🔗 Vídeo → Arquivo (sem cascata de exclusão)';
    END IF;
END $$;

/*--------------------------------------------------------------
  2.4  FK para AULA (ON DELETE CASCADE)
  --------------------------------------------------------------*/
DO $$ BEGIN
    IF EXISTS (SELECT 1 FROM pg_constraint
               WHERE conname = 'fk_tb_aula_tb_video_aula') THEN
        ALTER TABLE ppi_curso.tb_video_aula
          DROP CONSTRAINT fk_tb_aula_tb_video_aula;
    END IF;
    ALTER TABLE ppi_curso.tb_video_aula
        ADD CONSTRAINT fk_tb_aula_tb_video_aula
        FOREIGN KEY (id_aula)
        REFERENCES ppi_curso.tb_aula(id_aula)
        ON DELETE CASCADE
        ON UPDATE NO ACTION;
    COMMENT ON CONSTRAINT fk_tb_aula_tb_video_aula ON ppi_curso.tb_video_aula
        IS '🔗 Aula → Vídeo (cascade na exclusão)';
END $$;

/*--------------------------------------------------------------
  2.5  UNIQUE (id_aula) ⇒ garante 1-para-1
  --------------------------------------------------------------*/
CREATE UNIQUE INDEX IF NOT EXISTS uk_videoaula_id_aula
    ON ppi_curso.tb_video_aula(id_aula);

COMMENT ON INDEX uk_videoaula_id_aula
    IS '⚙️  Garante que cada Aula tenha no máximo 1 VideoAula';

COMMIT;
