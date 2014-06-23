package br.telehand.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * VwDadosRh generated by hbm2java
 */
@Entity
@Table(name = "vw_dados_rh", catalog = "db_sge")
public class VwDadosRh implements java.io.Serializable {

	private int nrMatricula;
	private String nmEmpregado;
	private Date dtInicioIndisp;
	private Date dtFimIndisp;

	public VwDadosRh() {
	}

	@Id
	@Column(name = "NR_MATRICULA", nullable = false)
	public int getNrMatricula() {
		return nrMatricula;
	}

	public void setNrMatricula(int nrMatricula) {
		this.nrMatricula = nrMatricula;
	}

	@Column(name = "NM_EMPREGADO", nullable = false, length = 20)
	public String getNmEmpregado() {
		return nmEmpregado;
	}

	public void setNmEmpregado(String nmEmpregado) {
		this.nmEmpregado = nmEmpregado;
	}

	@Column(name = "dt_inicio_indisp", length = 0)
	public Date getDtInicioIndisp() {
		return dtInicioIndisp;
	}

	public void setDtInicioIndisp(Date dtInicioIndisp) {
		this.dtInicioIndisp = dtInicioIndisp;
	}

	@Column(name = "dt_fim_indisp", length = 0)
	public Date getDtFimIndisp() {
		return dtFimIndisp;
	}

	public void setDtFimIndisp(Date dtFimIndisp) {
		this.dtFimIndisp = dtFimIndisp;
	}

}