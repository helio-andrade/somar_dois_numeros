import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'calculadora.dart';

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({Key? key, required Calculadora calculadora})
      : super(key: key);

  @override
  _CalculadoraPageState createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  final TextEditingController numero1Controller = TextEditingController();
  final TextEditingController numero2Controller = TextEditingController();
  final FocusNode num1Focus = FocusNode();

  int resultado = 0;

  void calcularResultado() {
    int? num1 = int.tryParse(numero1Controller.text);
    int? num2 = int.tryParse(numero2Controller.text);

    if (num1 == null || num2 == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Erro'),
            content: Text('Por favor, digite dois números inteiros.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    setState(() {
      resultado = Calculadora().calcular(num1, num2);
    });
  }

  void limparCampos() {
    setState(() {
      resultado = 0;
      numero1Controller.clear();
      numero2Controller.clear();
    });
    num1Focus.requestFocus();
  }

  void _handleKey(RawKeyEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.escape) {
      limparCampos();
    }
  }

  @override
  void initState() {
    super.initState();
    RawKeyboard.instance.addListener(_handleKey);
  }

  @override
  void dispose() {
    RawKeyboard.instance.removeListener(_handleKey);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculadora',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 50.0),
              SizedBox(
                width: 200.0,
                child: TextField(
                  controller: numero1Controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Digite um número',
                    filled: true,
                    fillColor: const Color(0xFFFFF7D1),
                  ),
                  focusNode: num1Focus,
                  onSubmitted: (_) => calcularResultado(),
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: 200.0,
                child: TextField(
                  controller: numero2Controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Digite outro número',
                    filled: true,
                    fillColor: const Color(0xFFFFF7D1),
                  ),
                  onSubmitted: (_) => calcularResultado(),
                ),
              ),
              const SizedBox(height: 32.0),
              Text(
                'Resultado: $resultado',
                style: const TextStyle(fontSize: 24.0),
              ),
              const SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: calcularResultado,
                    child: const Text('Calcular'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: limparCampos,
                    child: const Text('Limpar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
