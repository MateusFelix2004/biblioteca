<%-- 
    Document   : adicionar
    Created on : 30 de out. de 2024, 08:10:00
    Author     : Mateus
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="com.ifrn.biblioteca.modelo.Livros"%>
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
    <title>Biblioteca - Adicionar Livro</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <!-- Link para o arquivo CSS externo -->
    <link rel="stylesheet" href="./css/adicionar.css">
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
        <p>Adicionar Novo Livro</p>
        
        <div class="logout-btn-container">
            <button class="logout-btn">Sair</button>
        </div>
    </header>

    <main class="container">
        <% 
            // Instância da classe Livros para adicionar um novo livro
            Livros modeloLivros = new Livros();

            // Obtém os parâmetros do formulário
            String titulo = request.getParameter("titulo");
            String autor = request.getParameter("autor");
            String editora = request.getParameter("editora");
            String anoStr = request.getParameter("ano");

            // Se todos os parâmetros estiverem presentes, processa a adição do livro
            if (titulo != null && autor != null && editora != null && anoStr != null) {
                try {
                    int ano = Integer.parseInt(anoStr);

                    // Chama o método para adicionar o novo livro ao banco de dados
                    modeloLivros.adicionarLivro(titulo, autor, editora, anoStr);

                    // Exibe uma mensagem de sucesso após a adição
                    out.print("<p class='success-message'>Livro adicionado com sucesso!</p><br>");
                    out.print("<div class='success-message'>");
                    out.print("<a href='listar.jsp' class='btn loan-btn'>Voltar para a lista</a>");
                    out.print("</div>");
                } catch (NumberFormatException e) {
                    // Mensagem de erro caso o ano não seja um número válido
                    out.print("<p class='error-message'>Ano inválido. Por favor, insira um número válido.</p>");
                }
            } else { %>
                <!-- Exibe o formulário de adição se os parâmetros não estão presentes -->
            <form id="addForm" class="add-form">
                <label for="titulo">Título:</label>
                <input type="text" name="titulo" id="titulo" class="form-input" required>

                <label for="autor">Autor:</label>
                <input type="text" name="autor" id="autor" class="form-input" required>

                <label for="editora">Editora:</label>
                <input type="text" name="editora" id="editora" class="form-input" required>

                <label for="ano">Ano:</label>
                <input type="number" name="ano" id="ano" class="form-input" required min="1900" max="2100">

                <div class="button-group">
                    <button type="button" class="btn save-btn" onclick="adicionar()">Salvar</button>
                    <a href="listar.jsp" class="btn cancel-btn">Cancelar</a>
                </div>
            </form>

        <% } %>
    </main>

    <script src="../js/logout.js"></script>
    <script src="./js/adicionar.js"></script> <!-- Inclui o script JavaScript -->
<%
    }
%>
</body>
</html>
