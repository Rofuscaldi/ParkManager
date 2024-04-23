import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:park_manager/core/service_locator.dart';
import 'package:park_manager/presentation/history/bloc/history_bloc.dart';
import 'package:park_manager/presentation/history/history_screen.dart';
import 'package:park_manager/utils/keys.dart';

import '../../utils/mock_spot.dart';

class MockHistoryBloc extends Mock implements HistoryBloc {}

void main() {
  Future<void> initializeWidget(WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
        home: HistoryScreen(
          title: 'Garage',
        )));

    await tester.pump();
  }

  late HistoryBloc bloc;

  setUp(() {
    setup(sl);
    bloc = MockHistoryBloc();
    resetMocktailState();

    sl.allowReassignment = true;
  });

  testWidgets('Home loaded builds properly', (WidgetTester tester) async {
    when(() => bloc.state).thenReturn(HistoryInitial());

    await initializeWidget(tester);

    expect(find.byKey(Keys.historyListKey), findsNothing);
  });

  testWidgets('success', (WidgetTester tester) async {
    when(() => bloc.state).thenReturn(HistorySuccess(history: mockSpots));

    await initializeWidget(tester);

    expect(find.byKey(Keys.historyListKey), findsNothing);
  });
}
