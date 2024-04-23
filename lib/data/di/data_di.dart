import 'package:get_it/get_it.dart';
import 'package:park_manager/data/garage_repository_impl.dart';
import 'package:park_manager/data/history_repository_impl.dart';
import 'package:park_manager/data/data_source/local_garage_spots_data_source.dart';
import 'package:park_manager/data/data_source/local_history_data_source.dart';
import 'package:park_manager/domain/contract/garage_repository.dart';
import 'package:park_manager/domain/contract/history_repository.dart';

void setup(GetIt sl) {
  sl.registerLazySingleton<LocalGarageSpotsDataSource>(
      () => LocalGarageSpotsDataSource());
  sl.registerLazySingleton<LocalHistoryDataSource>(
      () => LocalHistoryDataSource());
  sl.registerLazySingleton<GarageRepository>(() => GarageRepositoryImpl(
      sl.get<LocalGarageSpotsDataSource>(), sl.get<HistoryRepository>()));
  sl.registerLazySingleton<HistoryRepository>(
      () => HistoryRepositoryImpl(sl.get<LocalHistoryDataSource>()));
}
