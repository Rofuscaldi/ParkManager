import 'package:park_manager/domain/model/spot.dart';

abstract class HistoryRepository {
  Future<void> addSpotInHistory(Spot spot);

  Future<List<Spot>> getHistory();
}
