<%@page import="br.telehand.util.Util"%>
<%@page import="java.util.Formatter"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Iterator"%>
<%@page import="br.telehand.model.TbServico"%>
<%@page import="java.util.List"%>
<%@page import="br.telehand.dao.ServicoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Serviços</title>

<jsp:include page="../templates/scripts.jsp"></jsp:include>
<jsp:include page="../templates/estilos.jsp"></jsp:include>
</head>

<body>
	<div class="container">

		<!-- Include de menu -->
		<jsp:include page="../templates/menu.jsp"></jsp:include>

		<ol class="breadcrumb">
			<li><a href="#">Parâmetros</a></li>
			<li class="active">Serviços</li>
		</ol>
		
		<div class="mensagemRetorno alert alert-info display-none"></div>

		<%

			if (request.getAttribute("msgStatus") != null) {
				out.print("<div class='alert alert-success'>" + request.getAttribute("msgStatus") + "</div>");
			}
		
			String titulo;
			if(request.getAttribute("resultadoBusca") != null){ titulo = "Resultado da busca"; }
			else { titulo = "Gerenciar Serviços"; }
		
		%>

		<div class="row-fluid text-left">
			<div style="margin-bottom: 20px;">
				<button class="btn btn-primary" id="CadastrarServico"><span class="glyphicon glyphicon-file"></span> <a href="/ProjetoHibernate/servico/formCadastrarServico.jsp" class="color-white">Cadastrar Novo</a></button>
				<button class="btn btn-primary" id="BuscarServico"><span class="glyphicon glyphicon-search"></span> <a href="/ProjetoHibernate/servico/formBuscarServico.jsp" class="color-white">Buscar</a></button>
			</div>
		</div>

		<div class="row-fluid">
			<div class="panel panel-primary">

				<div class="panel-heading">
					<h3 class="panel-title"><%=titulo %></h3>
				</div>

				<div class="panel-body">
					<table class="table table-striped">
						<thead>
							<tr>
								<th>ID</th>
								<th>Nome do serviço</th>
								<th>Qt Inicio</th>
								<th>Qt Fim</th>
								<th>Qt Emp</th>
								<th></th>
								<th></th>
							</tr>
						</thead>

						<tbody>

							<%
								ServicoDAO s = new ServicoDAO();
								
								List<TbServico> servicos;
							
								// Verificar se existe um atribute vindo de uma busca
								if(request.getAttribute("resultadoBusca") != null){
									servicos = (List) request.getAttribute("resultadoBusca");
								
								// Se nao tiver, liste todos servicos
								} else {
									servicos = s.listarTodos();
								}

								
								for (Iterator<TbServico> iterator = servicos.iterator(); iterator.hasNext();) {
									TbServico sv = (TbServico) iterator.next();
							%>

							<tr>
								<td><%=sv.getIdServico()%></td>
								<td><%=sv.getNmServico()%></td>
								<td><%=sv.getQtInicio()%></td>
								<td><%=sv.getQtFim()%></td>
								<td><%=sv.getQtEmp()%></td>
								<!-- td><%=Util.DateParaString(sv.getDtVigencia(), "dd/MM/yyyy HH:mm:ss")%></td -->
								<td><button type="button" class="btn btn-primary btn-xs"><i class="glyphicon glyphicon-edit"></i> <a class="color-white" href="/ProjetoHibernate/ServicoServlet.do?Controle=Editar&id=<%=sv.getIdServico()%>">Editar</a></button></td>
								<td><button type="button" class="btn btn-danger btn-xs confirm-delete" data-id="<%=sv.getIdServico()%>"><i class="glyphicon glyphicon-trash"></i> Apagar</button></td>

							</tr>

							<% } %>

						</tbody>
					</table>
				</div>
			</div>
			
<!-- Modal -->
<div class="modal fade" id="ConfirmarApagarServico" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <form action="/ProjetoHibernate/ServicoServlet.do" method="GET">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Apagar Serviço</h4>
      </div>
      <div class="modal-body">
        <p>Você tem certeza que deseja apagar o servico?</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Não</button>
        <button type="submit" class="btn btn-primary confirmar-apagar-servico">Sim</button>
      </div>
    </div>
    <input type="hidden" name="id" id="IdApagar">
    <input type="hidden" name="Controle" value="Apagar">
    </form>
  </div>
</div>
<!-- FIM Modal de confirmação -->
			
		</div><!-- /container -->

	
</body>
</html>

