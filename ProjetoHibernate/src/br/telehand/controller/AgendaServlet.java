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
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import br.telehand.dao.VwAgendaComAgendamentoDAO;
import br.telehand.dao.VwAgendaSemAgendamentoDAO;
import br.telehand.model.VwAgendaComAgendamento;
import br.telehand.model.VwAgendaSemAgendamento;
import br.telehand.util.Util;

/**
 * Servlet implementation class AgendaServlet
 */
@WebServlet("/AgendaServlet")
public class AgendaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AgendaServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		/* ====================================================================
		 *  CADASTRAR ATENDIMENTO : RESGATAR HRs E DIA, TRANSPORTAR PARA O FORM
		 * ==================================================================== */
		if( (request.getParameter("Controle") != null) && (request.getParameter("Controle").equals("CadastrarAtendimento")) ){
			
			request.setAttribute("hInicial", request.getParameter("hInicial") );
			request.setAttribute("hFinal", request.getParameter("hFinal") );
			request.setAttribute("dia", request.getParameter("dia") );
			request.setAttribute("idServico", request.getParameter("idServico").toString() );
			request.setAttribute("idJanela", request.getParameter("idJanela").toString() );
			request.setAttribute("idEquipe", request.getParameter("idEquipe").toString() );
			request.setAttribute("usuarioLogado", request.getParameter("usuarioLogado").toString() );
			request.setAttribute("dt_agendamento", request.getParameter("dt_agendamento").toString() );
			request.setAttribute("matriculaTecnico", request.getParameter("matriculaTecnico").toString() );
			
			RequestDispatcher view = request.getRequestDispatcher("atendimento/calendario/formCadastrar.jsp");
			view.forward(request, response);
			
		}
		
		
		/* ====================================================================
		 *  CANCELAR ATENDIMENTO : RESGATAR HRs E DIA, TRANSPORTAR PARA O FORM
		 *  REAGENDAR ATENDIMENTO : RESGATAR HRs E DIA, TRANSPORTAR PARA O FORM
		 * ==================================================================== */
		if( (request.getParameter("Controle") != null) && 
				( (request.getParameter("Controle").equals("CancelarAtendimento")) ||  
				  (request.getParameter("Controle").equals("ReagendarAtendimento")) ||
				  (request.getParameter("Controle").equals("VisualizarAtendimento"))
			    )
			    ){
			
			String Acao = "";
			
			request.setAttribute("hInicial", request.getParameter("hInicial") );
			request.setAttribute("hFinal", request.getParameter("hFinal") );
			request.setAttribute("dia", request.getParameter("dia") );
			request.setAttribute("idServico", request.getParameter("idServico").toString() );
			request.setAttribute("idJanela", request.getParameter("idJanela").toString() );
			request.setAttribute("idEquipe", request.getParameter("idEquipe").toString() );
			request.setAttribute("usuarioLogado", request.getParameter("usuarioLogado").toString() );
			request.setAttribute("dt_agendamento", request.getParameter("dt_agendamento").toString() );
			request.setAttribute("matriculaTecnico", request.getParameter("matriculaTecnico").toString() );
			request.setAttribute("idOs", request.getParameter("idOs").toString() );
			request.setAttribute("idAtendimento", request.getParameter("idAtendimento").toString() );
			
			
			/* ====================================================================
			 * CANCELAR ATENDIMENTO  
			 * ==================================================================== */
			if(request.getParameter("Controle").equals("CancelarAtendimento")){
				Acao = "atendimento/calendario/formCancelar.jsp";
			}
			
			
			/* ====================================================================
			 * CANCELAR ATENDIMENTO  
			 * ==================================================================== */
			if(request.getParameter("Controle").equals("VisualizarAtendimento")){
				Acao = "atendimento/calendario/formVisualizar.jsp";
			}
			
			
			/* ====================================================================
			 * REAGENDAR ATENDIMENTO  
			 * ==================================================================== */
			else if(request.getParameter("Controle").equals("ReagendarAtendimento")){
				
				// Regatar dados da VwAgendaSemAgendamento e montar um selectOption
				Integer IdServico = Integer.parseInt(request.getParameter("idServico").toString());
				VwAgendaSemAgendamentoDAO vwSDAO = new VwAgendaSemAgendamentoDAO();
				List<VwAgendaSemAgendamento> vw = vwSDAO.listarPorIdServico(IdServico);
				
				String selectAgendasDisponiveis = "<select name='slcAtendimento' id='slcAtendimento' class='form-control col-xs-8'>";
					   selectAgendasDisponiveis += "<option>- Selecione um horario para agendamento -</option>";
					   
				    	for(int i = 0; i<vw.size(); i++){
				    		
				    		// Transformar String em Date
				    		SimpleDateFormat fTotal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				    		String pDtAgendamento = "";
				    		String DtOption = "";
				    		String dataFormatadaInicial = "";
				    		
				    		try {
				    			
				    			// Pegar apenas a hora final e hora inicial, removendo o 1970-xx-xx
				    			DateFormat fHora = DateFormat.getTimeInstance();
				    			String hInicial = fHora.format(vw.get(i).getId().getHrInicial());
				    			//String hFinal = fHora.format(this.getHrFinal());
				    			
				    			// Dividir o 'yyyy-MM-dd HH:mm:ss' => 'yyyy-MM-dd'
				    			String data = vw.get(i).getId().getAnoMesDia().toString();
				    			String[] divide = data.split(" ");
				    			String ano_mes_dia = divide[0];
				    			
				    			// Montar 'yyyy-MM-dd HH:mm:ss' com a hora inicial e hora final certas
				    			dataFormatadaInicial = ano_mes_dia + " " + hInicial;
				    			//String dataFormatadaFinal = ano_mes_dia + " " + hFinal;
				    			
				    			// Transformar as datas montadas em Date
				    			Date dateI = fTotal.parse(dataFormatadaInicial);
				    			
				    			
				    			String dOpt[] = ano_mes_dia.split("-");
				    			String InicialOption = dOpt[2] + "/" + dOpt[1] + "/" + dOpt[0];
				    			
				    			DtOption = InicialOption + " " + hInicial;
				    			pDtAgendamento = dataFormatadaInicial.substring(0, 3);
				    			
				    			
				    		} catch (ParseException e) {
				    			e.printStackTrace();
				    		}
				    					    		
				    		
				    		selectAgendasDisponiveis += "<option value='"+ vw.get(i).getId().getIdServico() + "_" + 
				    													   vw.get(i).getId().getIdJanela() +  "_" +
				    													   vw.get(i).getId().getIdEquipe() +  "_" + 
				    													   dataFormatadaInicial +  "_" +
				    													   vw.get(i).getId().getNrMatriculaTecnico() +  
				    													   "'>" + DtOption + "</option>";
				    		
				    	}
					   
					   selectAgendasDisponiveis += "</select>";
					   
					   request.setAttribute("slcAtendimento", selectAgendasDisponiveis);
				
				Acao = "atendimento/calendario/formReagendar.jsp";
			} // Fim do Reagendar
			
			RequestDispatcher view = request.getRequestDispatcher(Acao);
			view.forward(request, response);
			
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		/* ====================================================================
		 *  RESGATAR AGENDA COM/SEM AGENDAMENTOS POR IdServico
		 * ==================================================================== */
		if( (request.getParameter("Controle") != null) && (request.getParameter("Controle").equals("CalendarioAgendamento")) ){
		
		Integer IdServico = Integer.parseInt(request.getParameter("slcServico"));
		
		HttpSession session = request.getSession();
		String matriculaUsuario = session.getAttribute("matriculaUsuario").toString();
		
		String Status = "";
		
		JSONArray jArr = new JSONArray(); // Array que vai receber a lista de arrays com os dados dos agendamentos/janelas
		JSONObject s = new JSONObject(); // Array de resultado de sucesso
		s.put("success", 1); // Notificar 1 = sucesso
		
		VwAgendaComAgendamentoDAO vcDAO = new VwAgendaComAgendamentoDAO();
		List<VwAgendaComAgendamento> listaC = vcDAO.listarPorIdServico(IdServico);
		
		for(int i=0; i<listaC.size(); i++){
			VwAgendaComAgendamento obj = (VwAgendaComAgendamento) listaC.get(i);
			
			String CdStatus = obj.getId().getCdStatus();
			
			// Gerar numero unico para cada objeto
			Integer hash = obj.getId().hashCode();
			if( hash < 0 ){ hash = hash*-1;	}
			
			Integer IdEquipe = obj.getId().getIdEquipe();
			Integer IdJanela = obj.getId().getIdJanela();
			Integer matriculaTecnico = obj.getId().getNrMatriculaTecnico();
			Integer IdOS = obj.getId().getIdOs();
			Long IdAtendimento = obj.getId().getIdAtendimento();
			
			// Verificar se status eh diferente de C (Cancelado)
			if(!CdStatus.equals("C")){
				
				JSONObject objJSON = new JSONObject();
				objJSON.put("id", hash);
				
				String controle = "CancelarAtendimento";
				
				/*
				A - Aberto
				C - Cancelado
				P - Pendente
				R - Reagendado
				E - Efetuado*/
				
				if(CdStatus.equals("P")){
					
					objJSON.put("class", "event-warning"); // bolinha amarela
					Status = "Atendimento Pendente";
					controle = "ReagendarAtendimento";
					
				} else if(CdStatus.equals("A")){
					Status = "Atendimento Indisponível";
					objJSON.put("class", "event-important"); // bolinha vermelha
					
				} else if(CdStatus.equals("E")){
					objJSON.put("class", "event-info"); // bolinha azul
					Status = "Atedimento Efetuado";
					controle = "VisualizarAtendimento";
				} else if(CdStatus.equals("R")){
					objJSON.put("class", "event-special"); // bolinha roxa - atendimento reagendado
					Status = "Atendimento Reagendado";
					controle = "VisualizarAtendimento";
				}
								
				// Transformar String em Date
				SimpleDateFormat fTotal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				try {
					
					// Pegar apenas a hora final e hora inicial, removendo o 1970-xx-xx
					DateFormat fHora = DateFormat.getTimeInstance();
					String hInicial = fHora.format(obj.getId().getHrInicial());
					String hFinal = fHora.format(obj.getId().getHrFinal());
					
					// Dividir o 'yyyy-MM-dd HH:mm:ss' => 'yyyy-MM-dd'
					String data = obj.getId().getData();
					String[] divide = data.split(" ");
					String ano_mes_dia = divide[0];
					
					// Montar 'yyyy-MM-dd HH:mm:ss' com a hora inicial e hora final certas
					String dataFormatadaInicial = ano_mes_dia + " " + hInicial;
					String dataFormatadaFinal = ano_mes_dia + " " + hFinal;
					
					// Transformar as datas montadas em Date
					Date dateI = fTotal.parse(dataFormatadaInicial);
					Date dateF = fTotal.parse(dataFormatadaFinal);
					
					// Transformar as datas montadas em Millisegundos
					long lDateI = dateI.getTime();
					long lDateF = dateF.getTime();
					
					objJSON.put("start", lDateI);
					objJSON.put("end", lDateF);
					
					// Montar Titulo
					objJSON.put("title", Status + " - " + hInicial + " - " + hFinal);
					
					objJSON.put("url", "http://localhost:8080/ProjetoHibernate/AgendaServlet.do?hInicial=" + 
					hInicial + "&hFinal=" + hFinal + "&dia=" + ano_mes_dia + "&idServico="+ IdServico + "&idEquipe=" + IdEquipe + 
					"&usuarioLogado=" + matriculaUsuario + "&idJanela=" + IdJanela + "&dt_agendamento=" + dataFormatadaInicial + "&matriculaTecnico=" + matriculaTecnico +
					"&idOs=" + IdOS + "&idAtendimento=" + IdAtendimento + "&Controle=" + controle);
					
					// Inserir o resultado no array
					jArr.put(objJSON);
					
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}// Final do IF status = C
		} // Final for COM ATENDIMENTO
		
		/* ====================================================================
		 * AGENDA SEM ATENDIMENTO
		 * ====================================================================
		 */
		VwAgendaSemAgendamentoDAO vsDAO = new VwAgendaSemAgendamentoDAO();
		List<VwAgendaSemAgendamento> listaS = vsDAO.listarPorIdServico(IdServico);

		for(int i=0; i<listaS.size(); i++){
			VwAgendaSemAgendamento obj = (VwAgendaSemAgendamento) listaS.get(i);
		
			// Gerar numero unico para cada objeto
			Integer hash = obj.getId().hashCode();
			if( hash < 0 ){ hash = hash*-1;	}

			Integer IdEquipe = obj.getId().getIdEquipe();
			Integer IdJanela = obj.getId().getIdJanela();
			Integer matriculaTecnico = obj.getId().getNrMatriculaTecnico();
			
			JSONObject objJSON = new JSONObject();
			objJSON.put("id", hash);
			objJSON.put("class", "event-success"); // event-success = bolinha verde
			
			// Transformar String em Date
			SimpleDateFormat fTotal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			try {
				
				// Pegar apenas a hora final e hora inicial, removendo o 1970-xx-xx
				DateFormat fHora = DateFormat.getTimeInstance();
				String hInicial = fHora.format(obj.getId().getHrInicial());
				String hFinal = fHora.format(obj.getId().getHrFinal());
				
				// Dividir o 'yyyy-MM-dd HH:mm:ss' => 'yyyy-MM-dd'
				String ano_mes_dia = Util.DateParaString(obj.getId().getAnoMesDia(), "yyyy-MM-dd");
				
				// Montar 'yyyy-MM-dd HH:mm:ss' com a hora inicial e hora final certas
				String dataFormatadaInicial = ano_mes_dia + " " + hInicial;
				String dataFormatadaFinal = ano_mes_dia + " " + hFinal;
				
				// Transformar as datas montadas em Date
				Date dateI = fTotal.parse(dataFormatadaInicial);
				Date dateF = fTotal.parse(dataFormatadaFinal);
				
				// Transformar as datas montadas em Millisegundos
				long lDateI = dateI.getTime();
				long lDateF = dateF.getTime();
				
				objJSON.put("start", lDateI);
				objJSON.put("end", lDateF);
				
				// Montar Titulo
				objJSON.put("title", "Atendimento Disponível - " + hInicial + " - " + hFinal);
				objJSON.put("url", "http://localhost:8080/ProjetoHibernate/AgendaServlet.do?hInicial=" + 
				hInicial + "&hFinal=" + hFinal + "&dia=" + ano_mes_dia + "&idServico="+ IdServico + "&idEquipe=" + IdEquipe + 
				"&usuarioLogado=" + matriculaUsuario + "&idJanela=" + IdJanela + "&dt_agendamento=" + dataFormatadaInicial + "&matriculaTecnico=" + matriculaTecnico + "&Controle=CadastrarAtendimento");
				
				// Inserir o resultado no array
				jArr.put(objJSON);
				
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
		}
		
		s.put("result", jArr);
		
		String resposta = s.toString();
		
		response.setContentType("text/json;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");	  
		response.getWriter().write(resposta);
		} // FIM RESGATAR AGENDA COM/SEM AGENDAMENTOS POR IdServico
		
		
	}
}
