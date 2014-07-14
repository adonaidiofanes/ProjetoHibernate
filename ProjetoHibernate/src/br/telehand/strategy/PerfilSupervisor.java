package br.telehand.strategy;

public class PerfilSupervisor implements PerfilStrategy {

	private static PerfilSupervisor instancia; // Instância do Singleton

	protected PerfilSupervisor() {
	}

	public static PerfilSupervisor instancia() {
		if (instancia == null) {
			instancia = new PerfilSupervisor();
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
		return false;
	}

	@Override
	public boolean permitirConsultar() {
		return true;
	}

	@Override
	public String getNomePapelPerfil() {
		return "supervisor";
	}

}
