import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:park_manager/domain/garage/add_vehicle/use_case/add_vehicle_use_case.dart';
import 'package:park_manager/domain/garage/delete_vehicle/use_case/delete_vehicle_use_case.dart';
import 'package:park_manager/domain/garage/get_spots/use_case/get_spots_use_case.dart';
import 'package:park_manager/domain/model/spot.dart';

part 'garage_event.dart';

part 'garage_state.dart';

class GarageBloc extends Bloc<GarageEvent, GarageState> {
  final GetSpotsUseCase _getSpotsUseCase;
  final AddVehicleUseCase _addVehicleUseCase;
  final DeleteVehicleUseCase _deleteVehicleUseCase;

  GarageBloc(this._getSpotsUseCase, this._addVehicleUseCase,
      this._deleteVehicleUseCase)
      : super(GarageInitial()) {
    on<GarageEvent>((event, emit) async {

      emit(GarageLoading());
      await Future.delayed(const Duration(seconds: 1));

      if (event is AddVehicleEvent) {
        final bool = await _addVehicleUseCase.call(event.newVehicle);
        if (bool.isNotEmpty) {
          emit(GetSpotsSuccess(spots: bool));
        } else {
          emit(AddVehicleError());
        }
      } else if (event is GetSpotsEvent) {
        final spots = await _getSpotsUseCase.call();
        emit(GetSpotsSuccess(spots: spots));
      } else if (event is DeleteVehicleEvent) {
        final vehicle = event.vehicle;
        final result = await _deleteVehicleUseCase.call(vehicle);
        if (result.isNotEmpty) {
          emit(GetSpotsSuccess(spots: result));
        }
      } else {
        emit(GarageError());
      }
    });
  }
}
