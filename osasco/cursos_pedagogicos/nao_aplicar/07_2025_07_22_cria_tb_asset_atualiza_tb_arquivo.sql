-- Criação do tipo enum para tipo_asset
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'tipo_asset') THEN
        CREATE TYPE ppi_curso.tipo_asset AS ENUM ('IMAGEM', 'VIDEO', 'DOCUMENTO', 'AUDIO');
    END IF;
END $$;

-- Criação do tipo enum para situacao_asset
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'situacao_asset') THEN
        CREATE TYPE ppi_curso.situacao_asset AS ENUM ('DISPONIVEL', 'PROCESSANDO', 'FALHA', 'EXCLUSAO_PENDENTE');
    END IF;
END $$;

-- Criação da tabela tb_asset
CREATE TABLE ppi_curso.tb_asset (
    id_asset BIGSERIAL PRIMARY KEY,
    nm_asset VARCHAR(255),
    tipo_asset ppi_curso.tipo_asset NOT NULL,
    situacao_asset ppi_curso.situacao_asset NOT NULL
);

COMMENT ON TABLE ppi_curso.tb_asset IS 'Tabela que armazena os ativos do curso, como vídeos ou documentos.';
COMMENT ON COLUMN ppi_curso.tb_asset.id_asset IS 'Identificador único do asset (chave primária).';
COMMENT ON COLUMN ppi_curso.tb_asset.nm_asset IS 'Nome do asset.';
COMMENT ON COLUMN ppi_curso.tb_asset.tipo_asset IS 'Tipo do asset, conforme enum TipoAsset.';
COMMENT ON COLUMN ppi_curso.tb_asset.situacao_asset IS 'Situação do asset, conforme enum SituacaoAsset.';

-- Adiciona a coluna de referência em tb_arquivo, se não existir
ALTER TABLE ppi_curso.tb_arquivo
ADD COLUMN IF NOT EXISTS id_asset BIGINT;

-- Cria a restrição de chave estrangeira asset-arquivo
-- Impede que arquivos/assets sejam excluídos (é necessário remover o objeto do MinIO antes de excluir o registro)
ALTER TABLE ppi_curso.tb_arquivo
ADD CONSTRAINT fk_arquivo_asset
FOREIGN KEY (id_asset)
REFERENCES ppi_curso.tb_asset(id_asset)
ON DELETE RESTRICT;

COMMENT ON COLUMN ppi_curso.tb_arquivo.id_asset IS 'Chave estrangeira para o asset ao qual o arquivo pertence.';

-- Adiciona a coluna id_arquivo_principal em tb_asset
ALTER TABLE ppi_curso.tb_asset
  ADD COLUMN id_arquivo_principal BIGINT NULL,
  ADD CONSTRAINT fk_asset_principal
      FOREIGN KEY (id_arquivo_principal)
      REFERENCES ppi_curso.tb_arquivo(id_arquivo)
      ON DELETE RESTRICT
      ON UPDATE CASCADE;