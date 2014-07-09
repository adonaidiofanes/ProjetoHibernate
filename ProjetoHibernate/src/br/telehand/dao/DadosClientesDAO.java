package br.telehand.dao;

// Generated 27/03/2014 15:10:19 by Hibernate Tools 4.0.0

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.LockMode;
import org.hibernate.Session;
import org.hibernate.criterion.Example;

import br.telehand.model.TbDadosClientes;
import br.telehand.util.SessionFactorySingleton;
/**
 * Home object for domain model class TbDadosClientes.
 * @see controller.TbDadosClientes
 * @author Hibernate Tools
 */
public class DadosClientesDAO {

	private static final Log log = LogFactory.getLog(DadosClientesDAO.class);

    public List<TbDadosClientes> listarTodos() {
    	
    	List<TbDadosClientes> list = null;
	    	
        Session session = SessionFactorySingleton.getSessionFactory().openSession();
		try {
			session.beginTransaction();
		    Criteria select = session.createCriteria(TbDadosClientes.class);  
		    
		    list = select.list();
		    
		    System.out.println(list);
			session.getTransaction().commit();
		} catch (HibernateException e) {
			if (session.getTransaction() != null)
				session.getTransaction().rollback();
		} finally {
			session.close();
		}
		return list;
    }

	public void persist(TbDadosClientes transientInstance) {
		log.debug("persisting TbDadosClientes instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			session.persist(transientInstance);
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(TbDadosClientes instance) {
		log.debug("attaching dirty TbDadosClientes instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			session.saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(TbDadosClientes instance) {
		log.debug("attaching clean TbDadosClientes instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			session.lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(TbDadosClientes persistentInstance) {
		log.debug("deleting TbDadosClientes instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			session.delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public TbDadosClientes merge(TbDadosClientes detachedInstance) {
		log.debug("merging TbDadosClientes instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			TbDadosClientes result = (TbDadosClientes) session.merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public TbDadosClientes findById(java.lang.Integer id) {
		log.debug("getting TbDadosClientes instance with id: " + id);
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			TbDadosClientes instance = (TbDadosClientes) session.get("controller.TbDadosClientes", id);
			if (instance == null) {
				log.debug("get successful, no instance found");
			} else {
				log.debug("get successful, instance found");
			}
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(TbDadosClientes instance) {
		log.debug("finding TbDadosClientes instance by example");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			List results = session
					.createCriteria("controller.TbDadosClientes")
					.add(Example.create(instance)).list();
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}
}
