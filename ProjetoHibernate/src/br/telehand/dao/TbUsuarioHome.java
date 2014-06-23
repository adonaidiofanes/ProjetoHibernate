package br.telehand.dao;

// Generated 27/03/2014 15:10:19 by Hibernate Tools 4.0.0

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import br.telehand.model.TbUsuario;
import br.telehand.util.Util;

/**
 * Home object for domain model class TbUsuario.
 * @see controller.TbUsuario
 * @author Hibernate Tools
 */
public class TbUsuarioHome {

	private static final Log log = LogFactory.getLog(TbUsuarioHome.class);
	
	public TbUsuario findById(int id) {
		log.debug("getting TbUsuario instance with id: " + id);
		try {
			Session session = Util.getSessionFactory().openSession();
	        org.hibernate.Criteria criteria = session.createCriteria(TbUsuario.class);
	        TbUsuario retorno = (TbUsuario) criteria.add(Restrictions.eq("nrMatricula", id)).uniqueResult();
			if (retorno == null) {
				log.debug("Usuario encontrado");
			} else {
				log.debug("Usuario nao encontrado");
			}
			return retorno;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}
	
	public String delete(TbUsuario persistentInstance) {
        Session session = Util.getSessionFactory().openSession();
        String retorno = null;
        try {
            TbUsuario auxiliar = persistentInstance;
            session.beginTransaction();
            session.delete(auxiliar);
            session.flush();
            session.getTransaction().commit();
            retorno = "Apagado com sucesso!";
        } catch (Exception e) {
            retorno = "Ocorreu um erro ao apagar o serviço!";
            session.getTransaction().rollback();
        } finally {
            session.close();
        }
        return retorno;
    }
	
}
