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
<title>Cadastrar Serviço</title>

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
			<li class="active">Cadastrar Serviço</li>
		</ol>

		<div class="row-fluid">
			<div class="panel panel-primary">

				<div class="panel-heading">
					<h3 class="panel-title">Cadastrar Serviço</h3>
				</div>

				<div class="panel-body">

					<form id="formCadastrarServico"
						action="/ProjetoHibernate/ServicoServlet.do"
						class="form-horizontal" role="form" form method="post">
						<!-- LadoEsquerdo -->
						<div class="col-md-6">
							<div class="form-group">
								<label for="nm_servico" class="col-sm-4 control-label">Nome
									do serviço</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" name="nm_servico"
										id="nm_servico" class="" required>
								</div>
							</div>

							<div class="form-group">
								<label for="dt_vigencia" class="col-sm-4 control-label"><i
									class="glyphicon glyphicon-calendar"></i> Data e hora de
									Vigência</label>
								<div class="col-sm-8">
									<input type="text" class="form-control dataHora"
										id="dt_vigencia" name="dt_vigencia" class=""
										placeholder="__/__/____ HH:mm:ss" required>
									<p class="help-block">A data de vigência do serviço</p>
								</div>
							</div>

							<div class="form-group">
								<label for="qtd_emp" class="col-sm-4 control-label"><i
									class="glyphicon glyphicon-user"></i> Qtd. Empregados</label>
								<div class="col-sm-8">
									<input type="number" class="form-control" id="qtd_emp"
										name="qtd_emp" class="" placeholder="" required>
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
										name="qt_inicio" required>
									<p class="help-block">Tempo Maximo de espera de retorno de
										status de técnico para inicio do atendimento</p>
								</div>
							</div>

							<div class="form-group">
								<label for="qt_fim" class="col-sm-4 control-label"><i
									class="glyphicon glyphicon-time"></i> Retorno Fim Atendimento</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="qt_fim"
										name="qt_fim" required>
									<p class="help-block">Tempo Maximo de espera de retorno de
										status de técnico para fim de atendimento</p>
								</div>
							</div>

							<input type="hidden" name="Controle" value="Cadastrar" />
							
							<div class="text-right">
								<button type="submit" class="btn btn-success" id="Cadastrar"><span class="glyphicon glyphicon glyphicon-floppy-saved"></span> Cadastrar </button>
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