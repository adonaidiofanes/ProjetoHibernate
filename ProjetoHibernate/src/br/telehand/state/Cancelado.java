package br.telehand.state;

import br.telehand.model.TbAtendimento;
import br.telehand.util.StateAtendimentoEnum;

public class Cancelado implements StateAtendimento {

	private StateAtendimentoEnum state; 

	private static Cancelado instancia; // Instância do Singleton
	
	protected Cancelado() {
	}

	public static Cancelado instancia() {
		if (instancia == null) {
			instancia = new Cancelado();
			instancia.state = StateAtendimentoEnum.Cancelado;
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
		throw new IllegalStateException("Mudança de estado de " + instancia.state + " para " + Reagendado.instancia().getStateEnum() + " não permitida.");
	}

	@Override
	public void concluirAtendimento(TbAtendimento atendimento) {
		throw new IllegalStateException("Mudança de estado de " + instancia.state + " para " + Efetuado.instancia().getStateEnum() + " não permitida.");
	}

	@Override
	public void gerarPendencia(TbAtendimento atendimento) {
		throw new IllegalStateException("Mudança de estado de " + instancia.state + " para " + Pendente.instancia().getStateEnum() + " não permitida.");
	}

	@Override
	public void cancelarAtendimento(TbAtendimento atendimento) {
		atendimento.definirEstado(Cancelado.instancia());
		System.out.println("Mudança de estado de " + instancia.state + " para " + atendimento.retornarEstado().getStateEnum() + " realizada.");	}

}
