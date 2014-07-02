package br.telehand.dao;

// Generated 27/03/2014 15:10:19 by Hibernate Tools 4.0.0

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import br.telehand.model.TbOs;
import br.telehand.util.SessionFactorySingleton;
/**
 * Home object for domain model class TbOs.
 * @see controller.TbOs
 * @author Hibernate Tools
 */
public class OsDAO {

	private static final Log log = LogFactory.getLog(OsDAO.class);
	
	public TbOs findById(int id) {
		log.debug("getting TbOs instance with id: " + id);
		try {
			
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			
	        org.hibernate.Criteria criteria = session.createCriteria(TbOs.class);
	        
	        TbOs retorno = (TbOs) criteria.add(Restrictions.eq("idOs", id)).uniqueResult();
	        
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
	
	public List<TbOs> listarTodos() {
		List<TbOs> list = null;
		
		Session session = SessionFactorySingleton.getSessionFactory().openSession();
		
		try {
			session.beginTransaction();
			//list = session.createQuery("from TbOs").list();
			Criteria cr = session.createCriteria(TbOs.class)
						  .addOrder(Order.desc("idOs"))
						  .setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
			list = cr.list();
			session.getTransaction().commit();
		} catch (HibernateException e) {
			if (session.getTransaction() != null)
				session.getTransaction().rollback();
		} finally {
			session.close();
		}
		return list;
	}
	
	public List<TbOs> listarPorMatricula(int matricula) {
		List<TbOs> list = null;
		
		Session session = SessionFactorySingleton.getSessionFactory().openSession();
		
		try {
			session.beginTransaction();
			
			Criteria cr = session.createCriteria(TbOs.class, "os");
					 cr.createAlias("tbAtendimentos", "atendimento");
					 cr.add(Restrictions.eq("atendimento.nrMatricula", matricula));
					 cr.addOrder(Order.desc("idOs"));
					 cr.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
					 
				 	 list = cr.list();
				 	 
			session.getTransaction().commit();
		} catch (HibernateException e) {
			if (session.getTransaction() != null)
				session.getTransaction().rollback();
		} 
		return list;
	}
	
	public TbOs selecionar(int id) {
		
		Session session = SessionFactorySingleton.getSessionFactory().openSession();
		
		try {

			Criteria cr = session.createCriteria(TbOs.class);
			TbOs retorno = (TbOs) cr.add( Restrictions.eq("idOs", id) ).uniqueResult();

			return retorno;
		} catch (RuntimeException re) {
			throw re;
		} finally {
			session.close();
		}
	}
	
    public String atualizar(TbOs os) {
    	System.out.println("Entrei no atualizar");
        Session session = SessionFactorySingleton.getSessionFactory().openSession();
        String retorno = null;
        try {
            session.beginTransaction();
            session.update(os);
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

}
