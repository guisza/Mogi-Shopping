<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    try {
        // Replace with your database credentials
        String url = "jdbc:mysql://localhost:3306/shopping";
        String username = "root";
        String dbPassword = "";

        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(url, username, dbPassword);

        String query = "SELECT * FROM users WHERE email = ? AND password = ?";
        preparedStatement = connection.prepareStatement(query);
        preparedStatement.setString(1, email);
        preparedStatement.setString(2, password);

        resultSet = preparedStatement.executeQuery();
        
        
        
        if (resultSet.next()) {
            // User authenticated successfully
            out.println("Login successful");
            request.getRequestDispatcher("sitelojista/lojista.html").forward(request, response);
        } else {
            // Authentication failed
            out.println("Invalid email or password");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    } finally {
        try {
            if (resultSet != null) resultSet.close();
            if (preparedStatement != null) preparedStatement.close();
            if (connection != null) connection.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
%>
    
