part of 'garage_bloc.dart';

@immutable
sealed class GarageState {}

final class GarageInitial extends GarageState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GarageInitial && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

final class GarageLoading extends GarageState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GarageLoading && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

final class GarageSuccess extends GarageState {}

final class GetSpotsSuccess extends GarageState {
  GetSpotsSuccess({required this.spots});

  final List<Spot> spots;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetSpotsSuccess &&
          runtimeType == other.runtimeType &&
          spots == other.spots;

  @override
  int get hashCode => 0;
}

final class GarageError extends GarageState {}

final class AddVehicleSuccess extends GarageState {
  AddVehicleSuccess({required this.spots});

  final List<Spot> spots;
}

final class AddVehicleError extends GarageState {}
