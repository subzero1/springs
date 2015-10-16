<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Add Product</title>
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

	</head>

	<body>
		eThis is my JSP page.
		<br>
		<form action="productSaveValidator.do" method="post">
			<fieldset>
				<legend>
					Add a Product
				</legend>
				<p>
					<label for="name">
						Product Name:
					</label>
					<input name="name" id="name" type="text" />
				</p>
				<p>
					<label for="description">
						Description :
					</label>
					<input name="description" id="description" type="text" />
				</p>
				<p>
					<label for="price">
						Price:
					</label>
					<input name="price" id="price" type="text" />
				</p>
				<p>
					<input id="reset" type="reset">
					<input type="submit" />
				</p>
			</fieldset>
		</form>
	</body>
</html>
