-- Atualiza tabela ppi.tb_regional com nova importação

ALTER TABLE ppi.tb_regional ADD COLUMN id_regional_sistema_legado INT;
INSERT INTO ppi.tb_regional (nm_regional, id_regional_sistema_legado)
SELECT NOME_REGIONAL, COD_REGIONAL
FROM (VALUES
  (1, 'NORTE')
, (2, 'SUL')
, (3, 'CENTRO')
, (4, 'NORDESTE')
, (5, 'NOROESTE')
, (6, 'SUDESTE')
, (7, 'SUDOESTE')
) AS T (COD_REGIONAL, NOME_REGIONAL)
WHERE NOT EXISTS (SELECT * FROM ppi.tb_regional r WHERE r.id_regional_sistema_legado = T.COD_REGIONAL)
;

