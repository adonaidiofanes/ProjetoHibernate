package br.telehand.strategy;

public class PerfilAnonimo implements PerfilStrategy {

	private static PerfilAnonimo instancia; // Instância do Singleton

	protected PerfilAnonimo() {
	}

	public static PerfilAnonimo instancia() {
		if (instancia == null) {
			instancia = new PerfilAnonimo();
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
		return false;
	}

	@Override
	public String getNomePapelPerfil() {
		return "anonimo";
	}

}
