import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:park_manager/core/service_locator.dart';
import 'package:park_manager/domain/garage/add_vehicle/use_case/add_vehicle_use_case.dart';
import 'package:park_manager/domain/garage/delete_vehicle/use_case/delete_vehicle_use_case.dart';
import 'package:park_manager/domain/garage/get_spots/use_case/get_spots_use_case.dart';
import 'package:park_manager/domain/model/spot.dart';
import 'package:park_manager/presentation/garage/bloc/garage_bloc.dart';

class _MockGetSpotsUseCase extends Mock implements GetSpotsUseCase {}

class _MockAddVehicleUseCase extends Mock implements AddVehicleUseCase {}

class _MockDeleteVehicleUseCase extends Mock implements DeleteVehicleUseCase {}

void main() {
  late GetSpotsUseCase getSpotsUseCase;
  late AddVehicleUseCase addVehicleUseCase;
  late DeleteVehicleUseCase deleteVehicleUseCase;
  late GarageBloc bloc;

  final spot = [
    Spot('carId', 'actionDateTime', spotId: 'spotId', isOccupied: false)
  ];

  setUp(() {
    setup(sl);

    getSpotsUseCase = _MockGetSpotsUseCase();
    addVehicleUseCase = _MockAddVehicleUseCase();
    deleteVehicleUseCase = _MockDeleteVehicleUseCase();

    bloc = GarageBloc(getSpotsUseCase, addVehicleUseCase, deleteVehicleUseCase);
    resetMocktailState();

    sl.allowReassignment = true;
    sl.registerLazySingleton<GetSpotsUseCase>(() => getSpotsUseCase);
    sl.registerLazySingleton<AddVehicleUseCase>(() => addVehicleUseCase);
    sl.registerLazySingleton<DeleteVehicleUseCase>(() => deleteVehicleUseCase);
  });

  test('Initial state of BLoC is correct', () {
    expect(bloc.state, GarageInitial());
  });

  test('BLoC returning success properly', () async* {
    when(() => getSpotsUseCase.call()).thenAnswer((_) => Future.value(spot));

    expectLater(
        bloc,
        emitsInOrder(
            <GarageState>[GarageInitial(), GetSpotsSuccess(spots: spot)]));

    bloc.add(GetSpotsEvent());
  });

  test('BLoC returning error', () async* {
    when(() => getSpotsUseCase.call()).thenAnswer((_) => Future.value([]));

    expectLater(
        bloc,
        emitsInOrder(
            <GarageState>[GarageInitial(), GarageLoading(), GarageError()]));

    bloc.add(GetSpotsEvent());
  });

  test('AddVehicle returning success', () async* {
    final newVehicle = Spot('ABC-1E24', '', spotId: '10', isOccupied: true);
    when(() => addVehicleUseCase.call(newVehicle)).thenAnswer((_) => Future.value(spot));

    expectLater(
        bloc,
        emitsInOrder(
            <GarageState>[GarageInitial(), GarageLoading(), GetSpotsSuccess(spots: spot)]));

    bloc.add(AddVehicleEvent(newVehicle: newVehicle));
  });

  test('AddVehicle returning error', () async* {
    final newVehicle = Spot('ABC-1E24', '', spotId: '10', isOccupied: true);
    when(() => addVehicleUseCase.call(newVehicle)).thenAnswer((_) => Future.value([]));

    expectLater(
        bloc,
        emitsInOrder(
            <GarageState>[GarageInitial(), GarageLoading(), AddVehicleError()]));

    bloc.add(AddVehicleEvent(newVehicle: newVehicle));
  });

  test('DeleteVehicle returning success', () async* {
    final deleteVehicle = Spot(null, '', spotId: '10', isOccupied: false);
    when(() => deleteVehicleUseCase.call(deleteVehicle)).thenAnswer((_) => Future.value(spot));

    expectLater(
        bloc,
        emitsInOrder(
            <GarageState>[GarageInitial(), GarageLoading(), GetSpotsSuccess(spots: spot)]));

    bloc.add(DeleteVehicleEvent(vehicle: deleteVehicle));
  });

  test('DeleteVehicle returning error', () async* {
    final deleteVehicle = Spot(null, '', spotId: '10', isOccupied: false);
    when(() => deleteVehicleUseCase.call(deleteVehicle)).thenAnswer((_) => Future.value([]));

    expectLater(
        bloc,
        emitsInOrder(
            <GarageState>[GarageInitial(), GarageLoading(), GarageError()]));

    bloc.add(DeleteVehicleEvent(vehicle: deleteVehicle));
  });
}
