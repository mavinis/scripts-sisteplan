--- Adicionar coluna ind_ativo na tabela disciplina
ALTER TABLE ppi.disciplina
ADD COLUMN ind_ativo BOOLEAN DEFAULT TRUE;

--- Setar ind_ativo das oficinas para FALSE
UPDATE ppi.disciplina
SET ind_ativo = FALSE
WHERE nm_disciplina ILIKE 'Ofic%';
