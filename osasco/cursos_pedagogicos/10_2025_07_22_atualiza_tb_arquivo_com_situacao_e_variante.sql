-- Criação do tipo enum para situacao_arquivo com os valores do Java
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'situacao_arquivo') THEN
        CREATE TYPE ppi_curso.situacao_arquivo AS ENUM (
            'ENVIO_PENDENTE',
            'FALHA_ENVIO',
            'PROCESSANDO',
            'FALHA_PROCESSAMENTO',
            'DISPONIVEL',
            'EXCLUSAO_PENDENTE'
        );
    END IF;
END;
$$;

-- Adiciona/atualiza a coluna situacao_arquivo para usar o tipo ENUM
ALTER TABLE ppi_curso.tb_arquivo
DROP COLUMN IF EXISTS situacao_arquivo;
ALTER TABLE ppi_curso.tb_arquivo
ADD COLUMN situacao_arquivo ppi_curso.situacao_arquivo NOT NULL DEFAULT 'ENVIO_PENDENTE';

-- Adiciona/atualiza a coluna variante_arquivo para ser do tipo TEXT
ALTER TABLE ppi_curso.tb_arquivo
DROP COLUMN IF EXISTS variante_arquivo;
ALTER TABLE ppi_curso.tb_arquivo
ADD COLUMN variante_arquivo TEXT NOT NULL DEFAULT 'ORIGINAL';

-- Comentários em português
COMMENT ON COLUMN ppi_curso.tb_arquivo.situacao_arquivo IS 'Situação do arquivo, conforme enum SituacaoArquivo.';
COMMENT ON COLUMN ppi_curso.tb_arquivo.variante_arquivo IS 'Tipo de variante do arquivo, ex: resolução, função, etc.';

