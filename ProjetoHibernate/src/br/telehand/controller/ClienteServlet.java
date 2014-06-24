package br.telehand.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;

import br.telehand.dao.ViewClienteDAO;
import br.telehand.model.ViewClientes;

/**
 * Servlet implementation class Clientes
 */
@WebServlet("/Clientes")
public class ClienteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ClienteServlet() {
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
		
	 /* ---------------------------------------------------- 
	 * BUSCAR REPORTE
	 * ----------------------------------------------------
	 */
	if ((request.getParameter("Controle") != null)
			&& (request.getParameter("Controle").equals("BuscarCliente")) ){
		
		String CPF = null;
		String CNPJ = null;
		
		if(request.getParameter("cpf") != null){
			CPF = request.getParameter("cpf").toString();
		} else {
			CNPJ = request.getParameter("cnpj").toString();
		}
		
		ViewClienteDAO DAOCliente = new ViewClienteDAO();
		ViewClientes cliente = DAOCliente.findByDoc(CPF, CNPJ);
		
		JSONArray jArr = new JSONArray();
		
		if( (cliente != null) && cliente.getNmCliente() != null ){ 
			jArr.put(cliente.getNmCliente()); 
			jArr.put(cliente.getId_cliente());
		}
		
		String resposta = jArr.toString();
		response.setContentType("text/json;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write(resposta);
		
	}
	
	}

}
