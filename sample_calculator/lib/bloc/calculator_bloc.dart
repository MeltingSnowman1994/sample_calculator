// calculator_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';

/// --- Events ---
abstract class CalculatorEvent {}

class InputDigit extends CalculatorEvent {
  final String digit;
  InputDigit(this.digit);
}

class InputOperator extends CalculatorEvent {
  final String operator;
  InputOperator(this.operator);
}

class Calculate extends CalculatorEvent {}

class Clear extends CalculatorEvent {}

/// --- States ---
abstract class CalculatorState {}

class CalculatorInitial extends CalculatorState {}

class CalculatorResult extends CalculatorState {
  final String display;
  CalculatorResult(this.display);
}

/// --- Bloc ---
class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  String _input = '';
  String _operator = '';
  double? _firstOperand;

  CalculatorBloc() : super(CalculatorInitial()) {
    on<InputDigit>(_onInputDigit);
    on<InputOperator>(_onInputOperator);
    on<Calculate>(_onCalculate);
    on<Clear>(_onClear);
  }

  void _onInputDigit(InputDigit event, Emitter<CalculatorState> emit) {
    _input += event.digit;
    emit(CalculatorResult(_input));
  }

  void _onInputOperator(InputOperator event, Emitter<CalculatorState> emit) {
    _firstOperand = double.tryParse(_input);
    _operator = event.operator;
    _input = '';
  }

  void _onCalculate(Calculate event, Emitter<CalculatorState> emit) {
    final secondOperand = double.tryParse(_input);
    if (_firstOperand == null || secondOperand == null) {
      emit(CalculatorResult('Error'));
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
          emit(CalculatorResult('Div by 0'));
          return;
        }
        result = _firstOperand! / secondOperand;
        break;
      default:
        emit(CalculatorResult('Invalid op'));
        return;
    }

    _input = result.toString();
    _firstOperand = null;
    _operator = '';
    emit(CalculatorResult(_input));
  }

  void _onClear(Clear event, Emitter<CalculatorState> emit) {
    _input = '';
    _operator = '';
    _firstOperand = null;
    emit(CalculatorResult(''));
  }
}
