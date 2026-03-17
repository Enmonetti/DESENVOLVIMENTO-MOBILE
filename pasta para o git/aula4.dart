import 'dart:io';

// EX1
void ex1() {
  print("\nEX1");
  print("Nome:");
  String nome = stdin.readLineSync()!;

  print("Curso:");
  String curso = stdin.readLineSync()!;

  print("Idade:");
  int idade = int.parse(stdin.readLineSync()!);

  print(nome);
  print(curso);
  print(idade);
}

// EX2
void ex2() {
  print("\nEX2");
  print("Base:");
  int b = int.parse(stdin.readLineSync()!);

  print("Altura:");
  int h = int.parse(stdin.readLineSync()!);

  int area = (b * h) ~/ 2;

  print("Area: " + area.toString());
}

// EX3
void ex3() {
  print("\nEX3");
  print("Salario:");
  int s = int.parse(stdin.readLineSync()!);

  int imposto = s ~/ 10;
  int bonus = (s * 2) ~/ 10;

  int total = s - imposto + bonus;

  print("Salario final: " + total.toString());
}

// EX4
void ex4() {
  print("\nEX4");
  print("1-Saque 2-Pix 3-Emprestimo 4-Transferencia");
  int op = int.parse(stdin.readLineSync()!);

  print("Valor:");
  int valor = int.parse(stdin.readLineSync()!);

  if (op == 1) print("Saque: " + valor.toString());
  else if (op == 2) print("Pix: " + valor.toString());
  else if (op == 3) print("Emprestimo: " + valor.toString());
  else if (op == 4) print("Transferencia: " + valor.toString());
  else print("Opcao invalida");
}

// EX5
void ex5() {
  print("\nEX5");
  print("Valor em reais:");
  int v = int.parse(stdin.readLineSync()!);

  print("1-Euro 2-Dolar 3-Franco");
  int op = int.parse(stdin.readLineSync()!);

  if (op == 1) print("Euro: " + (v ~/ 7).toString());
  else if (op == 2) print("Dolar: " + (v ~/ 6).toString());
  else if (op == 3) print("Franco: " + (v ~/ 4).toString());
  else print("Opcao invalida");
}

// EX6
class Carrinho {
  int total = 0;

  void adicionar(int valor) {
    total = total + valor;
  }

  void remover(int valor) {
    total = total - valor;
  }

  void mostrar() {
    print("Total carrinho: " + total.toString());
  }
}

// EX7
class Carro {
  String marca = "";
  String modelo = "";
  int ano = 0;
  bool ligado = false;

  void ligar() {
    ligado = true;
  }

  void desligar() {
    ligado = false;
  }

  void status() {
    if (ligado) {
      print("Motor ligado");
    } else {
      print("Motor desligado");
    }
  }
}

// MAIN
void main() {
  ex1();
  ex2();
  ex3();
  ex4();
  ex5();

  print("\nEX6");
  Carrinho c = Carrinho();
  c.adicionar(100);
  c.adicionar(50);
  c.remover(30);
  c.mostrar();

  print("\nEX7");
  Carro car = Carro();
  car.ligar();
  car.status();
  car.desligar();
  car.status();
}