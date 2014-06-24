<%@page import="br.telehand.model.ViewClientes"%>
<%@page import="br.telehand.dao.ViewClienteDAO"%>
<%@page import="br.telehand.dao.OsDAO"%>
<%@page import="br.telehand.model.TbOs"%>
<%@page import="br.telehand.dao.CategoriaDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reagendar Atendimento</title>

<jsp:include page="../../templates/scripts.jsp"></jsp:include>
<jsp:include page="../../templates/estilos.jsp"></jsp:include>
</head>

<body id="ReagendarAtendimento">

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
	String idOs = request.getAttribute("idOs").toString();
	String idAtendimento = request.getAttribute("idAtendimento").toString();
	String slcAtendimento = request.getAttribute("slcAtendimento").toString();
	
	// montar obj tb_os 
	OsDAO oDAO = new OsDAO();
	TbOs os = oDAO.findById(Integer.parseInt(idOs)); 
	
	// pegar tx_detalhe
	String descricao = os.getTxDetalhe();
	
	ViewClienteDAO clienteDAO = new ViewClienteDAO();
	ViewClientes cliente = clienteDAO.buscarPorIdCliente(os.getIdCliente());
	
	// pegar cpf ou cnpj
	String CPF = cliente.getCpf();
	String CNPJ = cliente.getCnpj();
	
	Integer idCliente = os.getIdCliente();
	
	CategoriaDAO DAOCategoria = new CategoriaDAO();
	
%>

	<div class="container">

		<!-- Include de menu -->
		<jsp:include page="../../templates/menu.jsp"></jsp:include>

		<ol class="breadcrumb">
			<li><a href="#">O.S.</a></li>
			<li class=""><a href="/ProjetoHibernate/atendimento/">Atendimentos</a></li>
			<li class="active">Reagendar Atendimento</li>
		</ol>

		<div class="row-fluid">
			<div class="panel panel-primary">

				<div class="panel-heading">
					<h3 class="panel-title">Reagendar Atendimento</h3>
				</div>

				<div class="panel-body">

					<form id="formReagendarAtendimento" action="/ProjetoHibernate/AtendimentoServlet.do" class="form-horizontal" role="form" form method="post">

						<div class="col-md-12">
							<div class="form-group">
							
								<% if( CPF!=null && CPF != "" && CPF != "0" && !CPF.isEmpty() ){ %>
								<div class="controle-cpf">
									<label for="nome" class="col-sm-2 control-label">Cliente</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" name="Nome" id="Nome" class="" disabled value="<%= cliente.getNmCliente().toString() %>">
									</div>
								</div>
								<% } %>
								
								<% if( CNPJ != null && CNPJ != "" && CNPJ != "0" && !CNPJ.isEmpty() ){ %>
								<div class="controle-cnpj">
									<label for="razao" class="col-sm-2 control-label">Razão Social</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" name="razao" id="razao" class="" disabled value="<%= cliente.getNmCliente().toString() %>">
									</div>
								</div>
								<% } %>
								
							</div> 
						</div>
						
						<div class="form-group">
							<label for="descricao" class="col-sm-2 control-label">Descrição</label>
							<textarea class="col-xs-8" rows="3" name="descricao" id="descricao"><%= descricao %></textarea>
						</div>
						
							<div class="form-group">
								<label for="slcAtendimento" class="col-sm-2 control-label">Selecione um novo horário para atendimento</label>
								<div class="col-sm-6">
									<%= slcAtendimento %>
								</div>
							</div>
						
							<div class="text-right">
								<button type="submit" class="btn btn-warning" id="Reagendar"><span class="glyphicon glyphicon-retweet"></span> Reagendar Atendimento </button>
								<button type="submit" class="btn btn-danger" id="Canclear"><span class="glyphicon glyphicon glyphicon-remove"></span> Cancelar Atendimento </button>
							</div>
							
							<input type="hidden" id="Controle" name="Controle" value="ReagendarAtendimento" />
							<input type="hidden" id="idAtendimento" name="idAtendimento" value="<%= idAtendimento %>">
							<input type="hidden" id="usuarioLogado" name="usuarioLogado" value="<%= usuarioLogado %>">
							<input type="hidden" id="idOs" name="idOs" value="<%= idOs %>">
							
							<input type="hidden" id="hInicial" name="hInicial" value="<%= hInicial %>">
							<input type="hidden" id="hFinal" name="hFinal" value="<%= hFinal %>">
							<input type="hidden" id="dia" name="dia" value="<%= dia %>">
							<input type="hidden" id="idServico" name="idServico" value="<%= idServico %>">
							<input type="hidden" id="idEquipe" name="idEquipe" value="<%= idEquipe %>">
							<input type="hidden" id="idJanela" name="idJanela" value="<%= idJanela %>">
							<input type="hidden" id="matriculaTecnico" name="matriculaTecnico" value="<%= matriculaTecnico %>">
							<input type="hidden" id="dt_agendamento" name="dt_agendamento" value="<%= dt_agendamento %>">
							<input type="hidden" id="idcliente" name="idcliente" value="<%= idCliente %>">
							
							<% if( CPF != null && CPF != "" && CPF != "0" && !CPF.isEmpty() ){ %>
							<input type="hidden" class="form-control" name="cpf" id="cpf" class="" value="<%=CPF%>">
							<% } %>
							
							<% if( CNPJ != null && CNPJ != "" && CNPJ != "0" && !CNPJ.isEmpty() ){ %>
							<input type="hidden" class="form-control" name="cnpj" id="cnpj" class="" value="<%=CNPJ%>">
							<% } %>
							
							
							
					</form>
				</div>
			</div>
		</div>
		</div><!-- /container -->
		
</body>
</html>