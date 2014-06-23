package br.telehand.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="vw_dados_clientes")
public class ViewClientes implements Serializable {

	private int id_cliente;
	private String cpf;
	private String cnpj;
	private String nmCliente;
	private String cdEmail;
	private String endereco;
	private String complemento;
	private String numero;
	private String bairro;
	private String cidade;
	private String uf;
	private String cep;
	private String nrTel;
	private String nrCelular;
	private String nrIdent;
	
	@Id
	@Column(name="id_cliente")
	public int getId_cliente() {
		return id_cliente;
	}
	public void setId_cliente(int id_cliente) {
		this.id_cliente = id_cliente;
	}
	
	@Column(name = "CPF", precision = 11, scale = 0)
	public String getCpf() {
		return this.cpf;
	}

	public void setCpf(String cpf) {
		this.cpf = cpf;
	}

	@Column(name = "CNPJ", precision = 14, scale = 0)
	public String getCnpj() {
		return this.cnpj;
	}

	public void setCnpj(String cnpj) {
		this.cnpj = cnpj;
	}

	@Column(name = "NM_CLIENTE", nullable = false, length = 20)
	public String getNmCliente() {
		return this.nmCliente;
	}

	public void setNmCliente(String nmCliente) {
		this.nmCliente = nmCliente;
	}

	@Column(name = "CD_EMAIL")
	public String getCdEmail() {
		return this.cdEmail;
	}

	public void setCdEmail(String cdEmail) {
		this.cdEmail = cdEmail;
	}

	@Column(name = "ENDERECO", length = 100)
	public String getEndereco() {
		return this.endereco;
	}

	public void setEndereco(String endereco) {
		this.endereco = endereco;
	}

	@Column(name = "COMPLEMENTO", length = 30)
	public String getComplemento() {
		return this.complemento;
	}

	public void setComplemento(String complemento) {
		this.complemento = complemento;
	}

	@Column(name = "NUMERO")
	public String getNumero() {
		return this.numero;
	}

	public void setNumero(String numero) {
		this.numero = numero;
	}

	@Column(name = "BAIRRO", length = 30)
	public String getBairro() {
		return this.bairro;
	}

	public void setBairro(String bairro) {
		this.bairro = bairro;
	}

	@Column(name = "CIDADE", length = 40)
	public String getCidade() {
		return this.cidade;
	}

	public void setCidade(String cidade) {
		this.cidade = cidade;
	}

	@Column(name = "UF", length = 2)
	public String getUf() {
		return this.uf;
	}

	public void setUf(String uf) {
		this.uf = uf;
	}

	@Column(name = "CEP")
	public String getCep() {
		return this.cep;
	}

	public void setCep(String cep) {
		this.cep = cep;
	}
	
	@Column(name = "nr_tel")
	public String getNrTel() {
		return nrTel;
	}
	
	public void setNrTel(String nrTel) {
		this.nrTel = nrTel;
	}
	
	@Column(name = "nr_celular")
	public String getNrCelular() {
		return nrCelular;
	}
	public void setNrCelular(String nrCelular) {
		this.nrCelular = nrCelular;
	}
	
	@Column(name = "nr_ident")
	public String getNrIdent() {
		return nrIdent;
	}
	public void setNrIdent(String nrIdent) {
		this.nrIdent = nrIdent;
	}

	
	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof VwDadosClientesId))
			return false;
		VwDadosClientesId castOther = (VwDadosClientesId) other;

		return (this.getId_cliente() == castOther.getIdCliente())
				&& ((this.getCpf() == castOther.getCpf()) || (this.getCpf() != null
						&& castOther.getCpf() != null && this.getCpf().equals(
						castOther.getCpf())))
				&& ((this.getCnpj() == castOther.getCnpj()) || (this.getCnpj() != null
						&& castOther.getCnpj() != null && this.getCnpj()
						.equals(castOther.getCnpj())))
				&& ((this.getNmCliente() == castOther.getNmCliente()) || (this
						.getNmCliente() != null
						&& castOther.getNmCliente() != null && this
						.getNmCliente().equals(castOther.getNmCliente())))
				&& ((this.getCdEmail() == castOther.getCdEmail()) || (this
						.getCdEmail() != null && castOther.getCdEmail() != null && this
						.getCdEmail().equals(castOther.getCdEmail())))
				&& ((this.getEndereco() == castOther.getEndereco()) || (this
						.getEndereco() != null
						&& castOther.getEndereco() != null && this
						.getEndereco().equals(castOther.getEndereco())))
				&& ((this.getComplemento() == castOther.getComplemento()) || (this
						.getComplemento() != null
						&& castOther.getComplemento() != null && this
						.getComplemento().equals(castOther.getComplemento())))
				&& ((this.getNumero() == castOther.getNumero()) || (this
						.getNumero() != null && castOther.getNumero() != null && this
						.getNumero().equals(castOther.getNumero())))
				&& ((this.getBairro() == castOther.getBairro()) || (this
						.getBairro() != null && castOther.getBairro() != null && this
						.getBairro().equals(castOther.getBairro())))
				&& ((this.getCidade() == castOther.getCidade()) || (this
						.getCidade() != null && castOther.getCidade() != null && this
						.getCidade().equals(castOther.getCidade())))
				&& ((this.getUf() == castOther.getUf()) || (this.getUf() != null
						&& castOther.getUf() != null && this.getUf().equals(
						castOther.getUf())))
				&& ((this.getCep() == castOther.getCep()) || (this.getCep() != null
						&& castOther.getCep() != null && this.getCep().equals(
						castOther.getCep())))
				&& ((this.getNrTel() == castOther.getNrTel()) || (this
						.getNrTel() != null
						&& castOther.getNrTel() != null && this
						.getNrTel().equals(castOther.getNrTel())))
				&& ((this.getNrIdent() == castOther.getNrIdent()) || (this
						.getNrIdent() != null
						&& castOther.getNrIdent() != null && this
						.getNrIdent().equals(castOther.getNrIdent())))
				&& ((this.getNrCelular() == castOther.getNrCelular()) || (this
						.getNrCelular() != null
						&& castOther.getNrCelular() != null && this
						.getNrCelular().equals(castOther.getNrCelular())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result + this.getId_cliente();
		result = 37 * result
				+ (getCpf() == null ? 0 : this.getCpf().hashCode());
		result = 37 * result
				+ (getCnpj() == null ? 0 : this.getCnpj().hashCode());
		result = 37 * result
				+ (getNmCliente() == null ? 0 : this.getNmCliente().hashCode());
		result = 37 * result
				+ (getCdEmail() == null ? 0 : this.getCdEmail().hashCode());
		result = 37 * result
				+ (getEndereco() == null ? 0 : this.getEndereco().hashCode());
		result = 37
				* result
				+ (getComplemento() == null ? 0 : this.getComplemento()
						.hashCode());
		result = 37 * result
				+ (getNumero() == null ? 0 : this.getNumero().hashCode());
		result = 37 * result
				+ (getBairro() == null ? 0 : this.getBairro().hashCode());
		result = 37 * result
				+ (getCidade() == null ? 0 : this.getCidade().hashCode());
		result = 37 * result + (getUf() == null ? 0 : this.getUf().hashCode());
		result = 37 * result
				+ (getCep() == null ? 0 : this.getCep().hashCode());
		result = 37 * result
				+ (getNrTel() == null ? 0 : this.getNrTel().hashCode());
		result = 37 * result
				+ (getNrCelular() == null ? 0 : this.getNrCelular().hashCode());
		result = 37 * result
				+ (getNrIdent() == null ? 0 : this.getNrIdent().hashCode());
		return result;
	}
	


}
