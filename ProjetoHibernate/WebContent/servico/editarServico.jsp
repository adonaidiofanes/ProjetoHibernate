<%@page import="br.telehand.util.Util"%>
<%@page import="br.telehand.dao.ServicoDAO"%>
<%@page import="br.telehand.model.TbServico"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Editar Serviço</title>
<jsp:include page="../templates/scripts.jsp"></jsp:include>
<jsp:include page="../templates/estilos.jsp"></jsp:include>
</head>
<body>

	<%
		// Resgatar dados do servico a ser editado
			String id = request.getAttribute("idEditar").toString();

			TbServico servico = new TbServico();
			ServicoDAO DAO = new ServicoDAO();

			servico = DAO.selecionar(Integer.parseInt(id));
	%>

	<div class="container">

		<!-- Include de menu -->
		<jsp:include page="../templates/menu.jsp"></jsp:include>

		<ol class="breadcrumb">
			<li><a href="#">Parâmetros</a></li>
			<li><a href="/ProjetoHibernate/servico/">Serviços</a></li>
			<li class="active">Editar Serviço</li>
		</ol>

		<%
			if (request.getAttribute("msgStatus") != null) {
				out.print("<h2>" + request.getAttribute("msgStatus") + "</h2>");
			}
		%>

		<div class="row-fluid">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">Cadastrar serviço</h3>
				</div>

				<div class="panel-body">

					<form class="form-horizontal" role="form" form method="post"
						action="/ProjetoHibernate/ServicoServlet.do"
						id="frmCadastrarServico">

						<!-- LadoEsquerdo -->
						<div class="col-md-6">

							<div class="form-group">
								<label for="nm_servico" class="col-sm-4 control-label">Nome
									do serviço</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" name="nm_servico"
										id="nm_servico" class="" value="<%=servico.getNmServico()%>" required>
								</div>
							</div>

							<div class="form-group">
								<label for="dt_vigencia" class="col-sm-4 control-label"><i
									class="glyphicon glyphicon-calendar"></i> Data de Vigência</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="dt_vigencia"
										name="dt_vigencia" class="" placeholder="__/__/____"
										value="<%=Util.DateParaString(servico.getDtVigencia(), "dd/MM/yyyy HH:mm:ss")%>" required>
									<p class="help-block">A data de vigência do serviço</p>
								</div>
							</div>

							<div class="form-group">
								<label for="qtd_emp" class="col-sm-4 control-label"><i
									class="glyphicon glyphicon-user"></i> Qtd. Empregados</label>
								<div class="col-sm-8">
									<input type="number" class="form-control" id="qtd_emp"
										name="qtd_emp" class="" placeholder=""
										value="<%=servico.getQtEmp()%>" required>
									<p class="help-block">Quantidade mínima de empregados para
										o serviço a ser cadastrado</p>
								</div>
							</div>
						</div>
						<!-- /LadoEsquerdo -->

						<!-- LadoDireito -->
						<div class="col-md-6">
							<div class="form-group">
								<label for="qt_inicio" class="col-sm-4 control-label"><i
									class="glyphicon glyphicon-time"></i> Retorno Início
									Atendimento</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="qt_inicio"
										name="qt_inicio" value="<%=servico.getQtInicio()%>" required>
									<p class="help-block">Tempo Maximo de espera de retorno de
										status de técnico para inicio do atendimento</p>
								</div>
							</div>

							<div class="form-group">
								<label for="qt_fim" class="col-sm-4 control-label"><i
									class="glyphicon glyphicon-time"></i> Retorno Fim Atendimento</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="qt_fim"
										name="qt_fim" value="<%=servico.getQtFim()%>" required>
									<p class="help-block">Tempo Maximo de espera de retorno de
										status de técnico para fim de atendimento</p>
								</div>
							</div>
							
							<input type="hidden" name="Controle" value="Atualizar" />
							<input type="hidden" name="Id" value="<%=servico.getIdServico() %>" required />
							
							<div class="row text-right">
								<button type="submit" class="btn btn-success">Atualizar</button>
							</div>

						</div>
						<!-- /LadoDireito -->
						
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>