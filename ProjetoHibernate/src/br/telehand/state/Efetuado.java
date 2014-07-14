package br.telehand.state;

import br.telehand.model.TbAtendimento;
import br.telehand.util.StateAtendimentoEnum;

public class Efetuado implements StateAtendimento {

	private StateAtendimentoEnum state; 

	private static Efetuado instancia; // Instância do Singleton
	
	protected Efetuado() {
	}

	public static Efetuado instancia() {
		if (instancia == null) {
			instancia = new Efetuado();
			instancia.state = StateAtendimentoEnum.Efetuado;
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
		atendimento.definirEstado(Efetuado.instancia());
		System.out.println("Mudança de estado de " + instancia.state + " para " + atendimento.retornarEstado().getStateEnum() + " realizada.");	}

	@Override
	public void gerarPendencia(TbAtendimento atendimento) {
		throw new IllegalStateException("Mudança de estado de " + instancia.state + " para " + Pendente.instancia().getStateEnum() + " não permitida.");
	}

	@Override
	public void cancelarAtendimento(TbAtendimento atendimento) {
		throw new IllegalStateException("Mudança de estado de " + instancia.state + " para " + Cancelado.instancia().getStateEnum() + " não permitida.");
	}

}
