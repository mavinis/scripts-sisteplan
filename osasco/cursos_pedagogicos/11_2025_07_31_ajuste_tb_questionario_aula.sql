/* =============================================================
   03 · AJUSTE DA TABELA QUESTIONARIO_AULA
   - Garante relação 1:1 com Aula
   =============================================================*/
BEGIN;

/*--------------------------------------------------------------
  3.1  FK para AULA (ON DELETE CASCADE)
  --------------------------------------------------------------*/
DO $$ BEGIN
    IF EXISTS (SELECT 1 FROM pg_constraint
               WHERE conname = 'fk_tb_aula_tb_questionario_aula') THEN
        ALTER TABLE ppi_curso.tb_questionario_aula
          DROP CONSTRAINT fk_tb_aula_tb_questionario_aula;
    END IF;
    ALTER TABLE ppi_curso.tb_questionario_aula
        ADD CONSTRAINT fk_tb_aula_tb_questionario_aula
        FOREIGN KEY (id_aula)
        REFERENCES ppi_curso.tb_aula(id_aula)
        ON DELETE CASCADE
        ON UPDATE NO ACTION;
    COMMENT ON CONSTRAINT fk_tb_aula_tb_questionario_aula
        ON ppi_curso.tb_questionario_aula
        IS 'Aula → QuestionarioAula (cascade na exclusão)';
END $$;

/*--------------------------------------------------------------
  3.2  UNIQUE (id_aula)
  --------------------------------------------------------------*/
CREATE UNIQUE INDEX IF NOT EXISTS uk_questionario_id_aula
    ON ppi_curso.tb_questionario_aula(id_aula);

COMMENT ON INDEX uk_questionario_id_aula
    IS 'Garante que cada Aula tenha no máximo 1 QuestionarioAula';

COMMIT;
