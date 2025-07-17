// ui/calculator_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/calculator_bloc.dart';
import 'calculator_button.dart';

class CalculatorView extends StatelessWidget {
  final List<String> _buttons = [
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    '*',
    '1',
    '2',
    '3',
    '-',
    '0',
    'C',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<CalculatorBloc, CalculatorState>(
          builder: (context, state) {
            String display = '';
            if (state is CalculatorResult) {
              display = state.display;
            }
            return Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(16),
              child: Text(display, style: TextStyle(fontSize: 32)),
            );
          },
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final buttonHeight = constraints.maxHeight / 4;
              final buttonWidth = constraints.maxWidth / 4;
              final aspectRatio = buttonWidth / buttonHeight;
              return GridView.count(
                childAspectRatio: aspectRatio,
                crossAxisCount: 4,
                children:
                    _buttons.map((label) {
                      return CalculatorButton(label: label);
                    }).toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}
