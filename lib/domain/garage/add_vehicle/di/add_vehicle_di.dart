import 'package:get_it/get_it.dart';
import 'package:park_manager/domain/garage/add_vehicle/use_case/add_vehicle_use_case.dart';
import 'package:park_manager/domain/contract/garage_repository.dart';

void setup(GetIt sl) {
  sl.registerLazySingleton<AddVehicleUseCase>(
          () => AddVehicleUseCase(sl.get<GarageRepository>()));
}