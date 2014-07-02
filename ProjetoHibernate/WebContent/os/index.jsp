<%@page import="br.telehand.model.TbOs"%>
<%@page import="br.telehand.util.Util"%>
<%@page import="java.util.Formatter"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ordens de Serviços</title>

<jsp:include page="../templates/scripts.jsp"></jsp:include>
<jsp:include page="../templates/estilos.jsp"></jsp:include>
</head>

<body>
	<div class="container">

		<!-- Include de menu -->
		<jsp:include page="../templates/menu.jsp"></jsp:include>

		<ol class="breadcrumb">
			<li><a href="#">Ordens de Serviços</a></li>
			<li class="active">Listagem das O.S.</li>
		</ol>
		
		<div class="row-fluid">
		
			<% 
				// Retorno da edicao de uma os especifica
				if( request.getAttribute("msgStatusAtualizar") == "erro" ){ %>
				
				<div class='alert alert-danger'>Erro ao atualizar OS!</div>	
				
			<%  } else if(request.getAttribute("msgStatusAtualizar") == "sucesso") { %>
			
				<div class='alert alert-success'>OS atualizada com sucesso!</div>
				
			<%
				}
			%>
		
			<div class="panel panel-primary">

				<div class="panel-heading">
					<h3 class="panel-title">Ordens de Serviços</h3>
				</div>				
				
				<% 
					// Busca de OS's
					if( request.getAttribute("Ordens") == null ){ %>
						<div class='alert alert-danger'>Nenhuma OS encontada!</div>
				<%  } else { %>
					
				<div class="panel-body">
					<table class="table table-striped">
						<thead>
							<tr>
								<th>Número</th>
								<th>Serviço</th>
								<th>Data de Criação</th>
								<th>Status</th>
								<th>Ações</th>
							</tr>
						</thead>

						<tbody>

							<%								
								List<TbOs> ordens = (List) request.getAttribute("Ordens");

								for (Iterator<TbOs> iterator = ordens.iterator(); iterator.hasNext();) {
									TbOs os = (TbOs) iterator.next();
							%>

							<tr>
								<td>#<%= os.getIdOs() %></td>
								<td><%= os.getTbServico().getNmServico() %></td>
								<td><%=Util.DateParaString(os.getDtGeracao(), "dd/MM/yyyy HH:mm:ss")%></td>
								<td><span class="<%=os.cssClass()%>"><%= os.nomeStatus() %></span></td>
								
								<td>

									<div class="btn-group btn-group-xs">

									  <div class="btn-group btn-group-xs">
									    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
									      <span class="glyphicon glyphicon-cog"></span> Ações
									      <span class="caret"></span>
									    </button>
									    <ul class="dropdown-menu">
									    	
									    	<li><a href="/ProjetoHibernate/OrdemServicoServlet.do?Controle=Visualizar&id=<%=os.getIdOs()%>">Visualizar</a></li>
									    	
									    	<% if( os.getCdStatus() == 'C' || os.getCdStatus() == 'S' ){ %>
									      	<li><a href="/ProjetoHibernate/OrdemServicoServlet.do?Controle=Editar&id=<%=os.getIdOs()%>">Editar</a></li>
									      	<% } %>
									      
									      	<% if( os.getCdStatus() == 'C' ){ %>
											<li><a href="/ProjetoHibernate/OrdemServicoServlet.do?Controle=SolicitarFechamento&id=<%=os.getIdOs()%>">Solicitar Fechamento</a></li>
											<% } %>
											
											<% if( os.getCdStatus() == 'S' ){ %>
											<li><a href="/ProjetoHibernate/OrdemServicoServlet.do?Controle=Fechar&id=<%=os.getIdOs()%>">Fechar</a></li>
											<% } %>
									    </ul>
									  </div>
									</div>
									
								</td>
							</tr>

					<%
							} // Final do loop
						} // Final da verificacao se existe ordens de servico 
					%> 

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

