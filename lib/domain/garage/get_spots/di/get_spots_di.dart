import 'package:get_it/get_it.dart';
import 'package:park_manager/domain/contract/garage_repository.dart';
import 'package:park_manager/domain/garage/get_spots/use_case/get_spots_use_case.dart';

void setup(GetIt sl) {
  sl.registerLazySingleton<GetSpotsUseCase>(
          () => GetSpotsUseCase(sl.get<GarageRepository>()));
}