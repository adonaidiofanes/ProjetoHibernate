package br.telehand.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.HibernateException;
import org.hibernate.Session;

import br.telehand.model.TbAgenda;
import br.telehand.util.SessionFactorySingleton;

public class AgendaDAO {

	private static final Log log = LogFactory.getLog(AgendaDAO.class);	
	
	public List<TbAgenda> listarPorIdServico(int IdServico) {
		
		List<TbAgenda> list = null;
		Session session = SessionFactorySingleton.getSessionFactory().openSession();
		
		try {
			session.beginTransaction();
			list = session.createQuery("from TbAgenda").list();
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
