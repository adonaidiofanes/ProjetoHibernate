package br.telehand.model;

// Generated 27/03/2014 16:20:36 by Hibernate Tools 4.0.0

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * TbTecAuxiliares generated by hbm2java
 */
@Entity
@Table(name = "tb_tec_auxiliares", catalog = "db_sge")
public class TbTecAuxiliares implements java.io.Serializable {

	private TbTecAuxiliaresId id;
	private TbEquipe tbEquipe;

	public TbTecAuxiliares() {
	}

	public TbTecAuxiliares(TbTecAuxiliaresId id, TbEquipe tbEquipe) {
		this.id = id;
		this.tbEquipe = tbEquipe;
	}

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "idEquipe", column = @Column(name = "Id_equipe", nullable = false)),
			@AttributeOverride(name = "nrMatricula", column = @Column(name = "Nr_matricula", nullable = false)) })
	public TbTecAuxiliaresId getId() {
		return this.id;
	}

	public void setId(TbTecAuxiliaresId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "Id_equipe", nullable = false, insertable = false, updatable = false)
	public TbEquipe getTbEquipe() {
		return this.tbEquipe;
	}

	public void setTbEquipe(TbEquipe tbEquipe) {
		this.tbEquipe = tbEquipe;
	}

}