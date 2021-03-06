package br.telehand.model;

// Generated 27/03/2014 16:20:36 by Hibernate Tools 4.0.0

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import br.telehand.strategy.PerfilAdministrador;
import br.telehand.strategy.PerfilAnonimo;
import br.telehand.strategy.PerfilAtendente;
import br.telehand.strategy.PerfilCoordenador;
import br.telehand.strategy.PerfilStrategy;
import br.telehand.strategy.PerfilSupervisor;
import br.telehand.strategy.PerfilTecnico;

/**
 * TbUsuario generated by hbm2java
 */
@Entity
@Table(name = "tb_usuario", catalog = "db_sge")
public class TbUsuario implements java.io.Serializable {

	/**
	 * Serial UID da classe
	 */
	private static final long serialVersionUID = 1L;
	
	private int nrMatricula;
	private char cdUsuario;
	
	@Transient
	private String nomeUsuario;
	
	@Transient
	private PerfilStrategy perfil = PerfilAnonimo.instancia();

	public TbUsuario() {
	}

	public TbUsuario(int nrMatricula, char cdUsuario) {
		this.nrMatricula = nrMatricula;
		this.cdUsuario = cdUsuario;
		
		this.definirPerfilUsuario(cdUsuario);
	}
	
	public TbUsuario(int nrMatricula, char cdUsuario, String nomeUsuario) {
		this.nrMatricula = nrMatricula;
		this.cdUsuario = cdUsuario;
		this.nomeUsuario = nomeUsuario;
		
		this.definirPerfilUsuario(cdUsuario);
	}

	@Id
	@Column(name = "nr_matricula", unique = true, nullable = false)
	public int getNrMatricula() {
		return this.nrMatricula;
	}

	public void setNrMatricula(int nrMatricula) {
		this.nrMatricula = nrMatricula;
	}

	@Column(name = "cd_usuario", nullable = false, length = 1)
	public char getCdUsuario() {
		return this.cdUsuario;
	}

	public void setCdUsuario(char cdUsuario) {
		this.cdUsuario = cdUsuario;
		
		this.definirPerfilUsuario(cdUsuario);
	}

	public String getNomeUsuario() {
		return nomeUsuario;
	}

	public void setNomeUsuario(String nomeUsuario) {
		this.nomeUsuario = nomeUsuario;
	}

	public PerfilStrategy retornarPerfil() {
		return perfil;
	}

	public void definirPerfil(PerfilStrategy perfil) {
		this.perfil = perfil;
	}
	
	/**
	 * Define o perfi do usuario atraves do codigo do seu papel.
	 * @param char papelUsuario
	 */
	public void definirPerfilUsuario(char papelUsuario) {
		
		switch(papelUsuario){
		
			case 'A' : this.definirPerfil(PerfilAdministrador.instancia());
				break;
				
			case 'T':  this.definirPerfil(PerfilTecnico.instancia());
				break;
				
			case 'C' : this.definirPerfil(PerfilCoordenador.instancia());
				break;
				
			case 'S' : this.definirPerfil(PerfilSupervisor.instancia());
				break;
				
			case 'D' : this.definirPerfil(PerfilAtendente.instancia());
				break;
				
			default: this.definirPerfil(PerfilAnonimo.instancia());
		}
		
	}
	
	/**
	 * Retorna se o usuario pertence ao perfil Administrador.
	 * @return boolean true ou false.
	 */
	@Transient
	public boolean isPerfilAdministrador() {
		return (this.perfil != null && this.perfil instanceof PerfilAdministrador);  
	}
	
	/**
	 * Retorna se o usuario pertence ao perfil Coordenador.
	 * @return boolean true ou false.
	 */
	@Transient
	public boolean isPerfilCoordenador() {
		return (this.perfil != null && this.perfil instanceof PerfilCoordenador);  
	}
	
	/**
	 * Retorna se o usuario pertence ao perfil Supervisor.
	 * @return boolean true ou false.
	 */
	@Transient
	public boolean isPerfilSupervisor() {
		return (this.perfil != null && this.perfil instanceof PerfilSupervisor);  
	}
	
	/**
	 * Retorna se o usuario pertence ao perfil Tecnico.
	 * @return boolean true ou false.
	 */
	@Transient
	public boolean isPerfilTecnico() {
		return (this.perfil != null && this.perfil instanceof PerfilTecnico);  
	}
	
	/**
	 * Retorna se o usuario pertence ao perfil Atendente.
	 * @return boolean true ou false.
	 */
	@Transient
	public boolean isPerfilAtendente() {
		return (this.perfil != null && this.perfil instanceof PerfilAtendente);
	}
	
	/**
	 * Retorna se o usuario pertence ao perfil Anomimo (sem perfil).
	 * @return boolean true ou false.
	 */
	@Transient
	public boolean isPerfilAnonimo() {
		return (this.perfil != null && this.perfil instanceof PerfilAnonimo);
	}
}
