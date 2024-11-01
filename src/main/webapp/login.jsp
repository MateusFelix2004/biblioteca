<%-- 
    Document   : login
    Created on : 26 de out. de 2024, 20:34:59
    Author     : Mateus
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Biblioteca - Login</title>
    <link rel="stylesheet" href="./css/login.css">
    <script src="./js/login.js" defer></script>
</head>
<body>
    <div class="login-container">
        <h2>Login</h2>
        <form id="loginForm">
            <label for="username">Usuário</label>
            <input type="text" id="username" name="username" value="mateus" required>

            <label for="password">Senha</label>
            <input type="password" id="password" name="password" value="1234" required>

            <button type="submit" class="btn-primary">Entrar</button>
        </form>
        <div id="error-message" class="error-message" style="display: none;"></div>
    </div>
</body>
</html>
