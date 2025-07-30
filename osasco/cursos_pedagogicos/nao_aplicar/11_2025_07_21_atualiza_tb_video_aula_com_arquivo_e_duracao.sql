-- Adiciona a coluna para armazenar a duração do vídeo
ALTER TABLE ppi_curso.tb_video_aula
ADD COLUMN duracao INTERVAL;

-- Adiciona a coluna para a chave estrangeira do arquivo
ALTER TABLE ppi_curso.tb_video_aula
ADD COLUMN id_arquivo BIGINT;

-- Adiciona a restrição de chave estrangeira para id_arquivo
ALTER TABLE ppi_curso.tb_video_aula
ADD CONSTRAINT fk_video_aula_arquivo 
FOREIGN KEY (id_arquivo)
REFERENCES ppi_curso.tb_arquivo(id_arquivo);

-- Comentários sobre as novas colunas
COMMENT ON COLUMN ppi_curso.tb_video_aula.duracao IS 'Duração do vídeo no formato de intervalo de tempo (INTERVAL).';
COMMENT ON COLUMN ppi_curso.tb_video_aula.id_arquivo IS 'Chave estrangeira para a tabela tb_arquivo, referenciando o arquivo de vídeo armazenado externamente.';
