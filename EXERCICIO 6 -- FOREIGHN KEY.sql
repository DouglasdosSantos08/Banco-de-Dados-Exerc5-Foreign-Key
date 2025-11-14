
CREATE DATABASE Midia
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_general_ci;


drop database Midia;


-- TABELAS DE DESENHOS


use midia;

CREATE TABLE desenhos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    desenho VARCHAR(100) NOT NULL,
    criador VARCHAR(100),
    ano_lancamento INT
);

SELECT * FROM desenhos;


insert into desenhos values
(default, 'Dragon Ball', 'Akira Toriyama','1984'),
(default, 'Naruto', 'Masashi Kishimoto','1999'),
(default, 'Demon Slayer', 'Koyoharu Gotouge','2016');



drop table desenhos;


CREATE TABLE personagens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    idade INT,
    desenho_id INT,
    FOREIGN KEY (desenho_id) REFERENCES desenhos(id)
);

SELECT * FROM personagens;

insert into personagens values
(default, 'Goku', '36','1'),
(default, 'Sasuke', '33','2'),
(default, 'Zenitsu', '16','3');

drop table personagens;

update personagens set desenho_id = null where id = 1;

desc personagens;

-- TABELAS DE MÚSICA


CREATE TABLE artistas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    genero VARCHAR(50)
);

insert into artistas values
(default, 'Jorge e Mateus', 'Sertanejo'),
(default, 'Gusttavo Lima', 'Sertanejo'),
(default, 'Zé Neto e Cristiano', 'Sertanejo'),
(default, 'Gusttavo Lima', 'Sertanejo');


SELECT * FROM artistas;


CREATE TABLE albuns (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    ano_lancamento INT,
    artista_id INT,
    FOREIGN KEY (artista_id) REFERENCES artistas(id)
);

insert into albuns values
(default, 'Amo Noite e Dia', '2010', '1'),
(default, 'Diz pra Mim', '2014', '2'),
(default, 'Cadeira de Aço', '2017', '3'),
(DEFAULT, 'Os Anjos Cantam', 2015, 4),
(DEFAULT, 'Terra Sem CEP', 2018, 4),
(DEFAULT, 'Ao Vivo Em Goiânia', 2012, 4);


SELECT * FROM albuns;


-- TABELAS DE LIVROS


CREATE TABLE autores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    nacionalidade VARCHAR(50)
);

INSERT INTO autores VALUES
(DEFAULT, 'Rick Riordan', 'Americano'),
(DEFAULT, 'Machado de Assis', 'Brasileiro'),
(DEFAULT, 'J.K. Rowling', 'Britânica');




SELECT * FROM autores;

CREATE TABLE livros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    genero VARCHAR(50),
    autor_id INT,
    FOREIGN KEY (autor_id) REFERENCES autores(id)
);

INSERT INTO livros VALUES
(DEFAULT, 'Percy Jackson e o Ladrão de Raios', 'Fantasia', 1),
(DEFAULT, 'Dom Casmurro', 'Realismo', 2),
(DEFAULT, 'Harry Potter e a Pedra Filosofal', 'Fantasia', 3);





SELECT * FROM livros;

-- 1 Listar o nome dos personagens e o nome do desenho a que pertencem

select d.desenho, n.nome as personagens from
desenhos d inner join personagens n  
on d.id = n.desenho_id;

-- 2 Listar o nome dos álbuns e o nome do artista correspondente

SELECT a.titulo, ar.nome AS artista FROM 
albuns a INNER JOIN artistas ar
    on a.artista_id = ar.id;
    
   -- 3  Listar o título dos livros e a nacionalidade do autor 
   
   SELECT l.titulo, a.nacionalidade FROM
   livros l INNER JOIN autores a
    on l.autor_id = a.id;


-- 4 Listar todos os personagens, mesmo que não estejam associados a um desenho

SELECT p.nome AS personagem, d.desenho AS desenho FROM
 personagens p LEFT JOIN desenhos d
    on p.desenho_id = d.id;
    
    -- 5 Listar todos os desenhos, mesmo que não tenham personagens Associados

SELECT d.desenho, p.nome AS personagem FROM
desenhos d LEFT JOIN personagens p
    ON d.id = p.desenho_id;

-- 6 Listar todos os álbuns, mesmo que não estejam associados a um artista

SELECT a.titulo AS album, ar.nome AS artista FROM 
albuns a LEFT JOIN artistas ar
    ON a.artista_id = ar.id;

-- 7 Listar todos os artistas, mesmo que não tenham álbuns lançados

SELECT ar.nome AS artista, a.titulo AS album FROM
 artistas ar LEFT JOIN albuns a
    ON ar.id = a.artista_id;

-- 8 Listar todos os livros, mesmo que não estejam associados a um autor

SELECT l.titulo AS livro, a.nome AS autor FROM 
livros l LEFT JOIN autores a
    ON l.autor_id = a.id;


-- 9 Listar todos os autores, mesmo que não tenham livros publicados

SELECT a.nome AS autor, l.titulo AS livro FROM
 autores a LEFT JOIN livros l
    ON a.id = l.autor_id;

-- 10 Listar os nomes dos personagens e dos desenhos, mas apenas para os personagens que têm mais de 18 anos

SELECT p.nome AS personagem, d.desenho FROM
 personagens p INNER JOIN desenhos d
    ON p.desenho_id = d.id
WHERE p.idade > 18;

-- 11  Listar os títulos dos álbuns lançados antes de 2000 e o nome do artista

SELECT a.titulo AS album, ar.nome AS artista FROM
 albuns a INNER JOIN artistas ar
    ON a.artista_id = ar.id
WHERE a.ano_lancamento < 2000;

-- 12 Listar os títulos dos livros de autores brasileiros

SELECT l.titulo FROM 
livros l INNER JOIN autores a
    ON l.autor_id = a.id
WHERE a.nacionalidade = 'Brasileiro';

-- 13 Listar os nomes dos personagens e dos desenhos, ordenados pelo nome do desenho em ordem alfabética

SELECT p.nome AS personagem, d.desenho FROM
 personagens p INNER JOIN desenhos d
    ON p.desenho_id = d.id
ORDER BY d.desenho ASC;

-- 14 Listar os títulos dos álbuns e o nome do artista, ordenados pelo ano de lançamento do álbum em ordem decrescente

SELECT a.titulo AS album, ar.nome AS artista, a.ano_lancamento FROM
 albuns a  INNER JOIN artistas ar ON a.artista_id = ar.id
ORDER BY a.ano_lancamento DESC;

-- 15 Listar os títulos dos livros e o nome do autor, ordenados pelo título do livro em ordem alfabética

SELECT l.titulo AS livro, a.nome AS autor FROM
 livros l  INNER JOIN autores a ON l.autor_id = a.id
ORDER BY l.titulo ASC;

-- 16 Contar quantos personagens pertencem a cada desenho

SELECT d.desenho, COUNT(p.id) AS total_personagens FROM
 desenhos d  LEFT JOIN personagens p ON d.id = p.desenho_id
GROUP BY d.id, d.desenho;

-- 17 Calcular a média de idade dos personagens de cada desenho

SELECT d.desenho, AVG(p.idade) AS media_idade FROM
 desenhos d LEFT JOIN personagens p ON d.id = p.desenho_id
GROUP BY d.id, d.desenho;

-- 18 Listar os artistas que possuem mais de 3 álbuns lançados

SELECT ar.nome AS artista, COUNT(a.id) AS total_albuns FROM
 artistas ar INNER JOIN albuns a ON ar.id = a.artista_id
GROUP BY ar.id, ar.nome
HAVING COUNT(a.id) > 3;

-- 19 Listar os autores que possuem livros publicados em mais de um gênero

SELECT a.nome AS autor, COUNT(DISTINCT l.genero) AS qtd_generos FROM
 autores a INNER JOIN livros l ON a.id = l.autor_id
GROUP BY a.id, a.nome
HAVING COUNT(DISTINCT l.genero) > 1;

-- 20 Listar os desenhos que possuem personagens com idade média maior que 30 anos

SELECT d.desenho, AVG(p.idade) AS media_idade FROM
 desenhos d INNER JOIN personagens p ON d.id = p.desenho_id
GROUP BY d.id, d.desenho
HAVING AVG(p.idade) > 30;
