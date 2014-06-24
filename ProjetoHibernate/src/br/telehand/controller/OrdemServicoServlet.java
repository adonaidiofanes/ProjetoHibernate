package br.telehand.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import br.telehand.dao.AtendimentoDAO;
import br.telehand.dao.CategoriaDAO;
import br.telehand.dao.OsDAO;
import br.telehand.dao.ServicoDAO;
import br.telehand.dao.ViewClienteDAO;
import br.telehand.model.TbAtendimento;
import br.telehand.model.TbCategoria;
import br.telehand.model.TbOs;
import br.telehand.model.TbServico;
import br.telehand.model.ViewClientes;
import br.telehand.util.Util;

/**
 * Servlet implementation class OrdemServicoServlet
 */
@WebServlet("/OrdemServicoServlet")
public class OrdemServicoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrdemServicoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		/* ====================================================================
		 * LISTAR TODAS OS E MONTAR TELA PRINCIPAL DE LISTAGEM DE OS
		 * ====================================================================
		 */
		if( (request.getParameter("Controle") != null) 
				&& (request.getParameter("Controle").equals("listar")) ){

			List retorno = null;
			OsDAO o = new OsDAO();
			
			// Verificar papel do usuario e listar as OS de acordo com papel
			// Ex: ex: tec só dele, adm e coordenador todas OS
			HttpSession session = request.getSession();
			String papel = (String) session.getAttribute("papel");
			Integer matricula = (Integer) session.getAttribute("matriculaUsuario");
			String msgStatusAtualizar = "";
			
			if( session.getAttribute("msgStatusAtualizar") != null ){
				msgStatusAtualizar = (String) session.getAttribute("msgStatusAtualizar");
				session.removeAttribute("msgStatusAtualizar");
			}
			
			// Redirecionar o usuario se tiver papel supervisor ou anonimo
			if( (papel == "supervisor") || (papel == "anonimo") ){
				response.sendRedirect("atendimento/index.jsp");
				return;
			}
			
			// Tecnico e coordenador veem todas OS
			if( (papel == "coordenador") || ( papel == "administrador" ) ){
				retorno = o.listarTodos();
			} else if (papel == "tecnico"){
				// Tecnico ve apenas as deles
				retorno = o.listarPorMatricula(matricula);
			}
						
			// Caso contrario liste apenas as OS de determinado papel ou apenas suas OS

			request.setAttribute("Ordens", retorno);
			request.setAttribute("msgStatusAtualizar", msgStatusAtualizar);
			RequestDispatcher view = request.getRequestDispatcher("os/index.jsp");
			view.forward(request, response);
			
		}
		
		/* ====================================================================
		 * EDITAR DETERMINADA OS
		 * ====================================================================
		 */
		if( (request.getParameter("Controle") != null) 
				&& (request.getParameter("Controle").equals("Editar") 
						&& (request.getParameter("id") != null))){
			
			Integer Id = Integer.parseInt(request.getParameter("id"));
			Integer IdCliente = 0;
			
			request.setAttribute("IdOs", Id);
			
			OsDAO oDAO = new OsDAO();
			TbOs os = oDAO.selecionar(Id);
			
			Integer IdServico = os.getTbServico().getIdServico();
			
			request.setAttribute("IdOs", Id);
			request.setAttribute("IdServico", os.getTbServico().getIdServico());
			request.setAttribute("NomeServico", os.getTbServico().getNmServico());
			request.setAttribute("DtGeracao", Util.DateParaString(os.getDtGeracao(), "dd/MM/yyyy HH:mm:ss"));
			request.setAttribute("Detalhe", os.getTxDetalhe());
			request.setAttribute("Kit", os.getCdKit());
			request.setAttribute("Status", os.nomeStatus());
			request.setAttribute("slcStatus", os.slcStatus());
			request.setAttribute("cssClass", os.cssClass());
			request.setAttribute("NomeStatus", os.nomeStatus());
			request.setAttribute("IdCliente", os.getIdCliente());
			
			if( os.getDtFim() != null ){ 
				request.setAttribute("DtFim", Util.DateParaString(os.getDtFim(), "dd/MM/yyyy HH:mm:ss"));
			} else {
				request.setAttribute("DtFim", "");
			}
			
			IdCliente = os.getIdCliente();
			
			ServicoDAO sDAO = new ServicoDAO();
			String optionsServico = sDAO.gerarOptions(IdServico);
			String selectServico = "<select id='slcServico' name='slcServico' class='form-control'>" +
				   optionsServico +
				   "</select>";
			request.setAttribute("Servico", selectServico);
			
			ViewClienteDAO cDAO = new ViewClienteDAO();
			ViewClientes cliente = cDAO.buscarPorIdCliente(IdCliente);
			request.setAttribute("NomeCliente", cliente.getNmCliente());
			
			AtendimentoDAO aDAO = new AtendimentoDAO();
			TbAtendimento categoria = aDAO.selecionar(Id);
			Integer IdCategoria = categoria.getTbCategoria().getIdCategoria();
			
			CategoriaDAO catDAO = new CategoriaDAO();
			String selectOption = catDAO.gerarOptions(IdCategoria);
			request.setAttribute("Categorias", selectOption);
			
			RequestDispatcher view = request.getRequestDispatcher("os/formEditar.jsp");
			view.forward(request, response);
		}
		
		/* ====================================================================
		 * SOLICITAR FECHAMENTO DE UMA DETERMINADA OS
		 * ====================================================================
		 */
		if( (request.getParameter("Controle") != null) 
				&& ( (request.getParameter("Controle").equals("SolicitarFechamento") || (request.getParameter("Controle").equals("Fechar") ) ) 
						&& (request.getParameter("id") != null))){
			
			Integer Id = Integer.parseInt(request.getParameter("id"));
			String Acao = "erro";
			
			request.setAttribute("IdOs", Id);
			
			OsDAO oDAO = new OsDAO();
			TbOs os = oDAO.selecionar(Id);
			
			Integer IdServico = os.getTbServico().getIdServico();
			Integer IdCliente = os.getIdCliente();
			
			request.setAttribute("IdOs", Id);
			request.setAttribute("IdServico", os.getTbServico().getIdServico());
			request.setAttribute("NomeServico", os.getTbServico().getNmServico());
			request.setAttribute("DtGeracao", Util.DateParaString(os.getDtGeracao(), "dd/MM/yyyy HH:mm:ss"));
			request.setAttribute("Detalhe", os.getTxDetalhe());
			request.setAttribute("Kit", os.getCdKit());
			request.setAttribute("Status", os.nomeStatus());
			request.setAttribute("slcStatus", os.slcStatus());
			request.setAttribute("cssClass", os.cssClass());
			request.setAttribute("NomeStatus", os.nomeStatus());
			request.setAttribute("IdCliente", os.getIdCliente());
			
			if( os.getDtFim() != null ){ 
				request.setAttribute("DtFim", Util.DateParaString(os.getDtFim(), "dd/MM/yyyy HH:mm:ss"));
			} else {
				request.setAttribute("DtFim", "");
			}
			
			ServicoDAO sDAO = new ServicoDAO();
			String optionsServico = sDAO.gerarOptions(IdServico);
			String selectServico = "<select id='slcServico' name='slcServico' class='form-control' disabled>" +
				   optionsServico +
				   "</select>";
			request.setAttribute("Servico", selectServico);			
			
			AtendimentoDAO aDAO = new AtendimentoDAO();
			TbAtendimento categoria = aDAO.selecionar(Id);
			Integer IdCategoria = categoria.getTbCategoria().getIdCategoria();
			
			ViewClienteDAO cDAO = new ViewClienteDAO();
			ViewClientes cliente = cDAO.buscarPorIdCliente(IdCliente);
			request.setAttribute("NomeCliente", cliente.getNmCliente());
			
			CategoriaDAO catDAO = new CategoriaDAO();
			String selectOption = catDAO.gerarOptions(IdCategoria);
			request.setAttribute("Categorias", selectOption);
			
			if( request.getParameter("Controle").equals("Fechar") ){
				Acao = "os/formFechar.jsp";
			} else {
				Acao = "os/formSolicitarFechamento.jsp";
			}
			
			RequestDispatcher view = request.getRequestDispatcher(Acao);
			view.forward(request, response);
			
		}
		
		/* ====================================================================
		 * VISUALIZAR OS
		 * ====================================================================
		 */
		if( (request.getParameter("Controle") != null) 
				&& (request.getParameter("Controle").equals("Visualizar") 
						&& (request.getParameter("id") != null))){

			Integer Id = Integer.parseInt(request.getParameter("id"));
			
			OsDAO oDAO = new OsDAO();
			TbOs os = oDAO.selecionar(Id);
			
			Integer IdCliente = os.getIdCliente();
			
			request.setAttribute("IdOs", Id);
			request.setAttribute("IdServico", os.getTbServico().getIdServico());
			request.setAttribute("NomeServico", os.getTbServico().getNmServico());
			request.setAttribute("DtGeracao", Util.DateParaString(os.getDtGeracao(), "dd/MM/yyyy HH:mm:ss"));
						
			request.setAttribute("Detalhe", os.getTxDetalhe());
			
			request.setAttribute("Kit", os.getCdKit());
			request.setAttribute("Status", os.nomeStatus());
			
			if( os.getDtFim() != null ){ 
				request.setAttribute("DtFim", Util.DateParaString(os.getDtFim(), "dd/MM/yyyy HH:mm:ss"));
			} else {
				request.setAttribute("DtFim", "");
			}
			
			ViewClienteDAO cDAO = new ViewClienteDAO();
			ViewClientes cliente = cDAO.buscarPorIdCliente(IdCliente);
			
			String CPF = "";
			if(cliente.getCpf() != null){
				CPF = cliente.getCpf();
			}
			request.setAttribute("CPF", CPF);
			
			String CNPJ = "";
			if(cliente.getCnpj() != null){
				CPF = cliente.getCnpj();
			}
			request.setAttribute("CNPJ", CNPJ);
						
			request.setAttribute("NomeCliente", cliente.getNmCliente());
			
			RequestDispatcher view = request.getRequestDispatcher("os/formVisualizar.jsp");
			view.forward(request, response);
			
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/* ====================================================================
		 * ATUALIZAR
		 * ====================================================================
		 */
		if( (request.getParameter("Controle") != null) 
				&& (request.getParameter("Controle").equals("Atualizar") 
						&& (request.getParameter("IdOs") != null))){

			Integer Id = Integer.parseInt(request.getParameter("IdOs"));
			Integer IdServico = Integer.parseInt(request.getParameter("slcServico"));
			Integer IdCategoria = Integer.parseInt(request.getParameter("Categoria"));
			String Detalhe = request.getParameter("Detalhe");
			
			OsDAO oDAO = new OsDAO();
			TbOs os = oDAO.selecionar(Id);
			
			os.setTxDetalhe(Detalhe);
			
			TbServico servico = new TbServico();
			servico.setIdServico(IdServico);
			
			os.setTbServico(servico);			
			
			String retorno = oDAO.atualizar(os);
			
			if( retorno == "sucesso" ){

				AtendimentoDAO aDAO = new AtendimentoDAO();
				TbAtendimento atendimento = aDAO.selecionar(Id);
				
				TbCategoria categoria = new TbCategoria();
				categoria.setIdCategoria(IdCategoria);
				
				atendimento.setTbCategoria(categoria);
				retorno = aDAO.atualizar(atendimento);
				
			}

			HttpSession session = request.getSession();
			session.setAttribute("msgStatusAtualizar", retorno);
			response.sendRedirect("OrdemServicoServlet.do?Controle=listar");
			
		}
		
		/* ====================================================================
		 * ATUALIZAR SOLICITACAO DE FECHAMENTO DE OS
		 * ====================================================================
		 */
		if( (request.getParameter("Controle") != null) 
				&& (request.getParameter("Controle").equals("SolicitarFechamento") 
						&& (request.getParameter("IdOs") != null))){

			Integer Id = Integer.parseInt(request.getParameter("IdOs"));
			String Detalhe = request.getParameter("Detalhe");
			Integer slcCategoria = Integer.parseInt(request.getParameter("Categoria"));
			
			OsDAO oDAO = new OsDAO();
			TbOs os = oDAO.selecionar(Id);
			
			// Atualizar o status para 'S'
			
			os.setCdStatus('S');
			
			os.setTxDetalhe(Detalhe);
			
			String retorno = oDAO.atualizar(os);
			
			if( retorno == "sucesso" ){
				AtendimentoDAO aDAO = new AtendimentoDAO();
				TbAtendimento atendimento = aDAO.selecionar(Id);
				
				TbCategoria categoria = new TbCategoria();
				categoria.setIdCategoria(slcCategoria);
				
				atendimento.setTbCategoria(categoria);
				retorno = aDAO.atualizar(atendimento);
				
			}

			HttpSession session = request.getSession();
			session.setAttribute("msgStatusAtualizar", retorno);
			response.sendRedirect("OrdemServicoServlet.do?Controle=listar");
			
		}
		
		
		/* ====================================================================
		 * FECHAR OS
		 * ====================================================================
		 */
		if( (request.getParameter("Controle") != null) 
				&& (request.getParameter("Controle").equals("FecharOs") 
						&& (request.getParameter("IdOs") != null))){

			Integer Id = Integer.parseInt(request.getParameter("IdOs"));
			String Detalhe = request.getParameter("Detalhe");
			Integer slcCategoria = Integer.parseInt(request.getParameter("Categoria"));
			
			OsDAO oDAO = new OsDAO();
			TbOs os = oDAO.selecionar(Id);
			
			// Atualizar o status para 'F'
			
			os.setCdStatus('F');
			
			os.setTxDetalhe(Detalhe);
			
			String retorno = oDAO.atualizar(os);
			
			if( retorno == "sucesso" ){
				AtendimentoDAO aDAO = new AtendimentoDAO();
				TbAtendimento atendimento = aDAO.selecionar(Id);
				
				TbCategoria categoria = new TbCategoria();
				categoria.setIdCategoria(slcCategoria);
				
				atendimento.setTbCategoria(categoria);
				retorno = aDAO.atualizar(atendimento);
				
			}

			HttpSession session = request.getSession();
			session.setAttribute("msgStatusAtualizar", retorno);
			response.sendRedirect("OrdemServicoServlet.do?Controle=listar");
			
		}
		
		
	} // Final doPost()

}
