package br.telehand.state;

import br.telehand.model.TbAtendimento;
import br.telehand.util.StateAtendimentoEnum;

public class Reagendado implements StateAtendimento {

	private StateAtendimentoEnum state;

	private static Reagendado instancia; // Instância do Singleton

	protected Reagendado() {
	}

	public static Reagendado instancia() {
		if (instancia == null) {
			instancia = new Reagendado();
			instancia.state = StateAtendimentoEnum.Reagendado;
		}
		return instancia;
	}

	@Override
	public StateAtendimentoEnum getStateEnum() {
		return state;
	}

	@Override
	public void abrirAtendimento(TbAtendimento atendimento) {
		throw new IllegalStateException("Mudança de estado de " + instancia.state + " para " + Aberto.instancia().getStateEnum() + " não permitida.");
	}

	@Override
	public void reagendarAtendimento(TbAtendimento atendimento) {
		atendimento.estabelecerEstado(Reagendado.instancia());
		System.out.println("Mudança de estado de " + instancia.state + " para " + atendimento.retornarEstado().getStateEnum() + " realizada.");
	}

	@Override
	public void concluirAtendimento(TbAtendimento atendimento) {
		atendimento.estabelecerEstado(Efetuado.instancia());
		System.out.println("Mudança de estado de " + instancia.state + " para " + atendimento.retornarEstado().getStateEnum() + " realizada.");
	}

	@Override
	public void gerarPendencia(TbAtendimento atendimento) {
		atendimento.estabelecerEstado(Pendente.instancia());
		System.out.println("Mudança de estado de " + instancia.state + " para " + atendimento.retornarEstado().getStateEnum() + " realizada.");
	}

	@Override
	public void cancelarAtendimento(TbAtendimento atendimento) {
		atendimento.estabelecerEstado(Cancelado.instancia());
		System.out.println("Mudança de estado de " + instancia.state + " para " + atendimento.retornarEstado().getStateEnum() + " realizada.");
	}
}
