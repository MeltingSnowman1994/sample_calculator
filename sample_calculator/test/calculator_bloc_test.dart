import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:sample_calculator/bloc/calculator_bloc.dart';

void main() {
  group('CalculatorBloc', () {
    late CalculatorBloc bloc;

    setUp(() {
      bloc = CalculatorBloc();
    });

    tearDown(() {
      bloc.close();
    });

    test('初期状態は CalculatorInitial', () {
      expect(bloc.state, isA<CalculatorInitial>());
    });

    blocTest<CalculatorBloc, CalculatorState>(
      '数字を1つ入力すると状態が "1" になる',
      build: () => CalculatorBloc(),
      act: (bloc) => bloc.add(InputDigit('1')),
      expect:
          () => [
            isA<CalculatorResult>().having((s) => s.display, 'display', '1'),
          ],
    );

    blocTest<CalculatorBloc, CalculatorState>(
      '2 + 3 = を入力すると状態が "5.0" になる',
      build: () => CalculatorBloc(),
      act: (bloc) {
        bloc
          ..add(InputDigit('2'))
          ..add(InputOperator('+'))
          ..add(InputDigit('3'))
          ..add(Calculate());
      },
      wait: const Duration(milliseconds: 10),
      expect:
          () => [
            isA<CalculatorResult>().having((s) => s.display, 'display', '2'),
            // オペレータ入力で表示は変わらない
            isA<CalculatorResult>().having((s) => s.display, 'display', '3'),
            isA<CalculatorResult>().having((s) => s.display, 'display', '5.0'),
          ],
    );

    blocTest<CalculatorBloc, CalculatorState>(
      '0で割った場合は "Div by 0" を返す',
      build: () => CalculatorBloc(),
      act: (bloc) {
        bloc
          ..add(InputDigit('9'))
          ..add(InputOperator('/'))
          ..add(InputDigit('0'))
          ..add(Calculate());
      },
      wait: const Duration(milliseconds: 10),
      expect:
          () => [
            isA<CalculatorResult>().having((s) => s.display, 'display', '9'),
            isA<CalculatorResult>().having((s) => s.display, 'display', '0'),
            isA<CalculatorResult>().having(
              (s) => s.display,
              'display',
              'Div by 0',
            ),
          ],
    );

    blocTest<CalculatorBloc, CalculatorState>(
      'Clearを押すと表示が空になる',
      build: () => CalculatorBloc(),
      act: (bloc) {
        bloc
          ..add(InputDigit('8'))
          ..add(Clear());
      },
      expect:
          () => [
            isA<CalculatorResult>().having((s) => s.display, 'display', '8'),
            isA<CalculatorResult>().having((s) => s.display, 'display', ''),
          ],
    );
  });
}
