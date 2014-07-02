<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Endereços de atendimento</title>

<jsp:include page="../../templates/scripts.jsp"></jsp:include>
<jsp:include page="../../templates/estilos.jsp"></jsp:include>
<link rel="stylesheet" href="/ProjetoHibernate/css/calendar.css">

</head>

<body id="retornoCadastroAtendimento">
	<div class="container">
	
	<!-- Include de menu -->
	<jsp:include page="../../templates/menu.jsp"></jsp:include>
	
	<div class="page-header">
	
	
		<div id="retorno">
	
			<% 
				if (request.getAttribute("retornoPrInsAgendamento") != null) { 
					out.print(request.getAttribute("retornoPrInsAgendamento"));
				}
			
				// Retorno do Cancelamento de atendimento
				if (request.getAttribute("retornoPrDelAgendamento") != null) { 
					out.print(request.getAttribute("retornoPrDelAgendamento"));
				}
			
			%>
			
		</div>
		</div>
		</div>
		
</body>

</html>