<%@page import="br.telehand.model.TbUsuario"%>
<%
	// Resgatar sessao do usuario
	TbUsuario usuarioLogado = (TbUsuario) session.getAttribute("usuarioLogado");
	//String nomeUsuario = (String) session.getAttribute("nomeUsuario");
	//String papel = (String) session.getAttribute("papel");
	
	// Sessao instanciada para verificar se ela eh nova
	// Se for nova redirecione o usuario
	HttpSession rsessao = request.getSession();
	
	if( (usuarioLogado == null) || 
		(usuarioLogado.isPerfilAnonimo()) || 
		(rsessao.isNew()) ){

		// Invalida sessao
		session.invalidate();
		
		// Redireciona usuario
		response.sendRedirect("/ProjetoHibernate/index.jsp");
		// Usar response redirect, se nao funcionar, redirecione com javascript
		out.print("<script>window.location.href = '/ProjetoHibernate/index.jsp';</script>");

	}  else {
	
%>
	
	<!-- Menu -->
	<div class="row">
		<div class="logoPrincipal"></div>
		<hr />
	</div>
	
	<jsp:include page='<%="menu-" + usuarioLogado.retornarPerfil().getNomePapelPerfil() + ".jsp"%>'></jsp:include>

<% } %>