-- ==========================================================
-- ARQUIVO: Queries de Análise e Relatórios
-- OBJETIVO: Demonstrar uso de JOINs, Agrupamentos e Filtros
-- ==========================================================

-- 1. Relatório de Alunos com Pendências (Livros Atrasados)
-- Utiliza INNER JOIN para cruzar dados de três tabelas
SELECT 
    a.nome_completo AS Aluno,
    a.curso AS Curso,
    l.titulo AS Livro,
    e.data_prevista AS 'Data de Devolução'
FROM emprestimos e
JOIN alunos a ON e.fk_aluno = a.id_aluno
JOIN livros l ON e.fk_livro = l.id_livro
WHERE e.status = 'ATRASADO'
ORDER BY e.data_prevista ASC;

-- 2. Estatística: Quais cursos leem mais? (Agregação)
-- Utiliza GROUP BY e COUNT para gerar métricas
SELECT 
    a.curso, 
    COUNT(e.id_emprestimo) as total_emprestimos
FROM alunos a
JOIN emprestimos e ON a.id_aluno = e.fk_aluno
GROUP BY a.curso
ORDER BY total_emprestimos DESC;
