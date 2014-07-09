package br.telehand.dao;

// Generated 27/03/2014 15:10:19 by Hibernate Tools 4.0.0

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.hibernate.Session;
import org.hibernate.criterion.Example;

import br.telehand.model.TbJanela;
import br.telehand.util.SessionFactorySingleton;

/**
 * Home object for domain model class TbJanela.
 * @see controller.TbJanela
 * @author Hibernate Tools
 */
public class JanelaDAO {

	private static final Log log = LogFactory.getLog(JanelaDAO.class);

	public void persist(TbJanela transientInstance) {
		log.debug("persisting TbJanela instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			session.persist(transientInstance);
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(TbJanela instance) {
		log.debug("attaching dirty TbJanela instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			session.saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(TbJanela instance) {
		log.debug("attaching clean TbJanela instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			session.lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(TbJanela persistentInstance) {
		log.debug("deleting TbJanela instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			session.delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public TbJanela merge(TbJanela detachedInstance) {
		log.debug("merging TbJanela instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			TbJanela result = (TbJanela) session
					.merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public TbJanela findById(java.lang.Integer id) {
		log.debug("getting TbJanela instance with id: " + id);
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			TbJanela instance = (TbJanela) session
					.get("controller.TbJanela", id);
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

	public List findByExample(TbJanela instance) {
		log.debug("finding TbJanela instance by example");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			List results = session
					.createCriteria("controller.TbJanela")
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
