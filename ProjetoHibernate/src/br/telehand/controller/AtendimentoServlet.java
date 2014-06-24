package br.telehand.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Query;
import org.hibernate.Session;
import org.json.JSONArray;
import org.json.JSONObject;

import br.telehand.dao.AtendimentoDAO;
import br.telehand.dao.ViewClienteDAO;
import br.telehand.model.TbAtendimento;
import br.telehand.model.ViewClientes;
import br.telehand.util.Util;

@WebServlet("/AtendimentoServlet")
public class AtendimentoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AtendimentoServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		/* ====================================================================
		 * INSERIR NOVO ATENDIMENTO : CHAMA A PROCEDURE pr_ins_agendamento
		 * ====================================================================
		 */
		if ((request.getParameter("Controle") != null)
				&& (request.getParameter("Controle").equals("CadastrarAtendimento")) ){
			
			Integer idServico = Integer.parseInt(request.getParameter("idServico"));
	
			String CPF = "";
			String CNPJ = "";
			
			// Verificar se CPF existe e guarda-lo na variavel CPF
			if( request.getParameter("cpf") != null ){ CPF = request.getParameter("cpf").toString(); }
			
			// Verificar se CNPJ existe e guarda-lo na variavel CNPJ
			if( request.getParameter("cnpj") != null ){ CNPJ = request.getParameter("cnpj").toString(); }
			
			String descricao = request.getParameter("descricao").toString();
			Integer matriculaTecnico = Integer.parseInt(request.getParameter("matriculaTecnico"));
			Integer usuarioLogado = Integer.parseInt(request.getParameter("usuarioLogado").toString());
			Integer idJanela = Integer.parseInt(request.getParameter("idJanela").toString());
			Integer idEquipe = Integer.parseInt(request.getParameter("idEquipe").toString());
			String dt_agendamento = request.getParameter("dt_agendamento").toString();
			Integer idCliente = Integer.parseInt(request.getParameter("idcliente").toString());
			
			AtendimentoDAO aDAO = new AtendimentoDAO();
			
			// Chamar procedure 
			String resultadoProc = aDAO.pr_ins_agendamento(idServico, 
					1, 
					idCliente,
					descricao,
					matriculaTecnico, 
					usuarioLogado, 
					idJanela, 
					idEquipe,
					dt_agendamento);
			
			if( resultadoProc.equals("sucesso") ){
				resultadoProc = "<div class='alert alert-success'>Agendamento cadastrado com sucesso!</div>";
			} else if( resultadoProc.equals("erro") ){
				resultadoProc = "<div class='alert alert-danger'>Não foi possível cadastrar o agendamento!</div>";
			} else {
				resultadoProc = "";
			}
	
			request.setAttribute("retornoPrInsAgendamento", resultadoProc );
			
			RequestDispatcher view = request.getRequestDispatcher("atendimento/calendario/msgRetorno.jsp");
			view.forward(request, response);
			
		} // Fim do Inserir novo atendimento via procedure
	
	
		/* ====================================================================
		 * CANCELAR ATENDIMENTO : CHAMA A PROCEDURE pr_del_agendamento
		 * ====================================================================
		 */
		if ((request.getParameter("Controle") != null)
				&& (request.getParameter("Controle").equals("CancelarAtendimento")) ){
	
			Integer idOs = Integer.parseInt(request.getParameter("idOs"));
			Integer idAtendimento = Integer.parseInt(request.getParameter("idAtendimento"));
			Integer matriculaUsuario = Integer.parseInt(request.getParameter("usuarioLogado"));
					
			AtendimentoDAO aDAO = new AtendimentoDAO();
			
			// Chamar procedure
			String resultadoProc = aDAO.pr_del_agendamento(idOs, idAtendimento, matriculaUsuario);
	
			if( resultadoProc.equals("sucesso") ){
				if( resultadoProc.equals("sucesso") ){
					resultadoProc = "<div class='alert alert-success'>Atendimento cancelado com sucesso!</div>";
				} else if( resultadoProc.equals("erro") ){
					resultadoProc = "<div class='alert alert-danger'>Não foi possível cancelar o atendimento!</div>";
				} else {
					resultadoProc = "";
				}
			} else {
				resultadoProc = "<div class='alert alert-danger'>Erro ao cancelar o atendimento!</div>";
			}
			
			request.setAttribute("retornoPrDelAgendamento", resultadoProc );
			
			RequestDispatcher view = request.getRequestDispatcher("atendimento/calendario/msgRetorno.jsp");
			view.forward(request, response);
			
		}
		
		/* ====================================================================
		 * REAGENDAR ATENDIMENTO
		 *  1) CHAMA A PROCEDURE pr_del_agendamento
		 *  2) CHAMA A PROCEDURE pr_ins_agendamento
		 * ====================================================================
		 */
		if ((request.getParameter("Controle") != null)
				&& (request.getParameter("Controle").equals("ReagendarAtendimento")) ){
	
			Integer idOs = Integer.parseInt(request.getParameter("idOs"));
			Integer idAtendimento = Integer.parseInt(request.getParameter("idAtendimento"));
			Integer matriculaUsuario = Integer.parseInt(request.getParameter("usuarioLogado"));

			String descricao = request.getParameter("descricao").toString();
			Integer matriculaTecnico = Integer.parseInt(request.getParameter("matriculaTecnico"));
			Integer usuarioLogado = Integer.parseInt(request.getParameter("usuarioLogado").toString());
			Integer idJanela = Integer.parseInt(request.getParameter("idJanela").toString());
			Integer idEquipe = Integer.parseInt(request.getParameter("idEquipe").toString());
			Integer idCliente = Integer.parseInt(request.getParameter("idcliente").toString());
			String dt_agendamento = request.getParameter("dt_agendamento").toString();
			String CPF = "";
			String CNPJ = "";
			// Verificar se CPF existe e guarda-lo na variavel CPF
			if( request.getParameter("cpf") != null ){ CPF = request.getParameter("cpf").toString(); }
			// Verificar se CNPJ existe e guarda-lo na variavel CNPJ
			if( request.getParameter("cnpj") != null ){ CNPJ = request.getParameter("cnpj").toString(); }
			
			String slcAtendimento = request.getParameter("slcAtendimento").toString();
			
			AtendimentoDAO aDAO = new AtendimentoDAO();
			
			// PROCEDURE: PR_DEL_AGENDAMENTO
			TbAtendimento atendimento = aDAO.findById(idAtendimento);
			atendimento.setCdStatus('R');
			String retornoStatusR = aDAO.atualizar(atendimento);
	
			request.setAttribute("retornoStatusR", retornoStatusR );
			
			
			// PROCEDURE: PR_INS_AGENDAMENTO
			String resultados[] = slcAtendimento.split("_");
			Integer IdServico = Integer.parseInt(resultados[0]);
			Integer pIdJanela = Integer.parseInt(resultados[1]);
			Integer pIdEquipe = Integer.parseInt(resultados[2]);
			String pdtAgendamento = resultados[3];
			Integer pMatTec = Integer.parseInt(resultados[4]);
			
			String resultadoProcIns = aDAO.pr_ins_agendamento(
					IdServico, 
					1, 
					idCliente,
					descricao,
					pMatTec,
					usuarioLogado, 
					pIdJanela, 
					pIdEquipe,
					pdtAgendamento);
			
			if( retornoStatusR.equals("sucesso") ){
				if( resultadoProcIns.equals("sucesso") ){
					resultadoProcIns = "<div class='alert alert-success'>Reagendamento efetuado com sucesso!</div>";
				} else if( resultadoProcIns.equals("erro") ){
					resultadoProcIns = "<div class='alert alert-danger'>Nï¿½o foi possï¿½vel efetuar o agendamento!</div>";
				} else {
					resultadoProcIns = "";
				}
			} else {
				resultadoProcIns = "<div class='alert alert-danger'>Erro ao atualizar o atendimento!</div>";
			}
			
			request.setAttribute("retornoPrInsAgendamento", resultadoProcIns );
			
			RequestDispatcher view = request.getRequestDispatcher("atendimento/calendario/msgRetorno.jsp");
			view.forward(request, response);
			
		}
		
		/* ====================================================================
		 * BUSCAR ATENDIMENTO
		 * ====================================================================
		 */
		if ((request.getParameter("Controle") != null)
				&& (request.getParameter("Controle").equals("Buscar"))
				&& (request.getParameter("slcServico") != null)) {
	
			Integer servicoSelecionado = Integer.parseInt(request.getParameter("slcServico"));
	
			// Recebe todo conteï¿½do para transformar em JSON
			JSONArray jArr = new JSONArray();
	
			// Buscar Agendamento que contenha Obj Servico
			AtendimentoDAO DAOAtendimento = new AtendimentoDAO();
			List<TbAtendimento> agendamentos = DAOAtendimento.listarIdServico(servicoSelecionado);
			
			for (int i = 0; i < agendamentos.size(); i++) {
				TbAtendimento agendamento = (TbAtendimento) agendamentos.get(i);
				
				JSONObject jObj = new JSONObject();
				jObj.put("IdAtendimento", agendamento.getIdAtendimento());
				jObj.put("IdOS", agendamento.getTbOs().getIdOs());
				jObj.put("DtAgendamento", Util.DateParaString(agendamento.getDtAgendamento(), "dd/MM/yyyy HH:mm:ss"));
				jObj.put("NrMatricula", agendamento.getNrMatricula());
				jObj.put("CdStatus", String.valueOf(agendamento.getCdStatus()));
				jObj.put("IdJanela", agendamento.getTbAgenda().getTbJanela().getIdJanela());
				jObj.put("IdEquipe", agendamento.getTbAgenda().getTbEquipe().getIdEquipe());
				jObj.put("Smartphone", agendamento.getTbAgenda().getTbEquipe().getNrSmarthfone());
				jObj.put("Servico", agendamento.getTbOs().getTbServico().getNmServico());

				JSONObject jObj2 = new JSONObject();
				jObj2.put("tbAgendamento", jObj);
				
				Integer idCliente = 0;
				
				if( (agendamento.getTbOs().getIdCliente()) != null ){
					idCliente = agendamento.getTbOs().getIdCliente();
				}
				
				// Resgatar dados do cliente
				ViewClienteDAO vDAO = new ViewClienteDAO();
				
				ViewClientes cliente = vDAO.buscarPorIdCliente(idCliente);
				
				JSONObject jObjC = new JSONObject();
				jObjC.put("IdCliente", cliente.getId_cliente());
				jObjC.put("CPF", cliente.getCpf());
				jObjC.put("CNPJ", cliente.getCnpj());
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
				
				if(cliente.getNrCelular() != null){
					jObjC.put("Celular", cliente.getNrCelular().toString());
				} else {
					jObjC.put("Celular", "");
				}
	
				JSONObject jObjC2 = new JSONObject();
				jObjC2.put("tbCliente", jObjC);
	
				List lista = new ArrayList<>();
				lista.add(jObj2);
				lista.add(jObjC2);
				jArr.put(lista);
				
			}
			
			  String resposta = jArr.toString();
	
			  response.setContentType("text/json;charset=utf-8");
			  response.setHeader("Cache-Control", "no-cache");
			  
			  response.getWriter().write(resposta);
	
		} // Final controle buscar
		
		/* ====================================================================
		 * BUSCAR CALENDARIO
		 * ====================================================================
		 */
		if ((request.getParameter("Controle") != null)
				&& (request.getParameter("Controle").equals("BuscarCalendario"))
				&& (request.getParameter("slcServico") != null)) {

			Integer servicoSelecionado = Integer.parseInt(request.getParameter("slcServico"));

			// Recebe todo conteï¿½do para transformar em JSON
			JSONArray jArr = new JSONArray();

			// Buscar Agendamento que contenha Obj Servico
			AtendimentoDAO DAOAtendimento = new AtendimentoDAO();
			List<TbAtendimento> agendamentos = DAOAtendimento.listarIdServico(servicoSelecionado);
			
			for (int i = 0; i < agendamentos.size(); i++) {
				TbAtendimento agendamento = (TbAtendimento) agendamentos.get(i);
				
				JSONObject jObj = new JSONObject();
				jObj.put("IdAtendimento", agendamento.getIdAtendimento());
				jObj.put("IdOS", agendamento.getTbOs().getIdOs());
				jObj.put("DtAgendamento", Util.DateParaString(agendamento.getDtAgendamento(), "dd/MM/yyyy HH:mm:ss"));
				jObj.put("NrMatricula", agendamento.getNrMatricula());
				jObj.put("CdStatus", String.valueOf(agendamento.getCdStatus()));
				jObj.put("IdJanela", agendamento.getTbAgenda().getTbJanela().getIdJanela());
				jObj.put("IdEquipe", agendamento.getTbAgenda().getTbEquipe().getIdEquipe());
				jObj.put("Smartphone", agendamento.getTbAgenda().getTbEquipe().getNrSmarthfone());
				jObj.put("Servico", agendamento.getTbOs().getTbServico().getNmServico());
				
				JSONObject jObj2 = new JSONObject();
				jObj2.put("tbAgendamento", jObj);
				
				Integer idCliente = 0;
				
				if( (agendamento.getTbOs().getIdCliente()) != null ){
					idCliente = agendamento.getTbOs().getIdCliente();
				}
				
				// Resgatar dados do cliente
				ViewClienteDAO vDAO = new ViewClienteDAO();
				
				ViewClientes cliente = vDAO.buscarPorIdCliente(idCliente);
				
				JSONObject jObjC = new JSONObject();
				jObjC.put("IdCliente", cliente.getId_cliente());
				jObjC.put("CPF", cliente.getCpf());
				jObjC.put("CNPJ", cliente.getCnpj());
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
				
				if(cliente.getNrCelular() != null){
					jObjC.put("Celular", cliente.getNrCelular().toString());
				} else {
					jObjC.put("Celular", "");
				}

				JSONObject jObjC2 = new JSONObject();
				jObjC2.put("tbCliente", jObjC);

				List lista = new ArrayList<>();
				lista.add(jObj2);
				lista.add(jObjC2);
				jArr.put(lista);
				
			}
			
			  String resposta = jArr.toString();

			  response.setContentType("text/json;charset=utf-8");
			  response.setHeader("Cache-Control", "no-cache");

			  response.getWriter().write(resposta);

		} // Final controle buscar
		
	} // Final doPost

}
