-- ==========================================================
-- PROJETO: Sistema de Biblioteca Universitária
-- CONTEXTO: Extensão UnDF (Modelagem Relacional)
-- FERRAMENTA: MySQL Workbench
-- ==========================================================

CREATE SCHEMA IF NOT EXISTS `undf_library` DEFAULT CHARACTER SET utf8mb4;
USE `undf_library`;

-- 1. Tabela de Alunos
CREATE TABLE IF NOT EXISTS `alunos` (
  `id_aluno` INT NOT NULL AUTO_INCREMENT,
  `matricula` VARCHAR(20) NOT NULL UNIQUE,
  `nome_completo` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100),
  `curso` VARCHAR(50),
  PRIMARY KEY (`id_aluno`)
) ENGINE = InnoDB;

-- 2. Tabela de Livros
CREATE TABLE IF NOT EXISTS `livros` (
  `id_livro` INT NOT NULL AUTO_INCREMENT,
  `isbn` VARCHAR(13) NOT NULL UNIQUE,
  `titulo` VARCHAR(150) NOT NULL,
  `autor` VARCHAR(100),
  `ano_publicacao` YEAR,
  `estoque` INT DEFAULT 1,
  PRIMARY KEY (`id_livro`)
) ENGINE = InnoDB;

-- 3. Tabela de Empréstimos (Tabela Associativa N:N)
-- Registra qual aluno pegou qual livro e quando deve devolver
CREATE TABLE IF NOT EXISTS `emprestimos` (
  `id_emprestimo` INT NOT NULL AUTO_INCREMENT,
  `fk_aluno` INT NOT NULL,
  `fk_livro` INT NOT NULL,
  `data_retirada` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `data_prevista` DATE NOT NULL,
  `status` ENUM('ATIVO', 'DEVOLVIDO', 'ATRASADO') DEFAULT 'ATIVO',
  PRIMARY KEY (`id_emprestimo`),
  
  -- Chaves Estrangeiras (Integridade Referencial)
  CONSTRAINT `fk_emprestimo_aluno`
    FOREIGN KEY (`fk_aluno`) REFERENCES `alunos` (`id_aluno`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    
  CONSTRAINT `fk_emprestimo_livro`
    FOREIGN KEY (`fk_livro`) REFERENCES `livros` (`id_livro`)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;
