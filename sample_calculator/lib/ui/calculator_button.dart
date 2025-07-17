// ui/calculator_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/calculator_bloc.dart';

class CalculatorButton extends StatelessWidget {
  final String label;

  const CalculatorButton({required this.label});

  @override
  Widget build(BuildContext context) {
    void _onTap() {
      final bloc = context.read<CalculatorBloc>();
      if (RegExp(r'^[0-9]$').hasMatch(label)) {
        bloc.add(InputDigit(label));
      } else if (label == 'C') {
        bloc.add(Clear());
      } else if (label == '=') {
        bloc.add(Calculate());
      } else {
        bloc.add(InputOperator(label));
      }
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: _onTap,
        child: Text(label, style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
