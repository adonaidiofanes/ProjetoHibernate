package br.telehand.strategy;

public class PerfilAtendente implements PerfilStrategy {

	private static PerfilAtendente instancia; // Instância do Singleton

	protected PerfilAtendente() {
	}

	public static PerfilAtendente instancia() {
		if (instancia == null) {
			instancia = new PerfilAtendente();
		}
		return instancia;
	}

	@Override
	public boolean permitirIncluir() {
		return false;
	}

	@Override
	public boolean permitirAlterar() {
		return false;
	}

	@Override
	public boolean permitirExcluir() {
		return false;
	}

	@Override
	public boolean permitirConsultar() {
		return true;
	}

	@Override
	public String getNomePapelPerfil() {
		return "atendente";
	}

}
