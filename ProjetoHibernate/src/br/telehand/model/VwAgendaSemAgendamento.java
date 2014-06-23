package br.telehand.model;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * VwAgendaSemAgendamento generated by hbm2java
 */
@Entity
@Table(name = "vw_agenda_sem_agendamento", catalog = "db_sge")
public class VwAgendaSemAgendamento implements java.io.Serializable {

	private VwAgendaSemAgendamentoId id;

	public VwAgendaSemAgendamento() {
	}

	public VwAgendaSemAgendamento(VwAgendaSemAgendamentoId id) {
		this.id = id;
	}

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "idServico", column = @Column(name = "id_servico", nullable = false)),
			@AttributeOverride(name = "idJanela", column = @Column(name = "id_janela", nullable = false)),
			@AttributeOverride(name = "idEquipe", column = @Column(name = "id_equipe", nullable = false)),
			@AttributeOverride(name = "hrInicial", column = @Column(name = "Hr_inicial", nullable = false, length = 0)),
			@AttributeOverride(name = "hrFinal", column = @Column(name = "Hr_final", nullable = false, length = 0)),
			@AttributeOverride(name = "cdDia", column = @Column(name = "cd_dia", nullable = false)),
			@AttributeOverride(name = "cdSemana", column = @Column(name = "cd_semana", nullable = false)),
			@AttributeOverride(name = "anoMesDia", column = @Column(name = "ano_mes_dia", length = 0)),
			@AttributeOverride(name = "nrMatriculaTecnico", column = @Column(name = "NrMatriculaTecnico", nullable = false)) })
	public VwAgendaSemAgendamentoId getId() {
		return this.id;
	}

	public void setId(VwAgendaSemAgendamentoId id) {
		this.id = id;
	}

}
