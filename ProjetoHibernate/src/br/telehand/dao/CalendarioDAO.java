package br.telehand.dao;

// Generated 27/03/2014 15:10:19 by Hibernate Tools 4.0.0

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.hibernate.Session;
import org.hibernate.criterion.Example;

import br.telehand.model.TbCalendario;
import br.telehand.model.TbCalendarioId;
import br.telehand.util.SessionFactorySingleton;
/**
 * Home object for domain model class TbCalendario.
 * @see controller.TbCalendario
 * @author Hibernate Tools
 */
public class CalendarioDAO {

	private static final Log log = LogFactory.getLog(CalendarioDAO.class);

	public void persist(TbCalendario transientInstance) {
		log.debug("persisting TbCalendario instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			session.persist(transientInstance);
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(TbCalendario instance) {
		log.debug("attaching dirty TbCalendario instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			session.saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(TbCalendario instance) {
		log.debug("attaching clean TbCalendario instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			session.lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(TbCalendario persistentInstance) {
		log.debug("deleting TbCalendario instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			session.delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public TbCalendario merge(TbCalendario detachedInstance) {
		log.debug("merging TbCalendario instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			TbCalendario result = (TbCalendario) session.merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public TbCalendario findById(TbCalendarioId id) {
		log.debug("getting TbCalendario instance with id: " + id);
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			TbCalendario instance = (TbCalendario) session.get("controller.TbCalendario", id);
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

	public List findByExample(TbCalendario instance) {
		log.debug("finding TbCalendario instance by example");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			List results = session
					.createCriteria("controller.TbCalendario")
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
