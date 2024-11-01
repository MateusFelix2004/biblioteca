<%-- 
    Document   : emprestimo
    Created on : 26 de out. de 2024, 08:11:40
    Author     : Mateus
--%>

<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="com.ifrn.biblioteca.modelo.Livros"%>
<%@page import="com.ifrn.biblioteca.classes.Livro"%>
<%@page import="jakarta.servlet.http.HttpServletRequest" %>

<%
    // Obtém o token do cabeçalho Authorization
    String token = request.getHeader("Authorization");
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Biblioteca - Empréstimo de Livro</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <!-- Link para o arquivo CSS externo -->
    <link rel="stylesheet" href="./css/emprestimo.css">
</head>
<body>

<%
    // Verifica se o token está presente
    if (token == null || token.isEmpty()) {
%>
    <!-- Se o token não estiver presente, apenas inclui o guard.js -->
    <script src="../js/guard.js"></script>
<%
    } else {
%>
    <header class="header">
        <h1>Biblioteca</h1>
        <p>Empréstimo de Livro</p>
        
        <div class="logout-btn-container">
            <button class="logout-btn">Sair</button>
        </div>
    </header>

    <main class="container">
        <% 
        // Obtém o valor do parâmetro 'id' da URL
        String id = request.getParameter("id");
        Livro livro = null; // Variável para armazenar o livro encontrado

        // Instância da classe Livros
        Livros modeloLivros = new Livros();

        // Verifica se o id não é nulo ou vazio
        if (id != null && !id.isEmpty()) {
            // Busca o livro pelo id
            livro = modeloLivros.detalharLivro(Integer.parseInt(id)); // Supondo que este método exista
        }

        // Verifica se o livro foi encontrado
        if (livro != null) { 
        %>
            <!-- Card do Livro -->
            <div class="book-card">
                <h3 class="book-title"><%= livro.getTitulo() %></h3>
                <p class="book-author">Autor: <%= livro.getAutor() %></p>
                <p class="book-publisher">Editora: <%= livro.getEditora() %></p>
                <p class="book-year">Ano: <%= livro.getAno() %></p>
            </div>

            <!-- Formulário de Empréstimo -->
            <form action="emprestimo.jsp?id=<%= id %>" method="post" class="loan-form">
                <label for="username">Usuário (Tomador):</label>
                <input type="text" name="usuarioTomador" id="username" class="form-input" placeholder="Nome de usuário" required>

                <label for="senhaTomador">Senha (Tomador):</label>
                <input type="password" name="senhaTomador" id="senhaTomador" class="form-input" placeholder="Senha" required>
                
                <label for="senhaBibliotecario">Senha (Bibliotecário):</label>
                <input type="password" name="senhaBibliotecario" id="senhaBibliotecario" class="form-input" placeholder="Senha" required>

                <button type="submit" class="btn loan-btn">Emprestar</button>
            </form>
                
        <% } else { %>
            <p>ID do livro não fornecido ou livro não encontrado.</p>
            <br>
            <a href="listar.jsp" class="btn loan-btn">Voltar</a>
        <% } %>
    </main>
<%
    }
%>
<script src="../js/logout.js"></script>
</body>
</html>
