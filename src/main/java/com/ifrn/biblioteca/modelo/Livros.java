/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ifrn.biblioteca.modelo;

/**
 *
 * @author Mateus
 */
import com.ifrn.biblioteca.classes.Livro;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Livros {
    private Banco banco; // O atributo banco é inicializado como null

    // Método para adicionar um livro
    public void adicionarLivro(String titulo, String autor, String editora, String ano) {
        String query = "CALL adicionarLivro(?, ?, ?, ?)";
        
        try {
            banco = new Banco(); // Inicializa a conexão com o banco de dados
            PreparedStatement stmt = banco.conn.prepareStatement(query);
            stmt.setString(1, titulo);
            stmt.setString(2, autor);
            stmt.setString(3, editora);
            stmt.setString(4, ano);
            stmt.executeUpdate(); // Executa a inserção no banco
        } catch (SQLException e) {
            System.err.println("Erro ao adicionar livro: " + e.getMessage());
        } finally {
            if (banco != null) {
                banco.fecharConexao(); // Fecha a conexão após a operação
            }
        }
    }

    // Método para listar todos os livros
    public List<Livro> listarLivros() {
        String query = "CALL listarLivros();"; 
        List<Livro> listaLivros = new ArrayList<>(); 
        ResultSet rs = null;

        try {
            banco = new Banco(); // Inicializa a conexão com o banco de dados
            rs = banco.executarQuery(query); // Executa a consulta
            while (rs.next()) {
                int id = rs.getInt("id");
                String titulo = rs.getString("titulo");
                String autor = rs.getString("autor");
                String editora = rs.getString("editora");
                String ano = rs.getString("ano");

                // Cria um objeto Livro e adiciona à lista
                Livro livro = new Livro(id, titulo, autor, editora, ano);
                listaLivros.add(livro);
            }
        } catch (SQLException e) {
            System.err.println("Erro ao listar livros: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close(); // Fecha o ResultSet após o uso
            } catch (SQLException e) {
                System.err.println("Erro ao fechar ResultSet: " + e.getMessage());
            }
            if (banco != null) {
                banco.fecharConexao(); // Fecha a conexão após a operação
            }
        }

        return listaLivros; // Retorna a lista de livros
    }

    // Método para listar livros com base em um texto de pesquisa
    public List<Livro> listarLivrosPorTexto(String textoPesquisa) {
        List<Livro> listaLivros = new ArrayList<>();
        String query = "SELECT * FROM livros WHERE titulo LIKE ? OR autor LIKE ? OR editora LIKE ?";

        try {
            banco = new Banco(); // Inicializa a conexão com o banco de dados
            PreparedStatement stmt = banco.conn.prepareStatement(query);
            String pesquisa = "%" + textoPesquisa + "%"; 
            stmt.setString(1, pesquisa);
            stmt.setString(2, pesquisa);
            stmt.setString(3, pesquisa);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String titulo = rs.getString("titulo");
                String autor = rs.getString("autor");
                String editora = rs.getString("editora");
                String ano = rs.getString("ano");

                // Cria um objeto Livro e adiciona à lista
                Livro livro = new Livro(id, titulo, autor, editora, ano);
                listaLivros.add(livro);
            }
        } catch (SQLException e) {
            System.err.println("Erro ao listar livros por texto: " + e.getMessage());
        } finally {
            if (banco != null) {
                banco.fecharConexao(); // Fecha a conexão após a operação
            }
        }

        return listaLivros; // Retorna a lista de livros encontrados
    }

    // Método para detalhar um livro
    public Livro detalharLivro(int id) {
        String query = "CALL detalharLivro(?);"; 
        Livro livro = null;
        ResultSet rs = null;

        try {
            banco = new Banco(); // Inicializa a conexão com o banco de dados
            PreparedStatement stmt = banco.conn.prepareStatement(query);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();

            if (rs.next()) {
                String titulo = rs.getString("titulo");
                String autor = rs.getString("autor");
                String editora = rs.getString("editora");
                String ano = rs.getString("ano");

                livro = new Livro(id, titulo, autor, editora, ano);
            }
        } catch (SQLException e) {
            System.err.println("Erro ao detalhar livro: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close(); // Fecha o ResultSet após o uso
            } catch (SQLException e) {
                System.err.println("Erro ao fechar ResultSet: " + e.getMessage());
            }
            if (banco != null) {
                banco.fecharConexao(); // Fecha a conexão após a operação
            }
        }

        return livro; // Retorna o livro encontrado ou null
    }

    // Método para excluir um livro
    public void excluirLivro(int id) {
        String query = "CALL excluirLivro(?);"; 

        try {
            banco = new Banco(); // Inicializa a conexão com o banco de dados
            PreparedStatement stmt = banco.conn.prepareStatement(query);
            stmt.setInt(1, id);
            stmt.executeUpdate(); // Executa a exclusão no banco
        } catch (SQLException e) {
            System.err.println("Erro ao excluir livro: " + e.getMessage());
        } finally {
            if (banco != null) {
                banco.fecharConexao(); // Fecha a conexão após a operação
            }
        }
    }

    // Método para editar um livro
    public void editarLivro(int id, String titulo, String autor, String editora, String ano) {
        String query = "CALL editarLivro(?, ?, ?, ?, ?)"; 

        try {
            banco = new Banco(); // Inicializa a conexão com o banco de dados
            PreparedStatement stmt = banco.conn.prepareStatement(query);
            stmt.setInt(1, id);
            stmt.setString(2, titulo);
            stmt.setString(3, autor);
            stmt.setString(4, editora);
            stmt.setString(5, ano);
            stmt.executeUpdate(); // Executa a atualização no banco
        } catch (SQLException e) {
            System.err.println("Erro ao editar livro: " + e.getMessage());
        } finally {
            if (banco != null) {
                banco.fecharConexao(); // Fecha a conexão após a operação
            }
        }
    }
}