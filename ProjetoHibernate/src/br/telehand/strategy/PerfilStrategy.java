package br.telehand.strategy;

public interface PerfilStrategy {
	
	public boolean permitirIncluir();

	public boolean permitirAlterar();
	
	public boolean permitirExcluir();
	
	public boolean permitirConsultar();
	
	public String getNomePapelPerfil();
}
