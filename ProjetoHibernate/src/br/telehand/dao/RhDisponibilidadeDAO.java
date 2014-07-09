package br.telehand.dao;

// Generated 27/03/2014 15:10:19 by Hibernate Tools 4.0.0

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.hibernate.Session;
import org.hibernate.criterion.Example;

import br.telehand.model.TbRhDisponibilidade;
import br.telehand.util.SessionFactorySingleton;
/**
 * Home object for domain model class TbRhDisponibilidade.
 * @see controller.TbRhDisponibilidade
 * @author Hibernate Tools
 */
public class RhDisponibilidadeDAO {

	private static final Log log = LogFactory
			.getLog(RhDisponibilidadeDAO.class);

	public void persist(TbRhDisponibilidade transientInstance) {
		log.debug("persisting TbRhDisponibilidade instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			session.persist(transientInstance);
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(TbRhDisponibilidade instance) {
		log.debug("attaching dirty TbRhDisponibilidade instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			session.saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(TbRhDisponibilidade instance) {
		log.debug("attaching clean TbRhDisponibilidade instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			session.lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(TbRhDisponibilidade persistentInstance) {
		log.debug("deleting TbRhDisponibilidade instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			session.delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public TbRhDisponibilidade merge(TbRhDisponibilidade detachedInstance) {
		log.debug("merging TbRhDisponibilidade instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			TbRhDisponibilidade result = (TbRhDisponibilidade) session.merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public TbRhDisponibilidade findById(int id) {
		log.debug("getting TbRhDisponibilidade instance with id: " + id);
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			TbRhDisponibilidade instance = (TbRhDisponibilidade) session.get("controller.TbRhDisponibilidade",
							id);
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

	public List findByExample(TbRhDisponibilidade instance) {
		log.debug("finding TbRhDisponibilidade instance by example");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			List results = session
					.createCriteria("controller.TbRhDisponibilidade")
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
