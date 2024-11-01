/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


function editar(id) {
    // Obtém o token do localStorage
    const token = localStorage.getItem("token");

    // Seleciona o formulário e coleta os dados
    const form = document.querySelector("#editForm");
    const formData = new FormData(form);
    
    // Converte os dados do formulário para URLSearchParams
    const params = new URLSearchParams();
    formData.forEach((value, key) => {
        params.append(key, value);
    });

    // Configura as opções de requisição com o token no cabeçalho
    const options = {
        method: 'POST',
        headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/x-www-form-urlencoded' // Define o Content-Type
        },
        body: params // Envia os dados formatados
    };

    // Envia a requisição e substitui o conteúdo da página com a resposta
    fetch(`${window.location.pathname}?id=${id}`, options)
        .then(response => {
            if (!response.ok) {
                throw new Error('Erro na requisição: ' + response.statusText);
            }
            return response.text();
        })
        .then(html => {
            document.open();
            document.write(html);
            document.close();
        })
        .catch(error => {
            console.error("Erro ao fazer requisição:", error);
        });
}
