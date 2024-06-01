import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String display = "0";
  String calculation = "";
  double firstNumber = 0.0;
  String operation = '';

  void calcular(String tecla) {
    setState(() {
      if ('0123456789'.contains(tecla)) {
        if (display == "0") {
          display = tecla;
        } else {
          display += tecla;
        }
      } else if (tecla == ',') {
        if (!display.contains('.')) {
          display += '.';
        }
      } else if (tecla == 'AC') {
        display = "0";
        calculation = "";
        firstNumber = 0.0;
        operation = '';
      } else if (tecla == '<x') {
        display =
            display.length > 1 ? display.substring(0, display.length - 1) : '0';
      } else if ('+-x/'.contains(tecla)) {
        firstNumber = double.parse(display.replaceAll(',', '.'));
        operation = tecla;
        calculation = display + " " + operation + " ";
        display = '0';
      } else if (tecla == '=') {
        double secondNumber = double.parse(display.replaceAll(',', '.'));
        double result;
        switch (operation) {
          case '+':
            result = firstNumber + secondNumber;
            break;
          case '-':
            result = firstNumber - secondNumber;
            break;
          case 'x':
            result = firstNumber * secondNumber;
            break;
          case '/':
            result = firstNumber / secondNumber;
            break;
          default:
            result = secondNumber;
        }
        display = result.toString().replaceAll('.', ',');
        calculation += secondNumber.toString().replaceAll('.', ',') + " =";
      }
    });
  }

  Widget buildButton(String label, Color color, {double size = 80}) {
    return GestureDetector(
      onTap: () => calcular(label),
      child: Container(
        margin: EdgeInsets.all(5),
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(2, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Calculadora"),
          ),
          backgroundColor: Colors.blueGrey[900],
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          color: Colors.blueGrey[50],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(2, 3),
                    ),
                  ],
                ),
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      calculation,
                      style: TextStyle(fontSize: 24, color: Colors.grey),
                    ),
                    Text(
                      display,
                      style:
                          TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton("AC", Colors.red),
                      buildButton("<x", Colors.blue),
                      buildButton("/", Colors.orange),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton("7", Colors.grey[850]!),
                      buildButton("8", Colors.grey[850]!),
                      buildButton("9", Colors.grey[850]!),
                      buildButton("x", Colors.orange),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton("4", Colors.grey[850]!),
                      buildButton("5", Colors.grey[850]!),
                      buildButton("6", Colors.grey[850]!),
                      buildButton("-", Colors.orange),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton("1", Colors.grey[850]!),
                      buildButton("2", Colors.grey[850]!),
                      buildButton("3", Colors.grey[850]!),
                      buildButton("+", Colors.orange),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton("0", Colors.grey[850]!, size: 170),
                      buildButton(",", Colors.grey[850]!),
                      buildButton("=", Colors.green),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
