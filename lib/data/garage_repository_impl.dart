import 'package:park_manager/data/data_source/local_garage_spots_data_source.dart';
import 'package:park_manager/domain/contract/garage_repository.dart';
import 'package:park_manager/domain/contract/history_repository.dart';
import 'package:park_manager/domain/model/spot.dart';

class GarageRepositoryImpl implements GarageRepository {
  GarageRepositoryImpl(this._localGarage, this._historyRepository);

  final LocalGarageSpotsDataSource _localGarage;
  final HistoryRepository _historyRepository;

  @override
  Future<List<Spot>> updateGarageSpots(Spot spot) async {
    spot.actionDateTime = DateTime.now().toString();
    _historyRepository.addSpotInHistory(spot);
    final spotList = await _localGarage.manageGarage(spot, ManageGarage.addVehicle);
    return spotList;
  }

  @override
  Future<List<Spot>> deleteVehicle(Spot spot) async {
    spot.actionDateTime = DateTime.now().toString();
    _historyRepository.addSpotInHistory(spot);
    final spotList =
        await _localGarage.manageGarage(spot, ManageGarage.deleteVehicle);
    return spotList;
  }

  @override
  Future<List<Spot>> getSpots() async {
    final spots = await _localGarage.getGarageSpots();
    return spots;
  }
}
