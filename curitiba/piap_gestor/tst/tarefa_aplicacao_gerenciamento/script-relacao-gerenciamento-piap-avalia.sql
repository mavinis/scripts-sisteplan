-- Estabelece a relação de gerenciamento entre as aplicações PIAP Gestor e AVALIA

INSERT INTO ppi_seg.aplicacao_gerenciamento (
    nr_aplicacao_gerenciadora,
    nr_aplicacao_gerenciada
)
VALUES 
    (2, 2), -- PIAP Gestor se autogerencia
    (2, 6); -- PIAP Gestor gerencia AVALIA