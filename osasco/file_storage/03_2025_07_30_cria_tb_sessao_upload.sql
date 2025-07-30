-- Cria do tipo ENUM para tipo de upload

DO $$
BEGIN
  CREATE TYPE ppi_curso.tipo_upload AS ENUM ('SINGLE','MULTIPART');
EXCEPTION WHEN duplicate_object THEN NULL;
END
$$;
COMMENT ON TYPE ppi_curso.tipo_upload IS
  'Enum para tipo de upload';

-- SituacaoUpload (INICIADO, CANCELADO, CONCLUIDO, ERRO)
DO $$
BEGIN
  CREATE TYPE ppi.situacao_upload AS ENUM (
    'INICIADO','CANCELADO','CONCLUIDO','ERRO'
  );
EXCEPTION WHEN duplicate_object THEN NULL;
END
$$;
COMMENT ON TYPE ppi.situacao_upload IS
  'Enum para situação de upload';

-- Cria tb_sessao_upload

CREATE TABLE IF NOT EXISTS ppi.tb_sessao_upload (
    id_sessao_upload   BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario         BIGINT           NOT NULL,
    id_arquivo         BIGINT           NOT NULL,
    id_arquivo_ref     BIGINT           UNIQUE,
    id_multipart_upload TEXT,
    bucket             TEXT             NOT NULL,
    object_key         TEXT             NOT NULL,
    tipo_upload        ppi.tipo_upload NOT NULL,
    situacao           ppi.situacao_upload NOT NULL DEFAULT 'INICIADO',
    nm_arquivo_original TEXT            NOT NULL,
    content_type       TEXT             NOT NULL,
    tamanho_bytes      BIGINT           NOT NULL,
    tamanho_parte_bytes BIGINT          NOT NULL,
    nr_partes          INTEGER          NOT NULL,
    dt_inicio          TIMESTAMP WITH TIME ZONE NOT NULL,
    dt_expiracao       TIMESTAMP WITH TIME ZONE NOT NULL,
    dt_fim             TIMESTAMP WITH TIME ZONE,
    dt_exclusao        TIMESTAMP WITH TIME ZONE,
    CONSTRAINT fk_sessao_upload_arquivo
      FOREIGN KEY (id_arquivo)
      REFERENCES ppi.tb_arquivo (id_arquivo),
    CONSTRAINT fk_sessao_upload_arquivo_ref
      FOREIGN KEY (id_arquivo_ref)
      REFERENCES ppi.tb_arquivo_ref (id_arquivo_ref)
);

-- Comentários de documentação
COMMENT ON TABLE ppi.tb_sessao_upload IS 'Tabela de controle de sessões de upload multipart de arquivos';
COMMENT ON COLUMN ppi.tb_sessao_upload.id_sessao_upload IS 'Chave primária da sessão de upload';
COMMENT ON COLUMN ppi.tb_sessao_upload.id_usuario IS 'ID do usuário que iniciou a sessão';
COMMENT ON COLUMN ppi.tb_sessao_upload.id_arquivo IS 'ID do arquivo associado à sessão';
COMMENT ON COLUMN ppi.tb_sessao_upload.id_arquivo_ref IS 'ID da referência de arquivo final no File Storage';
COMMENT ON COLUMN ppi.tb_sessao_upload.id_multipart_upload IS 'ID retornado pelo provedor de multipart upload';
COMMENT ON COLUMN ppi.tb_sessao_upload.bucket IS 'Bucket onde a sessão está sendo realizada';
COMMENT ON COLUMN ppi.tb_sessao_upload.object_key IS 'Chave (path) do objeto dentro do bucket';
COMMENT ON COLUMN ppi.tb_sessao_upload.tipo_upload IS 'Tipo de upload (MULTIPART, SINGLE)';
COMMENT ON COLUMN ppi.tb_sessao_upload.situacao IS 'Estado atual do upload (INICIADO, CANCELADO, CONCLUIDO, ERRO)';
COMMENT ON COLUMN ppi.tb_sessao_upload.nm_arquivo_original IS 'Nome original do arquivo antes do upload';
COMMENT ON COLUMN ppi.tb_sessao_upload.content_type IS 'MIME type do arquivo em upload (ex., ''image/png'', ''video/mp4'')';
COMMENT ON COLUMN ppi.tb_sessao_upload.tamanho_bytes IS 'Tamanho total do arquivo em bytes';
COMMENT ON COLUMN ppi.tb_sessao_upload.tamanho_parte_bytes IS 'Tamanho de cada parte no multipart upload, em bytes';
COMMENT ON COLUMN ppi.tb_sessao_upload.nr_partes IS 'Número total de partes esperadas para upload';
COMMENT ON COLUMN ppi.tb_sessao_upload.dt_inicio IS 'Data e hora de início da sessão de upload';
COMMENT ON COLUMN ppi.tb_sessao_upload.dt_expiracao IS 'Data e hora em que a sessão expira';
COMMENT ON COLUMN ppi.tb_sessao_upload.dt_fim IS 'Data e hora em que o upload foi concluído';
COMMENT ON COLUMN ppi.tb_sessao_upload.dt_exclusao IS 'Data em que o registro foi excluído';