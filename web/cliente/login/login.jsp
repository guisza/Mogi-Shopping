<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>

<head>
    <title>Login</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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

        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
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

        input[type="submit"] {
            background-color: #4caf50;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        h2 {
            color: #333;
            margin-top: 12px;
        }

        h2.success {
            color: #4caf50;
        }

        h2.error {
            color: #f44336;
        }
    </style>
</head>

<body>
    <form method="post" action="">
        <%
            // Assuming you have a 'users' table with 'email' and 'password' columns
            String enteredEmail = request.getParameter("email");
            String enteredPassword = request.getParameter("password");

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/shopping", "root", "");
                Statement stmt = connection.createStatement();

                String sql = "SELECT * FROM users WHERE email='" + enteredEmail + "' AND password='" + enteredPassword + "'";
                ResultSet resultSet = stmt.executeQuery(sql);

                if (resultSet.next()) {
                    // Successful login
        %>
                    <h2 class="success">Login Successful!</h2>
        <%
                } else {
                    // Failed login
        %>
                    <h2 class="error">Login Failed. Please check your credentials.</h2>
        <%
                }

                connection.close();
            } catch (Exception ex) {
                ex.printStackTrace();
        %>
                <h2 class="error">Error: <%= ex.getMessage() %></h2>
        <%
            }
        %>
    </form>
</body>

</html>