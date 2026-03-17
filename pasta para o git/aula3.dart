import 'dart:io';

// 1
void ex1() {
  print("\nEX1");

  stdout.write("Nome: ");
  String nome = stdin.readLineSync()!;

  stdout.write("Curso: ");
  String curso = stdin.readLineSync()!;

  stdout.write("Idade: ");
  int idade = int.parse(stdin.readLineSync()!);

  print("Nome: " + nome);
  print("Curso: " + curso);
  print("Idade: " + idade.toString());
}

// 2
void ex2() {
  print("\nEX2");

  stdout.write("Base: ");
  int base = int.parse(stdin.readLineSync()!);

  stdout.write("Altura: ");
  int altura = int.parse(stdin.readLineSync()!);

  int area = (base * altura) ~/ 2;

  print("Area: " + area.toString());
}

// 3
void ex3() {
  print("\nEX3");

  stdout.write("Salario: ");
  int salario = int.parse(stdin.readLineSync()!);

  int imposto = salario ~/ 10;
  int bonus = (salario * 2) ~/ 10;

  int finalSalario = salario - imposto + bonus;

  print("Salario final: " + finalSalario.toString());
}

// 4
void ex4() {
  print("\nEX4");

  stdout.write("Valor em reais: ");
  int valor = int.parse(stdin.readLineSync()!);

  stdout.write("Moeda (1=EUR, 2=USD, 3=CHF): ");
  int op = int.parse(stdin.readLineSync()!);

  if (op == 1) {
    print("Euro: " + (valor ~/ 7).toString());
  } else if (op == 2) {
    print("Dolar: " + (valor ~/ 6).toString());
  } else if (op == 3) {
    print("Franco: " + (valor ~/ 4).toString());
  } else {
    print("Opcao invalida");
  }
}

// 5
void ex5() {
  print("\nEX5");

  stdout.write("Nota 1: ");
  int n1 = int.parse(stdin.readLineSync()!);

  stdout.write("Nota 2: ");
  int n2 = int.parse(stdin.readLineSync()!);

  int media = (n1 + n2) ~/ 2;

  if (media >= 7) {
    print("Aprovado");
  } else if (media >= 4) {
    print("Exame");
  } else {
    print("Reprovado");
  }
}

// 6
void ex6() {
  print("\nEX6");

  stdout.write("Idade 1: ");
  int a = int.parse(stdin.readLineSync()!);

  stdout.write("Idade 2: ");
  int b = int.parse(stdin.readLineSync()!);

  if (a > b) {
    print("Pessoa 1 mais velha");
  } else if (b > a) {
    print("Pessoa 2 mais velha");
  } else {
    print("Mesma idade");
  }
}

// 7
void ex7() {
  print("\nEX7");

  stdout.write("Carro 1: ");
  int a = int.parse(stdin.readLineSync()!);

  stdout.write("Carro 2: ");
  int b = int.parse(stdin.readLineSync()!);

  stdout.write("Carro 3: ");
  int c = int.parse(stdin.readLineSync()!);

  int maior = a;
  int menor = a;

  if (b > maior) maior = b;
  if (c > maior) maior = c;

  if (b < menor) menor = b;
  if (c < menor) menor = c;

  print("Mais caro: " + maior.toString());
  print("Mais barato: " + menor.toString());
}

// 8
void ex8() {
  print("\nEX8");

  stdout.write("Litros: ");
  int litros = int.parse(stdin.readLineSync()!);

  stdout.write("Tipo (1=E, 2=D, 3=G): ");
  int tipo = int.parse(stdin.readLineSync()!);

  int preco = 0;
  int desconto = 0;

  if (tipo == 1) {
    preco = 4;
    desconto = (preco * litros) ~/ 20;
  } else if (tipo == 2) {
    preco = 5;
    desconto = (preco * litros) ~/ 30;
  } else if (tipo == 3) {
    preco = 6;
    desconto = (preco * litros) ~/ 25;
  } else {
    print("Tipo invalido");
    return;
  }

  int total = (preco * litros) - desconto;

  print("Total: " + total.toString());
}

// 9
void ex9() {
  print("\nEX9");

  stdout.write("kWh: ");
  int kwh = int.parse(stdin.readLineSync()!);

  stdout.write("Tipo (1=R, 2=I, 3=C): ");
  int tipo = int.parse(stdin.readLineSync()!);

  int preco = 0;

  if (tipo == 1) preco = 1;
  else if (tipo == 2) preco = 1;
  else if (tipo == 3) preco = 1;
  else {
    print("Tipo invalido");
    return;
  }

  int total = preco * kwh;

  print("Total: " + total.toString());
}

// 10
void ex10() {
  print("\nEX10");

  stdout.write("Numero 1: ");
  int a = int.parse(stdin.readLineSync()!);

  stdout.write("Numero 2: ");
  int b = int.parse(stdin.readLineSync()!);

  stdout.write("Operacao (1=+,2=-,3=*,4=/): ");
  int op = int.parse(stdin.readLineSync()!);

  if (op == 1) print(a + b);
  else if (op == 2) print(a - b);
  else if (op == 3) print(a * b);
  else if (op == 4) {
    if (b != 0) print(a ~/ b);
    else print("Erro");
  } else {
    print("Opcao invalida");
  }
}