-- Remove a restrição NOT NULL da coluna arq_anexo da tb_arquivo
ALTER TABLE ppi_curso.tb_arquivo
ALTER COLUMN arq_anexo DROP NOT NULL;

-- Adiciona colunas para armazenar metadados de arquivos externos na tabela tb_arquivo
ALTER TABLE ppi_curso.tb_arquivo
ADD COLUMN chave VARCHAR(255),
ADD COLUMN tipo_mime VARCHAR(255),
ADD COLUMN tamanho_bytes BIGINT,
ADD COLUMN etag VARCHAR(255),
ADD COLUMN dt_criacao TIMESTAMP DEFAULT NOW();

-- Adiciona constraint para garantir que o tamanho do arquivo seja não negativo
ALTER TABLE ppi_curso.tb_arquivo
ADD CONSTRAINT chk_tamanho_bytes CHECK (tamanho_bytes >= 0);

COMMENT ON TABLE ppi_curso.tb_arquivo IS 'Tabela para armazenar metadados de arquivos externos, com nomes de colunas alinhados ao modelo Java Arquivo.';
COMMENT ON COLUMN ppi_curso.tb_arquivo.id_arquivo IS 'Identificador único do arquivo (Chave primária).';
COMMENT ON COLUMN ppi_curso.tb_arquivo.nm_arquivo IS 'Nome original do arquivo, como enviado pelo usuário.';
COMMENT ON COLUMN ppi_curso.tb_arquivo.chave IS 'Chave única do objeto no serviço de armazenamento (object key).';
COMMENT ON COLUMN ppi_curso.tb_arquivo.tipo_mime IS 'Tipo de conteúdo do arquivo (MIME type), por exemplo, "image/jpeg".';
COMMENT ON COLUMN ppi_curso.tb_arquivo.tamanho_bytes IS 'Tamanho do arquivo em bytes.';
COMMENT ON COLUMN ppi_curso.tb_arquivo.etag IS 'ETag do objeto, hash do objeto. Pode ser usado para verificar integridade.';
COMMENT ON COLUMN ppi_curso.tb_arquivo.dt_criacao IS 'Data e hora em que o arquivo foi criado.';