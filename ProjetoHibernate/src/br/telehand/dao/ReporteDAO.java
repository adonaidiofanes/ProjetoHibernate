package br.telehand.dao;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import br.telehand.model.TbReporte;
import br.telehand.util.SessionFactorySingleton;
/**
 * Home object for domain model class TbReporte.
 * @see controller.TbReporte
 * @author Hibernate Tools
 */
public class ReporteDAO {

	private static final Log log = LogFactory.getLog(ReporteDAO.class);

	public List<TbReporte> listarPorIdServico(int IdServico) {

		List<TbReporte> list = null;
		
		Session session = SessionFactorySingleton.getSessionFactory().openSession();
		
		try {
			session.beginTransaction();
			
			Criteria cr = session.createCriteria(TbReporte.class, "r");
			
//					cr.createAlias("r.tbAtendimento.tbOs.tbServico", "a")
//					.add(Restrictions.eq("a.idServico",IdServico));
//					  
//					cr.addOrder(Order.desc("r.id.dtReporte"));
//					list = cr.list();				
					
					
//					// Listar apenas os reportes do dia
					DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
					Date date = new Date();
					
					String dtReporte = dateFormat.format(date);
					
					String[] explode = dtReporte.split("/");
					
					String diaHoje = explode[2] + "-" + explode[1] + "-" + explode[0];
					
//					String dtReporteI = explode[2] + "-" + explode[1] + "-" + explode[0] + " 00:00:00";
//					String dtReporteF = explode[2] + "-" + explode[1] + "-" + explode[0] + " 23:59:59";
//					
//					java.sql.Timestamp dataI = java.sql.Timestamp.valueOf(dtReporteI);
//					java.sql.Timestamp dataF = java.sql.Timestamp.valueOf(dtReporteF);
//					
//					cr.add(Restrictions.between("r.id.dtReporte", dataI, dataF));
					
					
			
//			HQL
					
			String sql = "SELECT a from TbReporte a WHERE a.tbAtendimento.tbOs.tbServico.idServico = :id "
						+ "AND a.id.dtReporte LIKE '" + diaHoje + "%' "
						+ "AND a.id.dtReporte = (SELECT MAX(rr.id.dtReporte) FROM TbReporte rr "  
	                    + "WHERE a.tbAtendimento.idAtendimento = rr.tbAtendimento.idAtendimento)";
						
//					   	+ "GROUP BY a.tbAtendimento.idAtendimento "
//						+ "ORDER BY a.id.dtReporte DESC";
			list = session.createQuery(sql).setParameter("id", IdServico).list();
			
			session.getTransaction().commit();
		} catch (HibernateException e) {
			if (session.getTransaction() != null)
				session.getTransaction().rollback();
		} finally {
			session.close();
		}
		return list;
	}
	
}
