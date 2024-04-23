import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:park_manager/data/data_source/local_garage_spots_data_source.dart';
import 'package:park_manager/data/garage_repository_impl.dart';
import 'package:park_manager/domain/contract/garage_repository.dart';
import 'package:park_manager/domain/contract/history_repository.dart';
import 'package:park_manager/domain/model/spot.dart';

import '../utils/mock_spot.dart';

class _MockLocalGarageSpotsDataSource extends Mock
    implements LocalGarageSpotsDataSource {}

class _MockHistoryRepository extends Mock implements HistoryRepository {}

void main() {
  late LocalGarageSpotsDataSource garageDataSource;
  late HistoryRepository historyRepository;
  late GarageRepository repository;

  setUp(() {
    garageDataSource = _MockLocalGarageSpotsDataSource();
    historyRepository = _MockHistoryRepository();
    repository = GarageRepositoryImpl(garageDataSource, historyRepository);
  });

  test('DS returns spots', () async {
    when(() => garageDataSource.getGarageSpots())
        .thenAnswer((_) => Future.value(mockSpots));

    expect(await repository.getSpots(), mockSpots);
  });

  test('DS add vehicle properly', () async {
    final newVehicle = Spot('ABC-1E24', '', spotId: '10', isOccupied: true);
    when(() =>
            garageDataSource.manageGarage(newVehicle, ManageGarage.addVehicle))
        .thenAnswer((_) => Future.value(mockSpots));
    when(() => historyRepository.addSpotInHistory(newVehicle))
        .thenAnswer((_) => Future.value());

    expect(await repository.updateGarageSpots(newVehicle), mockSpots);
  });

  test('DS delete vehicle properly', () async {
    final deletedVehicle = Spot('ABC-1E24', '', spotId: '10', isOccupied: true);
    when(() =>
        garageDataSource.manageGarage(deletedVehicle, ManageGarage.deleteVehicle))
        .thenAnswer((_) => Future.value(mockSpots));
    when(() => historyRepository.addSpotInHistory(deletedVehicle))
        .thenAnswer((_) => Future.value());

    expect(await repository.deleteVehicle(deletedVehicle), mockSpots);
  });
}
