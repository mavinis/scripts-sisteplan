-- cria tb_arquivo_ref

CREATE TABLE IF NOT EXISTS ppi.tb_arquivo_ref (
    id_arquivo_ref     BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_arquivo         BIGINT         NOT NULL,
    bucket             TEXT           NOT NULL,
    object_key         TEXT           NOT NULL,
    content_hash       TEXT,
    content_type       TEXT           NOT NULL,
    tamanho_bytes      BIGINT         NOT NULL,
    largura            INTEGER,
    altura             INTEGER,
    resolucao          TEXT,
    duracao_ms         BIGINT,
    CONSTRAINT fk_arquivo_ref_arquivo
      FOREIGN KEY (id_arquivo)
      REFERENCES ppi.tb_arquivo (id_arquivo),
    CONSTRAINT uq_arquivo_ref_arquivo
      UNIQUE (id_arquivo)
);

-- Comentários de documentação
COMMENT ON TABLE ppi.tb_arquivo_ref IS 'Tabela de referências de arquivos<->objetos no File Storage. Cada referência faz a ligação entre um arquivo (tb_arquivo) e seu armazenamento físico (objeto no File Storage). Pode haver múltiplas referências para o mesmo arquivo, mas cada referência aponta para um único objeto armazenado.';
COMMENT ON COLUMN ppi.tb_arquivo_ref.id_arquivo_ref IS 'Chave primária da referência do arquivo';
COMMENT ON COLUMN ppi.tb_arquivo_ref.id_arquivo IS 'Chave estrangeira para tb_arquivo(id_arquivo)';
COMMENT ON COLUMN ppi.tb_arquivo_ref.bucket IS 'Nome do bucket/storage onde o arquivo reside';
COMMENT ON COLUMN ppi.tb_arquivo_ref.object_key IS 'Chave (path) do objeto dentro do bucket';
COMMENT ON COLUMN ppi.tb_arquivo_ref.content_hash IS 'Hash do conteúdo (SHA-256) para verificação de integridade e deduplicação';
COMMENT ON COLUMN ppi.tb_arquivo_ref.content_type IS 'MIME type do arquivo (ex., ''image/png'', ''video/mp4'')';
COMMENT ON COLUMN ppi.tb_arquivo_ref.tamanho_bytes IS 'Tamanho do arquivo em bytes';
COMMENT ON COLUMN ppi.tb_arquivo_ref.largura IS 'Largura (px) de imagens ou vídeos';
COMMENT ON COLUMN ppi.tb_arquivo_ref.altura IS 'Altura (px) de imagens ou vídeos';
COMMENT ON COLUMN ppi.tb_arquivo_ref.resolucao IS 'Resolução como string (ex., ''1080p'', ''720p'')';
COMMENT ON COLUMN ppi.tb_arquivo_ref.duracao_ms IS 'Duração em milissegundos (para arquivos de vídeo)';