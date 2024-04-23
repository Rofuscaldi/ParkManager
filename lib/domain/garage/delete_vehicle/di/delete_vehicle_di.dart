import 'package:get_it/get_it.dart';
import 'package:park_manager/domain/contract/garage_repository.dart';
import 'package:park_manager/domain/garage/delete_vehicle/use_case/delete_vehicle_use_case.dart';

void setup(GetIt sl) {
  sl.registerLazySingleton<DeleteVehicleUseCase>(
          () => DeleteVehicleUseCase(sl.get<GarageRepository>()));
}