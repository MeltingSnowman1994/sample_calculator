import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flat Calculator', home: CalculatorPage());
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _display = '';
  String _operator = '';
  double? _firstOperand;

  void _onPressed(String value) {
    setState(() {
      if (value == 'C') {
        _display = '';
        _firstOperand = null;
        _operator = '';
      } else if (value == '+' || value == '-' || value == '*' || value == '/') {
        if (_display.isNotEmpty) {
          _firstOperand = double.tryParse(_display);
          _operator = value;
          _display = '';
        }
      } else if (value == '=') {
        if (_firstOperand != null && _display.isNotEmpty) {
          final secondOperand = double.tryParse(_display);
          if (secondOperand == null) {
            _display = 'Error';
            return;
          }
          double result;
          switch (_operator) {
            case '+':
              result = _firstOperand! + secondOperand;
              break;
            case '-':
              result = _firstOperand! - secondOperand;
              break;
            case '*':
              result = _firstOperand! * secondOperand;
              break;
            case '/':
              if (secondOperand == 0) {
                _display = 'Div by 0';
                return;
              }
              result = _firstOperand! / secondOperand;
              break;
            default:
              return;
          }
          _display = result.toString();
          _firstOperand = null;
          _operator = '';
        }
      } else {
        _display += value;
      }
    });
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => _onPressed(text),
          child: Text(text, style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.centerRight,
            child: Text(_display, style: TextStyle(fontSize: 32)),
          ),
          Expanded(
            child: Column(
              children: [
                Row(children: ['7', '8', '9', '/'].map(_buildButton).toList()),
                Row(children: ['4', '5', '6', '*'].map(_buildButton).toList()),
                Row(children: ['1', '2', '3', '-'].map(_buildButton).toList()),
                Row(children: ['0', 'C', '=', '+'].map(_buildButton).toList()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
