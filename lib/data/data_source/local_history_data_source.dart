import 'package:park_manager/domain/model/spot.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalHistoryDataSource {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> addSpotInHistory(Spot spot) async {
    final SharedPreferences prefs = await _prefs;
    final cachedHistory = prefs.getStringList('history');
    if (cachedHistory != null) {
      final historyList = cachedHistory.map((e) => Spot.fromJson(e)).toList();
      historyList.add(spot);
      final historyUpdated = historyList.map((spot) => spot.toJson()).toList();
      prefs.setStringList('history', historyUpdated);
    } else {
      final list = <Spot>[];
      list.add(spot);
      final updatedList = list.map((spot) => spot.toJson()).toList();
      prefs.setStringList('history', updatedList);
    }
  }

  Future<List<Spot>> getHistory() async {
    final SharedPreferences prefs = await _prefs;
    final cachedHistory = prefs.getStringList('history');
    if (cachedHistory != null) {
      final historyList = cachedHistory.map((e) => Spot.fromJson(e)).toList();
      return historyList;
    }
    return [];
  }
}
