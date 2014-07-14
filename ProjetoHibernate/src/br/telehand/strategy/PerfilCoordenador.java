package br.telehand.strategy;

public class PerfilCoordenador implements PerfilStrategy {

	private static PerfilCoordenador instancia; // Instância do Singleton

	protected PerfilCoordenador() {
	}

	public static PerfilCoordenador instancia() {
		if (instancia == null) {
			instancia = new PerfilCoordenador();
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
		return "coordenador";
	}

}
