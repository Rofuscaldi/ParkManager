import 'package:get_it/get_it.dart';
import 'package:park_manager/domain/garage/add_vehicle/use_case/add_vehicle_use_case.dart';
import 'package:park_manager/domain/garage/delete_vehicle/use_case/delete_vehicle_use_case.dart';
import 'package:park_manager/domain/garage/get_spots/use_case/get_spots_use_case.dart';
import 'package:park_manager/presentation/garage/bloc/garage_bloc.dart';

void setup(GetIt sl) {
  sl.registerLazySingleton<GarageBloc>(() => GarageBloc(
      sl.get<GetSpotsUseCase>(),
      sl.get<AddVehicleUseCase>(),
      sl.get<DeleteVehicleUseCase>()));
}
