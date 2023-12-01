<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="model.Cliente"%>

<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Cadastro</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        h1 {
            color: #333;
        }

        b {
            color: #4caf50;
        }

        a {
            text-decoration: none;
            color: #4caf50;
            font-weight: bold;
            display: block;
            margin-top: 10px;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>
    <h1>Clientes</h1>
    <%
        // Recebendo dados
        Cliente cli = new Cliente(); // instância
        
        cli.setNome(request.getParameter("nome"));
        cli.setEmail(request.getParameter("email"));
        cli.setSenha(request.getParameter("senha"));

        // GRAVAR!
        try {
            Class.forName("com.mysql.jdbc.Driver"); // registra
            Connection conexao = DriverManager.getConnection("jdbc:mysql://localhost:3306/shopping", "root", ""); // abre Conn
            Statement stmt = conexao.createStatement(); // cria uma instrução
            String sql = "INSERT INTO clientes (nome, email, senha) VALUES ('" + cli.getNome() + "', '" + cli.getEmail() + "', '" + cli.getSenha() + "')"; // corrected SQL statement
            stmt.executeUpdate(sql); // exec. Query.
            conexao.close(); // fecha
        } catch (Exception ex) {
            ex.printStackTrace();
            out.println("Erro: " + ex.toString());
        }

        // Saída
        out.println("<b> Registro - Clientes </b>");
        out.println("<br> Identificação: " + cli.getId());
        out.println("<br> Nome: " + cli.getNome());
        out.println("<br> Email: " + cli.getEmail());
        out.println("<br> Senha: " + cli.getSenha());
    %>
    <a href="#"></a>
</body>

</html>