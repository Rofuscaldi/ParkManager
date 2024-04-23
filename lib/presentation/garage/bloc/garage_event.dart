part of 'garage_bloc.dart';

@immutable
sealed class GarageEvent {}

final class GetSpotsEvent extends GarageEvent {}

final class AddVehicleEvent extends GarageEvent {
  AddVehicleEvent({required this.newVehicle});

  final Spot newVehicle;
}

final class DeleteVehicleEvent extends GarageEvent {
  DeleteVehicleEvent({required this.vehicle});

  final Spot vehicle;
}
