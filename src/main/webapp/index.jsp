<%-- 
    Document   : index.jsp
    Created on : 25 de out. de 2024, 20:24:30
    Author     : Mateus
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Biblioteca - Bem-vindo(a)</title>
    <link rel="stylesheet" href="css.css"> <!-- Link para o seu CSS existente -->
    <link rel="stylesheet" href="./css/index.css"> <!-- Link para o novo CSS da página inicial -->
</head>
<body>
    <!-- Cabeçalho -->
    <header class="header">
        <h1>Bem-vindo ao Sistema de Livros</h1>
        <p>Descubra, empreste, e gerencie livros!</p>
    </header>

    <!-- Seção Hero -->
    <section class="hero">
        <div>
            <h1>Explore o Mundo da Leitura</h1>
            <p>Uma plataforma para quem ama e trabalha com livros.</p>
            <button class="cta-btn" onclick="window.location.href='login.jsp'">Entrar</button>
        </div>
    </section>

    <!-- Seção de Recursos -->
    <section class="features">
        <div class="feature-card">
            <h3>Pesquisar Livros</h3>
            <p>Encontre rapidamente os livros que você deseja.</p>
        </div>
        <div class="feature-card">
            <h3>Gerenciar Empréstimos</h3>
            <p>Mantenha o controle dos empréstimos de livros.</p>
        </div>
        <div class="feature-card">
            <h3>Recomendações Personalizadas</h3>
            <p>Receba sugestões com base nas suas leituras.</p>
        </div>
    </section>

</body>
</html>
