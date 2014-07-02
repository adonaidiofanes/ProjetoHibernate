package br.telehand.util;

import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;

public class SessionFactorySingleton {

	private static SessionFactory sessionFactoryInstance = null;

	private SessionFactorySingleton() {
	}

	public static synchronized SessionFactory getSessionFactory() {
		
		if (sessionFactoryInstance == null) {

			try {
				Configuration configuration = new Configuration();
			    configuration.configure();
			    ServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder().applySettings(configuration.getProperties()).build();
			    sessionFactoryInstance = configuration.buildSessionFactory(serviceRegistry);

			} catch (Throwable ex) {
				System.err.println("Erro ao criar o singleton SessionFactory." + ex);
				throw new ExceptionInInitializerError(ex);
			}
		}
		
		return sessionFactoryInstance;
	}
}
