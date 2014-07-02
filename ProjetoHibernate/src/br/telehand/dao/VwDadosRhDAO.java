package br.telehand.dao;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import br.telehand.model.VwDadosRh;
import br.telehand.util.SessionFactorySingleton;

public class VwDadosRhDAO {
	
	public VwDadosRh selectByMatricula(int matricula) {
		try {

			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			Criteria cr = session.createCriteria(VwDadosRh.class);
						
			VwDadosRh retorno = (VwDadosRh) cr.add( Restrictions.eq("nrMatricula", matricula) ).uniqueResult();
			
			return retorno;
		} catch (RuntimeException re) {
			throw re;
		}
	}
	
//	public VwDadosRh selectByMatricula(int matricula) {
//		
//		try {
//			
//			Session session = SessionFactorySingleton.getSessionFactory().openSession();
//			
//			Criteria cr = session.createCriteria(VwDadosRh.class);
//					 cr.add(Restrictions.eq("id.nrMatricula", 1));
////				  	 VwDadosRh retorno = (VwDadosRh) cr.uniqueResult();
//				  	 
//			System.out.println("=========== --- ===================");
//			System.out.println(cr.list());
//			System.out.println("============ --- ==================");
//			
//			VwDadosRh retorno = new VwDadosRh();
//			return retorno;
//			
//		} catch (RuntimeException re) {
//			throw re;
//		}
//		
//	}

}
