package br.telehand.dao;

// Generated 27/03/2014 15:10:19 by Hibernate Tools 4.0.0

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.HibernateException;
import org.hibernate.Session;

import br.telehand.model.TbCategoria;
import br.telehand.util.SessionFactorySingleton;
/**
 * Home object for domain model class TbCategoria.
 * @see controller.TbCategoria
 * @author Hibernate Tools
 */
public class CategoriaDAO {

	private static final Log log = LogFactory.getLog(CategoriaDAO.class);

	public List<TbCategoria> listarTodos() {
		
		List<TbCategoria> list = null;
		Session session = SessionFactorySingleton.getSessionFactory().openSession();
		
		try {
			session.beginTransaction();
			list = session.createQuery("from TbCategoria").list();
			session.getTransaction().commit();
			
		} catch (HibernateException e) {
			if (session.getTransaction() != null)
				session.getTransaction().rollback();
			
		}
		return list;
	}

    /* ================================================================================================
	 * METODOS AUXILIARES
	 * ================================================================================================ */
	
    public String gerarOptions(int selecionado){
    	String retorno = "";
    	String selected = "";
    	
    	List<TbCategoria> lista = this.listarTodos();
    	
    	for(int i = 0; i<lista.size(); i++){
    		
    		if( selecionado == lista.get(i).getIdCategoria() ){
    			selected = " selected";
    		} else {
    			selected = "";
    		}
    		
    		retorno += "<option value='"+ lista.get(i).getIdCategoria() +"'"+ selected +">" + lista.get(i).getTxCategoria() + "</option>";
    	}
    	
    	return retorno;
    }
	
}
