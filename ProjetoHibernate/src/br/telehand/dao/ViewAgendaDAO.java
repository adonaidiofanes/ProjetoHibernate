package br.telehand.dao;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;

import br.telehand.model.ViewAgenda;
import br.telehand.util.Util;

public class ViewAgendaDAO {
	
	public List<ViewAgenda> listarTodos() {
		
		List<ViewAgenda> list = null;
		Session session = Util.getSessionFactory().openSession();
		
		try {
			session.beginTransaction();
			list = session.createQuery("from ViewAgenda").list();
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
