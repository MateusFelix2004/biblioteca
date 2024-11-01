/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

document.addEventListener("DOMContentLoaded", function() {
    const form = document.getElementById("loginForm");

    form.addEventListener("submit", function(event) {
        event.preventDefault(); // Evita o envio padrão do formulário

        const usuario = document.getElementById("username").value;
        const senha = document.getElementById("password").value;
        const errorMessage = document.getElementById("error-message");

        // Enviando os dados como application/x-www-form-urlencoded
        fetch("/login", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: new URLSearchParams({ usuario, senha }) // Formata os dados
        })
        .then(response => {
            if (response.ok) {
                return response.json(); // Converte a resposta em JSON
            } else {
                // Verifica se o código de status está na faixa de 500
                if (response.status >= 500 && response.status < 600) {
                    return response.json().then(errData => {
                        // Exibe a mensagem de erro retornada pelo servidor
                        errorMessage.style.display = "block";
                        errorMessage.textContent = errData.message || "Erro no servidor. Tente novamente mais tarde."; // Usa a mensagem do servidor ou uma padrão
                        throw new Error(errData.message || "Erro no servidor.");
                    });
                } else {
                    // Se o status não estiver na faixa de 500, trata como erro de autenticação ou similar
                    errorMessage.style.display = "block";
                    errorMessage.textContent = "Usuário ou senha incorretos."; // Mensagem padrão para outros erros
                    throw new Error("Usuário ou senha incorretos.");
                }
            }
        })
        .then(data => {
            // Armazena o token no localStorage
            localStorage.setItem("token", data.token);
            window.location.href = "/home.jsp"; // Redireciona para a página inicial em caso de sucesso
        })
        .catch(error => {
            console.error("Erro ao fazer login:", error);
            // Aqui já tratamos os erros no bloco anterior, então não é necessário tratar novamente
        });
    });
});

