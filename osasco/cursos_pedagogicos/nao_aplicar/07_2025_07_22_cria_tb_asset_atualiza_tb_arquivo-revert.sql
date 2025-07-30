-- =========================
-- SCRIPT DE REVERT
-- =========================

-- Remove a constraint de chave estrangeira asset-arquivo
ALTER TABLE ppi_curso.tb_arquivo DROP CONSTRAINT IF EXISTS fk_arquivo_asset;

-- Remove a coluna id_asset de tb_arquivo
ALTER TABLE ppi_curso.tb_arquivo DROP COLUMN IF EXISTS id_asset;

-- Remove a constraint de chave estrangeira fk_asset_principal
ALTER TABLE ppi_curso.tb_asset DROP CONSTRAINT IF EXISTS fk_asset_principal;

-- Remove a coluna id_arquivo_principal de tb_asset
ALTER TABLE ppi_curso.tb_asset DROP COLUMN IF EXISTS id_arquivo_principal;

-- Remove a tabela tb_asset
DROP TABLE IF EXISTS ppi_curso.tb_asset CASCADE;

-- Remove o tipo ENUM situacao_asset
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_type WHERE typname = 'situacao_asset') THEN
        DROP TYPE ppi_curso.situacao_asset;
    END IF;
END $$;

-- Remove o tipo ENUM tipo_asset
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_type WHERE typname = 'tipo_asset') THEN
        DROP TYPE ppi_curso.tipo_asset;
    END IF;
END $$;
