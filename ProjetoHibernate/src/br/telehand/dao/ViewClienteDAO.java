package br.telehand.dao;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import br.telehand.model.ViewClientes;
import br.telehand.util.SessionFactorySingleton;

public class ViewClienteDAO {
	
	private static final Log log = LogFactory.getLog(ViewClientes.class);
	
	public ViewClientes findByDoc(String CPF, String CNPJ) {
		
		log.debug("getting ViewClientes instance with CPF: " + CPF + " CNPJ: " + CNPJ);
		
		String OP = null;
		String NUM = null;
		
		if( CPF != "" && CPF != "0"){  OP = "CPF";  NUM = CPF; }
		if( CNPJ != "" && CNPJ != "0"){ OP = "CNPJ"; NUM = CNPJ; }
				
		try {
			
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			
	        org.hibernate.Criteria criteria = session.createCriteria(ViewClientes.class);
	        
	        ViewClientes retorno = null;
	        
	        if( CPF != "" && CPF != null ){
	        	retorno = (ViewClientes) criteria.add(Restrictions.eq("cpf", CPF)).uniqueResult();
	        } else {
	        	retorno = (ViewClientes) criteria.add(Restrictions.eq("cnpj", CNPJ)).uniqueResult();
	        }
	        
			if (retorno == null) {
				log.debug("ViewClientes encontrado");
			} else {
				log.debug("ViewClientes nao encontrado");
			}
			
			return retorno;
			
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}
	
	public ViewClientes buscarPorIdCliente(Integer idCliente) {
		
		log.debug("getting ViewClientes instance with IdCliente: " + idCliente);
		
		try {
			
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			
	        org.hibernate.Criteria criteria = session.createCriteria(ViewClientes.class);
	        
	        ViewClientes retorno = null;
	        
        	retorno = (ViewClientes) criteria.add(Restrictions.eq("id_cliente", idCliente)).uniqueResult();
	        
			if (retorno == null) {
				log.debug("ViewClientes encontrado");
			} else {
				log.debug("ViewClientes nao encontrado");
			}
			
			return retorno;
			
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

}
