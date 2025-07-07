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
    v_nm_permissao := 'rota.dashboards.aluno';
    v_desc_permissao := 'Menu - Ideb Aluno';
    v_nr_aplicacao := 2;
    v_cod_menu_pai := 1;
    v_nm_menu := 'Ideb Aluno';
    v_rota_menu := '/home/dashboards/aluno';
    v_ordem := 3;
    v_svg_menu := '<svg xmlns="http://www.w3.org/2000/svg" enable-background="new 0 0 24 24" height="24px" viewBox="0 0 24 24" width="24px" fill="#e3e3e3"><g><rect fill="none" height="24" width="24"/></g><g><g><rect height="11" width="4" x="4" y="9"/><rect height="7" width="4" x="16" y="13"/><rect height="16" width="4" x="10" y="4"/></g></g></svg>';

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
