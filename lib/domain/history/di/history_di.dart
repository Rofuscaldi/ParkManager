import 'package:get_it/get_it.dart';
import 'package:park_manager/domain/contract/history_repository.dart';
import 'package:park_manager/domain/history/use_case/get_history_use_case.dart';

void setup(GetIt sl) {
  sl.registerLazySingleton<GetHistoryUseCase>(
          () => GetHistoryUseCase(sl.get<HistoryRepository>()));
}