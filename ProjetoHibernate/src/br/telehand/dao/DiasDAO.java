package br.telehand.dao;

// Generated 27/03/2014 15:10:19 by Hibernate Tools 4.0.0

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.hibernate.Session;
import org.hibernate.criterion.Example;

import br.telehand.model.TbDias;
import br.telehand.model.TbDiasId;
import br.telehand.util.SessionFactorySingleton;
/**
 * Home object for domain model class TbDias.
 * @see controller.TbDias
 * @author Hibernate Tools
 */
public class DiasDAO {

	private static final Log log = LogFactory.getLog(DiasDAO.class);

	public void persist(TbDias transientInstance) {
		log.debug("persisting TbDias instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			session.persist(transientInstance);
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(TbDias instance) {
		log.debug("attaching dirty TbDias instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			session.saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(TbDias instance) {
		log.debug("attaching clean TbDias instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			session.lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(TbDias persistentInstance) {
		log.debug("deleting TbDias instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			session.delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public TbDias merge(TbDias detachedInstance) {
		log.debug("merging TbDias instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			TbDias result = (TbDias) session.merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public TbDias findById(TbDiasId id) {
		log.debug("getting TbDias instance with id: " + id);
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			TbDias instance = (TbDias) session.get(
					"controller.TbDias", id);
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

	public List findByExample(TbDias instance) {
		log.debug("finding TbDias instance by example");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			List results = session
					.createCriteria("controller.TbDias")
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
