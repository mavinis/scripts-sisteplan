DO $$
DECLARE
    --VARIABLES
    v_cod_permissao INTEGER;
    v_cod_menu INTEGER;
    --AMBOS
    v_nr_aplicacao INTEGER;
    --PERMISSAO
    v_nm_permissao VARCHAR(150);
    v_desc_permissao VARCHAR(200);
    --MENU
    v_cod_menu_pai INTEGER;
    v_titulo_menu VARCHAR(100);
    v_svg_menu TEXT;
    v_rota_menu VARCHAR(100);
    v_ordem INTEGER;
BEGIN
    v_nm_permissao := 'submenu_avalia_desempenho_academico';
    v_desc_permissao := 'Submenu - Avalia Desempenho Acadêmico';
    v_nr_aplicacao := 6;
    v_cod_menu_pai := 1;
    v_titulo_menu := 'Desempenho Acadêmico';
    v_rota_menu := '/home/avalia-desempenho-academico';
    v_ordem := 8;
    v_svg_menu := '<svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#e3e3e3"><path d="M120-120v-80l80-80v160h-80Zm160 0v-240l80-80v320h-80Zm160 0v-320l80 81v239h-80Zm160 0v-239l80-80v319h-80Zm160 0v-400l80-80v480h-80ZM120-327v-113l280-280 160 160 280-280v113L560-447 400-607 120-327Z"/></svg>';

    INSERT INTO ppi_seg.permissao (nm_permissao, cod_situacao, desc_permissao, nr_aplicacao, cod_menu)
    VALUES (v_nm_permissao, 1, v_desc_permissao, v_nr_aplicacao, null)
    RETURNING cod_permissao INTO v_cod_permissao;

    INSERT INTO ppi_seg.menu (titulo, svg, rota, cod_situacao, cod_menu_pai, nr_aplicacao, cod_permissao, ordem)
    VALUES (v_titulo_menu, v_svg_menu, v_rota_menu, 1, v_cod_menu_pai, v_nr_aplicacao, v_cod_permissao, v_ordem)
    RETURNING cod_menu INTO v_cod_menu;

    UPDATE ppi_seg.permissao
    SET cod_menu = v_cod_menu
    WHERE nm_permissao = v_nm_permissao;
END $$;