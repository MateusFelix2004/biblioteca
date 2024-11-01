/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package bd;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


/**
 *
 * @author 20231148060009
 */
public class Banco {
    private Statement stmt;
    private ResultSet rs;
    public Connection conn;
    private static Banco b = new Banco();

    public Banco() {
        String url = "jdbc:mysql://localhost:3306/biblioteca";
        String usr = "root";
        String pas = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Use o driver correto
            conn = DriverManager.getConnection(url, usr, pas);
            stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
        } catch (SQLException e) {
            System.err.println("SQL Error: " + e.getMessage());
        } catch (ClassNotFoundException e) {
            System.err.println("Driver not found: " + e.getMessage());
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
        }
    }

    // Método para obter a instância do banco
    public static Banco getInstance() {
        return b;
    }
    

    // Outros métodos para manipular o banco de dados podem ser adicionados aqui
}