package br.telehand.state;

import br.telehand.model.TbAtendimento;

public class StateTest {

	public static void main(String[] args) {
		
		System.out.println("Inicio do Teste");
		
		TbAtendimento atendimento = new TbAtendimento();
		
		System.out.println("\n" + atendimento.retornarEstado().getStateEnum());
		atendimento.abrirAtendimento();
		
		System.out.println("\n" + atendimento.retornarEstado().getStateEnum());
		atendimento.gerarPendencia();
		
		System.out.println("\n" + atendimento.retornarEstado().getStateEnum());
		atendimento.reagendarAtendimento();
		
		System.out.println("\n" + atendimento.retornarEstado().getStateEnum());
		atendimento.gerarPendencia();
		
		System.out.println("\n" + atendimento.retornarEstado().getStateEnum());
		atendimento.cancelarAtendimento();
		
		System.out.println("\n" + atendimento.retornarEstado().getStateEnum());
		atendimento.concluirAtendimento();
		
		System.out.println("Fim do Teste");
	}

}
