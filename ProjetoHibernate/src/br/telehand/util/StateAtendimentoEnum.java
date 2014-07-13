package br.telehand.util;

public enum StateAtendimentoEnum {

	Aberto('A'), Cancelado('C'), Pendente('P'), Reagendado('R'), Efetuado('E');

	private char state;

	private StateAtendimentoEnum(char status) {
		this.state = status;
	}

	public char getStateChar() {
		return this.state;
	}

}