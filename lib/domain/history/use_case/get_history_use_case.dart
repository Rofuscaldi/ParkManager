import 'package:park_manager/domain/contract/history_repository.dart';
import 'package:park_manager/domain/model/spot.dart';

class GetHistoryUseCase {
  GetHistoryUseCase(this._historyRepository);

  final HistoryRepository _historyRepository;

  Future<List<Spot>> call() {
    return _historyRepository.getHistory();
  }
}