// ui/calculator_page.dart
import 'package:flutter/material.dart';
import 'calculator_view.dart';

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bloc Calculator')),
      body: CalculatorView(),
    );
  }
}
