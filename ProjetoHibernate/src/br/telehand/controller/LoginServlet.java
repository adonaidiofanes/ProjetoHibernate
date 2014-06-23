package br.telehand.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.Session;

import br.telehand.dao.LoginDAO;
import br.telehand.dao.VwDadosRhDAO;
import br.telehand.model.TbLogin;
import br.telehand.model.VwDadosRh;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/* ====================================================================
		 *  VALIDAR LOGIN E DIRECIONAR O USUARIO PARA PAGINA
		 * ==================================================================== */
		if( (request.getParameter("matricula") != null) && (request.getParameter("senha") != null) ){
			
			HttpSession session = request.getSession();
			
			// Limpar dados da sessao
			session.removeAttribute("papel");
			session.removeAttribute("nomeUsuario");
			session.removeAttribute("matriculaUsuario");

			
			Integer matricula = Integer.parseInt(request.getParameter("matricula"));
			String senha = request.getParameter("senha");
			String papel;
			
			LoginDAO lDAO = new LoginDAO();
			TbLogin login = lDAO.validaLogin(matricula, senha);

			if(login != null){
				// @TODO: Pegar dados da VwDadosRh e gravar em uma sessao
				VwDadosRhDAO rhDAO = new VwDadosRhDAO();
				VwDadosRh rh = rhDAO.selectByMatricula(login.getId().getNrMatricula());

				// Pegar dados(papel) do Cd Usuario e gravar numa sessao: ex: adminstrador, tecnico...
				switch(login.getId().getCdUsuario()){
					case 'A' : papel = "administrador";
						break;
					case 'T':  papel = "tecnico";
						break;
					case 'C' : papel = "coordenador";
						break;
					case 'S' : papel = "supervisor";
						break;
					case 'D' : papel = "atendente";
						break;
					default: papel = "anonimo";
				}
				
				// Gravar dados do usuario logado em uma sessao
				session.setAttribute("papel", papel);
				session.setAttribute("nomeUsuario", rh.getNmEmpregado());
				session.setAttribute("matriculaUsuario", rh.getNrMatricula());
				
				// redireciona o usuario para a pagina principal do sistema				
				response.sendRedirect("atendimento");
				
			} else {
				
				// Destroi a sessao caso exista
				session.invalidate();
				
				request.setAttribute("msg", "Usuário e/ou senhas inválidos!" );
				RequestDispatcher view = request.getRequestDispatcher("index.jsp");
				view.forward(request, response);
				
				// redireciona o usuario para a pagina de login, colocar uma mensagem de erro
			}
			
		}
	}

}
