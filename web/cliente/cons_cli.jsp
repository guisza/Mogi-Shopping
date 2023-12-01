<%-- 
    Document   : cliente
    Created on : 14/09/2023, 20:15:24
    Author     : alunos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="controle.Cliente"%>
<%@page import="java.text.*" import="java.lang.*"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Controle de Clientes</title>
    </head>
    <body>
        <h1>Clientes</h1>
        <%
            // Recebendo dados
            
            String id = request.getParameter("ident");                      
            
            //Consultar
            try{
                Class.forName("com.mysql.jdbc.Driver"); //registra            
                Connection conexao = DriverManager.getConnection("jdbc:mysql://localhost:3306/loja", "root", ""); // abre Conn
                Statement stmt = conexao.createStatement(); //cria uma instrução
                ///          SELECT * FROM clientes WHERE id = 3;
                String sql = "SELECT * FROM clientes WHERE id = " + id; //defin instr. SQL
               // String sql = "SELECT * FROM clientes " ; //defin instr. SQL
                ResultSet rs = stmt.executeQuery(sql); // exec. Query.
                
                //Saída
                while (rs.next()){
                    out.println("<br><br><b> Registro - Cliente </b>");
                    out.println("<br> Identificação: " + rs.getString("id"));
                    out.println("<br> Nome: " + rs.getString("nome"));
                    out.println("<br> Idade: " + rs.getString("idade"));
                    out.println("<br> Renda: " + rs.getString("renda"));
                }             
                               
                conexao.close(); //fecha                
            }
            catch(Exception ex){
                ex.printStackTrace();
                out.println("Erro: " + ex.toString());
            }
            
            
            

        %>
    </body>
</html>

