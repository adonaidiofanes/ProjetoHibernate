package br.telehand.dao;

// Generated 27/03/2014 15:10:19 by Hibernate Tools 4.0.0

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import br.telehand.model.TbAtendimento;
import br.telehand.model.TbOs;
import br.telehand.model.TbReporte;
import br.telehand.util.Util;
/**
 * Home object for domain model class TbAtendimento.
 * @see controller.TbAtendimento
 * @author Hibernate Tools
 */
public class AtendimentoDAO {

	private static final Log log = LogFactory.getLog(AtendimentoDAO.class);	

	public TbAtendimento findById(int id) {
		log.debug("getting TbAtendimento instance with id: " + id);
		try {
			
			Session session = Util.getSessionFactory().openSession();
			
	        org.hibernate.Criteria criteria = session.createCriteria(TbAtendimento.class);
	        
	        TbAtendimento retorno = (TbAtendimento) criteria.add(Restrictions.eq("idAtendimento", id)).uniqueResult();
	        
			if (retorno == null) { 
				log.debug("Atendimento encontrado");
			} else {
				log.debug("Atendimento nao encontrado");
			}
			return retorno;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}
	
	public List<TbAtendimento> listarIdServico(int IdServico) {

		List<TbAtendimento> list = null;
		
		Session session = Util.getSessionFactory().openSession();
		
		try {
			session.beginTransaction();
			
			Criteria cr = session.createCriteria(TbAtendimento.class, "a");
					 cr.createAlias("a.tbOs.tbServico", "s")
					 .add(Restrictions.eq("s.idServico",IdServico));
//					 cr.setMaxResults(12);
					 list = cr.list();
			
			session.getTransaction().commit();
		} catch (Exception e) {
			session.getTransaction().rollback();
		} finally {
			session.close();
		}
		
		return list;
	}
	
	public List<TbAtendimento> listarTodos() {
		
		List<TbAtendimento> list = null;
		Session session = Util.getSessionFactory().openSession();
		
		try {
			session.beginTransaction();
			list = session.createQuery("from TbAtendimento").list();
			session.getTransaction().commit();
			
		} catch (HibernateException e) {
			if (session.getTransaction() != null)
				session.getTransaction().rollback();
			
		} finally {
			session.close();
		}
		return list;
	}
	
	public TbAtendimento porIdJanela(int id) {
		log.debug("getting TbAtendimento instance with id: " + id);
		try {

			Session session = Util.getSessionFactory().openSession();
			Criteria cr = session.createCriteria(TbAtendimento.class);
			TbAtendimento retorno = (TbAtendimento) cr.add( Restrictions.eq("tbAgenda.idJanela", id) ).uniqueResult();
			
			if (retorno == null) {
				log.debug("Servico encontrado");
			} else {
				log.debug("Servico nao encontrado");
			}
			return retorno;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}
	
	public TbAtendimento selecionar(int id) {
		log.debug("getting TbAtendimento instance with id: " + id);
		try {

			Session session = Util.getSessionFactory().openSession();
			Criteria cr = session.createCriteria(TbAtendimento.class);
			TbAtendimento retorno = (TbAtendimento) cr.add( Restrictions.eq("tbOs.idOs", id) ).uniqueResult();
			
			if (retorno == null) {
				log.debug("Os encontrada");
			} else {
				log.debug("Os Nao Encontrada");
			}
			return retorno;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		} 
	}
	
    public String atualizar(TbAtendimento objAtendimento) {
        Session session = Util.getSessionFactory().openSession();
        String retorno = null;
        try {
            session.beginTransaction();
            session.update(objAtendimento);
            session.flush();
            session.getTransaction().commit();
            retorno = "sucesso";
        } catch (Exception e) {
        	System.out.println("erro:" + e.getMessage());
            retorno = "erro";
            session.getTransaction().rollback();
        }
        return retorno;
    }
	
	public String pr_ins_agendamento(Integer idServico, Integer idCategoria,
			Integer idCliente, String descricao,
			Integer matriculaTecnico, Integer usuarioLogado, Integer idJanela,
			Integer idEquipe, String dt_agendamento) {
		
		
		String retorno = "";
		
		// Inicia a sesssao
		Session session = Util.getSessionFactory().openSession();
		
		try {
			session.beginTransaction();
						
			Query query = session.createSQLQuery(
							"CALL pr_ins_agendamento(:p_id_servico, :p_id_categoria, :p_id_cliente, :p_tx_detalhe, :p_nr_matricula_tecnico, :p_nr_matricula_usuario, :p_id_janela, :p_id_equipe, :p_dt_agendamento)")
							.setParameter("p_id_servico", idServico)
							.setParameter("p_id_categoria", idCategoria)
							.setParameter("p_id_cliente", idCliente)
							.setParameter("p_tx_detalhe", descricao)
							.setParameter("p_nr_matricula_tecnico", matriculaTecnico)
							.setParameter("p_nr_matricula_usuario", usuarioLogado)
							.setParameter("p_id_janela", idJanela)
							.setParameter("p_id_equipe", idEquipe)
							.setParameter("p_dt_agendamento", dt_agendamento);
			
			int linhasAfetadas = query.executeUpdate();
			
			if( linhasAfetadas > 0 ){
				retorno = "sucesso";
			} else {
				retorno = "erro";
			}

			session.getTransaction().commit();
			
		} catch (Exception e) {
			session.getTransaction().rollback();
		} finally {
			session.close();
		}
		
		return retorno;
	}

	public String pr_del_agendamento(Integer p_id_os, Integer p_id_atendimento, Integer p_nr_matricula_usuario) {
		
		String retorno = "";
		
		// Inicia a sesssao
		Session session = Util.getSessionFactory().openSession();
		
		try {
			session.beginTransaction();
						
			Query query = session.createSQLQuery(
							"CALL pr_del_agendamento(:p_id_os, :p_id_atendimento, :p_nr_matricula_usuario)")
							.setParameter("p_id_os", p_id_os)
							.setParameter("p_id_atendimento", p_id_atendimento)
							.setParameter("p_nr_matricula_usuario", p_nr_matricula_usuario);
			
			int linhasAfetadas = query.executeUpdate();
			
			if( linhasAfetadas > 0 ){
				retorno = "sucesso";
			} else {
				retorno = "erro";
			}

			session.getTransaction().commit();
			
		} catch (Exception e) {
			session.getTransaction().rollback();
		} finally {
			session.close();
		}
		
		return retorno;
	}

}
