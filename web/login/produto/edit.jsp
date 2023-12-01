<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*" %>

<!DOCTYPE html>
<html>

<head>
    <title>Atualizar Produto</title>
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
    </style>
</head>

<body>
    <div>
        <h2>Atualizar Produto</h2>

        <%-- Retrieve form data from the request parameters --%>
        <%
            String productIdParam = request.getParameter("productId");
            String newTitle = request.getParameter("title");
            String newDescription = request.getParameter("description");
            String newPriceParam = request.getParameter("price");

            // Validate if productIdParam and newPriceParam are not null or empty and are numbers
            if (productIdParam != null && !productIdParam.isEmpty() && productIdParam.matches("\\d+")
                    && newPriceParam != null && !newPriceParam.isEmpty() && newPriceParam.matches("\\d+(\\.\\d+)?")) {
                int productId = Integer.parseInt(productIdParam);
                double newPrice = Double.parseDouble(newPriceParam);

                Connection connection = null;
                PreparedStatement preparedStatement = null;

                try {
                    String url = "jdbc:mysql://localhost:3306/shopping";
                    String username = "root";
                    String dbPassword = "";

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection(url, username, dbPassword);

                    // Update product information in the database
                    String query = "UPDATE produto SET titulo = ?, descricao = ?, preco = ? WHERE id = ?";
                    preparedStatement = connection.prepareStatement(query);
                    preparedStatement.setString(1, newTitle);
                    preparedStatement.setString(2, newDescription);
                    preparedStatement.setDouble(3, newPrice);
                    preparedStatement.setInt(4, productId);

                    int rowsAffected = preparedStatement.executeUpdate();

                    if (rowsAffected > 0) {
        %>
                        <p>Produto atualizado com sucesso!</p>
        <%
                    } else {
        %>
                        <p>Falha ao atualizar o produto. Tente novamente.</p>
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
            } else {
        %>
                <p>Parâmetros inválidos. Verifique os dados informados.</p>
        <%
            }
        %>

        <a href="visualizar.html">Voltar para Detalhes</a>
    </div>
</body>

</html>
