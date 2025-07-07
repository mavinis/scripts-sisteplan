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
    v_nm_permissao := 'rota.dashboards.avaliacoes_integrais';
    v_desc_permissao := 'Menu - Ideb Avaliações Integrais';
    v_nr_aplicacao := 2;
    v_cod_menu_pai := 1;
    v_nm_menu := 'Ideb Avaliações Integrais';
    v_rota_menu := '/home/dashboards/avaliacoes_integrais';
    v_ordem := 6;
    v_svg_menu := '<svg xmlns="http://www.w3.org/2000/svg" height="40px" viewBox="0 -960 960 960" width="40px" fill="#678622"><path d="M186.67-120q-27.5 0-47.09-19.58Q120-159.17 120-186.67v-586.66q0-27.5 19.58-47.09Q159.17-840 186.67-840h192.66q7.67-35.33 35.84-57.67Q443.33-920 480-920t64.83 22.33Q573-875.33 580.67-840h192.66q27.5 0 47.09 19.58Q840-800.83 840-773.33v586.66q0 27.5-19.58 47.09Q800.83-120 773.33-120H186.67Zm0-66.67h586.66v-586.66H186.67v586.66ZM280-280h275.33v-66.67H280V-280Zm0-166.67h400v-66.66H280v66.66Zm0-166.66h400V-680H280v66.67Zm200-181.34q13.67 0 23.5-9.83t9.83-23.5q0-13.67-9.83-23.5t-23.5-9.83q-13.67 0-23.5 9.83t-9.83 23.5q0 13.67 9.83 23.5t23.5 9.83Zm-293.33 608v-586.66 586.66Z"/></svg>';

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
