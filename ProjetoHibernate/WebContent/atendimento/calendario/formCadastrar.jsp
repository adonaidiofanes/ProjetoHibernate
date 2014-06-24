<%@page import="br.telehand.dao.CategoriaDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cadastrar Atendimento</title>

<jsp:include page="../../templates/scripts.jsp"></jsp:include>
<jsp:include page="../../templates/estilos.jsp"></jsp:include>
</head>

<body id="CadastrarAgendamento">

<%
	String hInicial = request.getAttribute("hInicial").toString();
	String hFinal = request.getAttribute("hFinal").toString();
	String dia = request.getAttribute("dia").toString();
	String idServico = request.getAttribute("idServico").toString();
	String idJanela = request.getAttribute("idJanela").toString();
	String idEquipe = request.getAttribute("idEquipe").toString();
	String usuarioLogado = request.getAttribute("usuarioLogado").toString();
	String dt_agendamento = request.getAttribute("dt_agendamento").toString();
	String matriculaTecnico = request.getAttribute("matriculaTecnico").toString();
	
	CategoriaDAO DAOCategoria = new CategoriaDAO();
	
%>

	<div class="container">

		<!-- Include de menu -->
		<jsp:include page="../../templates/menu.jsp"></jsp:include>

		<ol class="breadcrumb">
			<li><a href="#">O.S.</a></li>
			<li class=""><a href="/ProjetoHibernate/atendimento/">Atendimentos</a></li>
			<li class="active">Cadastrar Atendimento</li>
		</ol>

		<div class="row-fluid">
			<div class="panel panel-primary">

				<div class="panel-heading">
					<h3 class="panel-title">Cadastrar Atendimento</h3>
				</div>

				<div class="panel-body">

					<form id="formCadastrarAgendamento" action="/ProjetoHibernate/AtendimentoServlet.do" class="form-horizontal" role="form" form method="post">

						<div class="col-md-12">
							<div class="form-group">
									
								<div class="controle-cpf">
									<label for="cpf" class="col-sm-2 control-label">CPF</label>
									<div class="col-sm-8">
										<input type="text" class="form-control" name="cpf" id="cpf" class="">
									</div>
								</div>
								
								<div class="controle-cnpj">
									<label for="cnpj" class="col-sm-2 control-label">CNPJ</label>
									<div class="col-sm-8">
										<input type="text" class="form-control" name="cnpj" id="cnpj" class="">
									</div>
								</div>

								<div class="col-sm-2">
									<button type="button" id="btnBuscarClienteAgendamento" class="btn btn-primary glyphicon glyphicon-search"></button>
								</div>
							
							</div>
							
						<div class="col-md-12">
							<div class="form-group">
									
								<div class="controle-cpf">
									<label for="nome" class="col-sm-2 control-label">Nome</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" name="Nome" id="Nome" class="" disabled>
									</div>
								</div>
								
								<div class="controle-cnpj">
									<label for="razao" class="col-sm-2 control-label">Razão Social</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" name="razao" id="razao" class="" disabled>
									</div>
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<label for="razao" class="col-sm-2 control-label">Descrição</label>
							<textarea class="col-xs-8" rows="3" name="descricao" id="descricao"></textarea>
						</div>
						
						<!-- div class="col-sm-12">
							<label>Categoria</label>
							<%= "<select name='slcCategoria' id='slcCategoria' class='form-control'>" +  DAOCategoria.gerarOptions(0) + "</select>" %>
						</div -->

							<div class="text-right">
								<button type="submit" class="btn btn-success" id="Buscar"><span class="glyphicon glyphicon-floppy-save"></span> Cadastrar </button>
							</div>
							
							<input type="hidden" id="Controle" name="Controle" value="CadastrarAtendimento" />
							<input type="hidden" id="hInicial" name="hInicial" value="<%= hInicial %>">
							<input type="hidden" id="hFinal" name="hFinal" value="<%= hFinal %>">
							<input type="hidden" id="dia" name="dia" value="<%= dia %>">
							<input type="hidden" id="idServico" name="idServico" value="<%= idServico %>">
							<input type="hidden" id="idEquipe" name="idEquipe" value="<%= idEquipe %>">
							<input type="hidden" id="usuarioLogado" name="usuarioLogado" value="<%= usuarioLogado %>">
							<input type="hidden" id="idJanela" name="idJanela" value="<%= idJanela %>">
							<input type="hidden" id="matriculaTecnico" name="matriculaTecnico" value="<%= matriculaTecnico %>">
							<input type="hidden" id="dt_agendamento" name="dt_agendamento" value="<%= dt_agendamento %>">
							<input type="hidden" id="idcliente" name="idcliente" value="">
							
					</form>
				</div>
			</div>
		</div>
		</div><!-- /container -->
		
<!-- Modal -->
<div class="modal fade" id="TipoCliente" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">Escolha o tipo de cliente</h4>
      </div>
      <div class="modal-body">

		<p>
		<button type="button" id="cliente-cpf" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-user"></span> CPF</button>
		<button type="button" id="cliente-cnpj" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-lock"></span> CNPJ</button>
		</p>
		
      </div>
    </div>
  </div>
</div>
<!-- FIM Modal de confirmação -->
		
</body>
</html>