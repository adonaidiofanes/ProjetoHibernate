package br.telehand.dao;

// Generated 27/03/2014 15:10:19 by Hibernate Tools 4.0.0

import java.util.List;

import javax.naming.InitialContext;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.LockMode;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
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

	private final SessionFactory sessionFactory = getSessionFactory();

	protected SessionFactory getSessionFactory() {
		try {
			return (SessionFactory) new InitialContext()
					.lookup("SessionFactory");
		} catch (Exception e) {
			log.error("Could not locate SessionFactory in JNDI", e);
			throw new IllegalStateException(
					"Could not locate SessionFactory in JNDI");
		}
	}
	
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
			sessionFactory.getCurrentSession().persist(transientInstance);
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(TbDadosClientes instance) {
		log.debug("attaching dirty TbDadosClientes instance");
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(TbDadosClientes instance) {
		log.debug("attaching clean TbDadosClientes instance");
		try {
			sessionFactory.getCurrentSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(TbDadosClientes persistentInstance) {
		log.debug("deleting TbDadosClientes instance");
		try {
			sessionFactory.getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public TbDadosClientes merge(TbDadosClientes detachedInstance) {
		log.debug("merging TbDadosClientes instance");
		try {
			TbDadosClientes result = (TbDadosClientes) sessionFactory
					.getCurrentSession().merge(detachedInstance);
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
			TbDadosClientes instance = (TbDadosClientes) sessionFactory
					.getCurrentSession().get("controller.TbDadosClientes", id);
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
			List results = sessionFactory.getCurrentSession()
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
