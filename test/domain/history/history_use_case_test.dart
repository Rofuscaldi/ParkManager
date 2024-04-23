import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:park_manager/domain/contract/history_repository.dart';
import 'package:park_manager/domain/history/use_case/get_history_use_case.dart';

import '../../utils/mock_spot.dart';


class _MockHistoryRepository extends Mock implements HistoryRepository {}

void main() {
  late HistoryRepository repository;
  late GetHistoryUseCase getHistoryUseCase;

  setUp(() {
    repository = _MockHistoryRepository();
    getHistoryUseCase = GetHistoryUseCase(repository);
  });

  test('return history successfully', () async {
    when(() => repository.getHistory())
        .thenAnswer((_) => Future.value(mockSpots));

    expect(await getHistoryUseCase.call(), mockSpots);
  });
}
