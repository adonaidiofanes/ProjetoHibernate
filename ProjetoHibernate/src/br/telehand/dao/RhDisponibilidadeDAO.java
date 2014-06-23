package br.telehand.dao;

// Generated 27/03/2014 15:10:19 by Hibernate Tools 4.0.0

import java.util.List;
import javax.naming.InitialContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Example;
import br.telehand.model.TbRhDisponibilidade;
/**
 * Home object for domain model class TbRhDisponibilidade.
 * @see controller.TbRhDisponibilidade
 * @author Hibernate Tools
 */
public class RhDisponibilidadeDAO {

	private static final Log log = LogFactory
			.getLog(RhDisponibilidadeDAO.class);

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

	public void persist(TbRhDisponibilidade transientInstance) {
		log.debug("persisting TbRhDisponibilidade instance");
		try {
			sessionFactory.getCurrentSession().persist(transientInstance);
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(TbRhDisponibilidade instance) {
		log.debug("attaching dirty TbRhDisponibilidade instance");
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(TbRhDisponibilidade instance) {
		log.debug("attaching clean TbRhDisponibilidade instance");
		try {
			sessionFactory.getCurrentSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(TbRhDisponibilidade persistentInstance) {
		log.debug("deleting TbRhDisponibilidade instance");
		try {
			sessionFactory.getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public TbRhDisponibilidade merge(TbRhDisponibilidade detachedInstance) {
		log.debug("merging TbRhDisponibilidade instance");
		try {
			TbRhDisponibilidade result = (TbRhDisponibilidade) sessionFactory
					.getCurrentSession().merge(detachedInstance);
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
			TbRhDisponibilidade instance = (TbRhDisponibilidade) sessionFactory
					.getCurrentSession().get("controller.TbRhDisponibilidade",
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
			List results = sessionFactory.getCurrentSession()
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
