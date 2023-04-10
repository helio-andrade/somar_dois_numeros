import 'package:flutter/material.dart';
import 'calculadora.dart';
import 'package:somar_dois_numeros/calculadora_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculadoraPage(
        calculadora: Calculadora(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
