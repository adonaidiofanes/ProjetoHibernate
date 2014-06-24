package br.telehand.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import br.telehand.dao.ServicoDAO;
import br.telehand.model.TbServico;
import br.telehand.util.Util;

/**
 * Servlet implementation class ServicoServlet
 */
@WebServlet("/ServicoServlet")
public class ServicoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServicoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		/* ====================================================================
		 *  EDITAR SERVICO
		 * ==================================================================== */
		if( (request.getParameter("Controle") != null) && 
			(request.getParameter("Controle").equals("Editar") ) &&
			(request.getParameter("id") != null) 
			){

			TbServico servico = new TbServico();
			ServicoDAO DAO = new ServicoDAO();
			
			servico = DAO.selecionar(Integer.parseInt(request.getParameter("id")));
			
			String Id = servico.getIdServico().toString();
			
			request.setAttribute("idEditar", Id );
			RequestDispatcher view = request.getRequestDispatcher("servico/editarServico.jsp");
			view.forward(request, response);
			
		} // FIM EDITAR SERVICO
		
		
		/* ====================================================================
		 *  APAGAR SERVICO
		 * ==================================================================== */
		if( (request.getParameter("Controle") != null) 
			&& (request.getParameter("Controle").equals("Apagar")
			&& (request.getParameter("id") != null)
			) ){
			
			String IdApagar	= request.getParameter("id");
			if( !IdApagar.isEmpty() ){
				
				String id_servico 	= IdApagar;

				ServicoDAO DAO = new ServicoDAO();
				TbServico s = DAO.selecionar(Integer.parseInt(IdApagar));

				String msg = DAO.apagar(s);
				
				request.setAttribute("msgStatus", msg);
				RequestDispatcher view = request.getRequestDispatcher("servico/index.jsp");
				view.forward(request, response);
				
			} else {
				System.out.println("Erro ao selecionar o serviço a ser apagado!");
			}
			
		} // FIM APAGAR SERVICO
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		/* ====================================================================
		 *  CADASTRAR SERVICO
		 * ==================================================================== */
		if( (request.getParameter("Controle") != null) && (request.getParameter("Controle").equals("Cadastrar")) ){
			String nm_servico	= request.getParameter("nm_servico");
			String qt_inicio	= request.getParameter("qt_inicio");
			String qt_fim 		= request.getParameter("qt_fim");
			String qtd_emp 		= request.getParameter("qtd_emp");
			String dt_vigencia 	= request.getParameter("dt_vigencia");

			TbServico servico = new TbServico();
			servico.setNmServico(nm_servico);
			servico.setQtInicio(Integer.parseInt(qt_inicio));
			servico.setQtFim(Integer.parseInt(qt_fim));
			servico.setQtEmp(Integer.parseInt(qtd_emp));
			
			// Transformar String em Date
			SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
			try {
				 
				Date date = formatter.parse(dt_vigencia);
				servico.setDtVigencia(date);
		 
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			ServicoDAO DAO = new ServicoDAO();
			// TODO : Fazer verificacao de mensagens para imprimir a cor certa
			// Ex: Cadastrado com sucesso, imprime com fundo verde!
			String msg = DAO.cadastrar(servico);
			
			request.setAttribute("msgStatus", msg);
			RequestDispatcher view = request.getRequestDispatcher("servico/index.jsp");
			view.forward(request, response);
		
		} // FIM CADASTRAR SERVICO
		
		
		/* ====================================================================
		 *  ATUALIZAR SERVICO
		 * ==================================================================== */
		if( (request.getParameter("Controle") != null) && (request.getParameter("Controle").equals("Atualizar")) ){
			
			String IdAtualizar	= request.getParameter("Id");
			String msg = "";
			
			if( !IdAtualizar.isEmpty() ){
				
				String id_servico 	= IdAtualizar;
				String nm_servico	= request.getParameter("nm_servico");
				String qt_inicio	= request.getParameter("qt_inicio");
				String qt_fim 		= request.getParameter("qt_fim");
				String qtd_emp 		= request.getParameter("qtd_emp");
				String dt_vigencia 	= request.getParameter("dt_vigencia");
				
				TbServico servico = new TbServico();
				servico.setIdServico(Integer.parseInt(IdAtualizar));
				servico.setNmServico(nm_servico);
				servico.setQtInicio(Integer.parseInt(qt_inicio));
				servico.setQtFim(Integer.parseInt(qt_fim));
				servico.setQtEmp(Integer.parseInt(qtd_emp));

				SimpleDateFormat formataData = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");    
		        try {  
		            Date dataCerta = (Date) formataData.parse(dt_vigencia);
		            servico.setDtVigencia(dataCerta);
		        } catch (ParseException e) {  
		            e.printStackTrace();  
		        }  

		        ServicoDAO DAO = new ServicoDAO();
				msg = DAO.atualizar(servico);
				
			} else {
				msg = "Erro ao selecionar o serviï¿½o a ser atualizado!";
			}
			
			request.setAttribute("msgStatus", msg);
			RequestDispatcher view = request.getRequestDispatcher("servico/index.jsp");
			view.forward(request, response);
			
		} // FIM ATUALIZAR SERVICO
		
		/* ====================================================================
		 *  BUSCAR SERVICO
		 * ==================================================================== */
		if( (request.getParameter("Controle") != null) && (request.getParameter("Controle").equals("Buscar")) ){
			
				String nm_servico	= request.getParameter("nm_servico");
				String qt_inicio	= request.getParameter("qt_inicio");
				String qt_fim 		= request.getParameter("qt_fim");
				String qtd_emp 		= request.getParameter("qtd_emp");
				String dt_vigencia 	= request.getParameter("dt_vigencia");
				
				ServicoDAO DAO = new ServicoDAO();
				
				List<TbServico> s = DAO.buscarServico(nm_servico, qt_inicio, qt_fim, qtd_emp, dt_vigencia);
				
				request.setAttribute("resultadoBusca", s);
				RequestDispatcher view = request.getRequestDispatcher("servico/index.jsp");
				view.forward(request, response);
			
		} // FIM BUSCAR SERVICO
		
	} // FIM doPost

}
