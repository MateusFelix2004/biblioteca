/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

document.addEventListener('DOMContentLoaded', function() {
    // Seleciona o botão de logout usando a classe 'logout-btn'
    const logoutBtn = document.querySelector('.logout-btn');

    if (logoutBtn) { // Verifica se o botão de logout existe
        // Adiciona um evento de clique ao botão de logout
        logoutBtn.addEventListener('click', function(event) {
            event.preventDefault(); // Evita qualquer comportamento padrão
            confirmarLogout(); // Chama a função de confirmação de logout
        });
    } else {
        console.warn('Elemento .logout-btn não encontrado no DOM.');
    }
});

// Função que pergunta se o usuário deseja realmente fazer logout
function confirmarLogout() {
    const confirmLogout = confirm("Tem certeza de que deseja sair?");
    if (confirmLogout) {
        logout(); // Chama a função que executa o logout
    }
}

// Função que executa a lógica de logout
function logout() {
    // Remove o token do localStorage
    localStorage.removeItem('token');

    // Redireciona para a página de login
    window.location.href = '/login.jsp';
}
