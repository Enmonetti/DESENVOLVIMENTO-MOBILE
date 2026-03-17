// EX1 + EX2 (Máquina Industrial + subclasses)

abstract class MaquinaIndustrial {
  String nome = "";
  int potencia = 0;
  bool status = false;

  void ligar();
  void desligar();
}

class Prensa extends MaquinaIndustrial {
  int pressao = 0;

  void ligar() {
    status = true;
    print("Prensa ligada");
  }

  void desligar() {
    status = false;
    print("Prensa desligada");
  }
}

class RoboSolda extends MaquinaIndustrial {
  String tipoSolda = "";

  void ligar() {
    status = true;
    print("Robo de solda ligado");
  }

  void desligar() {
    status = false;
    print("Robo de solda desligado");
  }
}

// EX3 (Getter e Setter)

class Pessoa {
  String _nome = "";
  int _idade = 0;

  String get nome {
    return _nome;
  }

  void setNome(String n) {
    if (n != "") {
      _nome = n;
    }
  }

  int get idade {
    return _idade;
  }

  void setIdade(int i) {
    if (i > 0) {
      _idade = i;
    }
  }

  void mostrar() {
    print("Nome: " + _nome);
    print("Idade: " + _idade.toString());
  }
}

// EX4 + EX5 + EX6 + EX7

abstract class Automovel {
  String nome = "";
  String cor = "";
  int ano = 0;

  void cinto();
  void ligar();
  void desligar();
  void dirigir();
}

class Carro extends Automovel {
  void cinto() {
    print("Cinto colocado");
  }

  void ligar() {
    print("Carro ligado");
  }

  void desligar() {
    print("Carro desligado");
  }

  void dirigir() {
    print("Carro andando");
  }
}

// MAIN
void main() {

  print("\nEX1 e EX2");
  Prensa p = Prensa();
  p.ligar();
  p.desligar();

  RoboSolda r = RoboSolda();
  r.ligar();
  r.desligar();

  print("\nEX3");
  Pessoa pessoa = Pessoa();
  pessoa.setNome("Joao");
  pessoa.setIdade(20);
  pessoa.mostrar();

  print("\nEX4 a EX7");
  Carro c = Carro();
  c.cinto();
  c.ligar();
  c.dirigir();
  c.desligar();
}