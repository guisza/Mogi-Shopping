<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
    // controller
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirmPassword");
    
    // teste para verificar senha
    if (password.equals(confirmPassword)) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
    
    // acessando bd
        try {
            String url = "jdbc:mysql://localhost:3306/shopping";
            String username = "root";
            String dbPassword = "";

            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, username, dbPassword);

            String query = "INSERT INTO users (email, password) VALUES (?, ?)";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);

            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                // Registration successful
                out.println("Registration successful");
            } else {
                // Registration failed
                out.println("Registration failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        } finally {
            try {
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
        // Passwords do not match
        out.println("Passwords do not match");
    }
%>
