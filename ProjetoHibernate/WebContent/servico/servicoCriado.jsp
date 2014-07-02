<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Serviço Criado</title>
</head>
<body>

<!-- Include de menu -->
<jsp:include page="../templates/menu.jsp"></jsp:include>

	<h1>Serviço criado com sucesso</h1>
	<%=request.getAttribute("msgStatus")%>

</body>
</html>