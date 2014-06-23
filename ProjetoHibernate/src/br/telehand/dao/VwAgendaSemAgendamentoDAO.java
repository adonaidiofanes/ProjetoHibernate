package br.telehand.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.HibernateException;
import org.hibernate.Session;

import br.telehand.model.VwAgendaSemAgendamento;
import br.telehand.util.Util;

public class VwAgendaSemAgendamentoDAO {
	
	private static final Log log = LogFactory.getLog(VwAgendaSemAgendamento.class);	
	
	public List<VwAgendaSemAgendamento> listarPorIdServico(int IdServico) {

		List<VwAgendaSemAgendamento> list = null;
		Session session = Util.getSessionFactory().openSession();
		
		try {
			session.beginTransaction();
			String getOptions = "SELECT a from VwAgendaSemAgendamento a WHERE a.id.idServico = :id ORDER BY a.id.anoMesDia ASC";
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
