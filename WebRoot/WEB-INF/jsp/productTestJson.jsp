<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'productTestJson.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js">
	</script>
	<script type="text/javascript">
		$(function(){
			alert("测试通过");
		});
		function btnclick(){  
			$.ajax({ 

     		    type: 'POST', 

    			url: 'jsonTest.do' , 

    			data: {name:'sgssssg',
    			description:'测试同股哟',
    			price:'4234' } , 
	
   				success: function(data){
   					alert("");
   				 } , 

    			dataType: 'json' 
		    }); 
		}
	</script>
  </head>
  
  <body>
    This is my JSP page. <br>
    <input type="button" class="json" id="json" onClick="btnclick()"/>
  </body>
</html>
