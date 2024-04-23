import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:park_manager/domain/contract/garage_repository.dart';
import 'package:park_manager/domain/garage/add_vehicle/use_case/add_vehicle_use_case.dart';
import 'package:park_manager/domain/garage/delete_vehicle/use_case/delete_vehicle_use_case.dart';
import 'package:park_manager/domain/garage/get_spots/use_case/get_spots_use_case.dart';
import 'package:park_manager/domain/model/spot.dart';

import '../../utils/mock_spot.dart';

class _MockGarageRepository extends Mock implements GarageRepository {}

void main() {
  late GarageRepository repository;
  late GetSpotsUseCase getSpotsUseCase;
  late AddVehicleUseCase addVehicleUseCase;
  late DeleteVehicleUseCase deleteVehicleUseCase;

  setUp(() {
    repository = _MockGarageRepository();
    getSpotsUseCase = GetSpotsUseCase(repository);
    addVehicleUseCase = AddVehicleUseCase(repository);
    deleteVehicleUseCase = DeleteVehicleUseCase(repository);
  });

  test('return spots successfully', () async {
    when(() => repository.getSpots())
        .thenAnswer((_) => Future.value(mockSpots));

    expect(await getSpotsUseCase.call(), mockSpots);
  });

  test('add vehicle successfully', () async {
    final newSpot =
        Spot('ABC-1234', 'actionDateTime', spotId: '02', isOccupied: true);

    when(() => repository.updateGarageSpots(newSpot))
        .thenAnswer((_) => Future.value(mockSpots));

    expect(await addVehicleUseCase.call(newSpot), mockSpots);
  });

  test('delete vehicle successfully', () async {
    final deleteVehicle =
    Spot('ABC-1234', 'actionDateTime', spotId: '02', isOccupied: false);

    when(() => repository.deleteVehicle(deleteVehicle))
        .thenAnswer((_) => Future.value(mockSpots));

    expect(await deleteVehicleUseCase.call(deleteVehicle), mockSpots);
  });
}
