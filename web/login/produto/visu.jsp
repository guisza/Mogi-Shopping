<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*" %>

<!DOCTYPE html>
<html>

<head>
    <title>Detalhes do Produto</title>
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

        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
        }

        input {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            margin-bottom: 12px;
        }

        button {
            background-color: #4caf50;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }

        button:hover {
            background-color: #45a049;
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
    </style>
</head>

<body>
    <div>
        <h2>Detalhes do Produto</h2>
        
        <%-- Retrieve product ID from the request parameter --%>
        <%
            String productIdParam = request.getParameter("productId");

            // Validate if productIdParam is not null or empty and is a number
            if (productIdParam != null && !productIdParam.isEmpty() && productIdParam.matches("\\d+")) {
                int productId = Integer.parseInt(productIdParam);

                Connection connection = null;
                PreparedStatement preparedStatement = null;
                ResultSet resultSet = null;

                try {
                    String url = "jdbc:mysql://localhost:3306/shopping";
                    String username = "root";
                    String dbPassword = "";

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection(url, username, dbPassword);

                    String query = "SELECT * FROM produto WHERE id = ?";
                    preparedStatement = connection.prepareStatement(query);
                    preparedStatement.setInt(1, productId);

                    resultSet = preparedStatement.executeQuery();

                    if (resultSet.next()) {
                        // Retrieve product details from the result set
                        String title = resultSet.getString("titulo");
                        String description = resultSet.getString("descricao");
                        double price = resultSet.getDouble("preco");
        %>
                        <label>Título:</label>
                        <p><%= title %></p>
                        <label>Descrição:</label>
                        <p><%= description %></p>
                        <label>Preço:</label>
                        <p>R$:<%= price %></p>
        <%
                    } else {
        %>
                        <p>Produto não encontrado.</p>
        <%
                    }

                } catch (Exception e) {
                    e.printStackTrace();
        %>
                    <p>Error: <%= e.getMessage() %></p>
        <%
                } finally {
                    try {
                        if (resultSet != null) resultSet.close();
                        if (preparedStatement != null) preparedStatement.close();
                        if (connection != null) connection.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } else {
        %>
                <p>Parâmetro de ID do Produto inválido.</p>
        <%
            }
        %>
        <a href="edit.html">Editar</a>
        <a href="deletar.html">Deletar</a>

    </div>
</body>

</html>
