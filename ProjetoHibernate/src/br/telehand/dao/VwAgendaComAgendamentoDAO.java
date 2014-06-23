package br.telehand.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.HibernateException;
import org.hibernate.Session;

import br.telehand.model.VwAgendaComAgendamento;
import br.telehand.util.Util;

public class VwAgendaComAgendamentoDAO {
	
	private static final Log log = LogFactory.getLog(VwAgendaComAgendamento.class);	
	
	public List<VwAgendaComAgendamento> listarPorIdServico(int IdServico) {

		List<VwAgendaComAgendamento> list = null;
		Session session = Util.getSessionFactory().openSession();
		
		try {
			session.beginTransaction();
			String getOptions = "SELECT a from VwAgendaComAgendamento a WHERE a.id.idServico = :id";
			list = session.createQuery(getOptions).setParameter("id", IdServico).list();
			session.getTransaction().commit();			
		} catch (HibernateException e) {
			if (session.getTransaction() != null)
				session.getTransaction().rollback();
			
		} finally {
			session.close();
		}
		return list;		
	}

}
