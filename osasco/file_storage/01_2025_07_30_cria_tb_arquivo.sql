-- SituacaoArquivo (ENVIO_PENDENTE, ENVIADO, PROCESSANDO, DISPONIVEL, CORROMPIDO, EXCLUSAO_PENDENTE, EXCLUIDO)
DO $$
BEGIN
  CREATE TYPE ppi_curso.situacao_arquivo AS ENUM (
    'ENVIO_PENDENTE','ENVIADO','PROCESSANDO',
    'DISPONIVEL','CORROMPIDO','EXCLUSAO_PENDENTE','EXCLUIDO'
  );
EXCEPTION WHEN duplicate_object THEN NULL;
END
$$;
COMMENT ON TYPE ppi_curso.situacao_arquivo IS
  'Enum para situação de arquivo conforme Java SituacaoArquivo';

-- cria tb_arquivo
CREATE TABLE IF NOT EXISTS ppi_curso.tb_arquivo (
    id_arquivo         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    situacao           ppi_curso.situacao_arquivo NOT NULL DEFAULT 'ENVIO_PENDENTE',
    nm_arquivo_original TEXT          NOT NULL,
    id_usuario         BIGINT         NOT NULL,
    dt_cadastro        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
    dt_exclusao_pendente TIMESTAMP WITH TIME ZONE,
    dt_exclusao        TIMESTAMP WITH TIME ZONE
);

-- Comentários de documentação
COMMENT ON TABLE ppi_curso.tb_arquivo IS 
  'Tabela de arquivos armazenados no sistema';
COMMENT ON COLUMN ppi_curso.tb_arquivo.id_arquivo IS 
  'Chave primária da tabela de arquivos';
COMMENT ON COLUMN ppi_curso.tb_arquivo.situacao IS 
  'Situação do arquivo (ENVIO_PENDENTE, ENVIADO, DISPONIVEL, etc.)';
COMMENT ON COLUMN ppi_curso.tb_arquivo.nm_arquivo_original IS 
  'Nome original do arquivo enviado pelo usuário';
COMMENT ON COLUMN ppi_curso.tb_arquivo.id_usuario IS 
  'Identificador do usuário que enviou o arquivo';
COMMENT ON COLUMN ppi_curso.tb_arquivo.dt_cadastro IS 
  'Data e hora em que o registro foi criado';
COMMENT ON COLUMN ppi_curso.tb_arquivo.dt_exclusao_pendente IS 
  'Data em que foi marcada exclusão pendente (soft delete)';
COMMENT ON COLUMN ppi_curso.tb_arquivo.dt_exclusao IS 
  'Data em que o arquivo foi efetivamente excluído';