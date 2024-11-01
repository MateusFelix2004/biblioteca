/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


function adicionar() {
    // Obtém o token do localStorage
    const token = localStorage.getItem("token");

    // Seleciona o formulário e coleta os dados
    const form = document.querySelector("#addForm");
    const formData = new FormData(form);
    const data = Object.fromEntries(formData.entries());

    // Configura as opções de requisição com o token no cabeçalho
    const options = {
        method: 'POST',
        headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: new URLSearchParams(data) // Formata os dados para URL encoded
    };

    // Envia a requisição e substitui o conteúdo da página com a resposta
    fetch("adicionar.jsp", options)
        .then(response => response.text())
        .then(html => {
            document.open();
            document.write(html);
            document.close();
        })
        .catch(error => {
            console.error("Erro ao fazer requisição:", error);
        });
}
