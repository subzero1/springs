<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>Add Product</title>
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

	</head>

	<body> 
		eThis is my JSP page. 
		<br>
		<form id="product" action="productSave2.do" method="post">
			<fieldset>
				<legend>
					Add a Product
				</legend>
				<p>
					<label for="name">
						Product Name:
					</label>
					<input  id="name" name="name"/>
				</p>
				<p>
					<label for="description">
						Description :
					</label>
					<input name="description" id="description" />
				</p>
				<p>
					<label for="price">
						Price:
					</label>
					<input name="price" id="price" />
				</p>
				<p>
					<input id="reset" type="reset">
					<input type="submit" />
				</p>
			</fieldset>
		</form>
	</body>
</html>
