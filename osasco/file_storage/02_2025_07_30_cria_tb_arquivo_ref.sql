-- cria tb_arquivo_ref

CREATE TABLE IF NOT EXISTS ppi_curso.tb_arquivo_ref (
    id_arquivo_ref     BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_arquivo         BIGINT         NOT NULL,
    bucket             TEXT           NOT NULL,
    "key"              TEXT           NOT NULL,
    hash               TEXT,
    content_type       TEXT           NOT NULL,
    tamanho_bytes      BIGINT         NOT NULL,
    largura            INTEGER,
    altura             INTEGER,
    resolucao          TEXT,
    duracao_ms         BIGINT,
    CONSTRAINT fk_arquivo_ref_arquivo
      FOREIGN KEY (id_arquivo)
      REFERENCES ppi_curso.tb_arquivo (id_arquivo),
    CONSTRAINT uq_arquivo_ref_arquivo
      UNIQUE (id_arquivo)
);

-- Comentários de documentação
COMMENT ON TABLE ppi_curso.tb_arquivo_ref IS 
  'Tabela de metadados e referências de arquivos armazenados';
COMMENT ON COLUMN ppi_curso.tb_arquivo_ref.id_arquivo_ref IS 
  'Chave primária da referência do arquivo';
COMMENT ON COLUMN ppi_curso.tb_arquivo_ref.id_arquivo IS 
  'Chave estrangeira para tb_arquivo(id_arquivo)';
COMMENT ON COLUMN ppi_curso.tb_arquivo_ref.bucket IS 
  'Nome do bucket/storage onde o arquivo reside';
COMMENT ON COLUMN ppi_curso.tb_arquivo_ref."key" IS 
  'Chave (path) do objeto dentro do bucket';
COMMENT ON COLUMN ppi_curso.tb_arquivo_ref.hash IS 
  'Hash do conteúdo (p.ex., SHA-256)';
COMMENT ON COLUMN ppi_curso.tb_arquivo_ref.content_type IS 
  'MIME type do arquivo';
COMMENT ON COLUMN ppi_curso.tb_arquivo_ref.tamanho_bytes IS 
  'Tamanho do arquivo em bytes';
COMMENT ON COLUMN ppi_curso.tb_arquivo_ref.largura IS 
  'Largura (px) de imagens ou vídeos';
COMMENT ON COLUMN ppi_curso.tb_arquivo_ref.altura IS 
  'Altura (px) de imagens ou vídeos';
COMMENT ON COLUMN ppi_curso.tb_arquivo_ref.resolucao IS 
  'Resolução como string (p.ex., ''1920x1080'')';
COMMENT ON COLUMN ppi_curso.tb_arquivo_ref.duracao_ms IS 
  'Duração em milissegundos (para arquivos de vídeo)';