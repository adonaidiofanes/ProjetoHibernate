<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Calendário de atendimentos</title>

<jsp:include page="../../templates/scripts.jsp"></jsp:include>
<jsp:include page="../../templates/estilos.jsp"></jsp:include>
<link rel="stylesheet" href="/ProjetoHibernate/css/calendar.css">

</head>

<body>
	<div class="container">
	
	<!-- Include de menu -->
	<jsp:include page="../../templates/menu.jsp"></jsp:include>
	
	<div class="page-header">
	
		<!-- Include de form -->
		<jsp:include page="formBuscarAtendimentos.jsp"></jsp:include>	

		<% 
			if (request.getAttribute("retornoPrInsAgendamento") != null) { 
				if(request.getAttribute("retornoPrInsAgendamento") == "sucesso"){
		%>
				<div class='alert alert-success'>Agendamento cadastrado com sucesso!</div>
		<% 	
				} else {
		%>
				<div class='alert alert-danger'>Não foi possível cadastrar o agendamento!</div>
		<%
				}
			}
		%>
		
		<div id="controlador" class="display-none pull-right form-inline">
			<div class="btn-group">
				<button class="btn btn-primary" data-calendar-nav="prev"><< Anterior</button>
				<button class="btn" data-calendar-nav="today">Hoje</button>
				<button class="btn btn-primary" data-calendar-nav="next">Próximo >></button>
			</div>
			<div class="btn-group">
				<button class="btn btn-warning" data-calendar-view="year">Ano</button>
				<button class="btn btn-warning active" data-calendar-view="month">Mês</button>
				<button class="btn btn-warning" data-calendar-view="week">Semana</button>
				<button class="btn btn-warning" data-calendar-view="day">Dia</button>
			</div>
		</div>

		<h3 class="titulo-calendario display-none"></h3>
		
	</div>

	<div class="row">
		<div class="span12">
			<div id="calendar"></div>
		</div>
	</div>

	<div class="clearfix"></div>

	<script type="text/javascript" src="/ProjetoHibernate/js/calendario/underscore-min.js"></script>
	<script type="text/javascript" src="/ProjetoHibernate/js/calendario/jstz.min.js"></script>

	<script type="text/javascript" src="/ProjetoHibernate/js/calendario/pt-BR.js"></script>

	<script type="text/javascript" src="/ProjetoHibernate/js/calendario/calendar.js"></script>
	<script type="text/javascript" src="/ProjetoHibernate/js/calendario/app.js"></script>
	</div><!-- /.container -->
	
	
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
	
	
<br><br><br><br><br>
</body>

</html>