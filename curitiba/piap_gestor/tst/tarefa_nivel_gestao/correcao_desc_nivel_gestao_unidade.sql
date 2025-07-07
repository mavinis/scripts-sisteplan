-- Correção da desc_nivel_gestao da linha Unidade

UPDATE ppi_seg.nivel_gestao
SET desc_nivel_gestao = 'Usuários neste grupo podem ver e gerenciar usuários de unidades específicas'
WHERE cod_nivel_gestao = 1;
