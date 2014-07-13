package br.telehand.state;

import br.telehand.model.TbAtendimento;
import br.telehand.util.StateAtendimentoEnum;


public interface StateAtendimento {
	
	public StateAtendimentoEnum getStateEnum();  
	
	public void abrirAtendimento(TbAtendimento atendimento);
	
	public void reagendarAtendimento(TbAtendimento atendimento);
	
	public void concluirAtendimento(TbAtendimento atendimento);
	
	public void gerarPendencia(TbAtendimento atendimento);
	
	public void cancelarAtendimento(TbAtendimento atendimento);

}
