package br.telehand.state;

import br.telehand.model.TbAtendimento;
import br.telehand.util.StateAtendimentoEnum;

public class Pendente implements StateAtendimento {

	private StateAtendimentoEnum state; 

	private static Pendente instancia; // Instância do Singleton
	
	protected Pendente() {
	}

	public static Pendente instancia() {
		if (instancia == null) {
			instancia = new Pendente();
			instancia.state = StateAtendimentoEnum.Pendente;
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
		atendimento.definirEstado(Reagendado.instancia());
		System.out.println("Mudança de estado de " + instancia.state + " para " + atendimento.retornarEstado().getStateEnum() + " realizada.");
	}

	@Override
	public void concluirAtendimento(TbAtendimento atendimento) {
		throw new IllegalStateException("Mudança de estado de " + instancia.state + " para " + Efetuado.instancia().getStateEnum() + " não permitida.");
	}

	@Override
	public void gerarPendencia(TbAtendimento atendimento) {
		atendimento.definirEstado(Pendente.instancia());
		System.out.println("Mudança de estado de " + instancia.state + " para " + atendimento.retornarEstado().getStateEnum() + " realizada.");
	}

	@Override
	public void cancelarAtendimento(TbAtendimento atendimento) {
		atendimento.definirEstado(Cancelado.instancia());
		System.out.println("Mudança de estado de " + instancia.state + " para " + atendimento.retornarEstado().getStateEnum() + " realizada.");	}

}
