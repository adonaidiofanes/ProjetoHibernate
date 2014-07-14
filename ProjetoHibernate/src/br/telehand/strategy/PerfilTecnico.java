package br.telehand.strategy;

public class PerfilTecnico implements PerfilStrategy {

	private static PerfilTecnico instancia; // Instância do Singleton

	protected PerfilTecnico() {
	}

	public static PerfilTecnico instancia() {
		if (instancia == null) {
			instancia = new PerfilTecnico();
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
		return "tecnico";
	}

}
