import 'package:get_it/get_it.dart';
import 'package:park_manager/domain/history/use_case/get_history_use_case.dart';
import 'package:park_manager/presentation/history/bloc/history_bloc.dart';

void setup(GetIt sl) {
  sl.registerLazySingleton<HistoryBloc>(() => HistoryBloc(sl.get<GetHistoryUseCase>()));
}
