<%-- 
    Document   : listar
    Created on : 26 de out. de 2024, 07:48:42
    Author     : Mateus
--%>

<%@page import="com.ifrn.biblioteca.modelo.Livros"%>
<%@page import="com.ifrn.biblioteca.classes.Livro"%>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Biblioteca - Lista de Livros</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!-- Link para o arquivo CSS externo -->
    <link rel="stylesheet" href="./css/listar.css">
</head>
<body>
    <script src="./js/excluir.js"></script>
    
    <%
    // Obtém o token do cabeçalho Authorization
    String token = request.getHeader("Authorization");

    // Verifica se o token está presente
    if (token == null || token.isEmpty()) {
    %>
        <!-- Se o token não estiver presente, apenas inclui o guard.js -->
        <script src="../js/guard.js"></script>
    <%
    } else {
    %>
        <!-- Conteúdo da página se o token estiver presente -->
        <header class="header">
            <h1>Biblioteca</h1>
            <p>Explore e Gerencie os Livros Disponíveis</p>

        <div class="logout-btn-container">
            <button class="logout-btn">Sair</button>
        </div>
        </header>

        <main class="container">
            <!-- Campo de Pesquisa -->
            <%
            String textoPesquisa = request.getParameter("query"); // Obtém o parâmetro de pesquisa da query string
            %>
<section class="search-section">
    <form action="" method="get" class="search-form">
        <input type="text" name="query" id="searchInput" class="search-input" 
               placeholder="Pesquisar livro..."
               value="<%= textoPesquisa != null ? textoPesquisa : "" %>"> <!-- Preenche com o valor de textoPesquisa -->
        <button type="submit" class="btn search-btn">Pesquisar</button>
    </form>
</section>

<%
    Livros modeloLivros = new Livros(); // Instância da classe Livros
    List<Livro> listaLivros;

    // Verifica se textoPesquisa não é nulo e não é vazio
    if (textoPesquisa != null && !textoPesquisa.trim().isEmpty()) {
        listaLivros = modeloLivros.listarLivrosPorTexto(textoPesquisa); // Método para listar livros com base na pesquisa
    } else {
        listaLivros = modeloLivros.listarLivros(); // Obtém a lista de todos os livros
    }
%>

<section class="book-list">
    <h2>Lista de Livros</h2>
    <div class="book-cards">
        <% if (listaLivros.isEmpty()) { %>
            <%-- Card de Nenhum Resultado Encontrado --%>
            <div class="no-results-card"> <!-- Não esconda inicialmente, se a lista estiver vazia -->
                <h3 class="no-results-title">Nenhum resultado encontrado</h3>
                <p class="no-results-message">Tente ajustar sua pesquisa ou verifique se os livros estão disponíveis.</p>
            </div>
            <%-- Fim do card de Nenhum Resultado Encontrado --%>
        <% } else { %>
            <%-- Loop para gerar cards de livro --%>
            <%
                for (Livro livro : listaLivros) {
            %>
                <div class="book-card">
                    <h3 class="book-title"><%= livro.getTitulo() %></h3>
                    <p class="book-author">Autor: <%= livro.getAutor() %></p>
                    <p class="book-publisher">Editora: <%= livro.getEditora() %></p>
                    <p class="book-year">Ano: <%= livro.getAno() %></p>
                    <div class="book-actions">
                        <a href="editar.jsp?id=<%= livro.getId() %>" class="btn edit-btn">Editar</a>
                        <button class="btn delete-btn" onclick="excluir(<%= livro.getId() %>)">Excluir</button>
                        <a href="emprestimo.jsp?id=<%= livro.getId() %>" class="btn loan-btn">Empréstimo</a>
                    </div>
                </div>
            <% } %>
        <% } %>
                </div>
            </section>

<script>
    function confirmarExclusao(id) {
        if (confirm("Você tem certeza que deseja excluir este livro?")) {
            window.location.href = "excluir.jsp?id=" + id; // Redireciona para a página de exclusão
        }
    }
</script>
        </main>
    <%
    }
    %>

    <script src="../js/logout.js"></script>
</body>
</html>


