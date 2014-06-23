<%@page import="br.telehand.dao.AtendimentoDAO"%>
<%@page import="br.telehand.dao.ServicoDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Endereços de atendimento</title>
	
	<jsp:include page="../templates/scripts.jsp"></jsp:include>
	<jsp:include page="../templates/estilos.jsp"></jsp:include>
</head>

<body>
<div class="container">

<%
	ServicoDAO DAOServico = new ServicoDAO();
%>

	<!-- Include de menu -->
	<jsp:include page="../templates/menu.jsp"></jsp:include>

	<div class="row-fluid">
		<div class="panel panel-primary">
			<div class="panel-heading">
			<h3 class="panel-title">Endereços de atendimento</h3>
			</div>
			<div class="panel-body">
			<form method="POST" action="AgendamentoServlet.do" id="frmBuscarAgendamento">
				<fieldset>
				<legend>Filtrar</legend>
				
				<!-- div class="col-sm-2">
					<label>Data de Atendimento</label>
					<input class="form-control" type="text" placeholder="Ex: dd/mm/yy">
				</div -->
				
				<div class="col-sm-6">
					<label>Tipo(s) de Serviço(s)</label>
					<%= "<select name='slcServico' id='slcServico' class='form-control'>" +  DAOServico.gerarOptions(0) + "</select>" %>
				</div>
				
				<div class="col-sm-3">
					<!-- label>Equipe(s)</label>
					<select multiple="multiple" class="form-control">
					  <option>Todas</option>
					  <option># 001</option>
					  <option># 002</option>
					  <option># 003</option>
					  <option># 004</option>
					  <option># 005</option>
					</select-->
				</div>
				
				<div class="col-sm-3">
					<input type="hidden" id="Controle" name="Controle" value="Buscar" /> 
					<button type="submit" class="btn btn btn-primary" value="Buscar" id="Buscar"><span class="glyphicon glyphicon-search"></span> Buscar</button>
				</div>
				
				</fieldset>
			</form>
			</div>
		</div>
	</div>

	
	<div id="mapa" style="height: 800px; width: 100%"></div>

	


</div><!-- /.container -->

	<!-- Scripts Personalizados -->
	<script src="/ProjetoHibernate/js/mapa.js"></script>

</body>

</html>