/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package com.ifrn.db;

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

public class Banco {
    private Statement stmt;
    private ResultSet rs;
    public Connection conn;

    // Construtor recebe host, usuário e senha como parâmetros
    public Banco(String host, String usuario, String senha) {
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
// Método para listar todos os bancos de dados no servidor
public List<String> listarBancos() {
    List<String> bancos = new ArrayList<>();
    try {
        // Executa a consulta para listar todos os bancos de dados
        String query = "SHOW DATABASES";
        ResultSet rs = stmt.executeQuery(query); // Usa o Statement para executar a consulta

        while (rs.next()) {
            bancos.add(rs.getString(1)); // Adiciona o nome de cada banco de dados à lista
        }

        rs.close(); // Fecha o ResultSet após a consulta
    } catch (SQLException e) {
        System.err.println("Erro ao listar bancos: " + e.getMessage());
    }
    
    return bancos;
}

}
