package br.telehand.state;

import br.telehand.model.TbAtendimento;
import br.telehand.util.StateAtendimentoEnum;

public class Aberto implements StateAtendimento {

	private StateAtendimentoEnum state; 

	private static Aberto instancia; // Instância do Singleton

	protected Aberto() {
	}

	public static Aberto instancia() {
		if (instancia == null) {
			instancia = new Aberto();
			instancia.state = StateAtendimentoEnum.Aberto;
		}
		return instancia;
	}
	
	@Override
	public StateAtendimentoEnum getStateEnum() {
		return state;
	}

	@Override
	public void abrirAtendimento(TbAtendimento atendimento) {
		atendimento.definirEstado(Aberto.instancia());
		System.out.println("Mudança de estado de " + instancia.state + " para " + atendimento.retornarEstado().getStateEnum() + " realizada.");
	}

	@Override
	public void reagendarAtendimento(TbAtendimento atendimento) {
		throw new IllegalStateException("Mudança de estado de " + instancia.state + " para " + Reagendado.instancia().getStateEnum() + " não permitida.");
	}

	@Override
	public void concluirAtendimento(TbAtendimento atendimento) {
		atendimento.definirEstado(Efetuado.instancia());
		System.out.println("Mudança de estado de " + instancia.state + " para " + atendimento.retornarEstado().getStateEnum() + " realizada.");
	}

	@Override
	public void gerarPendencia(TbAtendimento atendimento) {
		atendimento.definirEstado(Pendente.instancia());
		System.out.println("Mudança de estado de " + instancia.state + " para " + atendimento.retornarEstado().getStateEnum() + " realizada.");
	}

	@Override
	public void cancelarAtendimento(TbAtendimento atendimento) {
		atendimento.definirEstado(Cancelado.instancia());
		System.out.println("Mudança de estado de " + instancia.state + " para " + atendimento.retornarEstado().getStateEnum() + " realizada.");
	}
}
