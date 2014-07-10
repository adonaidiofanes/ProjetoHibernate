package br.telehand.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import br.telehand.dao.ReporteDAO;
import br.telehand.dao.ViewClienteDAO;
import br.telehand.model.TbReporte;
import br.telehand.model.ViewClientes;
import br.telehand.util.Util;

/**
 * Servlet implementation class ReporteServlet
 */
@WebServlet("/ReporteServlet")
public class ReporteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReporteServlet() {
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
				&& (request.getParameter("Controle").equals("Buscar"))
				&& (request.getParameter("slcServico") != null)) {
			
			Integer servicoSelecionado = Integer.parseInt(request.getParameter("slcServico"));

			// Recebe todo conteudo para transformar em JSON
			JSONArray jArr = new JSONArray();

			// Buscar Reporte que contenha Obj Servico
			ReporteDAO DAOReporte = new ReporteDAO();
			List<TbReporte> reportes = DAOReporte.listarPorIdServico(servicoSelecionado);
			
			if(reportes != null){
			
			for (int i = 0; i < reportes.size(); i++) {
				TbReporte reporte = (TbReporte) reportes.get(i);
				
				JSONObject jObj = new JSONObject();

				jObj.put("IdOS", reporte.getTbAtendimento().getTbOs().getIdOs());
				jObj.put("Latitude", reporte.getTxLatitude());
				jObj.put("Longitude", reporte.getTxLongitude());
				jObj.put("CdStatus", String.valueOf(reporte.getId().getCdStatus()));
				jObj.put("DtReporte", Util.DateParaString(reporte.getId().getDtReporte(), "dd/MM/yyyy HH:mm:ss"));
				
				jObj.put("IdEquipe", reporte.getTbAtendimento().getTbAgenda().getTbEquipe().getIdEquipe());
				jObj.put("Smartphone", reporte.getTbAtendimento().getTbAgenda().getTbEquipe().getNrSmarthfone());
				

				JSONObject jObj2 = new JSONObject();
				jObj2.put("tbAgendamento", jObj);
				
				Integer idCliente = 0;
				
				if( (reporte.getTbAtendimento().getTbOs().getIdCliente()) != null ){
					idCliente = reporte.getTbAtendimento().getTbOs().getIdCliente();
				}
				
				// Resgatar dados do cliente
				ViewClienteDAO vDAO = new ViewClienteDAO();
				
				ViewClientes cliente = vDAO.buscarPorIdCliente(idCliente);
				
				JSONObject jObjC = new JSONObject();
				jObjC.put("IdCliente", cliente.getId_cliente());
				jObjC.put("NmCliente", cliente.getNmCliente());
				jObjC.put("Email", cliente.getCdEmail());
				jObjC.put("Endereco", cliente.getEndereco());
				jObjC.put("Complemento", cliente.getComplemento());
				jObjC.put("Numero", cliente.getNumero());
				jObjC.put("Bairro", cliente.getBairro());
				jObjC.put("Cidade", cliente.getCidade());
				jObjC.put("UF", cliente.getUf());
				jObjC.put("CEP", cliente.getCep());
				jObjC.put("Telefone", cliente.getNrTel().toString());
				
				if( cliente.getNrCelular() != null ){
					jObjC.put("Celular", cliente.getNrCelular().toString());
				} else {
					jObjC.put("Celular", "Não cadastrado");
				}
				
				JSONObject jObjC2 = new JSONObject();
				jObjC2.put("tbCliente", jObjC);

				List lista = new ArrayList<>();
				lista.add(jObj2);
				lista.add(jObjC2);
				jArr.put(lista);
				
			}
			}
			
			  String resposta = jArr.toString();

			  response.setContentType("text/json;charset=utf-8");
			  response.setHeader("Cache-Control", "no-cache");
			  
			  response.getWriter().write(resposta);

		} // Final controle buscar
	}

}
