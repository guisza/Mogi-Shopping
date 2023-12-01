<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*" %>

<!DOCTYPE html>
<html>

<head>
    <title>Cadastrar Produto</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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

        div {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 320px;
            text-align: center;
        }

        h2 {
            color: #333;
        }

        p {
            margin-bottom: 12px;
            color: #333;
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

        .back-btn {
            background-color: #4caf50;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: block;
            margin-top: 10px;
        }

        .back-btn:hover {
            background-color: #45a049;
        }
    </style>
</head>

<body>
    <div>
        <h2>Cadastrar Produto</h2>

        <%-- Retrieve form data from the request parameter --%>
        <%
            String titulo = request.getParameter("titulo");
            String descricao = request.getParameter("descricao");
            double preco = Double.parseDouble(request.getParameter("preco"));

            Connection connection = null;
            PreparedStatement preparedStatement = null;

            try {
                String url = "jdbc:mysql://localhost:3306/shopping";
                String username = "root";
                String dbPassword = "";

                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(url, username, dbPassword);

                String query = "INSERT INTO produto (titulo, descricao, preco) VALUES (?, ?, ?)";
                preparedStatement = connection.prepareStatement(query);
                preparedStatement.setString(1, titulo);
                preparedStatement.setString(2, descricao);
                preparedStatement.setDouble(3, preco);

                int rowsAffected = preparedStatement.executeUpdate();

                if (rowsAffected > 0) {
        %>
                    <p>Produto cadastrado com sucesso!</p>
        <%
                } else {
        %>
                    <p>Falha ao cadastrar o produto. Tente novamente.</p>
        <%
                }

            } catch (Exception e) {
                e.printStackTrace();
        %>
                <p>Error: <%= e.getMessage() %></p>
        <%
            } finally {
                try {
                    if (preparedStatement != null) preparedStatement.close();
                    if (connection != null) connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>

        <a href="../sitelojista/lojista.html" class="back-btn">Voltar para Detalhes</a>
    </div>
</body>

</html>