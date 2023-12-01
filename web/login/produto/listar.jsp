<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Lista de Produtos</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        h1 {
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f5f5f5;
        }

        a img {
            border: 0;
        }

        a {
            text-decoration: none;
        }
    </style>
</head>

<body>
    <h1>Produtos</h1>
    <%
        // Recebendo dados
        String id = request.getParameter("productId");

        // Consultar
        try {
            Class.forName("com.mysql.jdbc.Driver"); // registra
            Connection conexao = DriverManager.getConnection("jdbc:mysql://localhost:3306/shopping", "root", ""); // abre Conn
            Statement stmt = conexao.createStatement(); // cria uma instrução
            String sql = "SELECT * FROM produto "; // define instr. SQL
            ResultSet rs = stmt.executeQuery(sql); // exec. Query.
    %>
    <table>
        <tr>
            <th>#</th>
            <th>Id</th>
            <th>Título</th>
            <th>Preço</th>
            <th>Detalhes</th>
        </tr>
        <%
            // Saída
            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getRow() %></td>
            <td><%= rs.getString("id") %></td>
            <td><%= rs.getString("titulo") %></td>
            <td><%= rs.getFloat("preco") %></td>
            <td><a href="visu.jsp?id=<%= rs.getString("id") %>"><img src="imagem/plus.png" alt="Detalhes" /></a></td>
            </tr>
        <%
            }
        %>
    </table>
    <%
        conexao.close(); // fecha
    } catch (Exception ex) {
        ex.printStackTrace();
        out.println("Erro: " + ex.toString());
    }
    %>
</body>

</html>