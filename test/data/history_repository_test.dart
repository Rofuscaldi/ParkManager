import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:park_manager/data/data_source/local_history_data_source.dart';
import 'package:park_manager/data/history_repository_impl.dart';
import 'package:park_manager/domain/contract/history_repository.dart';

import '../utils/mock_spot.dart';

class _MockLocalHistoryDataSource extends Mock
    implements LocalHistoryDataSource {}

void main() {
  late LocalHistoryDataSource dataSource;
  late HistoryRepository repository;

  setUp(() {
    dataSource = _MockLocalHistoryDataSource();
    repository = HistoryRepositoryImpl(dataSource);
  });

  test('DS returns history', () async {
    when(() => dataSource.getHistory())
        .thenAnswer((_) => Future.value(mockSpots));

    expect(await repository.getHistory(), mockSpots);
  });
}
