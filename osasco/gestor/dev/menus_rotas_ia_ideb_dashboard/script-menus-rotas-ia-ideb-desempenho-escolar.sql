DO $$
DECLARE
    --VARIABLES
    v_id_permissao INTEGER;
    v_id_menu INTEGER;
    --AMBOS
    v_nr_aplicacao INTEGER;
    --PERMISSAO
    v_nm_permissao VARCHAR(150);
    v_desc_permissao VARCHAR(200);
    --MENU
    v_cod_menu_pai INTEGER;
    v_nm_menu VARCHAR(100);
    v_svg_menu TEXT;
    v_rota_menu VARCHAR(100);
    v_ordem INTEGER;
BEGIN
    v_nm_permissao := 'rota.dashboards.desempenho_escolar';
    v_desc_permissao := 'Menu - Ideb Desempenho Escolar';
    v_nr_aplicacao := 2;
    v_cod_menu_pai := 1;
    v_nm_menu := 'Ideb Desempenho Escolar';
    v_rota_menu := '/home/dashboards/desempenho_escolar';
    v_ordem := 5;
    v_svg_menu := '<svg xmlns="http://www.w3.org/2000/svg" height="40px" viewBox="0 -960 960 960" width="40px" fill="#678622"><path d="M479.33-120 192.67-276.67v-240L40-600l439.33-240L920-600v318h-66.67v-280L766-516.67v240L479.33-120Zm0-316 301.34-164-301.34-162-300 162 300 164Zm0 240.33 220-120.66v-162.34L479.33-360l-220-120v163.67l220 120.66ZM480-436Zm-.67 79.33Zm0 0Z"/></svg>';

    INSERT INTO ppi_seg.tb_permissao (nm_permissao, ind_ativo, desc_permissao, nr_aplicacao, id_menu)
    VALUES (v_nm_permissao, TRUE, v_desc_permissao, v_nr_aplicacao, null)
    RETURNING id_permissao INTO v_id_permissao;

    INSERT INTO ppi_seg.tb_menu (nm_menu, svg, rota, ind_ativo, cod_menu_pai, nr_aplicacao, cod_permissao, ordem)
    VALUES (v_nm_menu, v_svg_menu, v_rota_menu, TRUE, v_cod_menu_pai, v_nr_aplicacao, v_id_permissao, v_ordem)
    RETURNING id_menu INTO v_id_menu;

    UPDATE ppi_seg.tb_permissao
    SET id_menu = v_id_menu
    WHERE nm_permissao = v_nm_permissao;
END $$;
