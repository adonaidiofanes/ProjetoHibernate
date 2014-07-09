package br.telehand.dao;

// Generated 27/03/2014 15:10:19 by Hibernate Tools 4.0.0

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.hibernate.Session;
import org.hibernate.criterion.Example;

import br.telehand.model.TbTecAuxiliares;
import br.telehand.model.TbTecAuxiliaresId;
import br.telehand.util.SessionFactorySingleton;
/**
 * Home object for domain model class TbTecAuxiliares.
 * @see controller.TbTecAuxiliares
 * @author Hibernate Tools
 */
public class TecAuxiliaresDAO {

	private static final Log log = LogFactory.getLog(TecAuxiliaresDAO.class);

	public void persist(TbTecAuxiliares transientInstance) {
		log.debug("persisting TbTecAuxiliares instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			session.persist(transientInstance);
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(TbTecAuxiliares instance) {
		log.debug("attaching dirty TbTecAuxiliares instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			session.saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(TbTecAuxiliares instance) {
		log.debug("attaching clean TbTecAuxiliares instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			session.lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(TbTecAuxiliares persistentInstance) {
		log.debug("deleting TbTecAuxiliares instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			session.delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public TbTecAuxiliares merge(TbTecAuxiliares detachedInstance) {
		log.debug("merging TbTecAuxiliares instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			TbTecAuxiliares result = (TbTecAuxiliares) session.merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public TbTecAuxiliares findById(TbTecAuxiliaresId id) {
		log.debug("getting TbTecAuxiliares instance with id: " + id);
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			TbTecAuxiliares instance = (TbTecAuxiliares) session.get("controller.TbTecAuxiliares", id);
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

	public List findByExample(TbTecAuxiliares instance) {
		log.debug("finding TbTecAuxiliares instance by example");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			List results = session
					.createCriteria("controller.TbTecAuxiliares")
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
