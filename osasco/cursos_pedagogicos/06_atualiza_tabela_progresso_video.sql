-- Atualiza tb_progresso_usuario_video para incluir novas colunas e constraints

-- Renomeia coluna nr_segundos_onde_parou para ultima_posicao_seg
ALTER TABLE ppi_curso.tb_progresso_usuario_video
    RENAME COLUMN nr_segundos_onde_parou TO ultima_posicao_seg;

-- Adiciona nova coluna duracao_total_seg (duração total em segundos)
ALTER TABLE ppi_curso.tb_progresso_usuario_video
    ADD COLUMN duracao_total_seg INTEGER NOT NULL DEFAULT 0;

-- Adiciona nova coluna trechos_assistidos como JSONB
ALTER TABLE ppi_curso.tb_progresso_usuario_video
    ADD COLUMN trechos_assistidos JSONB;

-- Atualiza a constraint de verificação para ultima_posicao_seg
ALTER TABLE ppi_curso.tb_progresso_usuario_video
    DROP CONSTRAINT IF EXISTS chk_segundos_nao_negativo;

-- Adiciona nova constraint de verificação para ultima_posicao_seg
ALTER TABLE ppi_curso.tb_progresso_usuario_video
    ADD CONSTRAINT chk_ultima_posicao_nao_negativa CHECK (ultima_posicao_seg >= 0);