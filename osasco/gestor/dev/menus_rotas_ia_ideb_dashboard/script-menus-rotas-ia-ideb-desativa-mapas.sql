-- Desativa MENUS de mapas de nota de frequência e atribuição de professores
UPDATE ppi_seg.tb_menu
SET ind_ativo = false
WHERE rota IN (
  '/home/dashboards/mapa-nota-frequencia',
  '/home/dashboards/mapa-atribuicao-professores'
);

-- Desativa PERMISSÕES de mapas de nota de frequência e atribuição de professores
UPDATE ppi_seg.tb_permissao
SET ind_ativo = false
WHERE nm_permissao IN (
  'rota.dashboards.mapaNotaFrequencia',
  'rota.dashboards.mapaAtribuicaoProfessores'
);