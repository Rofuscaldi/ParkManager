import 'package:park_manager/data/data_source/local_history_data_source.dart';
import 'package:park_manager/domain/contract/history_repository.dart';
import 'package:park_manager/domain/model/spot.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  HistoryRepositoryImpl(this._localHistory);

  final LocalHistoryDataSource _localHistory;

  @override
  Future<void> addSpotInHistory(Spot spot) async {
    await _localHistory.addSpotInHistory(spot);
  }

  @override
  Future<List<Spot>> getHistory() async {
    final history = await _localHistory.getHistory();
    return history;
  }
}
