/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package com.ifrn.biblioteca.modelo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Mateus
 */

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Banco {
    private Statement stmt;
    private ResultSet rs;
    public Connection conn;

    // Construtor padrão que estabelece a conexão com o banco de dados
    public Banco() {
        String host = "bdbiblioteca.cb0sckmkwooa.us-east-1.rds.amazonaws.com:3306/biblioteca";
        String usuario = "admin";
        String senha = "ifrn$2024";
        String url = "jdbc:mysql://" + host;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Use o driver correto
            conn = DriverManager.getConnection(url, usuario, senha);
            stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
        } catch (SQLException e) {
            System.err.println("SQL Error: " + e.getMessage());
        } catch (ClassNotFoundException e) {
            System.err.println("Driver not found: " + e.getMessage());
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
        }
    }

    // Método para executar uma consulta SQL e retornar um ResultSet
    public ResultSet executarQuery(String query) {
        try {
            return stmt.executeQuery(query); // Executa a consulta e retorna o ResultSet
        } catch (SQLException e) {
            System.err.println("Erro ao executar a consulta: " + e.getMessage());
            return null; // Retorna null em caso de erro
        }
    }

    // Método para fechar a conexão (recomendado)
    public void fecharConexao() {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            System.err.println("Erro ao fechar a conexão: " + e.getMessage());
        }
    }
}
