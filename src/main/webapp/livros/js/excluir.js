/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


function excluir(id) {
        // Confirma a exclusão com o usuário
        const confirmacao = confirm("Tem certeza de que deseja excluir este livro?");
        if (confirmacao) {
            // Realiza a requisição para excluir o livro
            fetch('/excluir', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'id=' + id // Envia o ID do livro
            })
            .then(response => {
                if (response.ok) {
                    // Se a resposta for bem-sucedida, exibe uma mensagem de sucesso
                    alert("Livro excluído com sucesso.");
                    // Atualiza a página para refletir as mudanças
                    location.reload(); // Redireciona para a mesma página
                } else {
                    // Se a resposta não for bem-sucedida, exibe uma mensagem de erro
                    response.json().then(data => {
                        alert(data.mensagem);
                    });
                }
            })
            .catch(error => {
                // Em caso de erro na requisição, exibe uma mensagem
                alert("Erro ao excluir o livro: " + error.message);
            });
        }
    }