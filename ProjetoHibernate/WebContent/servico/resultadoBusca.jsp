<%@page import="br.telehand.util.Util"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="br.telehand.model.TbServico"%>
<%@page import="br.telehand.dao.ServicoDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Serviços - Resultado da Busca</title>
	<jsp:include page="../templates/scripts.jsp"></jsp:include>
	<jsp:include page="../templates/estilos.jsp"></jsp:include>
</head>

<body>

	<div class="container">

		<!-- Include de menu -->
		<jsp:include page="../templates/menu.jsp"></jsp:include>

		<ol class="breadcrumb">
			<li><a href="#">Parâmetros</a></li>
			<li class=""><a href="/ProjetoHibernate/servico/">Serviços</a></li>
			<li class="active">Resultado da busca</li>
		</ol>

		<%
			if (request.getAttribute("msgStatus") != null) {
				out.print("<h2>" + request.getAttribute("msgStatus") + "</h2>");
			}
		%>


		<div class="row-fluid">
			<div class="panel panel-primary">

				<div class="panel-heading">
					<h3 class="panel-title">Resultado da Busca</h3>
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
								<th>Data Vigência</th>
								<th></th>
								<th></th>
							</tr>
						</thead>

						<tbody>

							<%
								ServicoDAO s = new ServicoDAO();
								List servicos = (List) request.getAttribute("resultadoBusca");
								for (Iterator<TbServico> iterator = servicos.iterator(); iterator.hasNext();) {
									TbServico sv = (TbServico) iterator.next();
							%>

							<tr>
								<td><%=sv.getIdServico()%></td>
								<td><%=sv.getNmServico()%></td>
								<td><%=sv.getQtInicio()%></td>
								<td><%=sv.getQtFim()%></td>
								<td><%=sv.getQtEmp()%></td>
								<td><%=Util.DateParaString(sv.getDtVigencia(), "dd/MM/yyyy HH:mm:ss")%></td>
								<td><button type="button" class="btn btn-primary btn-xs"><i class="glyphicon glyphicon-edit"></i> <a class="color-white" href="/ProjetoHibernate/ServicoServlet.do?Controle=Editar&id=<%=sv.getIdServico()%>">Editar</a></button></td>
								<td><button type="button" class="btn btn-danger btn-xs"><i class="glyphicon glyphicon-trash"></i> <a class="color-white" href="/ProjetoHibernate/ServicoServlet.do?Controle=Apagar&id=<%=sv.getIdServico()%>">Apagar</a></button></td>
							</tr>

							<% } %>

						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

</body>
</html>

