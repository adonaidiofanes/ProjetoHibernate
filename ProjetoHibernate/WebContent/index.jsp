<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Telehand</title>
	
	<jsp:include page="templates/scripts.jsp"></jsp:include>
	
	<!-- Script para criar mascaras -->
	<script src="/ProjetoHibernate/js/jquery.validate.js"></script>
	
	<jsp:include page="templates/estilos.jsp"></jsp:include>
</head>

<body>
	<div class="container">
	
	<div class="row-fluid">
	<div class="col-sm-3"></div>
	<div class="col-sm-6">
	<p></p>
	
	<% 
			if (request.getAttribute("msg") != null) {
				out.print("<div class='alert alert-danger'>" + request.getAttribute("msg") + "</div>");
			}
	%>
	
		<div class="well well-lg">
			<img src="img/logo.png" class="img-rounded center-block"/>
			<hr>
			<form role="form" action="LoginServlet.do" method="POST" id="frmLogin">
			
				<div class="form-group">
					<label for="matricula">Matrícula</label>
					<input type="number" class="form-control" name="matricula" id="matricula" placeholder="Digite sua matrícula">
				</div>
				
				<div class="form-group">
					<label for="senha">Senha</label>
					<input type="password" class="form-control" name="senha" id="senha" placeholder="Digite sua Senha">
				</div>
				
				<button type="submit" class="btn btn-default">Entrar</button>
				
			</form>
		</div>
		</div>
		
	<div class="col-sm-3"></div>
	</div>

	
	</div>

</body>
</html>