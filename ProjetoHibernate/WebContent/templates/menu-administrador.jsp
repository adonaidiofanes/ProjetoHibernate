	<%
		// Resgatar sessao do usuario
		String nomeUsuario = (String) session.getAttribute("nomeUsuario");
				
	%>
	
	<nav class="navbar navbar-default" role="navigation">
	  <div class="container-fluid">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
		  <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
			<span class="sr-only">Alternar navega��o</span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		  </button>
		  <a class="navbar-brand" href="/ProjetoHibernate/atendimento/"><span class="glyphicon glyphicon-home"></span> Home</a>
		</div>

		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		  <ul class="nav navbar-nav">
		  
		  	<!-- Parametros -->
			<li class="dropdown">
			  <a href="#" class="dropdown-toggle" data-toggle="dropdown">Par�metros <b class="caret"></b></a>
			  <ul class="dropdown-menu" role="menu">
			  	<li><a href="#">Perfis</a></li>
				<li><a href="/ProjetoHibernate/servico/">Servi�os</a></li>
				<li><a href="#">Equipe</a></li>
				<li><a href="#">Calend�rio</a></li>
				<li><a href="#">Janela</a></li>
				<li><a href="#">Agenda</a></li>
				<li><a href="#">Categoria de problema</a></li>
			  </ul>
			</li>
			
			<!-- Consultas -->
			<li class="dropdown">
			  <a href="#" class="dropdown-toggle" data-toggle="dropdown">Consultas <b class="caret"></b></a>
			  <ul class="dropdown-menu" role="menu">
				<li><a href="/ProjetoHibernate/atendimento/">Endere�os de Atendimentos</a></li>
				<li><a href="/ProjetoHibernate/reporte">Posicionamento das equipes</a></li>
				<li><a href="#">Atendimentos por cliente</a></li>
				<li><a href="#">LOG</a></li>
				<li><a href="#">Tempo m�dio de atendimento</a></li>
				<li><a href="#">N�mero de atendimentos</a></li>
				<li><a href="#">Atendimentos por t�cnico</a></li>
				<li><a href="#">Atendimentos de recupera��o</a></li>
			  </ul>
			</li>
			
			<li><a href="/ProjetoHibernate/atendimento/calendario/">Atendimentos</a></li>
			
			<li><a href="/ProjetoHibernate/OrdemServicoServlet.do?Controle=listar">O.S.</a></li>
			
		  </ul>

		  <ul class="nav navbar-nav navbar-right">
		  	<li><a href="#" class="button"><span class="glyphicon glyphicon-user"></span> <%= nomeUsuario %></a></li>
			<li><a href="/ProjetoHibernate/sair.jsp"><span class="glyphicon glyphicon-remove"></span> Sair</a></li>
		  </ul>
		  
		</div><!-- /.navbar-collapse -->
	  </div><!-- /.container-fluid -->
	</nav>