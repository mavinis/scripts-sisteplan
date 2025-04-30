DO $$
DECLARE
  -- Variables for container (parent) IDs
  v_ia_educativa_id       INTEGER;
  v_gestao_id             INTEGER;
  v_hub_id                INTEGER;
  v_avaliacoes_id         INTEGER;
  v_sala_virtual_id       INTEGER;
  v_cursos_id             INTEGER;
  v_painel_seguranca_id   INTEGER;
  
  -- Variable for each child menu insertion
  v_menu_id               INTEGER;
BEGIN
  -----------------------------------------------------------------------------
  -- Insert Container Records (no route) into ppi_seg.tb_menu
  -----------------------------------------------------------------------------
  -- IA Educativa container
  INSERT INTO ppi_seg.tb_menu (nm_menu, rota, svg, ordem, nr_aplicacao, ind_ativo)
  VALUES ('IA Educativa', NULL, '<SVG_PLACEHOLDER>', 1, 2, TRUE)
  RETURNING id_menu INTO v_ia_educativa_id;
  
  -- Gestão container
  INSERT INTO ppi_seg.tb_menu (nm_menu, rota, svg, ordem, nr_aplicacao, ind_ativo)
  VALUES ('Gestão', NULL, '<SVG_PLACEHOLDER>', 1, 2, TRUE)
  RETURNING id_menu INTO v_gestao_id;
  
  -- Hub de Conteúdos container
  INSERT INTO ppi_seg.tb_menu (nm_menu, rota, svg, ordem, nr_aplicacao, ind_ativo)
  VALUES ('Hub de Conteúdos', NULL, '<SVG_PLACEHOLDER>', 1, 2, TRUE)
  RETURNING id_menu INTO v_hub_id;
  
  -- Avaliações container
  INSERT INTO ppi_seg.tb_menu (nm_menu, rota, svg, ordem, nr_aplicacao, ind_ativo)
  VALUES ('Avaliações', NULL, '<SVG_PLACEHOLDER>', 1, 2, TRUE)
  RETURNING id_menu INTO v_avaliacoes_id;
  
  -- Sala Virtual container
  INSERT INTO ppi_seg.tb_menu (nm_menu, rota, svg, ordem, nr_aplicacao, ind_ativo)
  VALUES ('Sala Virtual', NULL, '<SVG_PLACEHOLDER>', 1, 2, TRUE)
  RETURNING id_menu INTO v_sala_virtual_id;
  
  -- Cursos Pedagógicos container
  INSERT INTO ppi_seg.tb_menu (nm_menu, rota, svg, ordem, nr_aplicacao, ind_ativo)
  VALUES ('Cursos Pedagógicos', NULL, '<SVG_PLACEHOLDER>', 1, 2, TRUE)
  RETURNING id_menu INTO v_cursos_id;
  
  -- Painel de Segurança container
  INSERT INTO ppi_seg.tb_menu (nm_menu, rota, svg, ordem, nr_aplicacao, ind_ativo)
  VALUES ('Painel de Segurança', NULL, '<SVG_PLACEHOLDER>', 1, 2, TRUE)
  RETURNING id_menu INTO v_painel_seguranca_id;
  
  -----------------------------------------------------------------------------
  -- Insert Child Records for IA Educativa (Parent: v_ia_educativa_id)
  -----------------------------------------------------------------------------
  -- Ideb IA
  INSERT INTO ppi_seg.tb_menu (cod_menu_pai, nm_menu, rota, svg, ordem, nr_aplicacao, ind_ativo)
  VALUES (v_ia_educativa_id, 'Ideb IA', '/home/dashboards/ideb', '<SVG_PLACEHOLDER>', 1, 2, TRUE)
  RETURNING id_menu INTO v_menu_id;
  INSERT INTO ppi_seg.tb_permissao (nm_permissao, desc_permissao, nr_aplicacao, id_menu, ind_ativo)
  VALUES ('rota.dashboards.ideb', 'Submenu – Ideb IA', 2, v_menu_id, TRUE);
  
  -- Mapa Notas e Desempenho
  INSERT INTO ppi_seg.tb_menu (cod_menu_pai, nm_menu, rota, svg, ordem, nr_aplicacao, ind_ativo)
  VALUES (v_ia_educativa_id, 'Mapa Notas e Desempenho', '/home/dashboards/mapa-nota-frequencia', '<SVG_PLACEHOLDER>', 2, 2, TRUE)
  RETURNING id_menu INTO v_menu_id;
  INSERT INTO ppi_seg.tb_permissao (nm_permissao, desc_permissao, nr_aplicacao, id_menu, ind_ativo)
  VALUES ('rota.dashboards.mapa_nota_frequencia', 'Submenu – Mapa Notas e Desempenho', 2, v_menu_id, TRUE);
  
  -- Mapa Atribuição de Professores
  INSERT INTO ppi_seg.tb_menu (cod_menu_pai, nm_menu, rota, svg, ordem, nr_aplicacao, ind_ativo)
  VALUES (v_ia_educativa_id, 'Mapa Atribuição de Professores', '/home/dashboards/mapa-atribuicao-professores', '<SVG_PLACEHOLDER>', 3, 2, TRUE)
  RETURNING id_menu INTO v_menu_id;
  INSERT INTO ppi_seg.tb_permissao (nm_permissao, desc_permissao, nr_aplicacao, id_menu, ind_ativo)
  VALUES ('rota.dashboards.mapa_atribuicao_professores', 'Submenu – Mapa Atribuição de Professores', 2, v_menu_id, TRUE);
  
  -- Permission for container IA Educativa
  INSERT INTO ppi_seg.tb_permissao (nm_permissao, desc_permissao, nr_aplicacao, id_menu, ind_ativo)
  VALUES ('rota.ia_educativa', 'Menu – IA Educativa', 2, v_ia_educativa_id, TRUE);
  
  -----------------------------------------------------------------------------
  -- Insert Child Records for Gestão (Parent: v_gestao_id)
  -----------------------------------------------------------------------------
  -- Painel Integração Dados
  INSERT INTO ppi_seg.tb_menu (cod_menu_pai, nm_menu, rota, svg, ordem, nr_aplicacao, ind_ativo)
  VALUES (v_gestao_id, 'Painel Integração Dados', '/home/gestao/gerenciamento-dados-integracao', '<SVG_PLACEHOLDER>', 1, 2, TRUE)
  RETURNING id_menu INTO v_menu_id;
  INSERT INTO ppi_seg.tb_permissao (nm_permissao, desc_permissao, nr_aplicacao, id_menu, ind_ativo)
  VALUES ('rota.gestao.gerenciamento_dados_integracao', 'Submenu – Painel Integração Dados', 2, v_menu_id, TRUE);
  
  -- Pesquisa de Professores
  INSERT INTO ppi_seg.tb_menu (cod_menu_pai, nm_menu, rota, svg, ordem, nr_aplicacao, ind_ativo)
  VALUES (v_gestao_id, 'Pesquisa de Professores', '/home/gestao/pesquisa-de-professores', '<SVG_PLACEHOLDER>', 2, 2, TRUE)
  RETURNING id_menu INTO v_menu_id;
  INSERT INTO ppi_seg.tb_permissao (nm_permissao, desc_permissao, nr_aplicacao, id_menu, ind_ativo)
  VALUES ('rota.gestao.pesquisa_professores', 'Submenu – Pesquisa de Professores', 2, v_menu_id, TRUE);
  
  -- Pesquisa de Alunos
  INSERT INTO ppi_seg.tb_menu (cod_menu_pai, nm_menu, rota, svg, ordem, nr_aplicacao, ind_ativo)
  VALUES (v_gestao_id, 'Pesquisa de Alunos', '/home/gestao/pesquisa-de-alunos', '<SVG_PLACEHOLDER>', 3, 2, TRUE)
  RETURNING id_menu INTO v_menu_id;
  INSERT INTO ppi_seg.tb_permissao (nm_permissao, desc_permissao, nr_aplicacao, id_menu, ind_ativo)
  VALUES ('rota.gestao.pesquisa_alunos', 'Submenu – Pesquisa de Alunos', 2, v_menu_id, TRUE);
  
  -- Frequências e Notas
  INSERT INTO ppi_seg.tb_menu (cod_menu_pai, nm_menu, rota, svg, ordem, nr_aplicacao, ind_ativo)
  VALUES (v_gestao_id, 'Frequências e Notas', '/home/gestao/frequencias-e-notas', '<SVG_PLACEHOLDER>', 4, 2, TRUE)
  RETURNING id_menu INTO v_menu_id;
  INSERT INTO ppi_seg.tb_permissao (nm_permissao, desc_permissao, nr_aplicacao, id_menu, ind_ativo)
  VALUES ('rota.gestao.frequencias_notas', 'Submenu – Frequências e Notas', 2, v_menu_id, TRUE);
  
  -- Vínculo Docentes
  INSERT INTO ppi_seg.tb_menu (cod_menu_pai, nm_menu, rota, svg, ordem, nr_aplicacao, ind_ativo)
  VALUES (v_gestao_id, 'Vínculo Docentes', '/home/gestao/gerenciamento-vinculo', '<SVG_PLACEHOLDER>', 5, 2, TRUE)
  RETURNING id_menu INTO v_menu_id;
  INSERT INTO ppi_seg.tb_permissao (nm_permissao, desc_permissao, nr_aplicacao, id_menu, ind_ativo)
  VALUES ('rota.gestao.gerenciamento_vinculo', 'Submenu – Vínculo Docentes', 2, v_menu_id, TRUE);
  
  -- Permission for container Gestão
  INSERT INTO ppi_seg.tb_permissao (nm_permissao, desc_permissao, nr_aplicacao, id_menu, ind_ativo)
  VALUES ('rota.gestao', 'Menu – Gestão', 2, v_gestao_id, TRUE);
  
  -----------------------------------------------------------------------------
  -- Insert Child Records for Hub de Conteúdos (Parent: v_hub_id)
  -----------------------------------------------------------------------------
  -- Planejamento de Ensino
  INSERT INTO ppi_seg.tb_menu (cod_menu_pai, nm_menu, rota, svg, ordem, nr_aplicacao, ind_ativo)
  VALUES (v_hub_id, 'Planejamento de Ensino', '/home/planejamento-ensino', '<SVG_PLACEHOLDER>', 1, 2, TRUE)
  RETURNING id_menu INTO v_menu_id;
  INSERT INTO ppi_seg.tb_permissao (nm_permissao, desc_permissao, nr_aplicacao, id_menu, ind_ativo)
  VALUES ('rota.planejamento_ensino', 'Submenu – Planejamento de Ensino', 2, v_menu_id, TRUE);
  
  -- Conteúdos Próprios
  INSERT INTO ppi_seg.tb_menu (cod_menu_pai, nm_menu, rota, svg, ordem, nr_aplicacao, ind_ativo)
  VALUES (v_hub_id, 'Conteúdos Próprios', '/home/aprender-hub/conteudos', '<SVG_PLACEHOLDER>', 2, 2, TRUE)
  RETURNING id_menu INTO v_menu_id;
  INSERT INTO ppi_seg.tb_permissao (nm_permissao, desc_permissao, nr_aplicacao, id_menu, ind_ativo)
  VALUES ('rota.aprender_hub.conteudos', 'Submenu – Conteúdos Próprios', 2, v_menu_id, TRUE);
  
  -- Conteúdos Externos
  INSERT INTO ppi_seg.tb_menu (cod_menu_pai, nm_menu, rota, svg, ordem, nr_aplicacao, ind_ativo)
  VALUES (v_hub_id, 'Conteúdos Externos', '/home/conteudos-externos', '<SVG_PLACEHOLDER>', 3, 2, TRUE)
  RETURNING id_menu INTO v_menu_id;
  INSERT INTO ppi_seg.tb_permissao (nm_permissao, desc_permissao, nr_aplicacao, id_menu, ind_ativo)
  VALUES ('rota.conteudos_externos', 'Submenu – Conteúdos Externos', 2, v_menu_id, TRUE);
  
  -- Permission for container Hub de Conteúdos
  INSERT INTO ppi_seg.tb_permissao (nm_permissao, desc_permissao, nr_aplicacao, id_menu, ind_ativo)
  VALUES ('rota.hub_conteudos', 'Menu – Hub de Conteúdos', 2, v_hub_id, TRUE);
  
  -----------------------------------------------------------------------------
  -- Insert Child Records for Avaliações (Parent: v_avaliacoes_id)
  -----------------------------------------------------------------------------
  -- Provas
  INSERT INTO ppi_seg.tb_menu (cod_menu_pai, nm_menu, rota, svg, ordem, nr_aplicacao, ind_ativo)
  VALUES (v_avaliacoes_id, 'Provas', '/home/avaliacoes/prova-curitiba', '<SVG_PLACEHOLDER>', 1, 2, TRUE)
  RETURNING id_menu INTO v_menu_id;
  INSERT INTO ppi_seg.tb_permissao (nm_permissao, desc_permissao, nr_aplicacao, id_menu, ind_ativo)
  VALUES ('rota.avaliacoes.prova_curitiba', 'Submenu – Provas', 2, v_menu_id, TRUE);
  
  -- Painel de Envio
  INSERT INTO ppi_seg.tb_menu (cod_menu_pai, nm_menu, rota, svg, ordem, nr_aplicacao, ind_ativo)
  VALUES (v_avaliacoes_id, 'Painel de Envio', '/home/avaliacoes/painel-envio', '<SVG_PLACEHOLDER>', 2, 2, TRUE)
  RETURNING id_menu INTO v_menu_id;
  INSERT INTO ppi_seg.tb_permissao (nm_permissao, desc_permissao, nr_aplicacao, id_menu, ind_ativo)
  VALUES ('rota.avaliacoes.painel_envio', 'Submenu – Painel de Envio', 2, v_menu_id, TRUE);
  
  -- Painel de Acompanhamento
  INSERT INTO ppi_seg.tb_menu (cod_menu_pai, nm_menu, rota, svg, ordem, nr_aplicacao, ind_ativo)
  VALUES (v_avaliacoes_id, 'Painel de Acompanhamento', '/home/avaliacoes/painel-acompanhamento', '<SVG_PLACEHOLDER>', 3, 2, TRUE)
  RETURNING id_menu INTO v_menu_id;
  INSERT INTO ppi_seg.tb_permissao (nm_permissao, desc_permissao, nr_aplicacao, id_menu, ind_ativo)
  VALUES ('rota.avaliacoes.painel_acompanhamento', 'Submenu – Painel de Acompanhamento', 2, v_menu_id, TRUE);
  
  -- Permission for container Avaliações
  INSERT INTO ppi_seg.tb_permissao (nm_permissao, desc_permissao, nr_aplicacao, id_menu, ind_ativo)
  VALUES ('rota.avaliacoes', 'Menu – Avaliações', 2, v_avaliacoes_id, TRUE);
  
  -----------------------------------------------------------------------------
  -- Insert Child Records for Sala Virtual (Parent: v_sala_virtual_id)
  -----------------------------------------------------------------------------
  -- Comunicado
  INSERT INTO ppi_seg.tb_menu (cod_menu_pai, nm_menu, rota, svg, ordem, nr_aplicacao, ind_ativo)
  VALUES (v_sala_virtual_id, 'Comunicado', '/home/comunicados', '<SVG_PLACEHOLDER>', 1, 2, TRUE)
  RETURNING id_menu INTO v_menu_id;
  INSERT INTO ppi_seg.tb_permissao (nm_permissao, desc_permissao, nr_aplicacao, id_menu, ind_ativo)
  VALUES ('rota.comunicados', 'Submenu – Comunicado', 2, v_menu_id, TRUE);
  
  -- Permission for container Sala Virtual
  INSERT INTO ppi_seg.tb_permissao (nm_permissao, desc_permissao, nr_aplicacao, id_menu, ind_ativo)
  VALUES ('rota.sala_virtual', 'Menu – Sala Virtual', 2, v_sala_virtual_id, TRUE);
  
  -----------------------------------------------------------------------------
  -- Insert Child Records for Cursos Pedagógicos (Parent: v_cursos_id)
  -----------------------------------------------------------------------------
  -- Cursos
  INSERT INTO ppi_seg.tb_menu (cod_menu_pai, nm_menu, rota, svg, ordem, nr_aplicacao, ind_ativo)
  VALUES (v_cursos_id, 'Cursos', '/home/cursos-pedagogicos', '<SVG_PLACEHOLDER>', 1, 2, TRUE)
  RETURNING id_menu INTO v_menu_id;
  INSERT INTO ppi_seg.tb_permissao (nm_permissao, desc_permissao, nr_aplicacao, id_menu, ind_ativo)
  VALUES ('rota.cursos_pedagogicos.cursos', 'Submenu – Cursos', 2, v_menu_id, TRUE);
  
  -- Permission for container Cursos Pedagógicos
  INSERT INTO ppi_seg.tb_permissao (nm_permissao, desc_permissao, nr_aplicacao, id_menu, ind_ativo)
  VALUES ('rota.cursos_pedagogicos', 'Menu – Cursos Pedagógicos', 2, v_cursos_id, TRUE);
  
  -----------------------------------------------------------------------------
  -- Insert Child Records for Painel de Segurança (Parent: v_painel_seguranca_id)
  -----------------------------------------------------------------------------
  -- Usuários
  INSERT INTO ppi_seg.tb_menu (cod_menu_pai, nm_menu, rota, svg, ordem, nr_aplicacao, ind_ativo)
  VALUES (v_painel_seguranca_id, 'Usuários', '/home/seguranca/usuarios', '<SVG_PLACEHOLDER>', 1, 2, TRUE)
  RETURNING id_menu INTO v_menu_id;
  INSERT INTO ppi_seg.tb_permissao (nm_permissao, desc_permissao, nr_aplicacao, id_menu, ind_ativo)
  VALUES ('rota.seguranca.usuarios', 'Submenu – Usuários', 2, v_menu_id, TRUE);
  
  -- Grupos de Usuários
  INSERT INTO ppi_seg.tb_menu (cod_menu_pai, nm_menu, rota, svg, ordem, nr_aplicacao, ind_ativo)
  VALUES (v_painel_seguranca_id, 'Grupos de Usuários', '/home/seguranca/grupos-usuarios', '<SVG_PLACEHOLDER>', 2, 2, TRUE)
  RETURNING id_menu INTO v_menu_id;
  INSERT INTO ppi_seg.tb_permissao (nm_permissao, desc_permissao, nr_aplicacao, id_menu, ind_ativo)
  VALUES ('rota.seguranca.grupos_usuarios', 'Submenu – Grupos de Usuários', 2, v_menu_id, TRUE);
  
  -- Grupos de Acesso
  INSERT INTO ppi_seg.tb_menu (cod_menu_pai, nm_menu, rota, svg, ordem, nr_aplicacao, ind_ativo)
  VALUES (v_painel_seguranca_id, 'Grupos de Acesso', '/home/seguranca/grupos-acesso', '<SVG_PLACEHOLDER>', 3, 2, TRUE)
  RETURNING id_menu INTO v_menu_id;
  INSERT INTO ppi_seg.tb_permissao (nm_permissao, desc_permissao, nr_aplicacao, id_menu, ind_ativo)
  VALUES ('rota.seguranca.grupos_acesso', 'Submenu – Grupos de Acesso', 2, v_menu_id, TRUE);
  
  -- Permission for container Painel de Segurança
  INSERT INTO ppi_seg.tb_permissao (nm_permissao, desc_permissao, nr_aplicacao, id_menu, ind_ativo)
  VALUES ('rota.painel_seguranca', 'Menu – Painel de Segurança', 2, v_painel_seguranca_id, TRUE);
  
END $$;
