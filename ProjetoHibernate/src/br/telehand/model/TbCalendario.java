package br.telehand.model;

// Generated 27/03/2014 16:20:36 by Hibernate Tools 4.0.0

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * TbCalendario generated by hbm2java
 */
@Entity
@Table(name = "tb_calendario", catalog = "db_sge")
public class TbCalendario implements java.io.Serializable {

	private TbCalendarioId id;

	public TbCalendario() {
	}

	public TbCalendario(TbCalendarioId id) {
		this.id = id;
	}

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "dtInicial", column = @Column(name = "Dt_inicial", nullable = false, length = 0)),
			@AttributeOverride(name = "dtFinal", column = @Column(name = "Dt_final", nullable = false, length = 0)) })
	public TbCalendarioId getId() {
		return this.id;
	}

	public void setId(TbCalendarioId id) {
		this.id = id;
	}

}
