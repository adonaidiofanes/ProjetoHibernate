package br.telehand.dao;

// Generated 27/03/2014 15:10:19 by Hibernate Tools 4.0.0

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Criteria;
import org.hibernate.LockMode;
import org.hibernate.Session;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.Restrictions;

import br.telehand.model.TbAlmKit;
import br.telehand.model.TbAtendimento;
import br.telehand.model.TbServico;
import br.telehand.util.SessionFactorySingleton;
/**
 * Home object for domain model class TbAlmKit.
 * @see controller.TbAlmKit
 * @author Hibernate Tools
 */
public class AlmKitDAO {

	private static final Log log = LogFactory.getLog(AlmKitDAO.class);

	public void persist(TbAlmKit transientInstance) {
		log.debug("persisting TbAlmKit instance");
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

	public void attachDirty(TbAlmKit instance) {
		log.debug("attaching dirty TbAlmKit instance");
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

	public void attachClean(TbAlmKit instance) {
		log.debug("attaching clean TbAlmKit instance");
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

	public void delete(TbAlmKit persistentInstance) {
		log.debug("deleting TbAlmKit instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			session.beginTransaction();
			session.delete(persistentInstance);
			session.getTransaction().commit();
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public TbAlmKit merge(TbAlmKit detachedInstance) {
		log.debug("merging TbAlmKit instance");
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			session.beginTransaction();
			TbAlmKit result = (TbAlmKit) session.merge(detachedInstance);
			session.getTransaction().commit();
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public TbAlmKit findById(int id) {
		log.debug("getting TbAlmKit instance with id: " + id);
		try {
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			session.beginTransaction();
			TbAlmKit instance = (TbAlmKit) session.get("controller.TbAlmKit", id);
			session.getTransaction().commit();
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

	public List findByExample(TbAlmKit instance) {
		log.debug("finding TbAlmKit instance by example");
		try {			
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			List results = session.createCriteria("controller.TbAlmKit")
								  .add(Example.create(instance)).list();
			log.debug("find by example successful, result size: " + results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}
	
	public TbAlmKit selecionarIdServico(int id) {
		log.debug("getting TbAlmKit instance with id: " + id);
		try {

			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			Criteria cr = session.createCriteria(TbAlmKit.class);
			TbAlmKit retorno = (TbAlmKit) cr.add( Restrictions.eq("idServico", id) ).uniqueResult();
			
			if (retorno == null) {
				log.debug("Kit encontrado");
			} else {
				log.debug("Kit nao encontrado");
			}
			return retorno;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}
}
