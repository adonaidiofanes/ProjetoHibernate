package br.telehand.dao;

// Generated 27/03/2014 15:10:19 by Hibernate Tools 4.0.0

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.hibernate.Session;
import org.hibernate.criterion.Example;

import br.telehand.model.TbLog;
import br.telehand.model.TbLogId;
import br.telehand.util.SessionFactorySingleton;
/**
 * Home object for domain model class TbLog.
 * @see controller.TbLog
 * @author Hibernate Tools
 */
public class LogDAO {

	private static final Log log = LogFactory.getLog(LogDAO.class);

	public void persist(TbLog transientInstance) {
		log.debug("persisting TbLog instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			
			session.beginTransaction();
			
			session.persist(transientInstance);
			
			session.getTransaction().commit();

			log.debug("persist successful");
			
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(TbLog instance) {
		log.debug("attaching dirty TbLog instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			
			session.beginTransaction();
			session.saveOrUpdate(instance);
			session.getTransaction().commit();

			log.debug("attach successful");
			
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(TbLog instance) {
		log.debug("attaching clean TbLog instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			
			session.beginTransaction();
			session.lock(instance, LockMode.NONE);
			session.getTransaction().commit();
			
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(TbLog persistentInstance) {
		log.debug("deleting TbLog instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			
			session.beginTransaction();
			session.lock(persistentInstance, LockMode.NONE);
			session.getTransaction().commit();
			session.delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public TbLog merge(TbLog detachedInstance) {
		log.debug("merging TbLog instance");
		try {			
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			session.beginTransaction();
			TbLog result = (TbLog) session.merge(detachedInstance);
			session.getTransaction().commit();
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public TbLog findById(TbLogId id) {
		log.debug("getting TbLog instance with id: " + id);
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			TbLog instance = (TbLog) session.get("controller.TbLog", id);
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

	public List findByExample(TbLog instance) {
		log.debug("finding TbLog instance by example");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			List results = session
					.createCriteria("controller.TbLog")
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
