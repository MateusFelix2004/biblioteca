/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ifrn.biblioteca.autenticacao;

import com.ifrn.biblioteca.classes.Usuario;
import com.ifrn.biblioteca.modelo.Banco; // Classe de conexão ao banco de dados
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Mateus
 */

@WebServlet(name = "Login", urlPatterns = {"/login"})
public class Login extends HttpServlet {

    private TokenManager tokenManager = new TokenManager(); // Instância do TokenManager
    private Banco banco = new Banco(); // Instância da classe de banco para executar a procedure

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("usuario");
        String password = request.getParameter("senha");

        try {
            // Executa a procedure login
            String query = "CALL login('" + username + "')";
            ResultSet rs = banco.executarQuery(query);

            if (rs.next()) {
                // Obtem os dados do usuário da consulta
                String dbPassword = rs.getString("senha");

                // Verifica a senha
                if (dbPassword.equals(password)) {
                    String id = rs.getString("id");
                    String nome = rs.getString("nome");
                    String tipo = rs.getString("tipo");

                    // Cria o usuário e gera o token
                    Usuario usuario = new Usuario(id, nome, tipo);
                    String token = tokenManager.gerarToken(usuario);

                    // Retorna o token em formato JSON
                    response.setContentType("application/json");
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.getWriter().write("{\"token\": \"" + token + "\"}");
                } else {
                    // Senha incorreta
                    response.setContentType("application/json");
                    response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                    response.getWriter().write("{\"mensagem\": \"Usuário ou senha incorretos.\"}");
                }
            } else {
                // Usuário não encontrado
                response.setContentType("application/json");
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.getWriter().write("{\"mensagem\": \"Usuário ou senha incorretos.\"}");
            }

        } catch (SQLException e) {
            // Lida com erros de banco de dados
            response.setContentType("application/json");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"mensagem\": \"Erro no servidor.\"}");
            e.printStackTrace();
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet para autenticação de usuários.";
    }
}
