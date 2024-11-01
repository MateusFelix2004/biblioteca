<%-- 
    Document   : home
    Created on : 29 de out. de 2024, 14:45:40
    Author     : 036348301694
--%>

<%@page import="com.ifrn.biblioteca.modelo.Livros"%>
<%@page import="com.ifrn.biblioteca.classes.Livro"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Biblioteca - Home</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!-- Link para o arquivo CSS externo -->
    <link rel="stylesheet" href="./css/home.css">
</head>
<body>

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
                <!-- Ícone de início (home) -->
                <span class="material-icons" translate="no">home</span>
                <button class="logout-btn">Sair</button>
            </div>
        </header>

        <main class="container">
            <h2>Bem-vindo à Biblioteca!</h2>
            <section class="options-section">
                <div class="option-card">
                    <h3>Livros</h3>
                    <a href="livros/listar.jsp" class="btn option-btn">Ver Livros</a>
                </div>
                <div class="option-card">
                    <h3>Adicionar Novo Livro</h3>
                    <a href="livros/adicionar.jsp" class="btn option-btn">Adicionar Livro</a>
                </div>
                <div class="option-card">
                    <h3>Empréstimos</h3>
                    <a href="emprestimo/gerenciar.jsp" class="btn option-btn">Gerenciar Empréstimos</a>
                </div>
                <!-- Adicione mais opções conforme necessário -->
            </section>
        </main>
<%
    }
%>

<script src="../js/logout.js"></script>
</body>
</html>
