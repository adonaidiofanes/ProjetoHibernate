package br.telehand.strategy;

public class PerfilAdministrador implements PerfilStrategy {

	private static PerfilAdministrador instancia; // Instância do Singleton

	protected PerfilAdministrador() {
	}

	public static PerfilAdministrador instancia() {
		if (instancia == null) {
			instancia = new PerfilAdministrador();
		}
		return instancia;
	}
	
	@Override
	public boolean permitirIncluir() {
		return true;
	}

	@Override
	public boolean permitirAlterar() {
		return true;
	}

	@Override
	public boolean permitirExcluir() {
		return true;
	}

	@Override
	public boolean permitirConsultar() {
		return true;
	}

	@Override
	public String getNomePapelPerfil() {
		return "administrador";
	}

}
