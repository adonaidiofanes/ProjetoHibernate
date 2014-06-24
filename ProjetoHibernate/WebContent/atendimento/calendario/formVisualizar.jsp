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
	<title>Visualizar Atendimento</title>
	
	<jsp:include page="../../templates/scripts.jsp"></jsp:include>
	<jsp:include page="../../templates/estilos.jsp"></jsp:include>
	
</head>

<body id="VisualizarAtendimento">

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
	
	CategoriaDAO DAOCategoria = new CategoriaDAO();
	
%>

	<div class="container">

		<!-- Include de menu -->
		<jsp:include page="../../templates/menu.jsp"></jsp:include>

		<ol class="breadcrumb">
			<li><a href="#">O.S.</a></li>
			<li class=""><a href="/ProjetoHibernate/atendimento/calendario/">Atendimentos</a></li>
			<li class="active">Visualizar Atendimento</li>
		</ol>

		<div class="row-fluid">
			<div class="panel panel-primary">

				<div class="panel-heading">
					<h3 class="panel-title">Visualizar Atendimento</h3>
				</div>

				<div class="panel-body">

					<form id="formVisualizarAtendimento" action="/ProjetoHibernate/AtendimentoServlet.do" class="form-horizontal" role="form" form method="post">

						<div class="col-md-12">
							<div class="form-group">
								
								<% if( CPF != null && CPF != "" && CPF != "0" && !CPF.isEmpty() ){ %>
								<div class="controle-cpf">
									<label for="cpf" class="col-sm-2 control-label">CPF</label>
									<div class="col-sm-8">
										<input type="text" class="form-control" name="cpf" id="cpf" class="" value="<%=CPF%>" disabled>
									</div>
								</div>
								<% } %>
								
								<% if( CNPJ  != null && CNPJ != "" && CNPJ != "0" && !CNPJ.isEmpty() ){ %>
								<div class="controle-cnpj">
									<label for="cnpj" class="col-sm-2 control-label">CNPJ</label>
									<div class="col-sm-8">
										<input type="text" class="form-control" name="cnpj" id="cnpj" class="" value="<%=CNPJ%>" disabled>
									</div>
								</div>
								<% } %>

								<div class="col-sm-2">
									<!-- button type="button" id="btnBuscarClienteAgendamento" class="btn btn-primary glyphicon glyphicon-search"></button> -->
								</div>
							
							</div>
							
						<div class="col-md-12">
							<div class="form-group">
							
								<% if( CPF != null && CPF != "" && CPF != "0" && !CPF.isEmpty() ){ %>
								<div class="controle-cpf">
									<label for="nome" class="col-sm-2 control-label">Nome</label>
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
							<label for="razao" class="col-sm-2 control-label">Descrição</label>
							<textarea class="col-xs-8" rows="3" name="descricao" id="descricao" disabled><%= descricao %></textarea>
						</div>

					</form>
				</div>
			</div>
		</div>
		</div><!-- /container -->
		
</body>
</html>