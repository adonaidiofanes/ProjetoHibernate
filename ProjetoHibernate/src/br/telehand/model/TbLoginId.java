package br.telehand.model;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * TbLoginId generated by hbm2java
 */
@Embeddable
public class TbLoginId implements java.io.Serializable {

	private int nrMatricula;
	private char cdUsuario;
	private String cdSenha;

	public TbLoginId() {
	}

	public TbLoginId(int nrMatricula, char cdUsuario, String cdSenha) {
		this.nrMatricula = nrMatricula;
		this.cdUsuario = cdUsuario;
		this.cdSenha = cdSenha;
	}

	@Column(name = "Nr_matricula", nullable = false)
	public int getNrMatricula() {
		return this.nrMatricula;
	}

	public void setNrMatricula(int nrMatricula) {
		this.nrMatricula = nrMatricula;
	}

	@Column(name = "Cd_USUARIO", nullable = false, length = 1)
	public char getCdUsuario() {
		return this.cdUsuario;
	}

	public void setCdUsuario(char cdUsuario) {
		this.cdUsuario = cdUsuario;
	}

	@Column(name = "CD_SENHA", nullable = false, length = 4)
	public String getCdSenha() {
		return this.cdSenha;
	}

	public void setCdSenha(String cdSenha) {
		this.cdSenha = cdSenha;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof TbLoginId))
			return false;
		TbLoginId castOther = (TbLoginId) other;

		return (this.getNrMatricula() == castOther.getNrMatricula())
				&& (this.getCdUsuario() == castOther.getCdUsuario())
				&& ((this.getCdSenha() == castOther.getCdSenha()) || (this
						.getCdSenha() != null && castOther.getCdSenha() != null && this
						.getCdSenha().equals(castOther.getCdSenha())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result + this.getNrMatricula();
		result = 37 * result + this.getCdUsuario();
		result = 37 * result
				+ (getCdSenha() == null ? 0 : this.getCdSenha().hashCode());
		return result;
	}

}
