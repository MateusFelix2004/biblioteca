/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ifrn.biblioteca.autenticacao;

/**
 *
 * @author Mateus
 */
import com.ifrn.biblioteca.classes.Usuario;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import java.util.Date;

public class TokenManager {
    private static final String SECRET_KEY = "your_secret_key"; // Substitua por uma chave secreta segura
    private static final long EXPIRATION_TIME = 60000; // 3 horas em milissegundos

    // Gera um token para um usuário
    public String gerarToken(Usuario usuario) {
        return Jwts.builder()
                .setSubject(usuario.getId())
                .claim("nome", usuario.getNome())
                .claim("tipo", usuario.getTipo())
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
                .signWith(SignatureAlgorithm.HS512, SECRET_KEY)
                .compact();
    }

    // Valida um token
    public boolean validarToken(String token) {
        try {
            Jwts.parser().setSigningKey(SECRET_KEY).parseClaimsJws(token);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    // Obtém o usuário do token
    public Usuario obterUsuarioDoToken(String token) {
        Claims claims = Jwts.parser()
                .setSigningKey(SECRET_KEY)
                .parseClaimsJws(token)
                .getBody();

        String id = claims.getSubject();
        String nome = claims.get("nome", String.class);
        String tipo = claims.get("tipo", String.class);

        return new Usuario(id, nome, tipo);
    }
}
