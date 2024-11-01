/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ifrn.biblioteca.modelo;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Mateus
 */
@WebServlet(name = "ExcluirLivro", urlPatterns = {"/excluir"})
public class ExcluirServlet extends HttpServlet {

    private Livros livros = new Livros(); // Instância da classe Livros

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtém o ID do livro a partir dos parâmetros da requisição
        String idParam = request.getParameter("id");
        if (idParam == null) {
            // Se o ID não foi fornecido, retorna 400 Bad Request
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"mensagem\": \"ID do livro é obrigatório.\"}");
            return;
        }

        try {
            int id = Integer.parseInt(idParam); // Converte o ID para inteiro
            livros.excluirLivro(id); // Tenta excluir o livro

            // Se a exclusão foi bem-sucedida, retorna 200 OK
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"mensagem\": \"Livro excluído com sucesso.\"}");

        } catch (NumberFormatException e) {
            // Se o ID não puder ser convertido para inteiro, retorna 400 Bad Request
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"mensagem\": \"ID do livro inválido.\"}");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet para exclusão de livros.";
    }
}