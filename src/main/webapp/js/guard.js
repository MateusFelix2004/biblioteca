/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


document.addEventListener("DOMContentLoaded", function() {
    // Verifica se o token existe no localStorage
    const token = localStorage.getItem("token");

    if (token) {
        // Obtém a URL atual
        const currentUrl = window.location.href;

        // Define as opções para a requisição com o token no cabeçalho
        const options = {
            method: 'GET', // ou 'POST', dependendo do que você precisa
            headers: {
                'Authorization': `Bearer ${token}`
            }
        };

        // Faz uma requisição para a mesma URL com o token no cabeçalho
        fetch(currentUrl, options)
            .then(response => {
                if (response.ok) {
                    // A requisição foi bem-sucedida, você pode manipular a resposta aqui
                    return response.text(); // Pega o corpo da resposta
                } else if (response.status === 401) {
                    // Se a resposta for 401, remove o token e redireciona para login
                    localStorage.removeItem("token"); // Remove o token do localStorage
                    window.location.href = "/login.jsp"; // Redireciona para a página de login
                } else {
                    console.error("Erro na requisição:", response.statusText);
                    // Redireciona para a página de login para outros erros, se necessário
                    window.location.href = "/login.jsp";
                }
            })
            .then(html => {
                // Substitui o conteúdo da página atual com a nova resposta
                document.open();
                document.write(html);
                document.close();
            })
            .catch(error => {
                console.error("Erro ao fazer requisição:", error);
            });
    } else {
        // Redireciona para a página de login se o token não existir
        window.location.href = "/login.jsp";
    }
});
