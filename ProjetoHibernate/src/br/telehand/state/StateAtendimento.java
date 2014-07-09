package br.telehand.state;

public interface StateAtendimento {
	
	public void reagendarAtendimento();
	
	public void concluirAtendimento();
	
	public void gerarPendencia();
	
	public void cancelarAtendimento();

}
