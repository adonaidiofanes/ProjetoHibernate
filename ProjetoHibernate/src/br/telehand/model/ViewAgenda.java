package br.telehand.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "vw_agenda", catalog = "db_sge")
public class ViewAgenda implements java.io.Serializable {
	
	private int idServico;
	private int idJanela;
	private int idEquipe;
	private Date hrInicial;
	private Date hrFinal;
	private int idAgendamento;
	
	@Column(name = "id_servico", nullable = false)
	public int getIdServico() {
		return idServico;
	}
	public void setIdServico(int idServico) {
		this.idServico = idServico;
	}
	
	@Id
	@Column(name = "id_janela", nullable = false)
	public int getIdJanela() {
		return idJanela;
	}
	public void setIdJanela(int idJanela) {
		this.idJanela = idJanela;
	}
	
	@Column(name = "id_equipe", nullable = false)
	public int getIdEquipe() {
		return idEquipe;
	}
	public void setIdEquipe(int idEquipe) {
		this.idEquipe = idEquipe;
	}
	
	@Column(name = "Hr_inicial", length = 0)
	public Date getHrInicial() {
		return hrInicial;
	}
	public void setHrInicial(Date hrInicial) {
		this.hrInicial = hrInicial;
	}
	
	@Column(name = "Hr_final", length = 0)
	public Date getHrFinal() {
		return hrFinal;
	}
	public void setHrFinal(Date hrFinal) {
		this.hrFinal = hrFinal;
	}
	
	@Column(name = "id_agendamento")
	public int getIdAgendamento() {
		return idAgendamento;
	}
	public void setIdAgendamento(int idAgendamento) {
		this.idAgendamento = idAgendamento;
	}
	
	
}
