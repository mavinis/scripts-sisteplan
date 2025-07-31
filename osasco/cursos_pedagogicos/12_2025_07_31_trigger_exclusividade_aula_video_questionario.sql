/* =============================================================
   04 · TRIGGER DE EXCLUSIVIDADE
   Impede que a mesma Aula receba Vídeo e Questionário simultaneamente
   =============================================================*/
BEGIN;

/*--------------------------------------------------------------
  4.1  Função auxiliar
  --------------------------------------------------------------*/
CREATE OR REPLACE FUNCTION ppi_curso.f_check_aula_mutex()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
/* Enforce exclusividade: uma Aula deve ter apenas um subtipo */
BEGIN
  IF TG_TABLE_NAME = 'tb_video_aula' THEN
     IF EXISTS (SELECT 1
                FROM ppi_curso.tb_questionario_aula q
                WHERE q.id_aula = NEW.id_aula) THEN
        RAISE EXCEPTION
          'Aula % já possui QuestionarioAula – impossível inserir VideoAula', NEW.id_aula;
     END IF;
  ELSE
     IF EXISTS (SELECT 1
                FROM ppi_curso.tb_video_aula v
                WHERE v.id_aula = NEW.id_aula) THEN
        RAISE EXCEPTION
          'Aula % já possui VideoAula – impossível inserir QuestionarioAula', NEW.id_aula;
     END IF;
  END IF;
  RETURN NEW;
END $$;

COMMENT ON FUNCTION ppi_curso.f_check_aula_mutex()
    IS 'Garante um único subtipo (Video ou Questionário) por Aula';

/*--------------------------------------------------------------
  4.2  Disparadores
  --------------------------------------------------------------*/
CREATE OR REPLACE TRIGGER trg_mutex_videoaula
    BEFORE INSERT ON ppi_curso.tb_video_aula
    FOR EACH ROW EXECUTE FUNCTION ppi_curso.f_check_aula_mutex();

COMMENT ON TRIGGER trg_mutex_videoaula ON ppi_curso.tb_video_aula
    IS 'Bloqueia segundo subtipo (Vídeo) para mesma Aula';

CREATE OR REPLACE TRIGGER trg_mutex_questionarioaula
    BEFORE INSERT ON ppi_curso.tb_questionario_aula
    FOR EACH ROW EXECUTE FUNCTION ppi_curso.f_check_aula_mutex();

COMMENT ON TRIGGER trg_mutex_questionarioaula ON ppi_curso.tb_questionario_aula
    IS 'Bloqueia segundo subtipo (Questionário) para mesma Aula';

COMMIT;
