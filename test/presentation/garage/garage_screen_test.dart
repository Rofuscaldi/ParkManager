import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:park_manager/core/service_locator.dart';
import 'package:park_manager/presentation/garage/bloc/garage_bloc.dart';
import 'package:park_manager/presentation/garage/garage_screen.dart';
import 'package:park_manager/utils/keys.dart';

class MockGarageBloc extends Mock implements GarageBloc {}

void main() {
  Future<void> initializeWidget(WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
        home: GarageScreen(
      title: 'Garage',
    )));

    await tester.pump(const Duration(seconds: 2));
  }

  late GarageBloc bloc;

  setUp(() {
    setup(sl);
    bloc = MockGarageBloc();
    resetMocktailState();
  });

  testWidgets('GarageInitial emits properly', (WidgetTester tester) async {
    when(() => bloc.state).thenReturn(GarageInitial());

    await initializeWidget(tester);

    expect(find.byKey(Keys.listViewKey), findsNothing);
  });
}
