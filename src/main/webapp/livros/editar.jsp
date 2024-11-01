<%-- 
    Document   : editar
    Created on : 26 de out. de 2024, 07:48:19
    Author     : Mateus
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="com.ifrn.biblioteca.modelo.Livros"%>
<%@page import="com.ifrn.biblioteca.classes.Livro"%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Biblioteca - Editar Livro</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <!-- Link para o arquivo CSS externo -->
    <link rel="stylesheet" href="./css/editar.css">
</head>
<body>
<%
    // Obtém o token do cabeçalho Authorization
    String token = request.getHeader("Authorization");

    // Verifica se o token está presente
    if (token == null || token.isEmpty()) {
%>
        <!-- Se o token não estiver presente, inclui o guard.js e interrompe o conteúdo da página -->
        <script src="../js/guard.js"></script>
<%
    } else {
        // Exibe o conteúdo da página se o token estiver presente
%>
    <header class="header">
        <h1>Biblioteca</h1>
        <p>Editar Livro</p>
        
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

            // Processa a edição do livro
            String titulo = request.getParameter("titulo");
            String autor = request.getParameter("autor");
            String editora = request.getParameter("editora");
            String anoStr = request.getParameter("ano");

            if (titulo != null && autor != null && editora != null && anoStr != null) {
                // Caso todos os parâmetros estejam presentes, atualiza o livro
                int ano = Integer.parseInt(anoStr);

                // Aqui você deve implementar a lógica de edição no banco de dados
                modeloLivros.editarLivro(Integer.parseInt(id), titulo, autor, editora, anoStr); // Método para atualizar o livro

                // Redireciona ou exibe uma mensagem de sucesso após a edição
                out.print("<p class='success-message'>Livro editado com sucesso!</p> <br>");
                out.print("<div class='success-message'>");
                out.print("<a href='listar.jsp' class='btn loan-btn'>Voltar para a lista</a>");
                out.print("</div>");
            }
        %>

        <% if (livro != null && titulo == null) { %>
            <!-- Formulário de Edição -->
            <form id="editForm" class="edit-form">
                <label for="titulo">Título:</label>
                <input type="text" name="titulo" id="titulo" class="form-input" value="<%= livro.getTitulo() %>" required>

                <label for="autor">Autor:</label>
                <input type="text" name="autor" id="autor" class="form-input" value="<%= livro.getAutor() %>" required>

                <label for="editora">Editora:</label>
                <input type="text" name="editora" id="editora" class="form-input" value="<%= livro.getEditora() %>" required>

                <label for="ano">Ano:</label>
                <input type="number" name="ano" id="ano" class="form-input" value="<%= livro.getAno() %>" required min="1900" max="2100">

                <div class="button-group">
                    <button type="button" class="btn save-btn" onclick="editar(<%= id %>)">Salvar</button>
                    <a href="listar.jsp" class="btn cancel-btn">Cancelar</a>
                </div>
            </form>
                
        <% } else if (livro == null) { %>
            <p class="success-message">ID do livro não fornecido ou livro não encontrado.</p>
            <br>
            <div class='success-message'>
                <a href="listar.jsp" class="btn loan-btn">Voltar</a>
            </div>
        <% } %>
    </main>
<%
    }
%>
<script src="../js/logout.js"></script>
<script src="./js/editar.js"></script>
</body>
</html>
