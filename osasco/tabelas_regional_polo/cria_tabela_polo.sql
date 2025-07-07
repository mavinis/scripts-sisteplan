-- Cria tabela ppi.tb_polo

drop table if exists ppi.tb_polo;
create table if not exists ppi.tb_polo (
	id_polo serial primary key
	, nm_polo varchar(30) not null
);

insert into ppi.tb_polo
SELECT COD_POLO, NOME_POLO FROM (VALUES
  (1, 'POLO NORTE')
, (2, 'POLO CENTRO')
, (3, 'POLO SUL')
) AS T (COD_POLO, NOME_POLO)
WHERE NOT EXISTS (SELECT * FROM ppi.tb_polo p WHERE p.nm_polo = T.NOME_POLO)
;

select * from ppi.tb_polo;