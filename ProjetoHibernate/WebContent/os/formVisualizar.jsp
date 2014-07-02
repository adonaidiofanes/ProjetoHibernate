<%@page import="br.telehand.util.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Detalhes da OS</title>
<jsp:include page="../templates/scripts.jsp"></jsp:include>
<jsp:include page="../templates/estilos.jsp"></jsp:include>
</head>
<body>

	<%
		// Resgatar dados do servico a ser editado
		String IdOs = request.getAttribute("IdOs").toString();
		String NomeServico = request.getAttribute("NomeServico").toString();
		String DtGeracao = request.getAttribute("DtGeracao").toString();
		String CPF = request.getAttribute("CPF").toString();
		String CNPJ = request.getAttribute("CNPJ").toString();
		String Detalhe = request.getAttribute("Detalhe").toString();
		String Kit = request.getAttribute("Kit").toString();
		String Status = request.getAttribute("Status").toString();
		String DtFim = request.getAttribute("DtFim").toString();
		String NomeCliente = request.getAttribute("NomeCliente").toString();
		
	%>

	<div class="container">

		<!-- Include de menu -->
		<jsp:include page="../templates/menu.jsp"></jsp:include>

		<ol class="breadcrumb">
			<li><a href="/ProjetoHibernate/OrdemServicoServlet.do?Controle=listar">O.S.</a></li>
			<li class="active">Detalhes da OS #<%= IdOs %></li>
		</ol>

		<div class="row-fluid">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">Visualizar OS</h3>
				</div>

				<div class="panel-body">
				
					<h3>OS NÚMERO: #<%=IdOs %></h3>
					<hr />
					
					<form class="form-horizontal" role="form" form method="post"
						action="/ProjetoHibernate/OrdemServicoServlet.do"
						id="frmCadastrarServico">

						<!-- LadoEsquerdo -->
						<div class="col-md-6">
						
							<div class="form-group">
								<label for="NomeCliente" class="col-sm-4 control-label">Nome do Cliente</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="NomeCliente"
										name="NomeCliente" class="" value="<%= NomeCliente %>" disabled>
								</div>
							</div>

							<div class="form-group">
								<label for="NomeServico" class="col-sm-4 control-label">Nome do Serviço</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="NomeServico"
										name="NomeServico" class="" value="<%= NomeServico %>" disabled>
								</div>
							</div>

							<div class="form-group">
								<label for="DtGeracao" class="col-sm-4 control-label">Data de Criação</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="DtGeracao"
										name="DtGeracao" class="" 
										value="<%=DtGeracao%>" disabled>
								</div>
							</div>
							
						<div class="form-group">
							<label for="Detalhe" class="col-sm-4 control-label">Detalhe</label>
							<div class="col-sm-8">
								<textarea class="form-control col-sm-8 " rows="3" id="Detalhe" name="Detalhe" disabled><%=Detalhe%></textarea>
							</div>
						</div>
							
						</div>
						<!-- /LadoEsquerdo -->

						<!-- LadoDireito -->
						<div class="col-md-6">

							<div class="form-group">
								<label for="Kit" class="col-sm-4 control-label">
								Kit</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="Kit"
										name="Kit" value="<%=Kit%>" disabled>
								</div>
							</div>
							
							<div class="form-group">
								<label for="Status" class="col-sm-4 control-label">
								Status</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="Status"
										name="Status" value="<%=Status%>" disabled>
								</div>
							</div>
							
							<% if(!DtFim.equals("")){ %>
							<div class="form-group">
								<label for="DtFim" class="col-sm-4 control-label">
								Data de Finalização</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="DtFim"
										name="DtFim" class="" 
										value="<%=DtFim%>" disabled>
								</div>
							</div>
							<% } %>
							
						</div>
						<!-- /LadoDireito -->
						
						<div class="row text-right col-sm-12">
							<button class="btn btn-success" id="imprimir"><span class="glyphicon glyphicon-print"></span> Imprimir</button>
						</div>
				
					</form>
				</div><!-- /panel-body -->
			</div>
		</div>

	</div>
</body>
</html>