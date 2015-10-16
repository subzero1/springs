<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Product Detail</title>
    
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
   <div id="global">
   <h4>The Product had been saved</h4>
   <p>
   		<h5>Details:</h5>
   		Product name:${product.name } <br/>
   		description:${product.description }<br/>
   		price:${product.price }<br/>
   </p>
   </div>
  </body>
</html>
