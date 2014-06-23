package br.telehand.model;

// Generated 27/03/2014 16:20:36 by Hibernate Tools 4.0.0

import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * TbCategoria generated by hbm2java
 */
@Entity
@Table(name = "tb_categoria", catalog = "db_sge")
public class TbCategoria implements java.io.Serializable {

	private Integer idCategoria;
	private String txCategoria;
	private Date dtVigencia;

	public TbCategoria() {
	}

	public TbCategoria(String txCategoria, Date dtVigencia) {
		this.txCategoria = txCategoria;
		this.dtVigencia = dtVigencia;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "Id_categoria", unique = true, nullable = false)
	public Integer getIdCategoria() {
		return this.idCategoria;
	}

	public void setIdCategoria(Integer idCategoria) {
		this.idCategoria = idCategoria;
	}

	@Column(name = "Tx_categoria", length = 20)
	public String getTxCategoria() {
		return this.txCategoria;
	}

	public void setTxCategoria(String txCategoria) {
		this.txCategoria = txCategoria;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "Dt_vigencia", length = 0)
	public Date getDtVigencia() {
		return this.dtVigencia;
	}

	public void setDtVigencia(Date dtVigencia) {
		this.dtVigencia = dtVigencia;
	}

}
