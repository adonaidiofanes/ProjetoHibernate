package br.telehand.dao;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import br.telehand.model.TbLogin;
import br.telehand.util.SessionFactorySingleton;

public class LoginDAO {

	public TbLogin validaLogin(int matricula, String senha) {
		
		try {
			
			Session session = SessionFactorySingleton.getSessionFactory().openSession();
			
			Criteria cr = session.createCriteria(TbLogin.class);
					 cr.add(Restrictions.eq("id.nrMatricula", matricula));
				  	 cr.add(Restrictions.eq("id.cdSenha", senha));
				  	 TbLogin retorno = (TbLogin) cr.uniqueResult();					 
			
			return retorno;
		} catch (RuntimeException re) {
			throw re;
		}
	}
	
}
